import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  /*
   * 登録
   */
  static void insert(
    String collection,
    Map<String, dynamic> data,
  ) async {
    await FirebaseFirestore.instance.collection(collection).doc().set(data);
  }

  /*
   * 登録
   */
  static void insertOrUpdate(
    String collection,
    String documentID,
    Map<String, dynamic> data,
  ) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentID)
        .set(data);
  }

  /*
   * 更新
   */
  static void update(
    String collection,
    String documentID,
    Map<String, dynamic> data,
  ) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentID)
        .update(data);
  }

  /*
   * 削除
   */
  static void delete(
    String collection,
    String documentId,
  ) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .delete();
  }

  /*
   * document取得
   */
  static Future<DocumentSnapshot> select(
    String collection,
    String documentId,
  ) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .get();
  }

  /*
   * 全document取得
   */
  static Future<QuerySnapshot> getDocuments(String collection) {
    return FirebaseFirestore.instance.collection(collection).get();
  }

  /*
   * Document の subscribe
   */
  static StreamSubscription<DocumentSnapshot> listen(
    String collection,
    String documentId,
    void Function(DocumentSnapshot event) onData,
  ) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .snapshots()
        .listen(onData);
  }
}
