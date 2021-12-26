import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/login.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../wrapper.dart';
import 'custom_text.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProviders = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body:authProviders.status == Status.Authenticating? Loading() : SingleChildScrollView(
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
                    controller:authProviders.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "User Name",
                        icon:Icon(Icons.person)
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
                    controller: authProviders.email,
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
                    controller: authProviders.password,
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
                  if(!await authProviders.signUp()){
                    _key.currentState.showSnackBar(
                        SnackBar(content:Text("Registration failed"))
                    );
                    return;
                  }
                  authProviders.clearControllers();
                  changeScreenReplacement(context,RegistrationScreen());
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
                        CustomText(text:"Registers",color: Colors.white,size: 19,)
                      ],
                    ),),

                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                changeScreen(context,LoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text:"Login here",size: 19,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
