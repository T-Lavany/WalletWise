<?php
header('Content-Type: application/json');

// Show errors during development (disable on production)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include your PDO database config
require_once 'config.php';

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid request method. Only POST is allowed.',
        'data' => []
    ]);
    exit;
}

// Get form data
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';

// Validate inputs
if (empty($email) || empty($password)) {
    echo json_encode([
        'status' => false,
        'message' => 'Email and password are required.',
        'data' => []
    ]);
    exit;
}

try {
    // Prepare and execute query to fetch user by email
    $stmt = $pdo->prepare("SELECT id, name, email, password FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        // User not found
        echo json_encode([
            'status' => false,
            'message' => 'Invalid email or password.',
            'data' => []
        ]);
        exit;
    }

    // Verify the password hash
    if (password_verify($password, $user['password'])) {
        // Login success
        echo json_encode([
            'status' => true,
            'message' => 'Login successful.',
            'data' => [[
                'id' => $user['id'],
                'name' => $user['name'],
                'email' => $user['email']
            ]]
        ]);
    } else {
        // Password incorrect
        echo json_encode([
            'status' => false,
            'message' => 'Invalid email or password.',
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
