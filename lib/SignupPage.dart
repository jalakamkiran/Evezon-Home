import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:medorbis/Helper/DatabaseHelper.dart';
import 'package:medorbis/models/Cartproducts.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreemState createState() => _CartScreemState();
}

class _CartScreemState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  DatabaseHelper databaseHelper;
  List<CartProducts> cartproducts;
  bool iscomplete = false;
  List<int> values;
  List<String> distributors;

  @override
  void initState() {
    distributors = List<String>();
    values = List<int>();
    cartproducts = List<CartProducts>();
    databaseHelper = DatabaseHelper();
    databaseHelper.initialise().then((value) {
      databaseHelper.getProductsinCart().then((value) {
        cartproducts = value;
      }).whenComplete(() {
        setState(() {
          iscomplete = true;
          for (int i = 0; i < cartproducts.length; i++) {
            values.add(0);
          }
          for (int j = 0; j < cartproducts.length; j++) {
            distributors.add(cartproducts[j].distributor);
          }
          distributors.forEach((element) {
            print(element);
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 243, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: ScreenUtil().setSp(50),
          ),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(50),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CartScreen();
                }));
              },
              child: Icon(
                Icons.delete,
                color: Colors.black,
                size: ScreenUtil().setSp(50),
              ),
            ),
          ),
        ],
      ),
      body: iscomplete
          ? Cartitem()
          : Center(
              child: Container(
                child: Text("No data added yet......."),
              ),
            ),
    );
  }

  Widget Cartitem() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: ListView.builder(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
              top: ScreenUtil().setHeight(30),
              bottom: ScreenUtil().setHeight(30)),
          itemCount: distributors.length,
          itemBuilder: (context, index) {
            String price = "";
            double totalprice = 0.0;
            List<CartProducts> distproduct = List<CartProducts>();
            databaseHelper
                .getdistributorscart(distributors[index])
                .then((value) {
              if (value != null) {
                distproduct = value;
                distproduct.forEach((element) {
                  double indiprice = element.rate * element.qty;
                  setState(() {
                    totalprice = totalprice + indiprice;
                    totalprice = totalprice + indiprice;
                  });
                });
              }
            });

            return Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(60)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    right: ScreenUtil().setWidth(30),
                    left: ScreenUtil().setWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      subtitle: Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                        child: Column(
                          children: [
                            // IntrinsicHeight(
                            //   child: Container(
                            //     child: Divider(
                            //       color: Colors.black,
                            //       thickness: ScreenUtil().setWidth(1),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Products : ",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(40),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          (distproduct.length + 1).toString(),
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(40),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Amount : ",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(40),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "0.0",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(40),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      children: [
                        Row(
                          children: [
                            Image(
                              height: ScreenUtil().setHeight(200),
                                width: ScreenUtil().setWidth(600),
                                image: AssetImage("assets/images/no-image.png"))
                          ],
                        )
                      ],
                      title: Text(
                        distributors[index],
                        style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
