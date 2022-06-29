class SearchModel{

  bool status;
  String message;
  Data data;

  SearchModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    message =json['message'];
    data=Data.fromJson(json['data']);
  }

}

class Data{
  int currentPage;
  List<Product> data=[];
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String path;
  int perPage;
  int to;
  int total;
  Data.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(Product.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];

  }
}


class Product {
  int id;
  num price;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}