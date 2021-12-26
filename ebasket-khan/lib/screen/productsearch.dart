import 'package:ebasket/model/Product.dart';
import 'package:ebasket/provider/product.dart';
import 'package:ebasket/screen/custom_text.dart';
import 'package:ebasket/screen/detail.dart';
import 'package:ebasket/screen/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class productsearch extends StatefulWidget {

  @override
  _productsearchState createState() => _productsearchState();
}

class _productsearchState extends State<productsearch> {
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
          'Searched Product',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: productProvider.productsSearched.length < 1 ? Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search,color: Colors.grey,size: 30,),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomText(text:"No Products Found")
        ],

      ) : ListView.separated(

        itemBuilder: (BuildContext context,int index){
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
                              productProvider.productsSearched[index].picture,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              productProvider.productsSearched[index].name,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0,),

                            Text(
                              "\u20B9 "+productProvider.productsSearched[index].price.toString(),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              productProvider.productsSearched[index].category,
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
                                        ProductDetail( productProvider.productsSearched[index].name, productProvider.productsSearched[index].price.toString(), productProvider.productsSearched[index].picture, productProvider.productsSearched[index].category,productProvider.productsSearched[index].id,productProvider.products[index].description,productProvider.products[index].id,productProvider.products[index].stock,productProvider.products[index].quans)
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

        },
        itemCount: productProvider.productsSearched.length,
        separatorBuilder: (BuildContext context,int index){
          return Divider(
            height: 0.0,
          );
        },

      ),
    );
  }
}
