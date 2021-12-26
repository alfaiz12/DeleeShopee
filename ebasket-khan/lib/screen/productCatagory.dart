import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/helpers/style.dart';
import 'package:ebasket/model/Product.dart';
import 'package:ebasket/provider/product.dart';
import 'package:ebasket/screen/cart.dart';
import 'package:ebasket/screen/detail.dart';
import 'package:ebasket/screen/product_detail.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class catagoryProduct extends StatefulWidget {
  String CatagoryType;
  catagoryProduct({this.CatagoryType});
  @override
  _catagoryProductState createState() => _catagoryProductState();
}

class _catagoryProductState extends State<catagoryProduct> {
  ProductModel product;
  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 5.0,
        title: Text(
            widget.CatagoryType,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
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
      body:ListView.separated(
        itemBuilder: (BuildContext context,int index){
          if(productProvider.products[index].category == widget.CatagoryType){
            return Padding(
              padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: 80.0,
                              width: 80.0,
                              child: Image.network(
                                productProvider.products[index].picture,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                productProvider.products[index].name,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0,),

                              Text(
                                "\u20B9 "+productProvider.products[index].price.toString(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              SizedBox(height: 10.0,),

                              Text(
                                productProvider.products[index].category,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),

                            ],
                          ),

                          Spacer(),

                          Column(
                            children: [
                              SizedBox(height: 20.0,),
                              RaisedButton(
                                color: Colors.green,
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>

                                          ProductDetail( productProvider.products[index].name, productProvider.products[index].price.toString(), productProvider.products[index].picture, productProvider.products[index].category,productProvider.products[index].id,productProvider.products[index].description,productProvider.products[index].id,productProvider.products[index].stock,productProvider.products[index].quans)

                                  ));

                                },
                                  child: Text(
                                    "ADD",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),

                            ],
                          ),

                        ]
                    ),
                  ],
                ),
              );
          }else{
            return SizedBox();
          }
        },

        separatorBuilder: (BuildContext context,int index){
          return Divider(
            height: 0.0,
          );
        },
        itemCount: productProvider.products.length,
      ),
    );
  }
}
