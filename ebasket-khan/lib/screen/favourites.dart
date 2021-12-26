import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/CustomTextStyle.dart';
import 'package:ebasket/screen/trackorder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class Orderdetailpage extends StatefulWidget {
 final name;
 final home;
 final road;
 final land;
 final city;
 final pin;
 final phone;
 final status;
 final idvm;
 final total;
 Orderdetailpage(this.name,this.home,this.road,this.land,this.city,this.pin,this.phone,this.status,this.idvm,this.total);
  //Orderdetailpage(String name,String home,String road,String land,String city,String pin,String Phone);
  @override
  _OrderdetailpageState createState() => _OrderdetailpageState();
}

class _OrderdetailpageState extends State<Orderdetailpage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Order Detail",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),

        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      price(),
                      selectedAddressSection(),
                      //checkoutItem(),
                      priceSection()
                    ],
                  ),
                ),
                flex: 90,
              ),
              (widget.status) != "100" ? Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: RaisedButton(
                    onPressed: () {
                     changeScreen(context, trackOrderPage(
                       widget.status,
                       widget.idvm,
                     ));
                    },
                    child: Text(
                      "Track Order",
                      style: CustomTextStyle.textFormFieldMedium.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                ),
                flex: 10,
              ):Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: RaisedButton(
                    onPressed: () {
                      changeScreen(context, trackOrderPage(
                        widget.status,
                        widget.idvm,
                      ));
                    },
                    child: Text(
                      "Order Delivered",
                      style: CustomTextStyle.textFormFieldMedium.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                ),
                flex: 10,
              )
            ],
          );
        }),
      ),
    );
  }
  selectedAddressSection() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "SHIPPING DETAILS",
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.name,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Text(
                      "HOME",
                    ),
                  )
                ],
              ),
              createAddressText(
                  widget.home, 16),
              createAddressText(widget.road, 6),
              createAddressText(widget.land, 6),
              createAddressText(widget.city, 6),
              createAddressText(widget.pin, 6),
              createAddressText("Maharashtra", 6),
              createAddressText(widget.phone, 6),
              SizedBox(
                height: 6,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              addressAction(),

            ],
          ),
        ),
      ),
    );
  }
  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
      ),
    );
  }
  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),

          Spacer(
            flex: 3,
          ),

          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
  priceSection() {
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              createPriceItem("Total MRP", widget.total,
                  Colors.grey.shade700),
              (int.parse(widget.total)) > 500 ?  createPriceItem("Delievery Charges", "FREE", Colors.green)
              : createPriceItem("Delievery Charges", "30", Colors.teal.shade300),
        SizedBox(
          height: 8,
        ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total",
                  ),
                  (int.parse(widget.total)) > 500 ?Text((int.parse(widget.total)).toString()):
                  Text((int.parse(widget.total)+30).toString())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
          ),
          Text(
            value,
          )
        ],
      ),
    );
  }
  price() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "OrderId : "
                    , style: CustomTextStyle.textFormFieldMedium
                        .copyWith(fontSize: 16)),
                    TextSpan(
                      text: widget.idvm, style: CustomTextStyle.textFormFieldMedium
                        .copyWith(fontSize: 16)
                    )
                  ]),
                ),
                SizedBox(
                  height: 4,
                ),
              ]
          ),
        ),
      ),
    );
  }

}



