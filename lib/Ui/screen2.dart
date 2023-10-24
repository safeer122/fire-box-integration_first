import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/home.dart';
import 'package:firebase_base/Ui/phone.dart';
import 'package:firebase_base/Ui/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
class _Screen2State extends State<Screen2> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }
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
                child: TextFormField(controller:password ,decoration: InputDecoration(
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
                  SizedBox(height: 50.h,),
              GestureDetector(
                onTap: (){
                  print( email.text);
                  print(password.text);
                  auth
                      .createUserWithEmailAndPassword(
                      email: email.text, password: password.text)
                      .then((value) => {
                    ToastMessage().toastmessage(message: 'Successfully registerd'),
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>home()))
                  })
                      .onError((error, stackTrace) => ToastMessage()
                      .toastmessage(message: error.toString()));
                },
                child: Container(
                  width: 200.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30.sp)),
                  child: Text("Sign Up",style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFFFFFF),
                  ),),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 70.w,top: 30.h),
                child: Row(
                  children: [
                    GestureDetector(onTap:(){
              signInwithGoogle().then((value) => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_)=>home())));
              },
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Color(0xff000000),
                        child: CircleAvatar(
                          radius: 23.r,
                          backgroundColor: Color(0xffFFFFFF),
                          child: Image.asset("asset/google.jpeg",width: 40.w,height: 28.h,),
                        ),
                      ),
                    ),
                    SizedBox(width: 70.w,
                    ),
                    GestureDetector(onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_)=>phone()));
                    },
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Color(0xff000000),
                        child: CircleAvatar(
                          radius: 23.r,
                          backgroundColor: Color(0xffFFFFFF),
                          child: Icon(Icons.phone_android,color: Color(0xff000000),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
