<?php
include '../config.php';

if (isset($_GET['email'])) {
    $email_chauffeur = $_GET['email'];

    $requete = $conn->prepare("SELECT * FROM Chauffeur WHERE Email = ?");
    $requete->bind_param('s', $email_chauffeur); 
    $requete->execute();

    $resultat = $requete->get_result();
    
    if ($resultat->num_rows > 0) {
        $chauffeur = $resultat->fetch_assoc();

        header('Content-Type: application/json');
        echo json_encode($chauffeur);
    } else {
        echo json_encode(array('message' => 'Chauffeur non trouvé'));
    }

    $requete->close();
    $conn->close();
} else {
    echo json_encode(array('message' => 'E-mail du chauffeur non spécifié'));
}
?>
