class ProductModels {
  String productName;
  int productPrice;
  String productImage;
  String productId;
  final List<dynamic> productUnit;
  ProductModels(
      {this.productId,
      this.productName,
      this.productPrice,
      this.productImage,
      this.productUnit});
}
