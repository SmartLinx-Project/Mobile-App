import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/local_storage.dart';

class UserData {
  String? firstName;
  String? lastName;
  String? mail;

  static final UserData _instance = UserData._internal();

  UserData._internal();

  factory UserData() {
    return _instance;
  }

  static UserData get instance => _instance;

  Future<void> fetchData() async {
    // Ottieni i dati dell'utente dalla tua API
    Map<String, dynamic>? user = await HttpService().getUserData();

    // Controlla se sono stati ottenuti dati validi
    if (user != null) {
      // Estrai i dati dall'oggetto mappa
      String? firstName = user['firstName'];
      String? lastName = user['lastName'];
      String? mail = user['mail'];

      await UserData().setUserData(firstName!, lastName!, mail!);
    } else {
      // Se non sono stati ottenuti dati validi, gestisci di conseguenza
    }
  }

  Future<void> init() async {
    await fetchData();
    firstName = await LocalStorage().getStringValue('firstName');
    lastName = await LocalStorage().getStringValue('lastName');
    mail = await LocalStorage().getStringValue('mail');
  }

  Future<void> setUserData(
      String firstName, String lastName, String mail) async {
    await LocalStorage().setStringValue('firstName', firstName);
    await LocalStorage().setStringValue('lastName', lastName);
    await LocalStorage().setStringValue('mail', mail);
  }

  String? getFirstName() {
    return firstName;
  }

  String? getLastName() {
    return lastName;
  }

  String? getEmail() {
    return mail;
  }

  Future<bool> editName(String firstName, String lastName) async {
    String? mail = getEmail();
    if (await HttpService().updateUserData(
        firstName: firstName, lastName: lastName, mail: mail!)) {
      await init();
      return true;
    } else {
      return false;
    }
  }
}
