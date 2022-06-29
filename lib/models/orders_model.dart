class OrdersModel{
  bool status;
  Data data;
  OrdersModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data{
  List<OrdersDetails> ordersDetails= [];
  Data.fromJson(Map<String,dynamic>json){
    json['data'].forEach((value){
      ordersDetails.add(OrdersDetails.fromJson(value));
    });
  }
}

class OrdersDetails{
  int id;
  num total;
  String date;
  String status;
  OrdersDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    total=json['total'];
    date=json['date'];
    status=json['status'];
  }
}