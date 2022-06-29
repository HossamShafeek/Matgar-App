class ChangePasswordModel{
  bool status;
  String message;
  Data data;
  ChangePasswordModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    message =json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data{
  String email;
  Data.fromJson(Map<String,dynamic>json){
    email=json['email'];
  }
}