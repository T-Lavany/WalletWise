<?php
header('Content-Type: application/json');

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'config.php';

// Only accept POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid request method. Only POST is allowed.',
        'data' => []
    ]);
    exit;
}

// Get email from POST data
$email = $_POST['email'] ?? '';

if (empty($email)) {
    echo json_encode([
        'status' => false,
        'message' => 'Email is required.',
        'data' => []
    ]);
    exit;
}

try {
    // Fetch transactions for this email, including the note field
    $stmt = $pdo->prepare("
        SELECT id, date, category, amount, note
        FROM transactions
        WHERE email = ?
        ORDER BY date DESC
    ");
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
