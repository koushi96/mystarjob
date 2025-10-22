<?php
//   CORS settings for Vite dev server
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true");

//   Handle preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');

//   Validate inputs
$type_id = isset($_GET['type_id']) ? intval($_GET['type_id']) : null;
$venue_id = isset($_GET['venue_id']) ? intval($_GET['venue_id']) : null;
$session_date = isset($_GET['session_date']) ? $_GET['session_date'] : null;

if (is_null($type_id) || is_null($venue_id) || is_null($session_date)) {
    http_response_code(400);
    echo json_encode(["error" => "Missing type_id, venue_id, or session_date"]);
    exit();
}

try {
    //   Connect to database
    $pdo = new PDO("mysql:host=localhost;dbname=my_star_job", "root", "Raghavhee@060524");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    //   Fetch available (unbooked) slots
    $stmt = $pdo->prepare("
        SELECT ats.slot_time
        FROM available_time_slots ats
        WHERE ats.session_type_id = :type_id
          AND ats.venue_id = :venue_id
          AND ats.session_date = :session_date
          AND ats.slot_time NOT IN (
              SELECT s.slot_time
              FROM sessions s
              WHERE s.session_type_id = :type_id
                AND s.venue_id = :venue_id
                AND s.session_date = :session_date
          )
        ORDER BY ats.slot_time ASC
    ");

    $stmt->execute([
        ':type_id' => $type_id,
        ':venue_id' => $venue_id,
        ':session_date' => $session_date
    ]);

    $slots = $stmt->fetchAll(PDO::FETCH_COLUMN);

    echo json_encode($slots);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "error" => "Database error",
        "details" => $e->getMessage() // ⚠️ Remove this in production
    ]);
}
?>