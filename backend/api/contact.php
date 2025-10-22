<?php
// Correct, complete CORS headers
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
$requiredFields = ['name', 'country', 'contact', 'email', 'company', 'jobTitle', 'inquiries'];
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
        INSERT INTO contacts (name, country, contact, email, company, jobTitle, inquiries)
        VALUES (:name, :country, :contact, :email, :company, :jobTitle, :inquiries)
    ");

    $stmt->execute([
        ':name' => $data['name'],
        ':country' => $data['country'],
        ':contact' => $data['contact'],
        ':email' => $data['email'],
        ':company' => $data['company'],
        ':jobTitle' => $data['jobTitle'],
        ':inquiries' => $data['inquiries'],
    ]);

    echo json_encode(["message" => "Contact form saved!", "status" => "success"]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => "Database error", "details" => $e->getMessage()]);
}