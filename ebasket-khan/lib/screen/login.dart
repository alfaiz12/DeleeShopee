import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/registration.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebasket/helpers/screen_navigation.dart';
import 'custom_text.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body:authProvider.status == Status.Authenticating? Loading() : SingleChildScrollView(
        child: Column(

          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/apple.jpg",width: 250,height: 250,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding:EdgeInsets.only(left:10),
                child: TextFormField(
                  controller: authProvider.email,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      icon:Icon(Icons.email)
                  ),
                ),),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding:EdgeInsets.only(left:10),
                  child: TextFormField(
                    controller: authProvider.password,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Passord",
                        icon:Icon(Icons.lock)
                    ),
                  ),),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: GestureDetector(
                onTap: ()async{
                  if(!await authProvider.signIn()){
                   _key.currentState.showSnackBar(
                       SnackBar(content:Text("Please enter correct emailid or password "))
                   );
                   return;
                  }
                  authProvider.clearControllers();
                  changeScreenReplacement(context,Wrapper());
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(padding:EdgeInsets.only(top:10,bottom: 10,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text:"Login",color: Colors.white,size: 19,)
                      ],
                    ),),

                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                changeScreen(context, RegistrationScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text:"Register here",size: 19,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
