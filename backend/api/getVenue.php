<?php
//   CORS headers for Vite dev server
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true");

//   Handle preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

//   Set JSON response header
header('Content-Type: application/json');

//   Connect to MySQL using PDO
try {
    $pdo = new PDO("mysql:host=localhost;dbname=my_star_job", "root", "Raghavhee@060524");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    //   Query the venues
    $stmt = $pdo->query("SELECT id, venue_city FROM exhibition_venue");

    $venues = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($venues);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "error" => "Database error",
        "details" => $e->getMessage()
    ]);
}
?>