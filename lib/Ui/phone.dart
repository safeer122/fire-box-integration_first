import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/get%20otp.dart';
import 'package:firebase_base/Ui/phone.dart';
import 'package:firebase_base/Ui/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class phone extends StatefulWidget {
  const phone({super.key});

  @override
  State<phone> createState() => _phoneState();
}
TextEditingController phone1 = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _phoneState extends State<phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
      body: Padding(
        padding: EdgeInsets.only(left: 35.w,top: 200.h),
        child: Column(
          children: [
            Container(
              width: 300.w,
              height: 50.h,
              decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(30.r)),
              child: TextFormField(controller: phone1,decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "  Phone no",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: Color(0xff000000),
                  )
              ),),
            ),
            SizedBox(height: 30.h,),
            GestureDetector(
              onTap: (){
                auth.verifyPhoneNumber(phoneNumber: phone1.text,verificationCompleted: (_){},
                    verificationFailed: (e){
                      ToastMessage().toastmessage(message: e.toString());
                    },
                    codeSent: (String verificationId,int? token){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>getotp(verificationId: verificationId,)));

                    },
                    codeAutoRetrievalTimeout: (e){
                      ToastMessage().toastmessage(message: e.toString());
                    });
              },
              child: Container(
                width: 200.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30.sp)),
                child: Text("Get otp",style: TextStyle(
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
