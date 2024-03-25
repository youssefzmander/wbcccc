
class SuiviQuotidien {
  final int idSuivi;
  final int idVehicule;
  final int idChauffeur;
  final DateTime dateSuivi;
  final int kilometrageReleve;
  final int niveauCarburant;
  final String preuve;

  SuiviQuotidien({
    required this.idSuivi,
    required this.idVehicule,
    required this.idChauffeur,
    required this.dateSuivi,
    required this.kilometrageReleve,
    required this.niveauCarburant,
    required this.preuve,
  });

  factory SuiviQuotidien.fromJson(Map<String, dynamic> json) {
    return SuiviQuotidien(
      idSuivi: json['ID_suivi'],
      idVehicule: json['ID_vehicule'],
      idChauffeur: json['ID_chauffeur'],
      dateSuivi: DateTime.parse(json['Date_suivi']),
      kilometrageReleve: json['Kilometrage_releve'],
      niveauCarburant: json['Niveau_carburant'],
      preuve: json['Preuve'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_suivi': idSuivi,
      'id_vehicule': idVehicule,
      'id_chauffeur': idChauffeur,
      'date_suivi': dateSuivi.toIso8601String(),
      'kilometrage_releve': kilometrageReleve,
      'niveau_carburant': niveauCarburant,
      'preuve': preuve,
    };
  }
}
