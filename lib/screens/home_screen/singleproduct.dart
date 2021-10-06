import 'package:flutter/material.dart';
import 'package:food_app/Widgets/counter.dart';
import 'package:food_app/Widgets/product_unit.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/modals/product_modals.dart';

class singleProduct extends StatefulWidget {
  String prodName;
  String prodImage;
  int prodPrice;
  String prodId;
  final Function ontap;
  final List<dynamic> prodUnit;
  singleProduct(
      {this.prodId,
      this.prodName,
      this.prodImage,
      this.ontap,
      this.prodPrice,
      this.prodUnit});
  @override
  _singleProductState createState() => _singleProductState();
}

class _singleProductState extends State<singleProduct> {
  String firstVal;
  String unitData;
  getFirstVal() {
    widget.prodUnit.firstWhere((element) {
      setState(() {
        firstVal = element;
      });
      return true;
    });
  }

  ProductUnit productUnit;
  @override
  Widget build(BuildContext context) {
    getFirstVal();
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 265,
        width: 180,
        decoration: BoxDecoration(
            color: Color(0xffd9dad9),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: widget.ontap,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image(
                      image: NetworkImage(widget.prodImage),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 100),
                    child: Text(
                      widget.prodName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 100, bottom: 5),
                    child: Text(
                      '50g / ${widget.prodPrice}\$',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ProductUnit(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.prodUnit.map((data) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          unitData = data;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Text(
                                          data,
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 20),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              });
                        },
                        title: unitData != null ? unitData : firstVal,
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Counter(
                        prodName: widget.prodName,
                        prodImage: widget.prodImage,
                        prodPrice: widget.prodPrice,
                        prodId: widget.prodId,
                        prodQuantity: 1,
                        prodUnit: unitData == null ? firstVal : unitData,
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
