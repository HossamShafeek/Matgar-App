
class ProductDetailsModel{
bool status;
ProductData productData;
ProductDetailsModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  //product: map['product'] != null ? testproduckt.fromMap(map['product']): null,
  productData=json['data']!=null?ProductData.fromJson(json['data']):null;
}
}

class ProductData{
  int id;
  num price;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  ProductData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    images = json['images'].cast<String>();
    inFavorites =json['in_favorites'];
    inCart =json['in_cart'];
  }
}
