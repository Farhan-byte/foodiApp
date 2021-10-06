import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/modals/product_modals.dart';
import 'package:food_app/screens/home_screen/search_items.dart';

class Search extends StatefulWidget {
  final List<ProductModels> search;
  Search({this.search});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';

  searchItems(String query) {
    List<ProductModels> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModels> _searchitems = searchItems(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Search'),
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.menu_outlined),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Text',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 56,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                fillColor: Color(0xffc2c2c2),
                filled: true,
                hintText: 'Search items in the store',
                suffixIcon: Icon(
                  Icons.search_outlined,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          Column(
              children: _searchitems.map((seasonData) {
            return Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  child: SearchItems(
                    isbool: false,
                    prodPrice: seasonData.productPrice,
                    prodImage: seasonData.productImage,
                    prodName: seasonData.productName,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                ),
              ],
            );
          }).toList())
        ],
      ),
    );
  }
}
