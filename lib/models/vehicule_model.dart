class Vehicule {
  final int id_vehicule;
  final String immatriculation;
  final String marque;
  final String modele;
  final String type_carburant;
  final int kilometrage;
  

  
  Vehicule({
    
    required this.id_vehicule, 
    required this.immatriculation, 
    required this.marque, 
    required this.modele, 
    required this.type_carburant, 
    required this.kilometrage});
  
  factory Vehicule.fromJson(Map<String, dynamic> json){
    return Vehicule(
      id_vehicule: json['ID_vehicule'],
      immatriculation: json['Immatriculation'],
      marque: json['Marque'],
      modele: json['Modele'],
      type_carburant: json['Type_carburant'],
      kilometrage: json['Kilometrage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_vehicule': id_vehicule,
      'immatriculation': immatriculation,
      'marque': marque,
      'modele': modele,
      'type_carburant': type_carburant,
      'kilometrage': kilometrage,
    };
  }

}
