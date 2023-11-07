import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/firestore/add_data.dart';
import 'package:firebase_base/Ui/upload_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../add_post.dart';
import '../toast_message.dart';

class firestorescreen extends StatefulWidget {
  const firestorescreen({super.key});

  @override
  State<firestorescreen> createState() => _firestorescreenState();
}

class _firestorescreenState extends State<firestorescreen> {
  final auth = FirebaseAuth.instance;
  late final firestore=FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('user');
  final editcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('fire Store'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          StreamBuilder<QuerySnapshot>(stream: firestore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
              return CircularProgressIndicator();
              if(snapshot.hasError)
                return Text('some eror');

            
            return  Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {

                    return ListTile(
                    onTap: (){
                    ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                      'title':'safeer'
                    }).then((value) {
                       ToastMessage().toastmessage(message: ('updated').toString());
                    }).onError((error, stackTrace) {
                      ToastMessage().toastmessage(message:error.toString());
                    });
                    ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                    },
                      title: Text( snapshot.data!.docs[index]['title'].toString()),
                      subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                    );
                  }),
            );
              }),
          TextButton(onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_)=>UploadImageScreen()));
          }, child: Text('Upload image'))

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => adddata()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showmydialoge(String title, String id) async {
    editcontroller.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('update'),
            content: Container(
              child: TextField(
                controller: editcontroller,
                decoration: InputDecoration(hintText: 'edit here'),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                    child: Text('cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: Text('update'))
            ],
          );
        });
  }
}
