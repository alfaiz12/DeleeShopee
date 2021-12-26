import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'custom_text.dart';
class payment extends StatefulWidget {
  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  int totalamount = 0;
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
      'key':'rzp_test_OjMIawXolRgDGr',
      'amount':totalamount*100,
      'name':'Dartings',
      'description':'Test Payment',
      'prefill':{'contact':'','email':''},
      'external':{
      'wallets':['paytm']
      }
    };
    try{
      _razorpay.open(option);
    }catch(e){
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
   // Fluttertoast.showToast(msg:"SUCCESS"+ response.paymentId);
  }
  void _handlePaymentError(PaymentFailureResponse response){
   // Fluttertoast.showToast(msg:"ERROR"+ response.code.toString() + " - " + response.message);
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
  }
}
