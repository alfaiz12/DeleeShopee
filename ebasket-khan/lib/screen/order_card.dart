import 'package:ebasket/helpers/style.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final prod_name;
  final prod_images;
  final prod_price;
  final prod_qty;
  OrderCard({
  this.prod_qty,this.prod_images,this.prod_price,this.prod_name});

  @override
  _OrderCardState createState() => _OrderCardState();
}
class _OrderCardState extends State<OrderCard> {
  int qtyi = 0;
  void name(){
    setState(() {
      qtyi=(widget.prod_qty);
    });
  }
  void add() {
    setState(() {
      qtyi=qtyi+1;
    });
  }
  void sub() {
    setState((){
      qtyi=qtyi-1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child:  Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: Image.network(
                widget.prod_images,
                height: 120,
                width: 100,
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
                          text: "${widget.prod_name} \n\n",
                          style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "\u20B9"+"${widget.prod_price } \n\n",
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
                          text: widget.prod_qty.toString(),
                          style: TextStyle(
                              color: primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ]),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}