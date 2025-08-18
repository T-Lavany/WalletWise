<?php
header('Content-Type: application/json');

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'config.php'; // Make sure this defines $pdo properly

// Only allow POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid request method.',
        'data' => []
    ]);
    exit;
}

// Get and sanitize input
$name = trim($_POST['name'] ?? '');
$email = trim($_POST['email'] ?? '');
$password = $_POST['password'] ?? '';

// Basic validation
if (empty($name) || empty($email) || empty($password)) {
    echo json_encode([
        'status' => false,
        'message' => 'All fields are required.',
        'data' => []
    ]);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid email format.',
        'data' => []
    ]);
    exit;
}

try {
    // Check if email already exists
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->execute([$email]);

    if ($stmt->rowCount() > 0) {
        echo json_encode([
            'status' => false,
            'message' => 'Email is already registered.',
            'data' => []
        ]);
        exit;
    }

    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // Insert new user
    $stmt = $pdo->prepare("INSERT INTO users (name, email, password) VALUES (?, ?, ?)");
    $success = $stmt->execute([$name, $email, $hashedPassword]);

    if ($success) {
        echo json_encode([
            'status' => true,
            'message' => 'Registration successful.',
            'data' => [
                'id' => $pdo->lastInsertId(),
                'name' => $name,
                'email' => $email
            ]
        ]);
    } else {
        echo json_encode([
            'status' => false,
            'message' => 'Registration failed.',
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
