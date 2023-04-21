import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:interviewapp/Sign%20up.dart';
import 'package:interviewapp/first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/common.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth=FirebaseAuth.instance;
  final gm=TextEditingController();
  final pass=TextEditingController();
  bool _isObscure = true;
  Future<void>logindata()async {
    final SharedPreferences sha =  await SharedPreferences.getInstance();
    sha.setString(userid, gm.text);

    try{
      _auth.signInWithEmailAndPassword(email: gm.text, password: pass.text).then((value){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>home()));
        Fluttertoast.showToast(msg: "Successfully Loged In");
      }).onError((FirebaseAuthException e, stackTrace){
        Fluttertoast.showToast(msg: e.message.toString());
      });
    }on FirebaseAuthException catch (e) {
      print(e);
    }
  }
  bool istrue = false;
  bool term = false;
  int group = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Log In Now',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please login to continue using our app',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(
                  height: 50,
                ),
                //EMAIL & TEXTFORMFIELD
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Text("Gmail",style: TextStyle( fontSize: 22,
                          color: Color(0xff000000)),)),
                ),
                SizedBox(height: 5,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,

                    child: TextFormField(
                      controller: gm,


                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color(0xff929090)
                              )
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color(0xff929090)
                              )
                          ),
                          prefixIcon:Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.email)
                          ),

                          hintText: "Enter Your Gmail",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color(0xff929090)
                              )
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),

                //PASSWORD
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Text("Password",style: TextStyle( fontSize: 22,
                          color: Color(0xff000000)))),
                ),
                SizedBox(height: 5,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: TextFormField(
                      controller: pass,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color(0xff929090)
                              )
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color(0xff929090)
                              )
                          ),
                          prefixIcon:Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.password)
                          ),
                          hintText: "Enter Your Password",
                          suffixIcon:Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              icon: Icon(
                                _isObscure ? Icons.visibility_off : Icons.visibility,
                                size: 28,
                                color: Color(0xff000000),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color(0xff929090)
                              )
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password ?',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100,),
                InkWell(
                  onTap: () {
                    logindata();
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.pinkAccent,
                    ),
                    child: Center(
                        child: Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.to(Sign_up());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 15, color: Colors.pinkAccent),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
