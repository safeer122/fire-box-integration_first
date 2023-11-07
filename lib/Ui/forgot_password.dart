import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  final email=TextEditingController();
  final auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title:Text('forgot password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             TextFormField(
               controller: email,
               decoration: InputDecoration(
                 hintText: 'email'
               ),
             ),
            SizedBox(height: 20.h,
            ),
            GestureDetector(
              onTap: (){
                auth.sendPasswordResetEmail(email: email.text.toString()).then((value) {
                     ToastMessage().toastmessage(message: ('we have sent you to recover password,please check email'));
                }).onError((error, stackTrace){
                  ToastMessage().toastmessage(message: error.toString());
                });
              },
              child: Container(
                width: 150.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30.sp)),
                child: Text("Forgot",style: TextStyle(
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
