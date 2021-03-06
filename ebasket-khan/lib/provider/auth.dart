import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebasket/model/Product.dart';
import 'package:ebasket/model/cart_item.dart';
import 'package:ebasket/model/order.dart';
import 'package:ebasket/model/user.dart';
import 'package:ebasket/services/order.dart';
import 'package:ebasket/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Status { Unintialized, Unauthenticated, Authenticating, Authentiated}

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  Firestore _firestore = Firestore.instance;

  FirebaseUser _user;
  Status _status = Status.Unintialized;

  //private variable
  UserServices _userServices = UserServices();
  UserModel _userModel;
  OrderModel _orderModel;
  OrderServices _orderServices = OrderServices();
  //getters
  Status get status => _status;

  UserModel get userModel => _userModel;
  OrderModel get orderModel => _orderModel;

  FirebaseUser get user => _user;
  List<OrderModel> orders = [];
  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  //signIn
  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      return true;
    } catch (e) {
      _status = Status.Unintialized;
      notifyListeners();
      print("error:" + e.toString());
      return false;
    }
  }

  //SignOut
  Future<void> signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  //singUp
  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((user) {
        Map<String, dynamic> values = {
          "name": name.text,
          "email": email.text,
          "id": user.user.uid,
        };
        _userServices.createUsers(values);
      });
      return true;
    } catch (e) {
      return onError(e.toString());
    }
  }

  Future sendPasswordreset()async{
    return _auth.sendPasswordResetEmail(email: email.text);
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
    print(orders);
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
  Future<void> reloadOrderModel() async {
    orders = await _orderServices.getUserOrders(userId:user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}");
    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authentiated;
      _userModel = await _userServices.getUserById(firebaseUser.uid);
    }
    notifyListeners();
  }

  // general metohds
  bool onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("we got an error");
    return false;
  }

  void clearControllers() {
    email.text = "";
    name.text = "";
    password.text = "";
  }

  Future<bool> addToCard(name, price, image, id, quantity,stock) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      //List cart = _userModel.cart;
      bool itemExists = false;
      print(name);
      Map cartItem = {
        "id": cartItemId,
        "name": name,
        "image": image,
        "productId": id,
        "price": price,
        "quantity": quantity,
        "stock":stock,
      };
      print("price");
      if (!itemExists) {
        _userServices.addToCart(userId: _user.uid, cartItem: cartItem);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> updateToCard(List cartItem) async {
    try {
      bool itemExists = true;
      if(itemExists) {
        _userServices.updateToCart(userId: _user.uid, cartItem: cartItem);
      }return true;
    } catch (e) {
      return false;
    }
  }

  //updating status of cancel order
  Future<bool> updateToCardorder(String orderId) async {
    try {
      bool itemExists = true;
      if(itemExists) {
        _userServices.updateToCartorder(orderId: orderId);
      }return true;
    } catch (e) {
      return false;
    }
  }

  //updating the stock of each products
  Future<bool> updateToProductsStock(String productId,String stock) async {
    try {
      bool itemExists = true;
      if(itemExists) {
        _userServices.updateToProductStock(productId: productId,stock: stock);
      }return true;
    } catch (e) {
      return false;
    }
  }

}
