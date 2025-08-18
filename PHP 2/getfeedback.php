<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Include DB connection (PDO)
require_once "config.php";

// Get email from query parameter
$email = isset($_GET['email']) ? trim($_GET['email']) : '';

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
    send_response("error", "Invalid email format.");
}

try {
    $stmt = $pdo->prepare("SELECT email, star_rating, feedback FROM app_feedback WHERE email = :email");
    $stmt->execute([':email' => $email]);
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($results) {
        send_response("success", "Feedback fetched successfully.", $results);
    } else {
        send_response("success", "No feedback found for this email.", []);
    }
} catch (PDOException $e) {
    send_response("error", "Database error: " . $e->getMessage());
}
?>
