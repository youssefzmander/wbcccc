import 'dart:io';

import 'package:http/http.dart' as http;

class NettoyageService {
  static const String apiUrl = 'http://localhost/wbcc/nettoyage/ajouter_nettoyage.php';

  Future<Map<String, dynamic>> ajouterNettoyage(Map<String, dynamic> nettoyageData, File? photoAvant, File? photoApres) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      Map<String, String> nettoyageDataString = nettoyageData.map((key, value) => MapEntry(key, value.toString()));

      request.fields.addAll(nettoyageDataString);

      if (photoAvant != null) {
        request.files.add(await http.MultipartFile.fromPath('Photo_avant', photoAvant.path));
      }

      if (photoApres != null) {
        request.files.add(await http.MultipartFile.fromPath('Photo_apres', photoApres.path));
      }
print("request:${request.fields}");
print("request:${request.files.last.toString()}");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        
        return {'status': 'success', 'message': 'Nettoyage ajouté avec succès'};
      } else {
        print("errr : ${response.body}");
        return {'status': 'error', 'message': 'Erreur lors de l\'ajout du nettoyage: ${response.statusCode}'};
      }
    } catch (e) {
      print("e:  $e");
      return {'status': 'error', 'message': 'Erreur lors de l\'ajout du nettoyage: $e'};
    }
  }
}
