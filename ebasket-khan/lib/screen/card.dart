import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/screen/buynow.dart';
import 'package:ebasket/screen/order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Order extends StatefulWidget {
  final prod_name;
  final prod_images;
  final prod_price;
  final prod_qty;
  final total;
  final id;
  final stock;
  Order({
    this.prod_name,
    this.prod_images,
    this.prod_price,
    this.prod_qty,
  this.total
  ,this.id,
  this.stock});
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Widget _buildTotalAmountContainer(){

    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total Amount",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                widget.total.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Delivery Fee",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              (widget.total) < 500?Text(
                "20",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ):Text(
                  "Free",
                  style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
              ),
    )
            ],
          ),

          SizedBox(height: 10.0,),


          Divider(height: 35.0,color: Color(0xFFD3D3D3),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Sub Amount",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              (widget.total) < 500?Text(
                (widget.total+20).toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ):Text(
                widget.total.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),

          SizedBox(height: 30.0,),
          GestureDetector(
            onTap: (){
              if(widget.total < 500) {
                int a = widget.total+20;
                changeScreen(context, buynow(
                    widget.prod_name, widget.prod_images, widget.prod_price,
                    widget.id, widget.prod_qty, a,widget.stock));
              }else{
                changeScreen(context, buynow(
                    widget.prod_name, widget.prod_images, widget.prod_price,
                    widget.id, widget.prod_qty, widget.total,widget.stock));
              }
             },
            child: Container(
              width: MediaQuery.of(context).size.width,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text(
            "Your Order",
          style: TextStyle(
            color: Colors.black
          )
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          OrderCard(prod_name:widget.prod_name,prod_images:widget.prod_images ,prod_price:widget.prod_price ,
            prod_qty:widget.prod_qty ,),
          _buildTotalAmountContainer(),
        ],
      ),
    );
  }
}
