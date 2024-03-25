class Chauffeur {
  final int id_chauffeur;
  final String nom;
  final String prenom;
  final String adresse;
  final String telephone;
  final String email;

  Chauffeur({
    required this.id_chauffeur,
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.telephone,
    required this.email,
  });

  factory Chauffeur.fromJson(Map<String, dynamic> json){
    return Chauffeur(
      id_chauffeur: json['ID_chauffeur'],
      nom: json['Nom'],
      prenom: json['Prenom'],
      adresse: json['Adresse'],
      telephone: json['Telephone'],
      email: json['Email'],
    );
  }

Map<String, dynamic> toJson() {
    return {
      'id': id_chauffeur,
      'nom': nom,
      'prenom': prenom,
      'adresse': adresse,
      'telephone': telephone,
      'email': email,
    };
  }
}