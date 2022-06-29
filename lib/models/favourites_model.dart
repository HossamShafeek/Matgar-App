class FavouritesModel{

  bool status;
  String message;
  Data data;

  FavouritesModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    message =json['message'];
    data=Data.fromJson(json['data']);
  }

}

class Data{
  int currentPage;
  List<FavouritesData> data=[];
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
      data.add(FavouritesData.fromJson(element));
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

class FavouritesData{

  int id;
  FavoriteProduct product;

  FavouritesData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product=FavoriteProduct.fromJson(json['product']);
  }

}


class FavoriteProduct {
  int id;
  num price;
  num oldPrice;
  int discount;
  String image;
  String name;
  String description;

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}