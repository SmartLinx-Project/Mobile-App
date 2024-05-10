import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth.dart';

class HttpService {
  String host = 'https://example.com/example';

  Future<bool> addUser({
    required String email,
    required String firstname,
    required String lastname,
  }) async {
    var client = http.Client();
    String uriLink = 'user';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';
      Map<String, dynamic> requestBody = {
        'mail': email,
        'firstName': firstname,
        'lastName': lastname,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    var client = http.Client();
    String uriLink = 'user';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse JSON response
        Map<String, dynamic> userData = jsonDecode(response.body);
        return userData;
      } else {
        // Handle other status codes
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }

  Future<bool> updateUserData(
      {required String firstName,
      required String lastName,
      required String mail}) async {
    var client = http.Client();
    String uriLink = 'user';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Map<String, dynamic> requestBody = {
        'firstName': firstName,
        'lastName': lastName,
        'mail': mail,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> deleteUserData() async {
    var client = http.Client();
    String uriLink = 'user';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';
      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>?> getHomeInfo() async {
    var client = http.Client();
    String uriLink = 'user/info';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonContent = jsonDecode(response.body);
        return (jsonContent);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }

  Future<bool> delFamilyMember(
      {required int homeID, required String mail}) async {
    var client = http.Client();
    String uriLink = 'familyMember';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'homeId': homeID.toString(),
        'mail': mail,
      });

      var response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<int> addFamilyMember(
      {required int homeID, required String mail}) async {
    var client = http.Client();
    String uriLink = 'familyMember';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'homeId': homeID.toString(),
        'mail': mail,
      });

      var response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return 0;
      } else if (response.statusCode == 409) {
        return 1;
      } else if (response.statusCode == 500) {
        return 2;
      } else {
        return 3;
      }
    } catch (e) {
      return 3;
    } finally {
      client.close();
    }
  }

  Future<bool> setStatus(
      {required int hubID,
      required String ieeeAddress,
      required String command}) async {
    var client = http.Client();
    String uriLink = 'device/mqtt';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Map<String, dynamic> requestBody = {
        'hubId': hubID,
        'ieee_address': ieeeAddress,
        'command': command,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> setHome(
      {required int homeID,
      required String name,
      required String address}) async {
    var client = http.Client();
    String uriLink = 'home';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Map<String, dynamic> requestBody = {
        'homeID': homeID,
        'name': name,
        'address': address,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> addFavourite({required int deviceID}) async {
    var client = http.Client();
    String uriLink = 'favourite';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'deviceId': deviceID.toString(),
        'token': token,
        'uid': uid,
      });

      var response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> setRoom({
    required int roomID,
    required String name,
  }) async {
    var client = http.Client();
    String uriLink = 'room';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Map<String, dynamic> requestBody = {
        'roomID': roomID,
        'name': name,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> delHome({
    required int homeID,
  }) async {
    var client = http.Client();
    String uriLink = 'home';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();
    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'homeId': homeID.toString(),
      });

      var response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> delRoom({
    required int roomID,
  }) async {
    var client = http.Client();
    String uriLink = 'room';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'roomId': roomID.toString(),
      });

      var response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> delFavourite({
    required int deviceID,
  }) async {
    var client = http.Client();
    String uriLink = 'favourite';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'deviceId': deviceID.toString(),
      });

      var response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> delDevice({
    required int deviceID,
  }) async {
    var client = http.Client();
    String uriLink = 'device';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'deviceId': deviceID.toString(),
      });

      var response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> addHome({required String name, required String address}) async {
    var client = http.Client();
    String uriLink = 'home';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Map<String, dynamic> requestBody = {
        'name': name,
        'address': address,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.post(uri,
          headers: {'Content-Type': 'application/json'}, body: jsonBody);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> addRoom({required String name, required int homeID}) async {
    var client = http.Client();
    String uriLink = 'room';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Map<String, dynamic> requestBody = {
        'name': name,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'homeId': homeID.toString(),
      });

      var response = await client.post(uri,
          headers: {'Content-Type': 'application/json'}, body: jsonBody);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> setHub({required int homeID, required int hubID}) async {
    var client = http.Client();
    String uriLink = 'home/hub';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'homeId': homeID.toString(),
        'hubId': hubID.toString(),
      });

      var response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> joinDevice({required int hubID}) async {
    var client = http.Client();
    String uriLink = 'device/mqtt';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'hubId': hubID.toString(),
      });

      var response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      return {};
    } finally {
      client.close();
    }
  }

  Future<bool> addDevice({
    required String name,
    required String ieeeAddress,
    required String model,
    required int roomID,
    required String type,
  }) async {
    var client = http.Client();
    String uriLink = 'device';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';
      Map<String, dynamic> requestBody = {
        'name': name,
        'ieeeAddress': ieeeAddress,
        'type': type,
        'model': model,
        'roomID': roomID.toString(),
        'enabled': 'false',
        'startTime': '00:00:00',
        'endTime': '00:00:00',
        'periodicity': [],
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> leaveDevice(
      {required int hubID, required String ieeeAddress}) async {
    var client = http.Client();
    String uriLink = 'device/mqtt';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'ieee_address': ieeeAddress,
        'hubId': hubID.toString(),
      });

      var response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<bool> setDevice({
    required int deviceID,
    required String name,
    required bool schedState,
    required String startTime,
    required String endTime,
    required List<String> periodicity,
  }) async {
    var client = http.Client();
    String uriLink = 'device';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';
      Map<String, dynamic> requestBody = {
        'deviceID': deviceID.toString(),
        'name': name,
        'enabled': schedState.toString(),
        'startTime': startTime,
        'endTime': endTime,
        'periodicity': periodicity,
      };
      String jsonBody = jsonEncode(requestBody);

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
      });

      var response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> getStatus({
    required String ieeeAddress,
    required int hubID,
    required String type,
  }) async {
    var client = http.Client();
    String uriLink = 'device/mqtt';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'hubId': hubID.toString(),
        'type': type,
        'ieee_address': ieeeAddress,
      });

      var response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      return {};
    } finally {
      client.close();
    }
  }

  void disableJoin({
    required int hubID,
  }) async {
    var client = http.Client();
    String uriLink = 'home/hub';
    String token = await Auth().getToken();
    String uid = await Auth().getUid();

    try {
      String url = '$host$uriLink';

      Uri uri = Uri.parse(url).replace(queryParameters: {
        'token': token,
        'uid': uid,
        'hubId': hubID.toString(),
      });
      await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
    } finally {
      client.close();
    }
  }
}
