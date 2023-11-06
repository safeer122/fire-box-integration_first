

import 'dart:io';

import 'package:firebase_base/Ui/toast_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  File? _image ;
  final picker = ImagePicker();
       firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
       DatabaseReference databaseRef=FirebaseDatabase.instance.ref('post');
  Future getImageGallery()async{
    final pickFile =await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    setState(() {
      if(pickFile !=null){
        _image =File(pickFile.path);
      }else{
        print(('no image picked'));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Upload Image'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Center(
             child: InkWell(
               onTap:(){
                 getImageGallery();
               },
               child: Container(
                 height: 200.h,
                 width: 200.w,
                 decoration: BoxDecoration(
                   border: Border.all(
                     color: Colors.black
                   )
                 ),
                 child:_image !=null ? Image.file(_image!.absolute):
                 Center(child: Icon(Icons.image)),
               ),
             ),
           ),
          SizedBox(height: 30.h,),
          GestureDetector(
            onTap: ()async{

              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/foldername/'+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadtask=ref.putFile(_image!.absolute);

              await Future.value(uploadtask).then((value)async {
                var newUrl =await ref.getDownloadURL();

                databaseRef.child('1').set({
                  'id':'1212',
                  'title':newUrl.toString()
                }).then((value) {
                  ToastMessage().toastmessage(message: ('uploded').toString());
                }).onError((error, stackTrace) {
                  ToastMessage().toastmessage(message: error.toString());
                });
              });


              },
            child: Container(
              width: 200.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30.sp)),
              child: Text("upload",style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xffFFFFFF),
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
