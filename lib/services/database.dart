import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/home/model/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
   void readJobs();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) => _setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  void readJobs() {
    final path = APIPath.jobs(uid);
    final refernce = FirebaseFirestore.instance.collection(path);
    final snapshoot = refernce.snapshots();
    snapshoot.listen(
      (snapshoot) {
        snapshoot.docs.forEach(
          (snapshoot) {
            print(
              snapshoot.data(),
            );
          },
        );
      },
    );
  }

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final refernce = FirebaseFirestore.instance.doc(path);
    print('$path:$data');
    await refernce.set(data);
  }
}
