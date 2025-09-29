<?php
// Real register endpoint for Chatsy app
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, key, token, VERSIONCODE, lang, DEVICETYPE');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

// Database credentials
$servername = "localhost";
$username = "aichocka_alex";
$password = "SamAlex83—";
$dbname = "aichocka_aichatsy_5";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode([
        'responseCode' => 0,
        'responseMsg' => 'Database connection failed',
        'data' => null
    ]);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get input data
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        $input = $_POST;
    }
    
    $email = $input['email'] ?? '';
    $password = $input['password'] ?? '';
    $name = $input['name'] ?? '';
    
    if (empty($email) || empty($password)) {
        echo json_encode([
            'responseCode' => 0,
            'responseMsg' => 'Email and password are required',
            'data' => null
        ]);
        exit();
    }
    
    // Check if user already exists
    $stmt = $conn->prepare("SELECT user_id FROM user_master WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        echo json_encode([
            'responseCode' => 0,
            'responseMsg' => 'User already exists',
            'data' => null
        ]);
        exit();
    }
    
    // Insert new user
    $stmt = $conn->prepare("INSERT INTO user_master (name, email, password, is_first_time, created_at, updated_at) VALUES (?, ?, ?, 1, NOW(), NOW())");
    $stmt->bind_param("sss", $name, $email, $password);
    
    if ($stmt->execute()) {
        $new_user_id = $conn->insert_id;
        
        echo json_encode([
            'responseCode' => 1,
            'responseMsg' => 'Registration successful',
            'data' => [
                'user' => [
                    'id' => $new_user_id,
                    'name' => $name,
                    'email' => $email
                ],
                'token' => 'user_token_' . $new_user_id . '_' . time()
            ]
        ]);
    } else {
        echo json_encode([
            'responseCode' => 0,
            'responseMsg' => 'Registration failed',
            'data' => null
        ]);
    }
} else {
    echo json_encode([
        'responseCode' => 0,
        'responseMsg' => 'Method not allowed',
        'data' => null
    ]);
}

$conn->close();
?>
