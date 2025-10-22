<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');

$type_id = isset($_GET['type_id']) ? intval($_GET['type_id']) : null;
$venue_id = isset($_GET['venue_id']) ? intval($_GET['venue_id']) : null;

try {
    $pdo = new PDO("mysql:host=localhost;dbname=my_star_job", "root", "Raghavhee@060524");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if (!$venue_id) {
        $stmt = $pdo->query("
            SELECT venue_id, exhibition_date 
            FROM exhibition_date 
            ORDER BY exhibition_date ASC
        ");
        $dates = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($dates);
        exit();
    }

    $stmt = $pdo->prepare("
        SELECT exhibition_date 
        FROM exhibition_date 
        WHERE venue_id = :venue_id
        ORDER BY exhibition_date ASC
    ");
    $stmt->execute([':venue_id' => $venue_id]);

    $dates = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo json_encode($dates);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "error" => "Database error",
        "details" => $e->getMessage()
    ]);
}
?>
