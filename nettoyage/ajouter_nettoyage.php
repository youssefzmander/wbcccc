<?php
header('Content-Type: application/json');
include '../config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $data = $_POST;

    if (
        isset($data['ID_vehicule']) &&
        isset($data['ID_chauffeur']) &&
        isset($data['Date_nettoyage']) &&
        isset($_FILES['Photo_avant']) &&
        isset($_FILES['Photo_apres'])
    ) {
        $id_vehicule = $data['ID_vehicule'];
        $id_chauffeur = $data['ID_chauffeur'];
        $date_nettoyage = $data['Date_nettoyage'];

        $photo_avant = $_FILES['Photo_avant'];
        $photo_apres = $_FILES['Photo_apres'];

        $photo_avant_path = '../uploads/' . $photo_avant['name'];
        $photo_apres_path = '../uploads/' . $photo_apres['name'];
        move_uploaded_file($photo_avant['tmp_name'], $photo_avant_path);
        move_uploaded_file($photo_apres['tmp_name'], $photo_apres_path);

        $sql = "INSERT INTO Nettoyage_vehicule (ID_vehicule, ID_chauffeur, Date_nettoyage, Photo_avant, Photo_apres) VALUES ('$id_vehicule', '$id_chauffeur', '$date_nettoyage', '$photo_avant_path', '$photo_apres_path')";
        if ($conn->query($sql) === TRUE) {
            echo json_encode(['status' => 'success', 'message' => 'Nettoyage ajouté avec succès']);
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
