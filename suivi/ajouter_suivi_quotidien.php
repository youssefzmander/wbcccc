<?php
include '../config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if (
        isset($_POST['id_vehicule']) &&
        isset($_POST['id_chauffeur']) &&
        isset($_POST['date_suivi']) &&
        isset($_POST['kilometrage_releve']) &&
        isset($_POST['niveau_carburant']) &&
        isset($_FILES['preuve'])
    ) {
        $id_vehicule = mysqli_real_escape_string($conn, $_POST['id_vehicule']);
        $id_chauffeur = mysqli_real_escape_string($conn, $_POST['id_chauffeur']);
        $date_suivi = mysqli_real_escape_string($conn, $_POST['date_suivi']);
        $kilometrage_releve = mysqli_real_escape_string($conn, $_POST['kilometrage_releve']);
        $niveau_carburant = mysqli_real_escape_string($conn, $_POST['niveau_carburant']);

        $preuve = $_FILES['preuve'];
        $preuve_path = '../uploads/' . $preuve['name'];
        move_uploaded_file($preuve['tmp_name'], $preuve_path);

        $requete = $conn->prepare("INSERT INTO Suivi_quotidien (ID_vehicule, ID_chauffeur, Date_suivi, Kilometrage_releve, Niveau_carburant, Preuve) VALUES (?, ?, ?, ?, ?, ?)");
        $requete->bind_param('iissis', $id_vehicule, $id_chauffeur, $date_suivi, $kilometrage_releve, $niveau_carburant, $preuve_path);
        if ($requete->execute()) {
            http_response_code(201);
            echo json_encode(array('message' => 'Suivi quotidien ajouté avec succès'));
        } else {
            http_response_code(500);
            echo json_encode(array('message' => 'Erreur lors de l\'ajout du suivi quotidien'));
        }

        $requete->close();
        $conn->close();
    } else {
        http_response_code(400);
        echo json_encode(array('message' => 'Données incomplètes, veuillez fournir toutes les informations nécessaires'));
    }
} else {
    http_response_code(405);
    echo json_encode(array('message' => 'Méthode non autorisée'));
}
?>
