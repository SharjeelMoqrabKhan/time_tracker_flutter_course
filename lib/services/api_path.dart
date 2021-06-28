class APIPath {
  static String job(String uid, String jobID) => '/users/$uid/jobs/$jobID';
  static String jobs(String uid) => '/users/$uid/jobs';
}
