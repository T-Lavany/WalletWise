<?php
header('Content-Type: application/json');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid request method. Use POST.',
        'data' => []
    ]);
    exit;
}

$username = trim($_POST['username'] ?? '');
$password = $_POST['password'] ?? '';

if (empty($username) || empty($password)) {
    echo json_encode([
        'status' => false,
        'message' => 'Username and password are required.',
        'data' => []
    ]);
    exit;
}

try {
    $stmt = $pdo->prepare("SELECT id, username, password FROM admins WHERE username = ?");
    $stmt->execute([$username]);
    $admin = $stmt->fetch();

    if ($admin && password_verify($password, $admin['password'])) {
        // Successful login
        echo json_encode([
            'status' => true,
            'message' => 'Admin login successful.',
            'data' => [
                'id' => $admin['id'],
                'username' => $admin['username']
            ]
        ]);
    } else {
        echo json_encode([
            'status' => false,
            'message' => 'Invalid username or password.',
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
