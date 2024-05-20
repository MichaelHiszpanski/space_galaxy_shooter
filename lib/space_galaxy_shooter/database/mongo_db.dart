import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseService {
  final String apiUrl = "http://192.168.109.128:5000";
  Future<List<dynamic>> fetchUsers() async {
    try {
      final apiResponse = await http.get(Uri.parse('$apiUrl/getAllUsers'));
      if (apiResponse.statusCode == 200) {
        return json.decode(apiResponse.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> checkUserLoginAndPassword(
      String login, String password) async {
    try {
      final apiResponse = await http.post(
        Uri.parse('$apiUrl/userLogin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'login': login,
          'password': password,
        }),
      );
      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 404) {
        return json.decode(apiResponse.body);
      } else {
        return {'success': false, 'message': 'Login was not successful'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failing to Login'};
    }
  }

  Future<Map<String, dynamic>> loginUser(String login, String password) async {
    var dbService = DatabaseService();
    Map<String, dynamic> loginResult =
        await dbService.checkUserLoginAndPassword(login, password);

    if (loginResult['success']) {
      return loginResult;
    } else {
      return {'success': false, 'message': 'Failing to Login'};
    }
  }

  Future<Map<String, dynamic>> updateScores(
      String login, List<int> newScores) async {
    try {
      final apiResponse = await http.patch(
        Uri.parse('$apiUrl/updatedUserScores'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'login': login,
          'newScores': newScores,
        }),
      );
      if (apiResponse.statusCode == 200) {
        return json.decode(apiResponse.body);
      } else {
        return {'success': false, 'message': 'Failed updating Scores'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Scores was not updated'};
    }
  }

  Future<Map<String, dynamic>> addNewUser(String login, String password) async {
    try {
      final apiResponse = await http.post(
        Uri.parse('$apiUrl/addUser'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'login': login,
          'password': password,
        }),
      );
      if (apiResponse.statusCode == 201) {
        return {'success': true, 'message': 'New User was added to MongoDB'};
      } else {
        return {'success': false, 'message': 'Failing added New User'};
      }
    } catch (e) {
      return {'success': false, 'message': 'New User was not added'};
    }
  }
}
