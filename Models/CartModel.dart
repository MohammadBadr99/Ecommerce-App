import 'package:ecommerce/Models/productInfoModel.dart';

class Cart extends ProductsModel {
  List<ProductsModel> _cart = [];
  double _totalPrice = 0.0;

  void addToCart(ProductsModel item) {
    _cart.add(item);
    _totalPrice += item.getproductPrice;
    notifyListeners();
  }

  void removeFromCart(ProductsModel item) {
    _cart.remove(item);
    _totalPrice -= item.getproductPrice;
    notifyListeners();
  }

  get getItemsCount {
    return _cart.length;
  }

  get getTotalPrice {
    return _totalPrice;
  }

  get getItems {
    return _cart;
  }
}
