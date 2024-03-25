<?php
header('Content-Type: application/json');
include '../config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if (
        isset($_POST['ID_vehicule']) &&
        isset($_POST['ID_chauffeur']) &&
        isset($_POST['date_achat']) &&
        isset($_POST['montant']) &&
        isset($_POST['litres']) &&
        isset($_FILES['facture'])
    ) {
        $id_vehicule = $_POST['ID_vehicule'];
        $id_chauffeur = $_POST['ID_chauffeur'];
        $date_achat = $_POST['date_achat'];
        $montant = $_POST['montant'];
        $litres = $_POST['litres'];

       
        $facture = $_FILES['facture'];
        $facture_path = '../uploads/' . $facture['name'];
        move_uploaded_file($facture['tmp_name'], $facture_path);

        
        $date_achat = date('Y-m-d', strtotime($date_achat));

        $sql = "INSERT INTO Achat_carburant (ID_vehicule, ID_chauffeur, Date_achat, Montant, Litres, Facture) VALUES ('$id_vehicule', '$id_chauffeur', '$date_achat', '$montant', '$litres', '$facture_path')";
        if ($conn->query($sql) === TRUE) {
            echo json_encode(['status' => 'success', 'message' => 'Achat de carburant ajouté avec succès']);
        } else {
            http_response_code(500);
            echo json_encode(['status' => 'error', 'message' => 'Erreur lors de l\'insertion dans la base de données: ' . $conn->error]);
        }
    } else {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'Données incomplètes, veuillez fournir toutes les informations nécessaires']);
    }
} else {
    http_response_code(405);
    echo json_encode(['status' => 'error', 'message' => 'Méthode non autorisée']);
}
?>
