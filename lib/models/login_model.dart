class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel.formaJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.formaJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.formaJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
