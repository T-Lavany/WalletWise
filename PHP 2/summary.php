<?php
// Enable error reporting
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// DB credentials
$host = "localhost";
$user = "root";
$password = "";
$database = "WalletWise";

$conn = new mysqli($host, $user, $password, $database);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]);
    exit;
}

// Read from form-data (POST fields)
$requiredFields = ['email', 'house', 'food', 'lifestyle', 'entertainment', 'others', 'totalBudget'];
$missing = [];

foreach ($requiredFields as $field) {
    if (!isset($_POST[$field]) || $_POST[$field] === '') {
        $missing[] = $field;
    }
}

if (!empty($missing)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Missing required fields: " . implode(", ", $missing)
    ]);
    exit;
}

// Sanitize
$email = $conn->real_escape_string($_POST["email"]);
$house = (int) $_POST["house"];
$food = (int) $_POST["food"];
$lifestyle = (int) $_POST["lifestyle"];
$entertainment = (int) $_POST["entertainment"];
$others = (int) $_POST["others"];
$totalBudget = (int) $_POST["totalBudget"];

// Save to DB
$stmt = $conn->prepare("
    INSERT INTO summary (
        email, house, food, lifestyle, entertainment, others, total_budget, created_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())
");

if (!$stmt) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => "Prepare failed: " . $conn->error]);
    exit;
}

$stmt->bind_param("siiiiii", $email, $house, $food, $lifestyle, $entertainment, $others, $totalBudget);

if ($stmt->execute()) {
    echo json_encode([
        "status" => "success",
        "message" => "Budget summary saved successfully.",
        "data" => [
            "email" => $email,
            "house" => $house,
            "food" => $food,
            "lifestyle" => $lifestyle,
            "entertainment" => $entertainment,
            "others" => $others,
            "totalBudget" => $totalBudget
        ]
    ]);
} else {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => "Execution failed: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
