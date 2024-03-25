<?php
include '../config.php';

$immatriculation = $_POST['immatriculation'];
$marque = $_POST['marque'];
$modele = $_POST['modele'];
$type_carburant = $_POST['type_carburant'];
$kilometrage = $_POST['kilometrage'];

$sql = "INSERT INTO Vehicule (Immatriculation,Marque, Modele, Type_carburant, Kilometrage) VALUES ('$immatriculation','$marque', '$modele', '$type_carburant', '$kilometrage')";

if ($conn->query($sql) === TRUE) {
    echo "Véhicule ajouté avec succès";
} else {
    echo "Erreur : " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
