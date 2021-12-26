import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/provider/carts.dart';
import 'package:ebasket/provider/product.dart';
import 'package:ebasket/screen/login.dart';
import 'package:ebasket/screen/login1.dart';
import 'package:ebasket/screen/splash%20screen.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ebasket/services/cartService.dart';
import 'package:ebasket/services/totalk.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    //ChangeNotifierProvider.value(value: CartProvider.initialize()),
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),

  ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DS-Agroventures',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
          home: splash())));
}
class ScreensController extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    switch (auth.status) {
      case Status.Unintialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return loginPage();
      case Status.Authentiated:
        return Wrapper();
      default:
        //Loading();
        return loginPage();
    }
  }
}


