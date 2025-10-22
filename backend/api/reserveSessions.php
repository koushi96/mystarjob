<?php
// POST endpoint
header("Access‑Control‑Allow‑Origin: http://localhost:5173");
header("Access‑Control‑Allow‑Methods: POST, OPTIONS");
header("Access‑Control‑Allow‑Headers: Content‑Type");
header("Access‑Control‑Allow‑Credentials: true");
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);
$required = ['session_id','company','contact_person','job_title','contact_number','email'];
$missing = [];
foreach ($required as $f) {
    if (empty($data[$f])) {
        $missing[] = $f;
    }
}
if (!empty($missing)) {
    http_response_code(400);
    echo json_encode(["error"=>"Missing fields","fields"=>$missing]);
    exit();
}

try {
    $pdo = new PDO("mysql:host=localhost;dbname=my_star_job", "root", "Raghavhee@060524");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $stmt = $pdo->prepare("
      INSERT INTO reservations (session_id, company, contact_person, job_title, contact_number, email)
      VALUES (:session_id, :company, :contact_person, :job_title, :contact_number, :email)
    ");
    $stmt->execute([
      ':session_id'=>$data['session_id'],
      ':company'=>$data['company'],
      ':contact_person'=>$data['contact_person'],
      ':job_title'=>$data['job_title'],
      ':contact_number'=>$data['contact_number'],
      ':email'=>$data['email']
    ]);
    echo json_encode(["message"=>"Reservation successful","status"=>"success"]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error"=>"Database error","details"=>$e->getMessage()]);
}
?>