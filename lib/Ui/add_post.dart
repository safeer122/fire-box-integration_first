import 'dart:ffi';

import 'package:firebase_base/Ui/toast_message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class addpost extends StatefulWidget {
  const addpost({super.key});

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {
  final postController=TextEditingController();
  bool loading =false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("add Post"),
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
                GestureDetector(onTap: (){
                  setState(() {
                    loading=true;

                  });
                  String id =DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef.child(id).set( {
                    'title':postController.text.toString(),
                    'id':id,
                  }).then((value) {
                  ToastMessage().toastmessage(message: 'post added');
                  setState(() {
                    loading=false;

                  });
                  }).onError((error, stackTrace){
                    ToastMessage()
                        .toastmessage(message: error.toString());
                    setState(() {
                      loading=false;
                    });
                },);},
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
