<?php
include '../config.php';
$id_vehicule = $_POST['id_vehicule'];
$immatriculation = $_POST['immatriculation'];
$marque = $_POST['marque'];
$modele = $_POST['modele'];
$type_carburant = $_POST['type_carburant'];
$kilometrage = $_POST['kilometrage'];

$sql = "INSERT INTO Vehicule (Marque, Modele, Type_carburant, Kilometrage) VALUES ('$marque', '$modele', '$type_carburant', '$kilometrage')";

$sql = "UPDATE Vehicule SET Immatriculation='$immatriculation', Marque='$marque', Modele='$modele', Type_carburant='$type_carburant', Kilometrage='$kilometrage' WHERE ID_vehicule='$id_vehicule'";

if ($conn->query($sql) === TRUE) {
    echo "Véhicule ajouté avec succès";
} else {
    echo "Erreur : " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
