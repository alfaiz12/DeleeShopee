import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/login1.dart';
import 'package:ebasket/screen/registration1.dart';
import 'package:ebasket/widget/loading.dart';
import 'package:ebasket/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class reset extends StatefulWidget {
  @override
  _resetState createState() => _resetState();
}

class _resetState extends State<reset> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _key,
      body:authProvider.status == Status.Authenticating? Loading() : Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logods.png',),
                            fit: BoxFit.cover
                        ),
                        color: Colors.green
                    )
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reset Password!", style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'sfpro'
                  ),),
                  Text("Please enter your Mail-id to reset your password", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: authProvider.email,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                  ),

                  SizedBox(height: 30,),
                  InkWell(
                    onTap: ()async{
                       authProvider.sendPasswordreset();
                      _key.currentState.showSnackBar(SnackBar(content:Text("Reset Link has been sent to your email id")));
                      authProvider.clearControllers();
                      changeScreenReplacement(context,loginPage());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.green
                      ),
                      child: Center(
                        child: Text("Reset", style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'sfpro'
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
  void openSignUpPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>signUpPage()));
  }
  void openHomePage()
  {
    /*Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));*/
  }
}