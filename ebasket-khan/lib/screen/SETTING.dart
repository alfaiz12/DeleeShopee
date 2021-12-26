import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/provider/product.dart';
import 'package:ebasket/screen/Success.dart';
import 'package:ebasket/screen/custom_text.dart';
import 'package:ebasket/screen/home.dart';
import 'package:ebasket/screen/payment.dart';
import 'package:ebasket/services/order.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';
class address extends StatefulWidget {
  @override
  _addressState createState() => _addressState();
}
class _addressState extends State<address> {
  final form = GlobalKey<FormState>();
  var jkl;
  var _name;
  var _phone;
  var _pin;
  var _house;
  var _road;
  var _land;
  var _city;
  final namecon = TextEditingController();
  final phonecon = TextEditingController();
  final pincon = TextEditingController();
  final housecon = TextEditingController();
  final roadcon = TextEditingController();
  final landcon = TextEditingController();
  final citycon = TextEditingController();
  final _formkey =GlobalKey<FormState>();
  int totalamount = 0;
  var payment;
  Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
  void openCheckout()async{
    var option = {
      'key':'rzp_test_TfQ9j0yT0bsoRs',
      'amount':totalamount*100,
      'name':'Dartings',
      'description':'Test Payment',
      'prefill':{'contact':'','email':''},
      'external': {
        'wallets': ['paytm']
      }

    };
    try{
      _razorpay.open(option);
    }catch(e){
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response)async{
   // Fluttertoast.showToast(msg:"SUCCESS"+ response.paymentId);
    print("response.paymentId");
    setState(() {
      payment="SUCCESS";
    });
    print(payment);
    createorder();
  }
  void _handlePaymentError(PaymentFailureResponse response){
   //Fluttertoast.showToast(msg:"ERROR"+ response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response){
   // Fluttertoast.showToast(msg: "External Toast"+ response.walletName);
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);
    setState(() {
      totalamount=user.userModel.totalCartPrice;
    });
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.green,
          elevation: 0.0,
          title: CustomText(text: "User Details"),
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: Colors.white,
     body:  Builder(builder: (context) {
       return Column(
         children: <Widget>[
           Expanded(
             child: Container(
               child: ListView(
                 children: <Widget>[
                  userdet(),

               Center(
                 child: Text(
                       "Mode of payment",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 18.0,
                       ),
                     ),
               ),
                   card(),
                 ],
               ),
             ),
             flex: 90,
           ),

         ],
       );
     }),

    );
  }


  userdet(){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Material(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      leading: Icon(Icons.verified_user),
                      elevation: 0,
                      title: Text('Address'),
                      backgroundColor: Colors.green,
                      centerTitle: true,
                      actions: <Widget>[

                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        controller: pincon,
                        //initialValue: widget.user.fullName,
                        //  onSaved: (val) => widget.user.fullName = val,
                        validator: (val) =>
                        val.length == 6 ? null : 'invalid pincode',
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                          hintText: 'Enter pincode',
                          icon: Icon(Icons.pin_drop),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        controller: housecon,
                        //initialValue: widget.user.fullName,
                        //  onSaved: (val) => widget.user.fullName = val,
                        validator: (val) =>
                        val.length < 10 ? 'invalid address':null  ,
                        decoration: InputDecoration(
                          labelText: 'House No., Building name',
                          hintText: 'House No., Building name',
                          icon: Icon(Icons.home),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        controller: roadcon,
                        //initialValue: widget.user.fullName,
                        //  onSaved: (val) => widget.user.fullName = val,
                        validator: (val) =>
                        val.length == 10 ? 'invalid address' :null ,
                        decoration: InputDecoration(
                          labelText: 'Road Name,Area,Colony',
                          hintText: 'House No., Building name',
                          icon: Icon(Icons.home),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        controller: landcon,
                        //initialValue: widget.user.fullName,
                        //  onSaved: (val) => widget.user.fullName = val,
                        validator: (val) =>
                        val.length < 10 ? 'invalid address' :null ,
                        decoration: InputDecoration(
                          labelText: 'LandMark',
                          hintText: 'LandMark',
                          icon: Icon(Icons.home),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        controller: citycon,
                        //initialValue: widget.user.fullName,
                        //  onSaved: (val) => widget.user.fullName = val,
                        validator: (val) =>
                        val.isEmpty ? 'invalid city' :null ,
                        decoration: InputDecoration(
                          labelText: 'city',
                          hintText: 'Mumbai',
                          icon: Icon(Icons.location_city),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        controller: namecon,
                        //initialValue: widget.user.fullName,
                         //onSaved: (val) => widget.user.fullName = val,
                        validator: (val) =>
                        val.isEmpty ? 'please enter your name' :null ,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          icon: Icon(Icons.person),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 19),
                      child: TextFormField(
                        controller: phonecon,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        //  initialValue: widget.user.email,
                        //  onSaved: (val) => widget.user.email = val,
                        validator: (val) =>
                        val.length == 10  ? null :'invalid Phone number' ,
                        decoration: InputDecoration(
                          labelText: 'phone Number',
                          hintText: 'Enter your phone',
                          icon: Icon(Icons.phone),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  card(){
    final _key = GlobalKey<ScaffoldState>();
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final prod = Provider.of<ProductProvider>(context,listen: false);
    OrderServices _orderServices = OrderServices();
    return
      Card(
      margin: EdgeInsets.only(top: 15.0),
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.0,),
        child: Column(
          children: <Widget>[
            Divider(height: 10.0,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: ()async{
                  if(_formkey.currentState.validate()){
                  setState(() {
                    _name=namecon.text;
                    _phone=phonecon.text;
                    _pin=pincon.text;
                    _house=housecon.text;
                    _road=roadcon.text;
                    _land=landcon.text;
                    _city=citycon.text;
                  });
                  int totalcartsprices=0;
                  if(user.userModel.totalCartPrice<500){
                    totalcartsprices = totalcartsprices+20;
                  }else{
                    totalcartsprices = totalcartsprices;
                  }
                  var uuid = Uuid();
                  String id = uuid.v4();
                  _orderServices.createOrder(
                    user.userModel.id,
                    id,
                    user.userModel.cart,
                      totalcartsprices,
                    "0",
                    "some random description",
                    _name.toString(),
                    _phone.toString(),
                    _pin.toString(),
                    _house.toString(),
                    _road.toString(),
                    _land.toString(),
                    _city.toString()
                  );
                  for(Map cartItem in user.userModel.cart){
                    app.changeIsLoading();
                    user.reloadUserModel();
                    prod.loadProducts();
                    int stock = ((int.parse(cartItem["stock"]))-cartItem["quantity"]);
                    user.updateToProductsStock(cartItem["productId"],stock.toString());
                    bool value = await user.removeFromCart(cartItem:cartItem);
                    if(value){
                      user.reloadUserModel();
                      print("Item added to cart");

                    }else{
                      print("ITEM WAS NOT REMOVED");
                    }
                     app.changeIsLoading();
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Success()));
                  }
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 15.0,),
                    Text(
                      "Cash on delivery(Cod)",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 10.0,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: ()async{
             if(_formkey.currentState.validate()) {
               setState(() {
                 _name=namecon.text;
                 _phone=phonecon.text;
                 _pin=pincon.text;
                 _house=housecon.text;
                 _road=roadcon.text;
                 _land=landcon.text;
                 _city=citycon.text;
               });
               openCheckout();
              }
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.payment,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 15.0,),
                    Text(
                      "Payment",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void createorder()async{
    final user = Provider.of<AuthProvider>(context,listen: false);
    final app = Provider.of<AppProvider>(context,listen: false);
    final prod = Provider.of<ProductProvider>(context,listen: false);
    OrderServices _orderServices = OrderServices();
    if(payment=="SUCCESS")
    {
      int totalcartsprices=0;
      if(user.userModel.totalCartPrice<500){
        totalcartsprices = totalcartsprices+20;
      }else{
        totalcartsprices = totalcartsprices;
      }
      print("h..............");
      var uuid = Uuid();
      String id = uuid.v4();
      _orderServices.createOrder(
          user.userModel.id,
          id,
          user.userModel.cart,
          totalcartsprices,
          "0",
          "some random description",
          _name.toString(),
          _phone.toString(),
          _pin.toString(),
          _house.toString(),
          _road.toString(),
          _land.toString(),
          _city.toString()
      );
      for(Map cartItem in user.userModel.cart){
        app.changeIsLoading();
        user.reloadUserModel();
        prod.loadProducts();
        int stock = ((int.parse(cartItem["stock"]))-cartItem["quantity"]);
        user.updateToProductsStock(cartItem["productId"],stock.toString());
        bool value = await user.removeFromCart(cartItem:cartItem);
        if(value){
          user.reloadUserModel();
          print("Item added to cart");

        }else{
          print("ITEM WAS NOT REMOVED");
        }
        app.changeIsLoading();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Success()));
    }
  }
}
