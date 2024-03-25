<?php
include '../config.php';

$id_chauffeur = $_POST['id_chauffeur'];
$nom = $_POST['nom'];
$prenom = $_POST['prenom'];
$adresse = $_POST['adresse'];
$telephone = $_POST['telephone'];
$email = $_POST['email'];

$sql = "UPDATE Chauffeur SET Nom='$nom', Prenom='$prenom', Adresse='$adresse', Telephone='$telephone', Email='$email' WHERE ID_chauffeur='$id_chauffeur'";

if ($conn->query($sql) === TRUE) {
    echo "Chauffeur ajouté avec succès";
} else {
    echo "Erreur : " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
