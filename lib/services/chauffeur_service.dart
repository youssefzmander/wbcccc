import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wbcc/models/chauffeur_model.dart';
import 'package:wbcc/services/LocalStorageService.dart';
import 'package:wbcc/view/BottomNavigation.dart';

class ChauffeurService {
  static const String apiUrl = 'http://localhost/wbcc/chauffeur/get_chauffeur.php';
  
  

  Future<void> fetchAndSaveChauffeurByEmail(BuildContext context,String email) async {
    print("email$email");
    try{
    final response = await http.get(Uri.parse('$apiUrl?email=$email'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      final chauffeur = Chauffeur.fromJson(data);

      final chauffeurJson = json.encode(chauffeur.toJson());
      await LocalStorageService.saveData('chauffeur', chauffeurJson);
      print("added $chauffeurJson");
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(content: Text("Login avec succe",textAlign: TextAlign.center,), backgroundColor: Colors.green),
    );
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          );
    } else {
      
      throw Exception('Failed to load chauffeur${response.statusCode}');
    }
    }catch(e){
ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(content: Text("Mail non trouvé",textAlign: TextAlign.center,), backgroundColor: Colors.red),
    );
    }
  }
}
