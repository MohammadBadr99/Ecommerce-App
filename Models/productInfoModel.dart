import 'package:flutter/cupertino.dart';

class ProductsModel extends ChangeNotifier {
  late String _productName;
  late String _productDescription;
  late double _productPrice;

  void setProductName(String pName) {
    _productName = pName;
    notifyListeners();
  }

  void setProductDescription(String pDescription) {
    _productDescription = pDescription;
    notifyListeners();
  }

  void setProductPrice(double pPrice) {
    _productPrice = pPrice;
    notifyListeners();
  }

  get getProductName {
    return _productName;
  }

  get getProductDesc {
    return _productDescription;
  }

  get getproductPrice {
    return _productPrice;
  }
}
