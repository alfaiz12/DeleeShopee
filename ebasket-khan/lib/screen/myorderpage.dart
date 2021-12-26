import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/helpers/style.dart';
import 'package:ebasket/model/cart_item.dart';
import 'package:ebasket/model/order.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/cart.dart';
import 'package:ebasket/screen/favourites.dart';
import 'package:ebasket/services/order.dart';
import 'package:ebasket/services/user.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'custom_text.dart';

class myorders extends StatefulWidget {
  @override

  _myordersState createState() => _myordersState();
}

class _myordersState extends State<myorders> {

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
        title: CustomText(text: "My Orders"),
      
        actions: <Widget>[
          IconButton(
            onPressed: () {
              changeScreen(context, CartScreen());
            },
            icon: Icon(Icons.shopping_cart,color:white,size: 25.0,),
          ),
          IconButton(
            onPressed: () {
             Navigator.pop(context);
            },
            icon: Icon(Icons.home,color:white,size: 25.0,),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body:app.isLoading ? Loading() : SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: user.orders.length,
                itemBuilder: (_, index) {
                  print(user.orders.length);
                  OrderModel _order = user.orders[index];
                   return Column(
                     children: <Widget>[
                       ListView.builder(
                           shrinkWrap: true,
                           physics: ClampingScrollPhysics(),
                           itemCount: user.orders[index].cart.length,
                        itemBuilder: (_, indexs) {
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
                                      user.orders[index].cart[indexs]["image"],
                                      height: 120,
                                      width: 95,
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
                                                text: "${user.orders[index].cart[indexs]["name"]} \n\n",
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold)),
                                            TextSpan(
                                                text: "Quantity: ",
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)),
                                            TextSpan(
                                                text: "${user.orders[index].cart[indexs]["quantity"].toString()} \n\n",
                                                style: TextStyle(
                                                    color: primary,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)),
                                            TextSpan(
                                                text: "Status: ",
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)),
                                            (user.orders[index].status =="-100") ? TextSpan(
                                                text: "Cancelled",
                                                style: TextStyle(
                                                    color: green,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)):
                                            (user.orders[index].status =="0") ? TextSpan(
                                                text: "Confirmed",
                                                style: TextStyle(
                                                    color: green,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)):
                                            (user.orders[index].status =="50") ?
                                            TextSpan(
                                                text: "In Process",
                                                style: TextStyle(
                                                    color: green,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)): TextSpan(
                                                text: "Delivered",
                                                style: TextStyle(
                                                    color: green,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400))
                                          ]),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            RawMaterialButton(
                                              onPressed: (){
                                               changeScreen(context, Orderdetailpage(
                                                user.orders[index].name,
                                                 user.orders[index].home,
                                                 user.orders[index].road,
                                                 user.orders[index].land,
                                                 user.orders[index].city,
                                                 user.orders[index].pin,
                                                 user.orders[index].phone,
                                                 user.orders[index].status,
                                                 user.orders[index].id,
                                                 user.orders[index].cart[indexs]["price"],
                                               ));
                                              },
                                              child: Icon(Icons.more_horiz,color:Colors.white,size: 25.0,),
                                              shape: CircleBorder(),
                                              //elevation: 2.0,
                                              fillColor: Colors.green,
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );

                        }
                       ),
                     ],
                   );
                }),
          ],
        ),
      ),
    );
  }
}
