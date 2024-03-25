import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:wbcc/services/LocalStorageService.dart';
import 'package:wbcc/services/carburant_service.dart';
import 'package:wbcc/view/BottomNavigation.dart';
import 'package:path/path.dart' as path;


class AjouterCarburantPage extends StatefulWidget {
  @override
  _AjouterCarburantPageState createState() => _AjouterCarburantPageState();
}

class _AjouterCarburantPageState extends State<AjouterCarburantPage> {
  final _carburantService = CarburantService();
  File? _photoAvant;
  late String chiid = "";
  late String vhiid = "";
  late String vehicule="";
  late String chauffeur="";
  DateTime? daate;
  DateTime? dateAchat;
  TextEditingController montantController = TextEditingController();
  TextEditingController litresController = TextEditingController();
  TextEditingController factureController = TextEditingController();

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
  void _ajouterCarburant(BuildContext context) async{
    try{
    if (chiid.isEmpty || vhiid.isEmpty ) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Les données nécessaires sont incomplètes')),
      );
      return;
    }
  int? idChauffeur = int.tryParse(chiid);
  int? idVehicule = int.tryParse(vhiid);
    final carburantData = {
      'ID_vehicule': idVehicule,
      'ID_chauffeur': idChauffeur,
      'date_achat': daate?.toIso8601String(), 
      'montant': double.parse(montantController.text),
      'litres': double.parse(litresController.text),
      //'facture': factureController.text,
    };
print("datta:$carburantData");
final result = await _carburantService.addAchatCarburant(carburantData,_photoAvant);
    
    if (result['status'] == 'success') {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'],textAlign: TextAlign.center,), backgroundColor: Colors.green),
    );
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          ); 
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'],textAlign: TextAlign.center,), backgroundColor: Colors.red),
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
        title: Text('Ajouter un achat de carburant',style: TextStyle( fontWeight: FontWeight.bold),),
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
                'Choisir la date d\'achat',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ),
            SizedBox(height: 10),
          Text('Date selectionne: $daate'),
            SizedBox(height: 10),
            Text('Montant'),
            TextField(controller: montantController),
            SizedBox(height: 10),
            Text('Litres'),
            TextField(controller: litresController),
            SizedBox(height: 10),
            ElevatedButton(
            onPressed: () {
            _openFilePicker(true);  
            },
            child: Text('Sélectionner photo preuve facture'),
            ),
            _photoAvant != null
            ? Text('Photo avant sélectionnée : ${path.basename(_photoAvant!.path)}')
            : Container(),
SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _ajouterCarburant(context);
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
