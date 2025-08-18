<?php
header('Content-Type: application/json');
ini_set('display_errors', 1);
error_reporting(E_ALL);

require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['status' => false, 'message' => 'Only POST is allowed.']);
    exit;
}

$email = $_POST['email'] ?? '';
$income = $_POST['income'] ?? 0;
$savings = $_POST['savings'] ?? 0;
$house = $_POST['house'] ?? 0;
$food = $_POST['food'] ?? 0;
$lifestyle = $_POST['lifestyle'] ?? 0;
$entertainment = $_POST['entertainment'] ?? 0;
$others = $_POST['others'] ?? 0;

if (empty($email)) {
    echo json_encode(['status' => false, 'message' => 'Email is required.']);
    exit;
}

try {
    // Check if a record already exists for this email
    $check = $pdo->prepare("SELECT id FROM budget_goals WHERE email = ?");
    $check->execute([$email]);

    if ($check->rowCount() > 0) {
        // Update existing record
        $stmt = $pdo->prepare("UPDATE budget_goals SET income=?, savings=?, house=?, food=?, lifestyle=?, entertainment=?, others=? WHERE email=?");
        $stmt->execute([$income, $savings, $house, $food, $lifestyle, $entertainment, $others, $email]);
        $message = 'Budget goals updated successfully.';
    } else {
        // Insert new record
        $stmt = $pdo->prepare("INSERT INTO budget_goals (email, income, savings, house, food, lifestyle, entertainment, others) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$email, $income, $savings, $house, $food, $lifestyle, $entertainment, $others]);
        $message = 'Budget goals created successfully.';
    }

    // Return the submitted data
    $response = [
        'email' => $email,
        'income' => (float)$income,
        'savings' => (float)$savings,
        'house' => (float)$house,
        'food' => (float)$food,
        'lifestyle' => (float)$lifestyle,
        'entertainment' => (float)$entertainment,
        'others' => (float)$others,
    ];

    echo json_encode([
        'status' => true,
        'message' => $message,
        'data' => $response
    ]);

} catch (PDOException $e) {
    echo json_encode(['status' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}
?>
