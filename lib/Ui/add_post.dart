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
      ),
      body: Padding(
        padding:EdgeInsets.only(left: 20.w),
        child: Column(
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
              databaseRef.child(DateTime.now().month.toString()).child('comments').set( {
                'title':postController.text.toString(),
                'id':DateTime.now().day.toString(),
              }).then((value) {
              ToastMessage().toastmessage(message: 'post added');
              setState(() {

              });
              }).onError((error, stackTrace){
                ToastMessage()
                    .toastmessage(message: error.toString());
                setState(() {

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
        ),

      ),
    );
  }
}
