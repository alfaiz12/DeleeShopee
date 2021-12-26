import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/model/nes.dart';
import 'package:ebasket/model/order.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/custom_text.dart';
import 'package:ebasket/screen/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //List car =[];
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          onPressed: (){
            changeScreen(context, payment());
          },
          icon: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: user.orders.length,
              itemBuilder: (_, index){
                OrderModel _order = user.orders[index];
                return Column(
                    children:<Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: user.orders[index].cart.length,
                          itemBuilder: (_ , indexs) {
                            print(user.orders[index].cart[indexs]["productId"]);
                            return ListTile(
                              leading: CustomText(
                                text: "\$${_order.total / 100}",
                                weight: FontWeight.bold,
                              ),
                              title: Text("fruits"),
                              subtitle: Text("hi"),
                              //subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_order.id).toString()),
                              trailing: CustomText(
                                text: _order.status, color: Colors.green,),
                              //  trailing: CustomText(text: _order.cart[index], color: Colors.green,),
                            );
                          }
                      ),

                    ]
                );
              }),
        ),
      ),

    );

  }
}
