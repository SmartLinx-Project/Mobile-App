import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartlinx/services/http.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Non eseguire automaticamente l'accesso dopo la creazione dell'account
    } catch (e) {
      rethrow; // Rilancia l'eccezione per gestirla nell'ambito in cui viene chiamato il metodo
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> getToken() async {
    String? token;

    try {
      // Ottieni l'istanza di FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;

      // Controlla se l'utente è già autenticato
      if (auth.currentUser != null) {
        // Se l'utente è già autenticato, ottieni il token di accesso
        String? accessToken = await auth.currentUser!.getIdToken();
        token = accessToken;
      }
    } catch (e) {
      token = ''; // Assegna un valore di fallback in caso di errore
    }

    return token!;
  }

  Future<bool> isUserLoggedIn() async {
    try {
      // Ottieni l'istanza di FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;

      // Controlla se l'utente è già autenticato
      if (auth.currentUser != null) {
        // Ottieni il token di accesso
        String? accessToken = await auth.currentUser!.getIdToken(true);

        // Controlla se il token è valido
        if (accessToken != null && accessToken.isNotEmpty) {
          // Controlla se l'email è stata verificata
          if (auth.currentUser!.emailVerified) {
            return true; // L'utente è autenticato, il token è valido e l'email è verificata
          } else {
            return false; // L'utente è autenticato ma l'email non è verificata
          }
        }
      }
      return false; // L'utente non è autenticato o il token non è valido
    } catch (e) {
      return false; // Gestisci l'errore restituendo false
    }
  }

  Future<String> getUid() async {
    String? uid;

    try {
      // Ottieni l'istanza di FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;

      if (auth.currentUser != null) {
        // Se l'utente è già autenticato, ottieni il token di accesso
        String? accessUid = auth.currentUser!.uid;
        uid = accessUid;
      }
    } catch (e) {
      uid = ''; // Assegna un valore di fallback in caso di errore
    }

    return uid!;
  }

  Future<void> updateProfilePhoto(String photoUrl) async {
    try {
      // Ottieni l'utente corrente
      User? currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        // Aggiorna il profilo dell'utente con l'URI della foto del profilo
        await currentUser.updatePhotoURL(photoUrl);
      }
    } catch (e) {
      // Gestisci l'errore se si verifica un problema durante l'aggiornamento del profilo
      rethrow;
    }
  }

  String? getProfilePhotoUrl() {
    try {
      // Ottieni l'utente corrente
      User? currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        // Ottieni l'URL della foto del profilo dall'utente corrente
        return currentUser.photoURL;
      }
      return null; // Se l'utente non è autenticato o non ha un'immagine del profilo
    } catch (e) {
      // Gestisci l'errore se si verifica un problema durante il recupero dell'URL della foto del profilo
      return null;
    }
  }

  Future<void> deleteUserByUid(String uid) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.currentUser!.delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword({required String newPassword}) async {
    try {
      User? currentUser = _firebaseAuth.currentUser;

      await currentUser?.updatePassword(newPassword);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final List<String> displayNameParts =
            googleUser.displayName!.split(' ');
        final String firstName = displayNameParts.first;
        final String lastName =
            displayNameParts.length > 1 ? displayNameParts.last : '';

        final String email = googleUser.email;

        try {
          await HttpService()
              .addUser(email: email, firstname: firstName, lastname: lastName);
        } on Exception {}
      }
      return true;
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_failed') {}

      return false;
    } on Exception {
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      // Get user profile data
      final userData = await FacebookAuth.instance.getUserData();
      final String firstName = userData['first_name'];
      final String lastName = userData['last_name'];
      final String email = userData['email'];

      await HttpService().addUser(email: email, firstname: firstName, lastname: lastName);
      return true;
    } catch (e) {
      // If there's an error during the authentication process, return false
      return false;
    }
  }

}
