import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/main.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/avi.dart';
import 'package:ebasket/screen/cart.dart';
import 'package:ebasket/screen/explore.dart';
import 'package:ebasket/screen/login.dart';
import 'package:ebasket/screen/login1.dart';
import 'package:ebasket/screen/myorderpage.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool turnonNotification = false;
  bool turnonLocation = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          offset: Offset(0,4.0),
                          color: Colors.black38,
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage('images/groceries.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(width: 30.0,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.userModel.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        user.userModel.email,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        height: 25.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            "Welcome!!",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 40.0,),
              Text(
                "Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 15.0),
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            //changeScreen(context, Wrapper());
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));;
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.green,
                              ),
                              SizedBox(width: 15.0,),
                              Text(
                                "Home",
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
                          onTap: (){
                            changeScreen(context, Explore());
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.explore,
                                color: Colors.green,
                              ),
                              SizedBox(width: 15.0,),
                              Text(
                                "Explore",
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
                          onTap: (){
                            changeScreen(context, CartScreen());
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.green,
                              ),
                              SizedBox(width: 15.0,),
                              Text(
                                "Shopping Cart",
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
                            await user.getOrders();
                            changeScreen(context, myorders());
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.shopping_basket,
                                color: Colors.green,
                              ),
                              SizedBox(width: 15.0,),
                              Text(
                                "My Orders",
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
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.description,
                              color: Colors.green,
                            ),
                            SizedBox(width: 15.0,),
                            Text(
                              "About Us",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 10.0,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.visibility,
                              color: Colors.green,
                            ),
                            SizedBox(width: 15.0,),
                            Text(
                              "Terms and Condition",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 90.0,),
              GestureDetector(
                onTap: () async {
                  user.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginPage()));
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
                      "Logout",
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
        ),
      ),
    );
  }
}
