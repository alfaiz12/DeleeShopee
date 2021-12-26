
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/card.dart';
import 'package:ebasket/screen/cart.dart';
import 'package:ebasket/screen/explore.dart';
import 'package:ebasket/screen/home.dart';
import 'package:ebasket/screen/home_product.dart';
import 'package:ebasket/screen/myorderpage.dart';
import 'package:ebasket/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:ebasket/screen/order.dart';
import 'package:provider/provider.dart';
class Main_screen extends StatefulWidget {
  @override
  _Main_screenState createState() => _Main_screenState();
}
class _Main_screenState extends State<Main_screen> {
  int currentTabIndex = 0;
  List<Widget> pages;
  Widget currentPage;
  HomePage homePage;
  CartScreen cart;
  Explore favorite;
  Profile profile;

  @override

  void initState(){
    super.initState();
    homePage = HomePage();
    cart = CartScreen();
    favorite = Explore();
    profile = Profile();
    pages = [homePage,favorite,cart,profile];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text("Explore"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Cart"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
          ],
        ),

        body: currentPage,
      ),
    );
  }
}