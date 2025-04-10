class GetCartData {
  bool? status;
  String? message;
  Data? data;

  GetCartData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CartItems>? cartItems;
  dynamic? subTotal;
  dynamic? total;

  Data({this.cartItems, this.subTotal, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    return data;
  }
}

class CartItems {
  dynamic? id;
  double? quantity;
  Product? product;

  CartItems({this.id, this.quantity, this.product});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = (json['quantity'] as num?)?.toDouble();
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  dynamic? id;
  double? price;
  double? oldPrice;
  double? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = (json['price'] as num?)?.toDouble();
    oldPrice = (json['old_price'] as num?)?.toDouble();
    discount = (json['discount'] as num?)?.toDouble();
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}
