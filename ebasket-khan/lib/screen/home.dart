import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/provider/product.dart';
import 'package:ebasket/screen/SETTING.dart';
import 'package:ebasket/screen/addtocarts.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ebasket/screen/cart.dart';
import 'package:ebasket/screen/catagory.dart';
import 'package:ebasket/screen/detail.dart';
import 'package:ebasket/screen/favourites.dart';
import 'package:ebasket/screen/home_product.dart';
import 'package:ebasket/screen/login1.dart';
import 'package:ebasket/screen/myorderpage.dart';
import 'package:ebasket/screen/order.dart';
import 'package:ebasket/screen/order_card.dart';
import 'package:ebasket/screen/productsearch.dart';
import 'package:ebasket/screen/profile.dart';
import 'package:ebasket/screen/registration1.dart';
import 'package:ebasket/screen/trackorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebasket/SizeConfig.dart';
import 'package:ebasket/screen/explore.dart';
import 'package:provider/provider.dart';
import 'package:ebasket/screen/frontpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int one = 0;

  @override
  Widget _buildShoppingCart() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Agroventures",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        leading: (IconButton(onPressed: () {
          changeScreen(context, Profile());
        },icon: Icon(Icons.person), )),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              changeScreen(context, CartScreen());
            },
            icon: _buildShoppingCart(),
          ),
          IconButton(
            onPressed: () async {
              await user.getOrders();
              changeScreen(context, myorders());
            },
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          //image_carousal,
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.green,
                  offset: Offset(1, 1),
                  blurRadius: 4,
                ),
              ]),
              child: ListTile(
                leading: Icon(
                  Icons.filter_list,
                  color: Colors.red,
                ),
                title: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (pattern) async {
                    app.changeIsLoading();
                    productProvider.loadProducts();
                    await productProvider.search(productName: pattern);
                    changeScreen(context, productsearch());
                    app.changeIsLoading();
                  },
                  decoration: InputDecoration(
                    hintText: "Find products here...",
                    border: InputBorder.none,
                  ),
                ),
                trailing: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(left: 15.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Category',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              )),
          SizedBox(height: 10.0),
          horizontal_list(),
          SizedBox(height: 10.0),
          Container(
              padding: EdgeInsets.only(left: 15.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Our Products',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              )),
          SizedBox(height: 15.0),
          GridView.builder(
              primary: false,
              //crossAxisSpacing: 2.0,
              //mainAxisSpacing: 4.0,
              shrinkWrap: true,
              //scrollDirection: Axis.horizontal,
              itemCount: productProvider.products.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (_, index) {
                {
                  return  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 7.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 12.0),
                        Stack(children: <Widget>[
                          Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(productProvider
                                        .products[index].picture))),
                          ),
                        ]),
                        SizedBox(height: 8.0),
                        Text(
                          productProvider.products[index].name,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "\u20B9" +
                              productProvider.products[index].price.toString() + productProvider.products[index].quans.toString(),
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.grey),
                        ),
                        SizedBox(height: 15.0),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            changeScreen(
                                context,
                                ProductDetail(
                                    productProvider.products[index].name,
                                    productProvider.products[index].price.toString(),
                                    productProvider.products[index].picture,
                                    productProvider.products[index].category,
                                    productProvider.products[index].id,
                                    productProvider.products[index].description,
                                    productProvider.products[index].id,
                                    productProvider.products[index].stock,
                                productProvider.products[index].quans));
                          },
                          child: Container(
                            width: 175.0,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                            ),
                            child: Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
    //margin: 2.isEven? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
                  );
                }
              return CircularProgressIndicator();
              })
          //image_carousal,
          //SizedBox(height: 15.0 ),
          //image_carousal,
          //SizedBox(height: 15.0 ),
        ],
      ),
    );
  }
}
