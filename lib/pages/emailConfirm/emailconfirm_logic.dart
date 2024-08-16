import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth.dart';

class EmailConfirmLogic{

  void sendVerificationEmail() async{
    Auth().currentUser?.sendEmailVerification();
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
}