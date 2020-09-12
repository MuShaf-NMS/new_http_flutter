import 'dart:convert';
import 'package:http_flutter/app/models/login.dart';
import 'package:http_flutter/app/models/siswa.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiServices {
  static const url = 'https://api-v2.pondokdiya.id';
  Future<List<Siswa>> getData(String token) async {
    final response = await http
        .get("$url/siswa", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return getAll(response.body);
    } else {
      throw Exception('Oops');
    }
  }

  Future<Siswa> getSiswa(int id, String token) async {
    final response = await http
        .get('$url/siswa/$id', headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return getOne(response.body);
    }
  }

  Future<bool> postData(Siswa data, String token) async {
    final response = await http.post('$url/add-siswa',
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: dataToJson(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> putData(Siswa data, int id, String token) async {
    final response = await http.put('$url/siswa/$id',
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: dataToJson(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(int id, String token) async {
    final resposne = await http.delete('$url/delete-siswa/$id', headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token'
    });
    if (resposne.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Login> login(Map<String, String> data) async {
    print(data);
    final response = await http.post('$url/login',
        headers: {"content-type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      return getToken(response.body);
    } else {
      return Login(accessToken: null, nama: null, username: null);
    }
  }
}
