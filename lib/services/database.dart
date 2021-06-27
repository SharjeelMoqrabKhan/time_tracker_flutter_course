import 'package:flutter/foundation.dart';

abstract class Database {}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
}
