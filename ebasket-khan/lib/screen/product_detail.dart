import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebasket/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:ebasket/screen/order_card.dart';
import 'package:ebasket/screen/card.dart';
import 'package:ebasket/screen/Post.dart';
import 'package:ebasket/model/Product.dart';
import 'package:provider/provider.dart';
class ProductDettails extends StatefulWidget {
  final name;
  final price;
  final image;
  final category;
  ProductDettails(this.name,this.price,this.image,this.category);
  @override
  _ProductDettailsState createState() => _ProductDettailsState();
}
class _ProductDettailsState extends State<ProductDettails> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackbar(){
    print("Item Added to Cart");
    final snackBar = new SnackBar(content: new Text("Item added to cart"),
    duration: new Duration(seconds: 3),
    backgroundColor: Colors.red,);
  _scaffoldkey.currentState.showSnackBar(snackBar);
  }
  int _valu = 1;
  int prod_total_price=0;
  void add(){
    setState(() {
      _valu+=1;
     // prod_total_price=_valu*int.parse(widget.products_detail_new_price);
    });
  }
  void sub(){
    setState(() {
      if(_valu==1){
      }else {
        _valu -= 1;
        //prod_total_price=_valu*int.parse(widget.products_detail_new_price);
      }});
  }


  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "e-Basket",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme:  IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.image),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "1kg",
                          style: TextStyle(
                            color: Colors.grey,

                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$${widget.price}",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Row(

            children: <Widget>[
              Container(
                color: Colors.red,
                width: 360.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: (){
                        sub();

                      },
                      child: Icon(Icons.remove,color:Colors.black,size: 25.0,),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                    ),
                    Text('$_valu',style:TextStyle(fontSize: 34.0,color: Colors.black)),
                    RawMaterialButton(
                      onPressed: (){
                        add();

                      },
                      child: Icon(Icons.add,color:Colors.black,size: 25.0,),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                    ),
                  ],
                ),
              ),

            ],
          ),
          //==============First Button=======
          Row(
            children: <Widget>[
              //==========size =============
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute
                      (builder: (context)=>new Order(
                      prod_name: widget.name,prod_images: widget.image,prod_price:widget.price,
                      prod_qty: _valu,
                    ))
                    );
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Buy Now"),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    /*FirebaseFirestore.instance.collection("Add_to_Cart").where("product_Name",isEqualTo: "coconut").get().then((query) => {
                      const thing = query.docs[0];
                    });*/
                    //black();
                    //getData(widget.product.name,widget.product.picture,widget.product.price,_valu);
                    _showSnackbar();
                    /*FirebaseFirestore.instance.collection("Add_to_Cart").document("pEtzUeT7Nk0u8ewfia2").set({
                      "product_Name": widget.products_detail_name,
                      "product_image": widget.products_detail_picture,
                      "product_price":widget.products_detail_new_price.toString(),
                      "product_qty":13,
                    }).then((value) {
                      print("updated");
                    });*/
                    /*FirebaseFirestore.instance.collection('Add_to_Cart').where('product_Name',isEqualTo: "coconut").
                    get().then((QuerySnapshot docs){
                      // ignore: deprecated_member_use
                      if(docs.documents.isEmpty){
                        _showSnackbar();
                      }else{
                        print(docs.documents[0].data());
                        //_showSnackbar();
                      }
                    });*/
                   // FirebaseFirestore.instance.collection("user_cat").doc().snapshots().then((QuerySnapshot snap){
                    //});
                  }),

              IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
            ],
          ),
          Divider(),

          //Product Detail
          ListTile(
            title: Text("Product Details:"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                    "when an unknown printer took a galley of type and scrambled it to make a type specimen book"
                    ". It has survived not only five centuries, "
            ),
          ),

          Divider(),

          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Name",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.name),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Price",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.price.toString()),
              ),
            ],
          ),


          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Total Price",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('$prod_total_price'),
              ),
            ],
          ),

          Divider(),
          Text("Similar Product"),
          //Similar Product


        ],
      ),
    );
  }
}


//Similar Product





