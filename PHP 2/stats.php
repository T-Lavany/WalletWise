<?php
header('Content-Type: application/json');
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(['status' => false, 'message' => 'Only GET is allowed.']);
    exit;
}

$user_id = $_GET['user_id'] ?? '';
if (empty($user_id)) {
    echo json_encode(['status' => false, 'message' => 'User ID is required.']);
    exit;
}

try {
    // 1. Get total cash in and cash out
    $stmt = $pdo->prepare("
        SELECT 
            SUM(CASE WHEN type = 'cashin' THEN amount ELSE 0 END) AS total_cashin,
            SUM(CASE WHEN type = 'cashout' THEN amount ELSE 0 END) AS total_cashout,
            COUNT(*) AS total_transactions
        FROM transactions
        WHERE user_id = ?
    ");
    $stmt->execute([$user_id]);
    $totals = $stmt->fetch(PDO::FETCH_ASSOC);

    // 2. Get budget for user
    $stmt = $pdo->prepare("SELECT house, food, lifestyle, entertainment, others FROM budget_goals WHERE user_id = ?");
    $stmt->execute([$user_id]);
    $budget = $stmt->fetch(PDO::FETCH_ASSOC);

    // 3. Get total cash out per category
    $stmt = $pdo->prepare("
        SELECT category, SUM(amount) AS total
        FROM transactions
        WHERE user_id = ? AND type = 'cashout'
        GROUP BY category
    ");
    $stmt->execute([$user_id]);
    $category_spending = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

    // 4. Calculate % vs budget
    $category_stats = [];
    foreach (['house', 'food', 'lifestyle', 'entertainment', 'others'] as $category) {
        $spent = isset($category_spending[$category]) ? $category_spending[$category] : 0;
        $budgeted = $budget[$category] ?? 0;
        $percent = $budgeted > 0 ? round(($spent / $budgeted) * 100, 2) : null;
        $category_stats[$category] = [
            'spent' => (float)$spent,
            'budget' => (float)$budgeted,
            'percent_used' => $percent
        ];
    }

    // 5. Calculate balance
    $balance = ($totals['total_cashin'] ?? 0) - ($totals['total_cashout'] ?? 0);

    echo json_encode([
        'status' => true,
        'message' => 'Budget stats retrieved successfully.',
        'data' => [
            'total_cash_in' => (float)($totals['total_cashin'] ?? 0),
            'total_cash_out' => (float)($totals['total_cashout'] ?? 0),
            'balance' => (float)$balance,
            'category_spending_vs_budget' => $category_stats,
            'total_transactions' => (int)($totals['total_transactions'] ?? 0)
        ]
    ]);
} catch (PDOException $e) {
    echo json_encode(['status' => false, 'message' => 'DB Error: ' . $e->getMessage()]);
}
?>
