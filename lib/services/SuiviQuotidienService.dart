import 'dart:io';

import 'package:http/http.dart' as http;


class SuiviQuotidienService {
  static const String apiUrl = 'http://localhost/wbcc/suivi/ajouter_suivi_quotidien.php';

  Future<Map<String, dynamic>> addSuiviQuotidien(Map<String, dynamic> suiviData, File? photoAvant) async {
    try{
            var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      Map<String, String> suiviDataString = suiviData.map((key, value) => MapEntry(key, value.toString()));
      request.fields.addAll(suiviDataString);
      if (photoAvant != null) {
        request.files.add(await http.MultipartFile.fromPath('preuve', photoAvant.path));
      }

    print("request:${request.fields}");
print("request:${request.files.last.toString()}");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        
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
