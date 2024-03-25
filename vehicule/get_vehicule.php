<?php
include '../config.php';

if (isset($_GET['Immatriculation'])) { 
    $immatriculation = $_GET['Immatriculation'];

    $requete = $conn->prepare("SELECT * FROM Vehicule WHERE Immatriculation = ?");
    $requete->bind_param('s', $immatriculation);
    $requete->execute();

    $resultat = $requete->get_result();
    
    if ($resultat->num_rows > 0) {
        $vehicule = $resultat->fetch_assoc();

        header('Content-Type: application/json');
        echo json_encode($vehicule);
    } else {
        http_response_code(404);
        echo json_encode(array('message' => 'Véhicule non trouvé'));
    }

    $requete->close();
    $conn->close();
} else {
    http_response_code(400);
    echo json_encode(array('message' => 'Immatriculation non spécifiée'));
}
?>
