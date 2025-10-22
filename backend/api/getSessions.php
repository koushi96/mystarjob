<?php
//   Allow local development requests from Vite (localhost:5173)
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

//   Handle preflight (OPTIONS) request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');

try {
    //   Connect to database
    $pdo = new PDO("mysql:host=localhost;dbname=my_star_job;charset=utf8mb4", "root", "Raghavhee@060524");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Optional filters (if needed)
    $type_id = isset($_GET['session_type_id']) ? intval($_GET['session_type_id']) : null;
    $venue_id = isset($_GET['venue_id']) ? intval($_GET['venue_id']) : null;
    $date = isset($_GET['session_date']) ? $_GET['session_date'] : null;

    $query = "
        SELECT 
            s.id,
            s.session_type_id,
            s.company,
            s.session_date,
            s.slot_time,
            st.type_name AS session_type,
            v.venue_city AS venue
        FROM sessions s
        JOIN session_type st ON s.session_type_id = st.id
        JOIN exhibition_venue v ON s.venue_id = v.id
        WHERE 1=1
    ";

    $params = [];

    if ($type_id) {
        $query .= " AND s.session_type_id = :type_id";
        $params[':type_id'] = $type_id;
    }

    if ($venue_id) {
        $query .= " AND s.venue_id = :venue_id";
        $params[':venue_id'] = $venue_id;
    }

    if ($date) {
        $query .= " AND s.session_date = :date";
        $params[':date'] = $date;
    }

    $query .= " ORDER BY s.session_date ASC, s.slot_time ASC";

    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    $sessions = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($sessions);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "error" => "Database connection failed",
        "details" => $e->getMessage()
    ]);
}
?>
