import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/firestore/firestore_list_screen.dart';
import 'package:flutter/material.dart';



import 'dart:ffi';

import 'package:firebase_base/Ui/toast_message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class adddata extends StatefulWidget {
  const adddata({super.key});

  @override
  State<adddata> createState() => _adddataState();
}

class _adddataState extends State<adddata> {
  final postController=TextEditingController();
  bool loading =false;
  late final firestore=FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("add fireStore Data"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 30.h,),
                TextFormField(
                  maxLines: 4,
                  controller: postController,
                  decoration: InputDecoration(
                      hintText: "Add whats in your mind",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 30.h,),

                   GestureDetector(
                     onTap: (){
                       String id = DateTime.now().millisecondsSinceEpoch.toString();
                       firestore.doc(id).set({
                                 'title':postController.text.toString(),
                         'id':id
                       }).then((value) {
                         ToastMessage().toastmessage(message: ('added'));
                       }).onError((error, stackTrace) {
                        ToastMessage()
                            .toastmessage(message: error.toString());
                       });
                     },
                     child: Container(
                      width: 200.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30.sp)),
                      child: Text("Add",style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFFFFFF),
                      ),),
                  ),
                   ),



              ],
            ),Visibility(visible: loading,child: CircularProgressIndicator()),

          ],
        ),
      ),
    );
  }

}

