<?php
header('Content-Type: application/json');

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'config.php';

// Allow only POST method
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid request method. Only POST is allowed.',
        'data' => []
    ]);
    exit;
}

// Try to parse JSON input first
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, true);

// If JSON decode fails or empty, fallback to $_POST
if (json_last_error() === JSON_ERROR_NONE && is_array($input)) {
    $category = isset($input['category']) ? trim($input['category']) : '';
    $date     = isset($input['date']) ? trim($input['date']) : date('Y-m-d');
    $note     = isset($input['note']) ? trim($input['note']) : '';
    $amount   = isset($input['amount']) ? trim($input['amount']) : '';
    $email    = isset($input['email']) ? trim($input['email']) : '';
} else {
    $category = isset($_POST['category']) ? trim($_POST['category']) : '';
    $date     = isset($_POST['date']) ? trim($_POST['date']) : date('Y-m-d');
    $note     = isset($_POST['note']) ? trim($_POST['note']) : '';
    $amount   = isset($_POST['amount']) ? trim($_POST['amount']) : '';
    $email    = isset($_POST['email']) ? trim($_POST['email']) : '';
}

// Validate required fields
if (empty($category) || empty($amount) || empty($email)) {
    echo json_encode([
        'status' => false,
        'message' => 'Category, amount, and email are required.',
        'data' => []
    ]);
    exit;
}

try {
    $stmt = $pdo->prepare("INSERT INTO transactions (type, category, date, note, amount, email) VALUES (?, ?, ?, ?, ?, ?)");
    $type = 'cash_in';

    $success = $stmt->execute([$type, $category, $date, $note, $amount, $email]);

    if ($success) {
        echo json_encode([
            'status' => true,
            'message' => 'Cash in recorded successfully.',
            'data' => [[
                'email'    => $email,
                'type'     => $type,
                'category' => $category,
                'date'     => $date,
                'note'     => $note,
                'amount'   => $amount
            ]]
        ]);
    } else {
        echo json_encode([
            'status' => false,
            'message' => 'Failed to record cash in.',
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
