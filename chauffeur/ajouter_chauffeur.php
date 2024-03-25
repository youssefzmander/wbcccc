<?php
include '../config.php';

$nom = $_POST['nom'];
$prenom = $_POST['prenom'];
$adresse = $_POST['adresse'];
$telephone = $_POST['telephone'];
$email = $_POST['email'];

$stmt = $conn->prepare("INSERT INTO Chauffeur (Nom, Prenom, Adresse, Telephone, Email) VALUES (?, ?, ?, ?, ?)");

if ($stmt === false) {
    echo "Erreur de préparation de la requête : " . $conn->error;
    exit();
}

$stmt->bind_param('sssss', $nom, $prenom, $adresse, $telephone, $email);

if ($stmt->execute() === true) {
    echo "Chauffeur ajouté avec succès";
} else {
    echo "Erreur : " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
