<?php
require_once 'config.php';
header('Content-Type: application/json');

$username = $_POST['username'] ?? '';
$feedback = $_POST['feedback'] ?? '';
$rating   = $_POST['rating'] ?? '';

if (empty($username) || empty($feedback) || empty($rating)) {
    echo json_encode([
        'status' => false,
        'message' => 'All fields are required.',
        'data' => []
    ]);
    exit;
}

try {
    $stmt = $pdo->prepare("INSERT INTO feedback (username, feedback, rating) VALUES (?, ?, ?)");
    $stmt->execute([$username, $feedback, $rating]);

    echo json_encode([
        'status' => true,
        'message' => 'Feedback submitted successfully',
        'data' => [
            'id' => $pdo->lastInsertId(),
            'username' => $username,
            'feedback' => $feedback,
            'rating' => $rating
        ]
    ]);
} catch (PDOException $e) {
    echo json_encode([
        'status' => false,
        'message' => 'Error submitting feedback: ' . $e->getMessage(),
        'data' => []
    ]);
}
