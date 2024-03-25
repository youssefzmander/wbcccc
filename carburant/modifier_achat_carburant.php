<?php
include '../config.php';

$id_achat = $_POST['id_achat'];
$id_vehicule = $_POST['id_vehicule'];
$id_chauffeur = $_POST['id_chauffeur'];
$date_achat = $_POST['date_achat'];
$montant = $_POST['montant'];
$litres = $_POST['litres'];
$facture = $_POST['facture'];



$sql = "UPDATE Achat_carburant SET ID_vehicule='$id_vehicule', ID_chauffeur='$id_chauffeur', Date_achat='$date_achat', Montant='$montant', Litres='$litres', Facture='$facture' WHERE ID_achat='$id_achat'";


if ($conn->query($sql) === TRUE) {
    echo "Achat de carburant modifié avec succès";
} else {
    echo "Erreur : " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
