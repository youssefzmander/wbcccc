<?php
include '../config.php';
$id_suivi = $_POST['id_suivi'];
$id_vehicule = $_POST['id_vehicule'];
$id_chauffeur = $_POST['id_chauffeur'];
$date_suivi = $_POST['date_suivi'];
$kilo_releve = $_POST['kilo_releve'];
$niveau_carburant = $_POST['niveau_carburant'];
$preuve = $_POST['preuve'];


$sql = "UPDATE Suivi_quotidien SET ID_vehicule='$id_vehicule',ID_chauffeur='$id_chauffeur', Date_suivi='$date_suivi', Kilometrage_releve='$kilo_releve', Niveau_carburant='$niveau_carburant', Preuve='$preuve' WHERE ID_suivi='$id_suivi'";


if ($conn->query($sql) === TRUE) {
    echo "Suivi quotidien ajouté avec succès";
} else {
    echo "Erreur : " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
