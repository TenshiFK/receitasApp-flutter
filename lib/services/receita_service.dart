import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receitasapp/models/receita_model.dart';

class ReceitaService {
  String userId;
  ReceitaService() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addReceita(ReceitaModel receitaModel) async {
    await _firestore
        .collection(userId)
        .doc(receitaModel.id)
        .set(receitaModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamReceitas() {
    return _firestore.collection(userId).snapshots();
  }

  Future<void> deleteReceita({required ReceitaModel receitaModel}) async {
    return _firestore.collection(userId).doc(receitaModel.id).delete();
  }

  Future<void> addFavoritos(ReceitaModel receitaModel) async {
    await _firestore
        .collection('Favoritos_$userId')
        .doc(receitaModel.id)
        .set(receitaModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamReceitasFavoritas() {
    return _firestore.collection('Favoritos_$userId').snapshots();
  }

  Future<void> deleteReceitaFavorita(
      {required ReceitaModel receitaModel}) async {
    return _firestore
        .collection('Favoritos_$userId')
        .doc(receitaModel.id)
        .delete();
  }
}
