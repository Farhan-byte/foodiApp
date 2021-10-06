import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/ProductProvider.dart';
import 'package:food_app/providers/User_provider.dart';
import 'package:food_app/screens/home_screen/DeliveryDetails/delivery_details.dart';
import 'package:food_app/screens/home_screen/DeliveryDetails/payment_details.dart';
import 'package:food_app/screens/home_screen/Review_cart.dart';
import 'package:food_app/screens/home_screen/drawer.dart';
import 'package:food_app/screens/home_screen/overView.dart';
import 'package:food_app/screens/home_screen/search_product.dart';
import 'package:food_app/screens/home_screen/tiles.dart';
import 'package:food_app/screens/home_screen/singleproduct.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductProvider productProvider;
  UserProvider userProvider;

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchHerbsProductData();
    productProvider.fetchFruitsProductData();
    productProvider.fetchSeasonsProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    userProvider = Provider.of(context);
    userProvider.getUserData();

    return SafeArea(
      child: Scaffold(
        drawer: DrawerSide(
          userProvider: userProvider,
        ),
        appBar: AppBar(
          backgroundColor: Color(0xffd6b738),
          title: Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xffd4d181),
              child: Padding(
                padding: EdgeInsets.only(right: 6),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Search(
                                  search:
                                      productProvider.getSearchProductDataList,
                                )));
                  },
                  icon: Icon(
                    Icons.search,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xffd4d181),
                child: IconButton(
                  icon: Icon(
                    Icons.shop,
                    size: 17,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReviewCart()));
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xffd4d181),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: 17,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentDetails()));
                  },
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView(children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://post.healthline.com/wp-content/uploads/2020/08/1200x628_FACEBOOK_11_Red_Vegetables_with_Health_Benefits-1200x628.jpg'),
                    fit: BoxFit.cover),
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 170,
                            ),
                            child: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                color: Color(0xffd1ad17),
                              ),
                              child: Center(
                                child: Text(
                                  'Vegi',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.green.shade900,
                                            offset: Offset(3, 3))
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 30, top: 10),
                            child: Text(
                              '30% Off',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.green[100],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'On all vegetable products',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Herb Seasoning',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(
                                    search: productProvider
                                        .getseasonsProductDataList,
                                  )));
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    productProvider.getseasonsProductDataList.map((seasonData) {
                  return singleProduct(
                    prodUnit: seasonData.productUnit,
                    prodPrice: seasonData.productPrice,
                    prodImage: seasonData.productImage,
                    prodName: seasonData.productName,
                    prodId: seasonData.productId,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductOverview(
                                    productImage: seasonData.productImage,
                                    productName: seasonData.productName,
                                    productPrice: seasonData.productPrice,
                                    productId: seasonData.productId,
                                  )));
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fresh Vegies',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(
                                    search:
                                        productProvider.getherbsProductDataList,
                                  )));
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.getherbsProductDataList
                    .map((herbsProductData) {
                  return singleProduct(
                    prodUnit: herbsProductData.productUnit,
                    prodName: herbsProductData.productName,
                    prodImage: herbsProductData.productImage,
                    prodPrice: herbsProductData.productPrice,
                    prodId: herbsProductData.productId,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductOverview(
                                    productImage: herbsProductData.productImage,
                                    productName: herbsProductData.productName,
                                    productPrice: herbsProductData.productPrice,
                                    productId: herbsProductData.productId,
                                  )));
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fresh Fruits',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(
                                    search: productProvider.getfruitsDataList,
                                  )));
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.getfruitsDataList.map((seasonData) {
                  return singleProduct(
                    prodUnit: seasonData.productUnit,
                    prodPrice: seasonData.productPrice,
                    prodImage: seasonData.productImage,
                    prodName: seasonData.productName,
                    prodId: seasonData.productId,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductOverview(
                                    productImage: seasonData.productImage,
                                    productName: seasonData.productName,
                                    productPrice: seasonData.productPrice,
                                    productId: seasonData.productId,
                                  )));
                    },
                  );
                }).toList(),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Citrus Fruits',
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         'View All',
            //         style: TextStyle(
            //             color: Colors.grey, fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       singleProduct(
            //           prodName: 'Red Blood',
            //           prodImage:
            //               'https://www.pngplay.com/wp-content/uploads/6/Sour-Grapefruit-PNG.png',
            //           ontap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProductOverview(
            //                           productImage:
            //                               'https://www.pngplay.com/wp-content/uploads/6/Sour-Grapefruit-PNG.png',
            //                           productName: 'Red Blood',
            //                         )));
            //           }),
            //       singleProduct(
            //           prodName: 'Red Citrus',
            //           prodImage:
            //               'https://www.pngplay.com/wp-content/uploads/1/Citrus-Fruit-PNG-Free-File.png',
            //           ontap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProductOverview(
            //                           productImage:
            //                               'https://www.pngplay.com/wp-content/uploads/1/Citrus-Fruit-PNG-Free-File.png',
            //                           productName: 'Red Citrus',
            //                         )));
            //           }),
            //       singleProduct(
            //           prodName: 'Orange',
            //           prodImage:
            //               'https://www.pngplay.com/wp-content/uploads/1/Citrus-Fruit-PNG-Stock-Photo.png',
            //           ontap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProductOverview(
            //                           productImage:
            //                               'https://www.pngplay.com/wp-content/uploads/1/Citrus-Fruit-PNG-Stock-Photo.png',
            //                           productName: 'Orange',
            //                         )));
            //           }),
            //       singleProduct(
            //           prodName: 'Spike',
            //           prodImage:
            //               'https://www.pngplay.com/wp-content/uploads/1/Citrus-Fruit-PNG.png',
            //           ontap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProductOverview(
            //                           productImage:
            //                               'https://www.pngplay.com/wp-content/uploads/1/Citrus-Fruit-PNG.png',
            //                           productName: 'Spike',
            //                         )));
            //           }),
            //       singleProduct(
            //           prodName: 'Lime',
            //           prodImage:
            //               'https://www.pngplay.com/wp-content/uploads/6/Lime-Green-Lemon-PNG.png',
            //           ontap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProductOverview(
            //                           productImage:
            //                               'https://www.pngplay.com/wp-content/uploads/6/Lime-Green-Lemon-PNG.png',
            //                           productName: 'Lime',
            //                         )));
            //           })
            //     ],
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}
