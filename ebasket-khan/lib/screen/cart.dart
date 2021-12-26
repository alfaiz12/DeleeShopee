import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/helpers/style.dart';
import 'package:ebasket/model/cart_item.dart';
import 'package:ebasket/model/user.dart';
import 'package:ebasket/model/user.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/SETTING.dart';
import 'package:ebasket/screen/explore.dart';
import 'package:ebasket/services/order.dart';
import 'package:ebasket/services/user.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'custom_text.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
 OrderServices _orderServices = OrderServices();
 int _value=0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);
    UserServices _userServices = UserServices();
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart",color: Colors.black,),

        actions: <Widget>[
          IconButton(
            onPressed: () {
              changeScreen(context, Explore());
            },
            icon: Icon(Icons.home,color:white,size: 30.0,),
          ),

        ],
      ),
      backgroundColor: Colors.white,
      body:app.isLoading ? Loading() :
      user.userModel.totalCartPrice < 1 ?
      Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart,color: Colors.grey,size: 30,),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomText(text:"Your Cart is Empty")
        ],

      )
      :
      ListView.builder(
          itemCount: user.userModel.cart.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: red.withOpacity(0.2),
                          offset: Offset(3, 2),
                          blurRadius: 30)
                    ]),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        user.userModel.cart[index]["image"],
                        height: 120,
                        width: 90,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "${user.userModel.cart[index]["name"]} \n\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\u20B9"+"${user.userModel.cart[index]["price"] } \n\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: "Quantity: ",
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: user.userModel.cart[index]["quantity"].toString(),
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RawMaterialButton(
                                onPressed: (){
                                  app.changeIsLoading();
                                  if(user.userModel.cart[index]["quantity"]==1){
                                    user.removeFromCart(cartItem: user.userModel.cart[index]);
                                    user.reloadUserModel();
                                  }else {
                                    user.userModel.cart[index]["quantity"] = user.userModel.cart[index]["quantity"] - 1;
                                    user.updateToCard(user.userModel.cart);
                                    user.reloadUserModel();
                                  }
                                  app.changeIsLoading();
                                },
                                child: Icon(Icons.delete,color:Colors.white,size: 25.0,),
                                shape: CircleBorder(),
                                //elevation: 2.0,
                                fillColor: Colors.green,
                              ),
                              Text(
                                user.userModel.cart[index]["quantity"].toString(),
                                style: TextStyle(
                                  fontSize:  20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RawMaterialButton(
                                onPressed: (){
                                  app.changeIsLoading();
                                  user.userModel.cart[index]["quantity"] = user.userModel.cart[index]["quantity"]+1;
                                  user.updateToCard(user.userModel.cart);
                                  user.reloadUserModel();
                                  app.changeIsLoading();
                                },
                                child: Icon(Icons.add,color:Colors.white,size: 25.0,),
                                shape: CircleBorder(),
                                elevation: 2.0,
                                fillColor: Colors.green,
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

      bottomNavigationBar:(user.userModel.totalCartPrice<1)? null:Container(
        height: 260,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Total: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  Text(
                      "${user.userModel.totalCartPrice}",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),

                ],
              ),
              SizedBox(
                height: 10.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "Delivery fee: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  if (user.userModel.totalCartPrice < 500) Text(
                      "20",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)) else Text(
                      "Free",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              Divider(
                height: 35.0,
                color: Color(0xFFD3D3D3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sub Amount",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  if ((user.userModel.totalCartPrice) < 500) Text(
                    ((user.userModel.totalCartPrice)+20).toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ) else Text(
                    user.userModel.totalCartPrice.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  changeScreen(context, address());
                },
                child: Container(
                  width: 500.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      "Process to Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

