import 'package:ebasket/dialog/dialog_helper.dart';
import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/favourites.dart';
import 'package:ebasket/screen/myorderpage.dart';
import 'package:flutter/material.dart';
import 'package:ebasket/screen/styleScheme.dart';
import 'package:ebasket/dialog/exit_confirmation_dialog.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class trackOrderPage extends StatefulWidget {
  final status;
  final id;
  trackOrderPage(this.status,this.id);
  @override
  _trackOrderPageState createState() => _trackOrderPageState();
}

class _trackOrderPageState extends State<trackOrderPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context,listen: false);
    final app = Provider.of<AppProvider>(context,listen: false);
    void exit(context)=> showDialog(context: context,builder: (context) =>ExitConfirmation(widget.id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Track Order", style: TextStyle(
            color: Colors.black
        ),),

      ),
      body:app.isLoading ? Loading() : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Number:", style: headingStyle,),
              Text(widget.id.toString(), style: contentStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 16
              ),),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 1,
                color: Colors.grey,
              ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 13, top: 50),
                      width: 4,
                      height: 400,
                      color: Colors.grey,
                    ),

                    (widget.status!="-100") ? Column(
                      children: [
                        (widget.status=="0") ? statusWidget('confirmed', 'Confirmed', true)  : statusWidget('confirmed', 'Confirmed', false),
                        (widget.status=="25") ? statusWidget('onBoard2', "Picked Up", true): statusWidget('onBoard2', "Picked Up", false),
                        (widget.status=="50") ? statusWidget('servicesImg', "In Process", true):statusWidget('servicesImg', "In Pricess", false),
                        (widget.status=="75") ? statusWidget('shipped', "Shipped", true):statusWidget('shipped', "Shipped", false),
                        (widget.status=="100") ? statusWidget('Delivery', "Delivered", true):statusWidget('Delivery', "Delivered", false),
                      ]
                    ):Column(
                        children: [
                           statusWidget('confirmed', 'Confirmed', true),
                           statusWidget('onBoard2', "Cancelled", true),
                          statusWidget('onBoard2', "Cancelled", true),
                          statusWidget('onBoard2', "Cancelled", true),
                          statusWidget('onBoard2', "Cancelled", true),
                        ]
                    )
                  ],
                ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 1,
                color: Colors.grey,
              ),

              (widget.status !="-100") && (widget.status !="100") ?  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                     app.changeIsLoading() ;
                     exit(context);
                     user.reloadOrderModel();
                     app.changeIsLoading();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.green,
                          )
                      ),
                      child: Text("Cancel Order", style: contentStyle.copyWith(
                          color: Colors.green
                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      changeScreen(context, myorders());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),

                        color: Colors.green,

                      ),
                      child: Text("My Orders", style: contentStyle.copyWith(
                          color: Colors.white
                      ),),
                    ),
                  ),
                ],
              ):Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      changeScreen(context, myorders());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),

                        color: Colors.green,

                      ),
                      child: Text("My Orders", style: contentStyle.copyWith(
                          color: Colors.white
                      ),),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),

    );
  }
  Container statusWidget(String img, String status, bool isActive)
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? Colors.green : Colors.white,
                border: Border.all(
                    color: (isActive) ? Colors.transparent : Colors.green,
                    width: 3
                )
            ),
          ),
          SizedBox(width: 50,),
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/$img.png"),
                        fit: BoxFit.contain
                    )
                ),
              ),
              Text(status, style: contentStyle.copyWith(
                  color: (isActive) ? Colors.orange : Colors.black
              ),)
            ],
          )
        ],
      ),
    );
  }
}