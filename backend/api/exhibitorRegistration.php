<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true");

// Handle preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Set JSON response
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

// Validation
$requiredFields = ['company', 'contactPerson', 'jobTitle', 'contactNumber', 'email', 'venue', 'date'];
$missing = [];

foreach ($requiredFields as $field) {
    if (empty($data[$field])) {
        $missing[] = $field;
    }
}

if (!empty($missing)) {
    http_response_code(400);
    echo json_encode(["error" => "Missing fields", "fields" => $missing]);
    exit();
}

//   Connect to MySQL
try {
    $pdo = new PDO("mysql:host=localhost;dbname=my_star_job", "root", "Raghavhee@060524");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    //   Insert into contacts table
    $stmt = $pdo->prepare("
        INSERT INTO exhibitorList (company, contactPerson, jobTitle, contactNumber, email, venue, date)
        VALUES (:company, :contactPerson, :jobTitle, :contactNumber, :email, :venue, :date)
    ");

    $stmt->execute([
        ':company' => $data['company'],
        ':contactPerson' => $data['contactPerson'],
        ':jobTitle' => $data['jobTitle'],
        ':contactNumber' => $data['contactNumber'],
        ':email' => $data['email'],
        ':venue' => $data['venue'],
        ':date' => $data['date'],
    ]);

    echo json_encode(["message" => "Exhibitor has been registered successfully", "status" => "success"]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => "Database error", "details" => $e->getMessage()]);
}