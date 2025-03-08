class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromjson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromjson(Map<String, dynamic> json) {
    if(banners!=null)
    {
      json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromjson(element));
    });
    }
    if(products!=null)
    {
      json['products'].forEach((element)
    {
      products.add(ProductModel.fromjson(element));
    });
    }
    }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromjson(Map<String, dynamic> json) {
    id=json['id'];
    image=json['image'];
  }
}

class ProductModel {
  int? id;
  int? discount;
  dynamic? price;
  dynamic? old_price;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromjson(Map<String,dynamic> json)
  {
    id=json['id'];
    discount=json['discount'];
    price=json['price'];
    old_price=json['old_price'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}
