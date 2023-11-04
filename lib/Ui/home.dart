import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/Ui/add_post.dart';
import 'package:firebase_base/Ui/toast_message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('Post');
  final searchfilter = TextEditingController();
  final editcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Home'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchfilter,
              decoration: InputDecoration(
                  hintText: ('search'), border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('loading'),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if (searchfilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context)=>[
                          PopupMenuItem(
                            value: 1,
                            onTap: (){

                              showmydialoge(title,snapshot.child('id').value.toString());
                            },
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('edit'),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                              },
                              // onTap: (){
                              //   Navigator.pop(context);
                              //   ref.child(snapshot.child('id').value.toString()).remove();
                              // },
                              leading: Icon(Icons.delete),
                              title: Text('delete'),
                            ),
                          )
                        ],
                      ),

                    );

                  } else if (title
                      .toLowerCase()
                      .toLowerCase()
                      .contains(searchfilter.text.toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => addpost()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> showmydialoge(String title,String id)async{
    editcontroller.text=title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('update'),
            content: Container(
              child: TextField(
                controller: editcontroller,
                decoration: InputDecoration(
                  hintText: 'edit here'
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'title':editcontroller.text.toLowerCase()
                }).then((value) {
                  ToastMessage()
                      .toastmessage(message:('post updated'));
                }).onError((error, stackTrace){
                  ToastMessage()
                      .toastmessage(message: error.toString());
                });
              }, child: Text('update'))
            ],
          );
        }
    );

  }
}
// Expanded(
//     child:
//
//     StreamBuilder(
//       stream:ref.onValue,
//       builder: (context,snapshot){
//
//         if(!snapshot.hasData){
//           return CircularProgressIndicator();
//         }else {
//           Map<dynamic, dynamic> map = snapshot.data!.snapshot
//               .value as dynamic;
//           List<dynamic>list = [];
//           list.clear();
//           list = map.values.toList();
//
//
//           return ListView.builder(
//               itemCount: snapshot.data!.snapshot.children.length,
//               itemBuilder: (context, index) {
//               return  ListTile(
//                   title: Text(list[index]['title']),
//                 subtitle: Text(list[index]['id']),
//                 );
//               });
//         }
//     },
//
//     )),
