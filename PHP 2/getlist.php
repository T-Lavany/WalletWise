<?php
header('Content-Type: application/json');

ini_set('display_errors', 1);
error_reporting(E_ALL);

require_once 'config.php';

// Allow only GET requests
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode([
        'status' => false,
        'message' => 'Only GET requests are allowed.',
        'data' => []
    ]);
    exit;
}

// Get email from query parameter
$email = isset($_GET['email']) ? trim($_GET['email']) : '';

if (empty($email)) {
    echo json_encode([
        'status' => false,
        'message' => 'Email is required.',
        'data' => []
    ]);
    exit;
}

try {
    $stmt = $pdo->prepare("SELECT id, date, category, amount FROM transactions WHERE email = ? ORDER BY date DESC");
    $stmt->execute([$email]);
    $transactions = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($transactions) {
        echo json_encode([
            'status' => true,
            'message' => 'Transactions retrieved successfully.',
            'data' => $transactions
        ]);
    } else {
        echo json_encode([
            'status' => false,
            'message' => 'No transactions found for this email.',
            'data' => []
        ]);
    }
} catch (PDOException $e) {
    echo json_encode([
        'status' => false,
        'message' => 'Database error: ' . $e->getMessage(),
        'data' => []
    ]);
}
?>
