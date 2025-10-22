<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');

$input = json_decode(file_get_contents("php://input"), true);

if (!$input) {
    http_response_code(400);
    echo json_encode(["error" => "Invalid JSON input"]);
    exit();
}

$required = ['company', 'contact_person', 'job_title', 'contact_number', 'email', 'session_type_id', 'venue_id', 'session_date', 'slot_time'];
foreach ($required as $field) {
    if (empty($input[$field])) {
        http_response_code(400);
        echo json_encode(["error" => "Missing required field: $field"]);
        exit();
    }
}

try {
    $pdo = new PDO("mysql:host=localhost;dbname=my_star_job", "root", "Raghavhee@060524");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Optional: prevent duplicate slot booking
    $check = $pdo->prepare("
        SELECT COUNT(*) FROM sessions
        WHERE session_type_id = :type_id AND venue_id = :venue_id
        AND session_date = :date AND slot_time = :slot
    ");
    $check->execute([
        ':type_id' => $input['session_type_id'],
        ':venue_id' => $input['venue_id'],
        ':date' => $input['session_date'],
        ':slot' => $input['slot_time']
    ]);
    if ($check->fetchColumn() > 0) {
        http_response_code(409);
        echo json_encode(["error" => "Slot already booked for this time."]);
        exit();
    }

    $stmt = $pdo->prepare("
        INSERT INTO sessions (session_type_id, venue_id, session_date, slot_time, company)
        VALUES (:type_id, :venue_id, :date, :slot, :company)
    ");
    $stmt->execute([
        ':type_id' => $input['session_type_id'],
        ':venue_id' => $input['venue_id'],
        ':date' => $input['session_date'],
        ':slot' => $input['slot_time'],
        ':company' => $input['company']
    ]);

    http_response_code(200);
    echo json_encode(["success" => true, "message" => "Session registered successfully"]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "error" => "Database error",
        "details" => $e->getMessage() // remove this in production
    ]);
}
?>
