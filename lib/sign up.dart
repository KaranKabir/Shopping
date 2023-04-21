import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Login.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  final _auth=FirebaseAuth.instance;
  final rgm=TextEditingController();
  final rpass=TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign Up Now',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please fill the details and create account',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(
                  height: 50,
                ),
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
                      controller: rgm,

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
                      controller: rpass,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Password must be atleast 6 character",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {

                    {  try {
                      _auth.createUserWithEmailAndPassword(
                          email: rgm.text, password: rpass.text)
                          .then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Login()));
                        Fluttertoast.showToast(msg: "Successfully Register");
                      }).onError((FirebaseAuthException e, stackTrace) {
                        Fluttertoast.showToast(msg: e.message.toString());
                      });
                    } on FirebaseAuthException catch (e) {
                      print(e);
                    }

                    }

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
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(Login());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        'Log in',
                        style: TextStyle(fontSize: 15, color: Colors.pinkAccent),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
