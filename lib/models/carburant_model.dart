
class Carburant {
  final int idVehicule;
  final int idChauffeur;
  final DateTime dateAchat;
  final double montant;
  final double litres;
  final String facture;

  Carburant({
    required this.idVehicule,
    required this.idChauffeur,
    required this.dateAchat,
    required this.montant,
    required this.litres,
    required this.facture,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_vehicule': idVehicule,
      'id_chauffeur': idChauffeur,
      'date_achat': dateAchat.toIso8601String(),
      'montant': montant,
      'litres': litres,
      'facture': facture,
    };
  }
}
