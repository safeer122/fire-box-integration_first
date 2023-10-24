import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/home.dart';
import 'package:firebase_base/Ui/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class getotp extends StatefulWidget {
  final String verificationId;
  const getotp({super.key, required this.verificationId});

  @override
  State<getotp> createState() => _getotpState();
}
TextEditingController verificationcode =TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
class _getotpState extends State<getotp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xffFFFFFF),
      body:  Padding(
        padding: EdgeInsets.only(left: 30.w,top: 200.h),
        child: Column(
          children: [
            Container(
              width: 300.w,
              height: 50.h,
              decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(30.r)),
              child: TextFormField(controller:verificationcode,decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,

              ),),
            ),
            SizedBox(height: 30.h,),
            GestureDetector(
              onTap: () async {
                final credentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationcode.text);
                try{
                  await auth.signInWithCredential(credentials);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>home()));
                }catch(e){
                  ToastMessage().toastmessage(message: e.toString());
                }
              },
              child: Container(
                width: 200.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30.sp)),
                child: Text("Verify",style: TextStyle(
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
