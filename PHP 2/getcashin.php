<?php
header('Content-Type: application/json');

// Enable error reporting (disable in production)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include database config
require_once 'config.php';

// Ensure GET request
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid request method. Only GET is allowed.',
        'data' => []
    ]);
    exit;
}

try {
    // Fetch all cash_in records
    $stmt = $pdo->prepare("SELECT id, type, category, date, note, amount FROM transactions WHERE type = ?");
    $stmt->execute(['cash_in']);
    $cashInList = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        'status' => true,
        'message' => 'Cash-in records retrieved successfully.',
        'data' => $cashInList
    ]);

} catch (PDOException $e) {
    echo json_encode([
        'status' => false,
        'message' => 'Database error: ' . $e->getMessage(),
        'data' => []
    ]);
}
