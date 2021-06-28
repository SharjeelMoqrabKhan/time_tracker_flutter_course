import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/home/model/job.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) async {
    final path = '/users/$uid/jobs/job-abc';
    final documentRefernce = FirebaseFirestore.instance.doc(path);
    await documentRefernce.set(job.toMap());
  }
}
