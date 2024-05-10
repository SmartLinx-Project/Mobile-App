import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/local_storage.dart';
import '../../services/auth.dart';

class RegisterLogic {
  Future<bool> register(
      String email,
      String password,
      String confirmPassword,
      String firstName,
      String lastName,
      Function(String) showSnackBar,
      Function changeLoadingState) async {
    String errorMessage = "Si è verificato un errore";

    changeLoadingState(true);

    if (firstName == '' ||
        password == '' ||
        confirmPassword == '' ||
        lastName == '' ||
        email == '') {
      errorMessage = 'Tutti i campi devono essere compilati!';
      showSnackBar(errorMessage);
      changeLoadingState(false);
      return false;
    } else if (password != confirmPassword) {
      errorMessage = 'Le due password non combaciano!';
      showSnackBar(errorMessage);
      changeLoadingState(false);
      return false;
    } else {
      try {
        await Auth()
            .createUserWithEmailAndPassword(email: email.trim(), password: password);
        if (!await HttpService().addUser(email: email.trim(), firstname: firstName, lastname: lastName)) {
          await Auth().deleteUserByUid(await Auth().getUid());
          errorMessage = 'Errore durante la connessione al server';
          changeLoadingState(false);
          showSnackBar(errorMessage);
          return false;
        }
        LocalStorage().setBoolValue('isFirstTime', false);
        changeLoadingState(false);
        return true;
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          errorMessage = 'La password fornita è troppo debole.';
        } else if (error.code == 'email-already-in-use') {
          errorMessage = 'Un account con questo indirizzo email esiste già.';
        } else if (error.code == 'invalid-email') {
          errorMessage = 'L\'indirizzo email non è valido.';
        } else if (error.code == 'network-request-failed') {
          errorMessage =
              'Connessione assente. Verifica la tua connessione internet.';
        }
        showSnackBar(errorMessage);
        changeLoadingState(false);
        return false;
      }
    }
  }
}
