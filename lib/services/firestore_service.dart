import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class FireStoreService{

  FireStoreService._();
  static final instance = FireStoreService._();

  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final refernce = FirebaseFirestore.instance.doc(path);
    print('$path:$data');
    await refernce.set(data);
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data ,String documentId) builder,
  }) {
    final refernce = FirebaseFirestore.instance.collection(path);
    final snapshot = refernce.snapshots();
    return snapshot.map((snapshot) => snapshot.docs
        .map(
          (snapshot) => builder(snapshot.data(),snapshot.id),
        )
        .toList());
  }
}