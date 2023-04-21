import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'common/common.dart';
import 'cart.dart';

class Mybeauty2 extends StatefulWidget {
  String? rname, rimg;
  int? rprice, rqty;
  Mybeauty2(
      {required this.rname,
      required this.rprice,
      required this.rimg,
      required this.rqty});

  @override
  State<Mybeauty2> createState() =>
      _Mybeauty2State(rname: rname, rimg: rimg, rprice: rprice);
}

class _Mybeauty2State extends State<Mybeauty2> {
  String? rname, rimg;
  int? rprice;
  _Mybeauty2State(
      {required this.rname, required this.rprice, required this.rimg});
  int qty = 1;
  bool isadded = false;
  int? getqtytxt;
  getqty() async {
    final g = FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .collection(FirebaseAuth.instance.currentUser!.email.toString())
        .doc(widget.rname.toString())
        .get();
    final DocumentReference document = FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .collection(FirebaseAuth.instance.currentUser!.email.toString())
        .doc(widget.rname.toString());

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        qty = snapshot.get("ProdQty");
      });
    });
  }

  @override
  void initState() {
    getqty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Center(
            child: BackButton(
          color: Colors.black,
        )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Details",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          //image
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Swiper(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image.network(rimg.toString());
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image 1
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/2.jpg',),fit: BoxFit.fill)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),

                      //image 2
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/4.jpg'),fit: BoxFit.fill)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),

                      //image 3
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/5.jpg'))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular(48)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rname.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                                height: 35,
                                width: 85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.black)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            qty == 1 ? qty = 1 : qty = qty - 1;
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                          size: 18,
                                        )),
                                    Text(
                                      qty.toString(),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (qty >=
                                                int.parse(
                                                    widget.rqty.toString())) {
                                              Fluttertoast.showToast(
                                                  msg: "Item not available");
                                            } else {
                                              setState(() {
                                                qty = qty + 1;
                                              });
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: 18,
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs. ${rprice! * qty}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isadded = true;
                                });
                                FirebaseFirestore.instance
                                    .collection("Cart")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email
                                        .toString())
                                    .collection(FirebaseAuth
                                        .instance.currentUser!.email
                                        .toString())
                                    .doc(widget.rname)
                                    .set({
                                  "ProdName": widget.rname,
                                  "ProdImage1": widget.rimg,
                                  "ProdPrice": rprice! * qty,
                                  "ProdQty": qty,
                                  "ProdDesc": "Ssss"
                                }).then((value) {
                                  setState(() {
                                    isadded = false;
                                  });
                                  Get.to(cart());
                                });

                                // otprod: cmctlstname.length.toString(),cname: rname.toString(),
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: isadded == true
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              "Add toCart",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        //Container
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 15),
    );
  }
}
