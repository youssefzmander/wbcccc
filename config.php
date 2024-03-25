<?php
define('DB_HOST', 'localhost');
define('DB_USER', 'admin'); 
define('DB_PASS', '000000'); 
define('DB_NAME', 'WBCC');

$conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

if ($conn->connect_error) {
    die("Erreur de connexion à la base de données : " . $conn->connect_error);
}
?>
