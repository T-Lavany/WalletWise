<?php
$host = 'localhost';
$db = 'WalletWise';     // 🟢 Replace with your actual database name
$user = 'root';          // 🟢 Default XAMPP username
$pass = '';              // 🟢 Leave blank if no password is set in XAMPP

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo json_encode([
        'status' => false,
        'message' => 'Connection failed: ' . $e->getMessage(),
        'data' => []
    ]);
    exit;
}
