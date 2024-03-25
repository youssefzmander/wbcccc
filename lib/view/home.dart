

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wbcc/services/LocalStorageService.dart';
import 'package:wbcc/services/vehicule_service.dart';
import 'package:wbcc/view/ajouter_carburant.dart';
import 'package:wbcc/view/ajouter_nettoyage.dart';
import 'package:wbcc/view/ajouter_suivi.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  late String matricule="";
  late String matt="";
  late String vhiid="";
  late String vehicule="";

  
@override
  void initState() {
    super.initState();
    reloadWidget();
  }
  void reloadWidget() {
    // Reload the widget after a delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _chargerDonnees();
      });
    });
  }
Future<void> _chargerDonnees() async {
  String? vehiculeData = await LocalStorageService.getData("vehicule");
  String? chauffeurData = await LocalStorageService.getData("chauffeur");

  if (vehiculeData != null && chauffeurData != null) {
    vehicule = vehiculeData;
    

    Map<String, dynamic> parsedJsonVehicule = jsonDecode(vehicule);
    matt = parsedJsonVehicule['immatriculation'].toString();

    
    
    print("bbbbb$vhiid");
  }else{
    print("nope");
  }
}


@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Entrer immatriculation de votre voiture',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    print('Value changed: $value');
                    matricule=value;

                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  print('OK button pressed');
                  LocalStorageService.clearData("vehicule");
                  VehiculeService().fetchAndSaveVehiculeByImmatriculation(matricule).then((value) => {
                    matt=matricule,
                  });
                  reloadWidget();
                },
              ),
            ],
          ),
           ListTile(
            title: Text('Immatriculation Vehicule : $matt ', style: TextStyle(fontSize: 20)),
          ),
          

          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              print('Card clicked');
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjouterSuiviPage()),
          );            
          },
          
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.control_point, size: 50),
                title: Text('suivi quotidien'),
                subtitle: Text(
                    'Relever le kilométrage et le carburant avec preuve'),
              ),
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              print('Card clicked');
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjouterNettoyagePage()),
          ); 
            },
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.cleaning_services, size: 50),
                title: Text('nettoyage du véhicule'),
                subtitle: Text(
                    'Prendre des photos, vidéos avant et après nettoyage.'),
              ),
            ),
          ),
const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              print('Card clicked');
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjouterCarburantPage()),
          );            
          },
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.local_gas_station, size: 50),
                title: Text('Achat carburant'),
                subtitle: Text(
                    'Entrer montant, nombre de litres, facture (Photos).'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}