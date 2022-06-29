class ChangeCartsModel{
  bool status;
  String message;
  Data data;
  ChangeCartsModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=Data.fromJson(json['data']);
  }
}

class Data{
  int id;
  int quantity;
  Product product;
  Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    quantity=json['quantity'];
    product=Product.fromJson(json['product']);
  }

}

class Product{
  int id;
  num price;
  num oldPrice;
  int discount;
  String image;

  Product.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}