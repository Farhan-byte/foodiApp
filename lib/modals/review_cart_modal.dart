class ReviewCartModal {
  final String cartId;
  final String cartImage;
  final String cartName;
  final int cartQuantity;
  final int cartPrice;
  String cartUnit;

  ReviewCartModal(
      {this.cartId,
      this.cartUnit,
      this.cartImage,
      this.cartName,
      this.cartPrice,
      this.cartQuantity});
}
