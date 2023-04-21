import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'common/common.dart';
import 'home.dart';

class cart extends StatefulWidget {
  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    // var sum = cmctlstprice.reduce((value, current) => value + current);
    // var tot=sum+99;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Cart")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection(FirebaseAuth.instance.currentUser!.email.toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No Data Found"));
              } else {
                var ds = snapshot.data!.docs;
                int sum = 0;
                for (int i = 0; i < ds.length; i++) {
                  sum += int.parse(ds[i]['ProdPrice'].toString());
                }

                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black12)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //image
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]
                                              .get("ProdImage1"))),
                                      borderRadius: BorderRadius.circular(20)),
                                ),

                                //Text
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Row(
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get("ProdName"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Spacer(),
                                          InkWell(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection("Cart")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.email
                                                        .toString())
                                                    .collection(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .email
                                                        .toString())
                                                    .doc(snapshot
                                                        .data!.docs[index].id)
                                                    .delete();
                                              },
                                              child: Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Size: 7.60 fl oz / 225ml",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get("ProdPrice")
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Qty: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get("ProdQty")
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    ),

                    //Subtotal
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Center(
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Spacer(),
                                Text(sum.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "IND",
                                  style: TextStyle(
                                      color: Colors.black26, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width * 0.85,
                        color: Colors.white,
                      ),
                    ),

                    //Shipping
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Shipping",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Spacer(),
                                Text("Rs. 99",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "IND",
                                  style: TextStyle(
                                      color: Colors.black26, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width * 0.85,
                        color: Colors.white,
                      ),
                    ),

                    //Bag Total
                    Center(
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Text(
                                "Bag Total",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text("${sum + 99}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "IND",
                                style: TextStyle(
                                    color: Colors.black26, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //Proceed To Checkout
                    Center(
                       child: GestureDetector(
                         onTap: () async {
                           snapshot.data!.docs.forEach((element) async {
                             await FirebaseFirestore.instance
                                 .collection("Cart")
                                 .doc(FirebaseAuth.instance.currentUser!.email
                                     .toString())
                                 .collection(FirebaseAuth
                                     .instance.currentUser!.email
                                     .toString())
                                 .doc(element.id)
                                 .delete();
                           });
                           Fluttertoast.showToast(msg: "Successfully Ordered");
                           Get.to(home());
                         },
                         child: Container(
                           height: 55,
                           width: 330,
                           child: Center(
                               child: Text(
                             "Pay By Cash",
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold),
                           )),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               color: Colors.black),
                         ),
                       ),
                     )
                  ],
                );
              }
            },
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 15),
    );
  }
}
