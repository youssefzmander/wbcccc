class Nettoyage {
  
  final int idVehicule;
  final int idChauffeur;
  final String dateNettoyage;
  final String photoAvant;
  final String photoApres;

  Nettoyage({
    
    required this.idVehicule,
    required this.idChauffeur,
    required this.dateNettoyage,
    required this.photoAvant,
    required this.photoApres,
  });

  factory Nettoyage.fromJson(Map<String, dynamic> json) {
    return Nettoyage(
      
      idVehicule: json['ID_vehicule'],
      idChauffeur: json['ID_chauffeur'],
      dateNettoyage: json['Date_nettoyage'],
      photoAvant: json['Photo_avant'],
      photoApres: json['Photo_apres'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      
      'ID_vehicule': idVehicule,
      'ID_chauffeur': idChauffeur,
      'Date_nettoyage': dateNettoyage,
      'Photo_avant': photoAvant,
      'Photo_apres': photoApres,
    };
  }
}
