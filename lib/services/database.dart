import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/home/model/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> streamJobs();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FireStoreService.instance;
  Future<void> createJob(Job job) => _service.setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> streamJobs() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
