import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/helpers/style.dart';
import 'package:ebasket/model/Product.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/cart.dart';
import 'package:ebasket/screen/custom_text.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ebasket/screen/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
class ProductDetail extends StatefulWidget {
  final name;
  final price;
  final image;
  final category;
  final id;
  final description;
  final productId;
  final stock;
  final quans;
  ProductDetail(this.name,this.price,this.image,this.category,this.id,this.description,this.productId,this.stock,this.quans);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductModel pro;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackbar(){
    print("Item Added to Cart");
    final snackBar = new SnackBar(content: new Text("Item added to cart"),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.green,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
  int _valu = 1;
  int prod_total_price=0;
  void add(){
    setState(() {
      _valu+=1;
    });
  }
  void sub(){
    setState(() {
      if(_valu==1){
      }else {
        _valu -= 1;
      }});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        elevation: 0.0,
        //title: CustomText(text: "Product Details"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
             // changeScreen(context, Wrapper());
              //Navigator.pop(context);
            }),
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
      bottomNavigationBar: Container(
        height: 250.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: (){
                    sub();
                  },
                  child: Icon(Icons.remove,color:Colors.white,size: 40.0,),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.green,
                ),
                Text(
                  "$_valu",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RawMaterialButton(
                  onPressed: (){
                          add();
                  },
                  child: Icon(Icons.add,color:Colors.white,size: 40.0,),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 15.0,),
            RaisedButton(
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute
                  (builder: (context)=>new Order(
                  prod_name: widget.name,prod_images: widget.image,prod_price:widget.price,
                  prod_qty: _valu,total: (int.parse(widget.price))*_valu,id: widget.productId,stock: widget.stock,
                ))
                );
              },
              child: Text(
                "Buy Now ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            FlatButton(
              color: Colors.orangeAccent,
              child: RaisedButton(
                color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 23.0,vertical: 10.0),
                onPressed: ()async{
                  app.changeIsLoading();
                  user.addToCard(widget.name,widget.price,widget.image,widget.productId,_valu,widget.stock);
                  user.reloadUserModel();
                  app.changeIsLoading();
                  _showSnackbar();
                  },
                child:app.isLoading ?Loading() : Text(
                    "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.zero,bottomLeft: Radius.circular(120),bottomRight: Radius.circular(120)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                color: Colors.green,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 5.0,
                      right: 110.0,
                      child: CircleAvatar(
                        maxRadius: (70.0),
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
               widget.category,
              style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 "\u20B9${ widget.price}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey
                  ),
                ),
                SizedBox(width: 0.0,),
                Text(
                  "${ widget.quans}",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                widget.description.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
