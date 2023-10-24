import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/home.dart';
import 'package:firebase_base/Ui/screen2.dart';
import 'package:firebase_base/Ui/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w,top: 200.h),
          child: Column(
            children: [
              Container(
                width: 300.w,
                height: 50.h,
                decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(30.r)),
                child: TextFormField(controller: email,decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "  Enter your email",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: Color(0xff000000),
                  )
                ),),
              ),
              SizedBox(height: 40.h,),
              Container(
                width: 300.w,
                height: 50.h,
                decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(30.r)),
                child: TextFormField(controller: password,decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "  password",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      color: Color(0xff000000),
                    )
                ),),
              ),
              SizedBox(height: 100.h,),
              GestureDetector(
                onTap: (){
                  auth.signInWithEmailAndPassword(
                      email: email.text, password: password.text)
                      .then((value) => {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>home()))
                  })
                      .onError((error, stackTrace) => ToastMessage()
                      .toastmessage(message: error.toString()));
                },
                child: Container(
                  width: 200.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30.sp)),
                  child: Text("Log in",style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFFFFFF),
                  ),),
                ),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.only(left: 80.w),
                child: Row(
                  children: [
                    Text("Already have an account?",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Color(0xff000000),
                    ),),
                    GestureDetector(onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) =>Screen2()));
                    },
                      child: Text("Sign Up",style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue
                      ),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
