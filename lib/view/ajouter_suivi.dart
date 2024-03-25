import 'dart:convert';
import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:wbcc/services/LocalStorageService.dart';
import 'package:wbcc/services/SuiviQuotidienService.dart';
import 'package:wbcc/view/BottomNavigation.dart';
import 'package:path/path.dart' as path;


class AjouterSuiviPage extends StatefulWidget {
  @override
  _AjouterSuiviPageState createState() => _AjouterSuiviPageState();
}

class _AjouterSuiviPageState extends State<AjouterSuiviPage> {
  final _suiviService = SuiviQuotidienService();
  File? _photoAvant;
  DateTime? daate;
  TextEditingController _kilometrageReleveController = TextEditingController();
  TextEditingController _niveauCarburantController = TextEditingController();
  late String chiid="";
  late String vhiid="";
  late String vehicule="";
  late String chauffeur="";
  
  @override
  void initState() {
    super.initState();
    _chargerDonnees();
  }
  void _openFilePicker(bool isPhotoAvant) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        if (isPhotoAvant) {
          _photoAvant = File(file.path!);
          print("avant:${_photoAvant}");
        } else {
         

        }
      });
    } else {
      print('Aucun fichier sélectionné');
    }
  }

  Future<void> _chargerDonnees() async {
  String? vehiculeData = await LocalStorageService.getData("vehicule");
  String? chauffeurData = await LocalStorageService.getData("chauffeur");

  if (vehiculeData != null && chauffeurData != null) {
    vehicule = vehiculeData;
    chauffeur = chauffeurData;

    Map<String, dynamic> parsedJsonVehicule = jsonDecode(vehicule);
    vhiid = parsedJsonVehicule['id_vehicule'].toString();

    Map<String, dynamic> parsedJsonChauffeur = jsonDecode(chauffeur);
    chiid = parsedJsonChauffeur['id'].toString();
    print("aaaaaa$chiid");
    print("bbbbb$vhiid");
  }else{
    print("nope");
  }
}
 void reloadWidget() {
    // Reload the widget after a delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        
      });
    });
  }
 Future<void> _ajouterSuivi(BuildContext context) async {
  
try{
  int? idChauffeur = int.tryParse(chiid);
  int? idVehicule = int.tryParse(vhiid);

  if (idChauffeur == null || idVehicule == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Les identifiants du chauffeur ou du véhicule sont invalides')),
    );
    return;
  }

  final suiviData = {
    'id_vehicule': idChauffeur,
    'id_chauffeur': idVehicule,
    'date_suivi': daate?.toIso8601String(),
    'kilometrage_releve': int.parse(_kilometrageReleveController.text),
    'niveau_carburant': int.parse(_niveauCarburantController.text),
    
  };
print("suiviData:$suiviData");
  final result = await _suiviService.addSuiviQuotidien(suiviData, _photoAvant);

    if (result['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.green),
      );
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          ); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
    }catch(e){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Verifier vos donnes",textAlign: TextAlign.center,), backgroundColor: Colors.red),
    );
}
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Ajouter un suivi quotidien',style: TextStyle( fontWeight: FontWeight.bold),),
        backgroundColor: Colors.red,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          ElevatedButton(
            
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  
                  
                  minTime: DateTime(2000, 1, 1),
                  maxTime: DateTime(2027, 1, 1), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                daate=date;
                print('confirm $date');
                reloadWidget();
              }, currentTime: DateTime.now(), locale: LocaleType.fr);
            },
            child: const Text(
              'Choisir la date de suivie',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15.0),
            ),
          ),
          SizedBox(height: 10),
          Text('Date selectionne: $daate'),
          SizedBox(height: 10),
          Text('Kilométrage relevé'),
          TextField(controller: _kilometrageReleveController),
          SizedBox(height: 10),
          Text('Niveau de carburant'),
          
          TextField(controller: _niveauCarburantController),
          
          SizedBox(height: 10),
          Text('Photo avant le nettoyage'),
          SizedBox(height: 20),
          ElevatedButton(
          onPressed: () {
          _openFilePicker(true);  
          },
          child: Text('Sélectionner photo Preuve'),
          ),
          _photoAvant != null
          ? Text('Photo Preuve sélectionnée : ${path.basename(_photoAvant!.path)}')
          : Container(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            
              print(chiid);
              print(vhiid);
              _ajouterSuivi(context);
            },
            child: Text('Ajouter'),
          ),
        ],
      ),
    ),
  );
}


  
}