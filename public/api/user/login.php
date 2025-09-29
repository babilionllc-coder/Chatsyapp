<?php
// Real login endpoint for Chatsy app
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, key, token, VERSIONCODE, lang, DEVICETYPE');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

// Database credentials
$servername = "localhost";
$username = "aichocka_alex"; // Your Namecheap database username
$password = "SamAlex83—"; // Your Namecheap database password
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
    
    if (empty($email) || empty($password)) {
        echo json_encode([
            'responseCode' => 0,
            'responseMsg' => 'Email and password are required',
            'data' => null
        ]);
        exit();
    }
    
    // Find user by email
    $stmt = $conn->prepare("SELECT * FROM user_master WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        // Simple password check (you might want to use proper hashing)
        if ($user['password'] === $password) {
            echo json_encode([
                'responseCode' => 1,
                'responseMsg' => 'Login successful',
                'data' => [
                    'user' => [
                        'id' => $user['user_id'],
                        'name' => $user['name'],
                        'email' => $user['email']
                    ],
                    'token' => 'user_token_' . $user['user_id'] . '_' . time()
                ]
            ]);
        } else {
            echo json_encode([
                'responseCode' => 0,
                'responseMsg' => 'Invalid password',
                'data' => null
            ]);
        }
    } else {
        echo json_encode([
            'responseCode' => 0,
            'responseMsg' => 'User not found',
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