import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> cadastrarUser({
    required String nome,
    required String senha,
    required String email,
    required String telefone,
  }) async {
    try {
      UserCredential usuario =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      await usuario.user!.updateDisplayName(nome);

      await _firestore.collection('users').doc(usuario.user!.uid).set({
        'telefone': telefone,
      }, SetOptions(merge: true));

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "E-mail já cadastrado";
      }

      return "Ocorreu um erro durante o cadastro!";
    }
  }

  Future<String?> logarUser({
    required String senha,
    required String email,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logoutUser() async {
    return _firebaseAuth.signOut();
  }
}
