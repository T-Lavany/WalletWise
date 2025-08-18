<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Include DB connection (PDO)
require_once "config.php";

// Get POST data and sanitize
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$star_rating = isset($_POST['star_rating']) ? intval($_POST['star_rating']) : 0;
$feedback = isset($_POST['feedback']) ? trim($_POST['feedback']) : '';

// Function to send JSON response
function send_response($status, $message, $data = null) {
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit();
}

// Validate email
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    send_response("error", "Invalid email.", []);
}

// Validate star rating
if ($star_rating < 1 || $star_rating > 5) {
    send_response("error", "Star rating must be between 1 and 5.", []);
}

// Prepare and execute insert query using PDO
try {
    $stmt = $pdo->prepare("INSERT INTO app_feedback (email, star_rating, feedback) VALUES (:email, :star_rating, :feedback)");
    $stmt->execute([
        ':email' => $email,
        ':star_rating' => $star_rating,
        ':feedback' => $feedback
    ]);

    // Example of returning inserted data
    $response_data = [
        "email" => $email,
        "star_rating" => $star_rating,
        "feedback" => $feedback
    ];

    send_response("success", "Feedback submitted successfully.", $response_data);
} catch (PDOException $e) {
    send_response("error", "Failed to save feedback: " . $e->getMessage(), []);
}
?>
