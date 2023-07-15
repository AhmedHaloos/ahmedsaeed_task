
class ResultApi{

  String? status;
  String? error;
  Map<String, dynamic>? data;

  static String success = "success";
  static String failed  = "failed";

  ResultApi(this.status, this.data, this.error);

}