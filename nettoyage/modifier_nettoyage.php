<?php
include 'config.php';

$id_nettoyage = $_POST['id_nettoyage'];
$id_vehicule = $_POST['id_vehicule'];
$id_chauffeur = $_POST['id_chauffeur'];
$date_nettoyage = $_POST['date_nettoyage'];
$photo_avant = $_POST['photo_avant'];
$photo_apres = $_POST['photo_apres'];



$sql = "UPDATE Nettoyage_vehicule SET ID_vehicule='$id_vehicule', ID_chauffeur='$id_chauffeur', Date_nettoyage='$date_nettoyage', Photo_avant='$photo_avant', Photo_apres='$photo_apres' WHERE ID_nettoyage='$id_nettoyage'";


if ($conn->query($sql) === TRUE) {
    echo "Nettoyage du véhicule ajouté avec succès";
} else {
    echo "Erreur : " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
