import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wbcc/models/vehicule_model.dart';
import 'package:wbcc/services/LocalStorageService.dart';


class VehiculeService {
  static const String apiUrl = 'http://localhost/wbcc/vehicule/get_vehicule.php';

  Future<void> fetchAndSaveVehiculeByImmatriculation(String immatriculation) async {
    print(immatriculation);
    final response = await http.get(Uri.parse('$apiUrl?Immatriculation=$immatriculation'));
    if (response.statusCode == 200) {
      
      await LocalStorageService.clearData('vehicule');
      final dynamic data = json.decode(response.body);
      final vehicule = Vehicule.fromJson(data);

      final vehiculeJson = json.encode(vehicule.toJson());
      await LocalStorageService.saveData('vehicule', vehiculeJson);
      print(vehiculeJson);
      
    } else {
      print(response.body);
      throw Exception('Failed to load vehicule');
    }
  }
}
