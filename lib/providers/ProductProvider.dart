import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/modals/product_modals.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {
  ProductModels productModels;
  List<ProductModels> herbsProductList = [];
  List<ProductModels> fruitsProductList = [];
  List<ProductModels> seasonProductList = [];
  List<ProductModels> SearchProductList = [];
  fetchHerbsProductData() async {
    List<ProductModels> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();
    value.docs.forEach((element) {
      productModels = ProductModels(
          productName: element.get("productName"),
          productImage: element.get("productImage"),
          productPrice: element.get("productPrice"),
          productUnit: element.get("productUnit"),
          productId: element.get("productID"));
      newList.add(productModels);
      SearchProductList.add(productModels);
    });
    herbsProductList = newList;
    notifyListeners();
  }

  fetchSeasonsProductData() async {
    List<ProductModels> newSList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("SeasonProduct").get();
    value.docs.forEach((element) {
      productModels = ProductModels(
          productName: element.get("productName"),
          productImage: element.get("productImage"),
          productPrice: element.get("productPrice"),
          productUnit: element.get("productUnit"),
          productId: element.get("productID"));
      newSList.add(productModels);
      SearchProductList.add(productModels);
    });
    seasonProductList = newSList;
    notifyListeners();
  }

  fetchFruitsProductData() async {
    List<ProductModels> newFlist = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FruitsProduct").get();
    value.docs.forEach((element) {
      productModels = ProductModels(
          productName: element.get("productName"),
          productImage: element.get("productImage"),
          productPrice: element.get("productPrice"),
          productUnit: element.get("productUnit"),
          productId: element.get("productID"));
      newFlist.add(productModels);
      SearchProductList.add(productModels);
    });
    fruitsProductList = newFlist;
    notifyListeners();
  }

  List<ProductModels> get getherbsProductDataList {
    return herbsProductList;
  }

  List<ProductModels> get getseasonsProductDataList {
    return seasonProductList;
  }

  List<ProductModels> get getfruitsDataList {
    return fruitsProductList;
  }

  List<ProductModels> get getSearchProductDataList {
    return SearchProductList;
  }
}
