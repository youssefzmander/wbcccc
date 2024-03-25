import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:wbcc/services/LocalStorageService.dart';

import 'package:wbcc/services/ajjout_nettoyage.dart';
import 'package:wbcc/view/BottomNavigation.dart';
import 'package:path/path.dart' as path;
class AjouterNettoyagePage extends StatefulWidget {
  @override
  _AjouterNettoyagePageState createState() => _AjouterNettoyagePageState();
}

class _AjouterNettoyagePageState extends State<AjouterNettoyagePage> {
  final _nettoyageService = NettoyageService();
  File? _photoAvant;
  File? _photoApres;
  late String chiid = "";
  late String vhiid = "";
  late String vehicule="";
  late String chauffeur="";
  DateTime? daate;

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
          _photoApres = File(file.path!);
          print("appre:${_photoApres}");

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
    }
  }
void reloadWidget() {
    // Reload the widget after a delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        
      });
    });
  }
  void _ajouterNettoyage(BuildContext context) async {
    try{
    if (chiid.isEmpty || vhiid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Les données nécessaires sont incomplètes')),
      );
      return;
    }

    int? idChauffeur = int.tryParse(chiid);
    int? idVehicule = int.tryParse(vhiid);

    final nettoyageData = {
      'ID_vehicule': idVehicule,
      'ID_chauffeur': idChauffeur,
      'Date_nettoyage': daate?.toIso8601String(),
    };

    final result = await _nettoyageService.ajouterNettoyage(nettoyageData, _photoAvant, _photoApres);

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
      SnackBar(content: Text("Verifier vos donnes",textAlign: TextAlign.center,), backgroundColor: Colors.red),
    );
    }
    }catch(e){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("erreur $e",textAlign: TextAlign.center,), backgroundColor: Colors.red),
    );
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un nettoyage',style: TextStyle( fontWeight: FontWeight.bold),),
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
                'Choisir la datede nettoyage',
style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
),
),
SizedBox(height: 10),
          Text('Date selectionne: $daate'),
SizedBox(height: 20),
Text('Photo avant le nettoyage'),
SizedBox(height: 20),
ElevatedButton(
onPressed: () {
_openFilePicker(true); 
},
child: Text('Sélectionner photo avant'),
),
_photoAvant != null
? Text('Photo avant sélectionnée : ${path.basename(_photoAvant!.path)}')
: Container(),
SizedBox(height: 20),
Text('Photo apres le nettoyage'),
SizedBox(height: 20),

ElevatedButton(
onPressed: () {
_openFilePicker(false); 
},
child: Text('Sélectionner photo après'),
),
_photoApres != null

? Text('Photo après sélectionnée : ${_photoApres!.path}')
: Container(),
SizedBox(height: 20),
ElevatedButton(
onPressed: () {
_ajouterNettoyage(context);
},
child: Text('Ajouter'),
),
],
),
),
);
}
}
