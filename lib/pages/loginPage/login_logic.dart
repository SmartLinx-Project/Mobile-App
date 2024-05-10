import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlinx/services/local_storage.dart';
import '../../services/auth.dart';

class LoginLogic {


  Future<bool> login(
      String email, String password, Function(String) showSnackBar, Function changeLoadingState) async {
      String errorMessage = "Si è verificato un errore";

      changeLoadingState(true);

    if (email == '' || password == '') {
      errorMessage = 'Tutti i campi devono essere pieni!';
      showSnackBar(errorMessage);
      changeLoadingState(false);
      return false;
    } else {
      try {
        await Auth().signInWithEmailAndPassword(email: email, password: password);
        LocalStorage().setBoolValue('isFirstTime', false);
        changeLoadingState(false);
        return true;
      } on FirebaseAuthException catch (error) {
        if (error.code == 'user-not-found' || error.code == 'wrong-password') {
          errorMessage = 'Credenziali non valide. Riprova.';
        } else if (error.code == 'network-request-failed') {
          errorMessage = 'Connessione assente. Verifica la tua connessione internet.';
        } else if (error.code == 'user-disabled') {
          errorMessage = 'Account utente disabilitato per questioni di sicurezza.';
        } else if (error.code == 'too-many-requests') {
          errorMessage = 'Troppi tentativi non riusciti, riprova più tardi.';
        } else if (error.code == 'invalid-email') {
          errorMessage = 'Email non valida!';
        } else if (error.code == 'invalid-password') {
          errorMessage = 'Password non valida!';
        } else if (error.code == 'invalid-credential') {
          errorMessage = 'Le credenziali fornite non sono valide.';
        }
        showSnackBar(errorMessage);
        changeLoadingState(false);
        return false;
      }
    }
  }

  Future<bool> checkVerification(Function changeLoadingState) async {

    changeLoadingState(true);

    try {
      User? user = Auth().currentUser;

      if (user != null) {
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user!.emailVerified) {
          // L'email è stata confermata.
          return true;
        } else {
          // L'email non è stata ancora confermata.
          changeLoadingState(false);
          return false;
        }
      } else {
        changeLoadingState(false);
        return false;
      }
    } catch (e) {
      changeLoadingState(false);
      return false;
    }
  }

  Future<bool> signInWithFacebook() async{
    if(await Auth().signInWithFacebook()){
      return true;
    } else{
      return false;
    }
  }

}
