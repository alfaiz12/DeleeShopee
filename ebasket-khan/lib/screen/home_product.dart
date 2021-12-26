import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebasket/model/Product.dart';
import 'package:ebasket/provider/product.dart';
import 'package:ebasket/screen/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebasket/screen/second.dart';
import 'package:ebasket/screen/detail.dart';
import 'package:provider/provider.dart';
class products extends StatefulWidget {
  products();
  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<products> {

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
   return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Our Products",
            style: TextStyle(
                color: Colors.black
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body:Container(
               child:  GridView.builder(
                itemCount:  productProvider.products.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (_, index)
                {
                  if(productProvider.products[index].name == "Features"){
                    return single_product(product: productProvider.products[index],);
                  }else{
                    return SizedBox();
                  }

                }),
    )
   );
  }

}

class single_product extends StatelessWidget {

  final ProductModel product;
  const single_product({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),

        ),
      color: Color(0xffF7DFB9),
      child: Hero(
        tag: Text(product.name),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
               ProductDetail(product.name,product.price,product.picture,product.category,product.id,product.description,product.id,product.stock,product.sale)
            )) ,
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                height: 45,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                    ),
                    Text("${product.price}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              child: Image.network("${product.picture}",
               fit: BoxFit.fill, ),
            ),
          ),
        ),
      ),
    );
  }
}



