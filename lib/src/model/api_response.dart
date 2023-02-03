// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiResponse {
  String? msg;
  bool? isSuccess;
  dynamic data;
  int? totalPage;

  ApiResponse({this.data, this.isSuccess, this.msg, this.totalPage});

  @override
  String toString() =>
      'ApiResponse(msg: $msg, isSuccess: $isSuccess, data: $data, totalPage: $totalPage)';
}
