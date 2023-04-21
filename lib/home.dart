import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interviewapp/profile.dart';
import 'package:searchfield/searchfield.dart';
import 'dart:io';
import 'beauty2.dart';
import 'cart.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {



  TextEditingController pname=TextEditingController();
  TextEditingController pprice=TextEditingController();
  TextEditingController pqty=TextEditingController();
  TextEditingController pdesc=TextEditingController();
  bool added=false;

  File? image1,image2;
  String? downloadedimg1,downloadedimg2;

  List seacrhprodprice=[];
  List seacrhprodname=[];
  List seacrhprodqty=[];
  List seacrhprodimg=[];
  List seacrhproddesc=[];

  get_searchList() async {

    seacrhprodprice.clear();
    seacrhprodname.clear();
    seacrhprodqty.clear();
    seacrhprodimg.clear();
    seacrhproddesc.clear();

    QuerySnapshot _search_qeurysnapshot = await FirebaseFirestore.instance.collection("Products").get();
    _search_qeurysnapshot.docs!.forEach((e) {
      setState(() {
        seacrhprodname.add(e.get("ProdName"));
        seacrhprodprice.add(e.get("ProdPrice"));
        seacrhprodqty.add(e.get("ProdQty"));
        seacrhprodimg.add(e.get("ProdImage1"));
        seacrhproddesc.add(e.get("ProdDesc"));
      });
    });
    // books= search_loc_List as List;
    print(seacrhprodname);
    print(seacrhprodname.length);

  }

  @override
  void initState() {
    get_searchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;
    return  WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading:Padding(
            padding:  EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>profile()));
              },
              child: Container(
                height: 80,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Icon(Icons.person,color: Colors.black,),
              ),
            ),
          ) ,
          title: Center(
            child: Text("Shopping",
              style: TextStyle(color: Colors.black,fontSize: 22),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child:   InkWell(
                  onTap: () async {
                    int count = await FirebaseFirestore.instance.collection("Cart").doc(FirebaseAuth.instance.currentUser!.email.toString()).collection(FirebaseAuth.instance.currentUser!.email.toString())
                        .get()
                        .then((value) => value.size);
                    print(count);
                    if(count<=0){
                      Fluttertoast.showToast(msg: "Add products to see the Cart");
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      width: w*0.2,
                      child:  Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(Icons.shopping_cart,color: Colors.black,size: 30),
                      )
                  ),
                )
            )
          ],
        ),

        body: Container(
          height: h,
          width: w,
          child: Column(
            children: [
              SizedBox(height: 30,),
              Center(
                child: Container(
                  width:w*0.9,
                  child:SearchField(
                    searchInputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(Icons.search,color: Colors.black,),
                      hintText: "Search for a Service....",
                    ),
                    suggestionsDecoration: BoxDecoration(
                        border:Border.all(color: Colors.black),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8))
                    ),
                    onSubmit: (x) {},

                    validator: (x) {
                      if (!seacrhprodname.contains(x) || x!.isEmpty) {
                        return 'Please Enter a valid State';
                      }
                      return null;
                    },
                    onSuggestionTap: (ivalue) {
                      print(ivalue.searchKey.toString());
                      print(seacrhprodname.indexOf(ivalue.searchKey.toString()));
                      Get.to(Mybeauty2(rimg:seacrhprodimg[seacrhprodname.indexOf(ivalue.searchKey.toString())],rname:ivalue.searchKey.toString() ,rprice: int.parse(seacrhprodprice[seacrhprodname.indexOf(ivalue.searchKey.toString())]),rqty: int.parse(seacrhprodqty[seacrhprodname.indexOf(ivalue.searchKey.toString())]),));
                    },
                    suggestions: seacrhprodname.map((e) => SearchFieldListItem(e.toString(), item: e,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 8.0),
                        child: Text(e.toString()),
                      ),
                    ),
                    ).toList(),
                  ),
                ),
              ),
              //search
              SizedBox(height: 30,),
              Expanded(
                child: Container(
                  width: w*0.9,
                  // color: Colors.black,
                  child:StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Products").snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      else if(snapshot.data!.docs.isEmpty){
                        return Text("No Products Found");
                      }
                      else{
                        return  GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(snapshot.data!.docs.length, (index)  {
                            return InkWell(
                              onTap: () {
                                Get.to(Mybeauty2(rname: snapshot.data!.docs[index].get("ProdName"), rprice: int.parse(snapshot.data!.docs[index].get("ProdPrice")), rimg:snapshot.data!.docs[index].get("ProdImage1"), rqty: int.parse(snapshot.data!.docs[index].get("ProdQty"))));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot.data!.docs[index].get("ProdImage1")),fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:  MediaQuery.of(context).size.width*0.4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.docs[index].get("ProdName"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                          SizedBox(height: 5,),
                                          Container(
                                              width: w*0.4,
                                              child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Text(snapshot.data!.docs[index].get("ProdDesc"),style: TextStyle(fontSize: 11),))),
                                          SizedBox(height: 5,),
                                          Text("₹${snapshot.data!.docs[index].get("ProdPrice")}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                          Text("Available Qty: ${snapshot.data!.docs[index].get("ProdQty")}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      }

                    },
                  ) ,
                ),
              )
            ],
          ),

        ),
        floatingActionButton: GestureDetector(
          onTap: (){
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    Future<void> uploadimg1() async {
                      XFile? pick = await ImagePicker().pickImage(source: ImageSource.gallery,);
                      setState(() {
                        image1 = File(pick!.path);
                        print("profile_image ${image1}");
                      });

                    }
                    Future<void> uploadimg2() async {
                      XFile? pick = await ImagePicker().pickImage(source: ImageSource.gallery,);
                      setState(() {
                        image2 = File(pick!.path);
                        print("profile_image ${image2}");
                      });
                    }

                    return Scaffold(
                      body: SingleChildScrollView(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: w*0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:h*0.01 ,),
                              Center(child: Text("PRODUCT DETAILS",style: TextStyle(fontSize: 19,color: Colors.black),)),

                              SizedBox(height:h*0.03 ,),
                              TextFormField(
                                controller: pname,
                                decoration: InputDecoration(
                                  hintText: "Enter Product Name",
                                  contentPadding: EdgeInsets.only(left: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),

                                ),
                              ),

                              SizedBox(height:h*0.01 ,),
                              TextFormField(
                                controller: pqty,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "Enter Product Qty",
                                  contentPadding: EdgeInsets.only(left: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),

                                ),
                              ),

                              SizedBox(height:h*0.01 ,),
                              TextFormField(
                                controller: pprice,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "Enter Product Price",
                                  contentPadding: EdgeInsets.only(left: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),

                                ),
                              ),

                              SizedBox(height:h*0.01 ,),
                              TextFormField(
                                controller: pdesc,
                                decoration: InputDecoration(
                                  hintText: "Enter Product Description",
                                  contentPadding: EdgeInsets.only(left: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black)
                                  ),

                                ),
                              ),
                              SizedBox(height:h*0.03 ,),
                              Text("Select Image:",style: TextStyle(color: Colors.black,fontSize: 18),),
                              SizedBox(height:h*0.01 ,),
                              Row(
                                children: [

                                  GestureDetector(
                                    onTap: (){
                                      uploadimg1();
                                    },
                                    child:image1==""||image1==null?
                                    Container(
                                      height: h*0.15,
                                      width: w*0.3,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                    ):Container(
                                      height: h*0.15,
                                      width: w*0.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(image1!),fit: BoxFit.cover
                                          ),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  GestureDetector(
                                    onTap: (){
                                      uploadimg2();
                                    },
                                    child:image2==""||image2==null?
                                    Container(
                                      height: h*0.15,
                                      width: w*0.3,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                    ):Container(
                                      height: h*0.15,
                                      width: w*0.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(image2!),fit: BoxFit.cover
                                          ),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: h*0.05,),
                              Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    if(pname.text==null||pprice.text==null|| pqty.text==null|| pdesc.text==null||image1==null||image2==null){
                                      Fluttertoast.showToast(msg: "PLease fill all details");
                                    }
                                    else {
                                      setState(() {
                                        added = true;
                                      });

                                      final _firebaseStorage = FirebaseStorage
                                          .instance;

                                      var snapshot = await _firebaseStorage
                                          .ref().child('Products/${pname.text
                                          .toString()}/img1').putFile(image1!);
                                      downloadedimg1 =
                                      await snapshot.ref.getDownloadURL();


                                      var snapshot1 = await _firebaseStorage
                                          .ref().child('Products/${pname.text
                                          .toString()}/img2').putFile(image2!);
                                      downloadedimg2 =
                                      await snapshot1.ref.getDownloadURL();

                                      print(downloadedimg1);
                                      print(downloadedimg2);
                                      final _fstore = FirebaseFirestore
                                          .instance;
                                      _fstore.collection("Products").doc(
                                          pname.text).set({
                                        "ProdName": pname.text,
                                        "ProdImage1": downloadedimg1,
                                        "ProdImage2": downloadedimg2,
                                        "ProdPrice": pprice.text,
                                        "ProdQty": pqty.text,
                                        "ProdDesc": pdesc.text
                                      }).then((value) async {
                                        setState(() {
                                          pname.clear();
                                          pprice.clear();
                                          pqty.clear();
                                          pdesc.clear();

                                          seacrhprodprice.clear();
                                          seacrhprodname.clear();
                                          seacrhprodqty.clear();
                                          seacrhprodimg.clear();
                                          seacrhproddesc.clear();
                                        });
                                        QuerySnapshot _search_qeurysnapshot = await FirebaseFirestore
                                            .instance.collection("Products")
                                            .get();
                                        _search_qeurysnapshot.docs!.forEach((
                                            e) {
                                          setState(() {
                                            seacrhprodname.add(e.get(
                                                "ProdName"));
                                            seacrhprodprice.add(e.get(
                                                "ProdPrice"));
                                            seacrhprodqty.add(e.get("ProdQty"));
                                            seacrhprodimg.add(e.get(
                                                "ProdImage1"));
                                            seacrhproddesc.add(e.get(
                                                "ProdDesc"));
                                          });
                                        });
                                        setState(() {
                                          added = false;
                                        });
                                        Get.back();
                                      });
                                    }

                                  },
                                  child: Container(
                                    width: w*0.5,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black
                                    ),
                                    child: added==true?CircularProgressIndicator(color: Colors.white,):Text("Add Product",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color:Colors.black ),
                shape: BoxShape.circle,
                color: Colors.white
            ),
            child: Icon(Icons.add,color: Colors.black,size: 28,),
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 15),
      ),
    );
  }
}
