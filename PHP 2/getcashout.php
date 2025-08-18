<?php
header('Content-Type: application/json');

// Enable error reporting (for development only, disable in production)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include your database configuration file (make sure $pdo is set there)
require_once 'config.php';

// Only allow GET requests
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode([
        'status' => false,
        'message' => 'Only GET requests are allowed.',
        'data' => []
    ]);
    exit;
}

try {
    // Prepare and execute query to get cash_out transactions
    $stmt = $pdo->prepare("SELECT id, type, category, date, note, amount FROM transactions WHERE type = :type");
    $stmt->execute(['type' => 'cash_out']);
    $records = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        'status' => true,
        'message' => 'Cash-out records retrieved successfully.',
        'data' => $records
    ]);
} catch (PDOException $e) {
    echo json_encode([
        'status' => false,
        'message' => 'Database error: ' . $e->getMessage(),
        'data' => []
    ]);
}
