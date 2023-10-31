import 'package:firebase_base/Ui/add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('Home')),
       automaticallyImplyLeading: false,
        
      ),
      body:Padding(
        padding:EdgeInsets.only(left: 250.w,top: 500.h),
        child: FloatingActionButton(onPressed: (){
           Navigator.push(context,MaterialPageRoute(builder:(_)=>addpost() ));
        },
        child: Icon(Icons.add),),
      ),
    );
  }
}
