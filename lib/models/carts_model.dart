class CartsModel {
  bool status;
  Data data;

  CartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data{
  List<CartItems> cartItems;
  int subTotal;
  int total;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((value) {
        cartItems.add(CartItems.fromJson(value));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems{
  int id;
  int quantity;
  Product product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] =  Product.fromJson(json['product']);
  }
}

class Product{
  int id;
  num price;
  num oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}