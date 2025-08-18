<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Include DB connection (PDO)
require_once "config.php";

// Function to send JSON response
function send_response($status, $message, $data = null) {
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit();
}

try {
    // Optional: filter by email if provided
    $email = isset($_GET['email']) ? trim($_GET['email']) : '';

    if (!empty($email)) {
        // Validate email
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            send_response("error", "Invalid email format.", []);
        }

        $stmt = $pdo->prepare("SELECT * FROM app_feedback WHERE email = :email ORDER BY id DESC");
        $stmt->execute([':email' => $email]);
    } else {
        // Fetch all feedback
        $stmt = $pdo->query("SELECT * FROM app_feedback ORDER BY id DESC");
    }

    $feedbacks = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($feedbacks) {
        send_response("success", "Feedback retrieved successfully.", $feedbacks);
    } else {
        send_response("success", "No feedback found.", []);
    }

} catch (PDOException $e) {
    send_response("error", "Failed to retrieve feedback: " . $e->getMessage(), []);
}
?>
