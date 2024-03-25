import 'dart:io';
import 'package:http/http.dart' as http;

class CarburantService {
  static const String apiUrl = 'http://localhost/wbcc/carburant/ajouter_achat_carburant.php';

  Future<Map<String, dynamic>> addAchatCarburant(Map<String, dynamic> carburantData, File? photoAvant) async {
    try {
            var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      Map<String, String> CarburantString = carburantData.map((key, value) => MapEntry(key, value.toString()));
      request.fields.addAll(CarburantString);
      print("carburantData$carburantData");

      if (photoAvant != null) {
        request.files.add(await http.MultipartFile.fromPath('facture', photoAvant.path));
      }
print("request:${request.fields}");
var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("suuuuuu : ${response.body}");
        return {'status': 'success', 'message': 'Nettoyage ajouté avec succès'};
      } else {
        print("fffff : ${response.body}");
        return {'status': 'error', 'message': 'Erreur lors de l\'ajout du nettoyage: ${response.statusCode}'};
      }
    } catch (e) {
      
      return {'status': 'error', 'message': 'Erreur lors de l\'ajout du nettoyage: $e'};
    }
  }
}
