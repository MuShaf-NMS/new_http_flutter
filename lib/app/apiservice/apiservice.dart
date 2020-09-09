import 'package:http_flutter/app/models/siswa.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiServices {
  static const url = 'https://api-v2.pondokdiya.id';
  Future<List<Siswa>> getData() async {
    final response = await http.get("$url/siswa");
    if (response.statusCode == 200) {
      return getAll(response.body);
    } else {
      throw Exception('Oops');
    }
  }

  Future<Siswa> getSiswa(int id) async {
    final response = await http.get('$url/siswa/$id');
    if (response.statusCode == 200) {
      return getOne(response.body);
    }
  }

  Future<bool> postData(Siswa data) async {
    final response = await http.post('$url/add-siswa',
        headers: {"content-type": "application/json"}, body: dataToJson(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> putData(Siswa data, int id) async {
    final response = await http.put('$url/siswa/$id',
        headers: {"content-type": "application/json"}, body: dataToJson(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    final resposne = await http.delete('$url/delete-siswa/$id',
        headers: {"content-type": "application/json"});
    if (resposne.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
