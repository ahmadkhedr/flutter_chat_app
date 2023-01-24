// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/DataLayer/Models/MessageModel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var db = FirebaseFirestore.instance;
  List<MessageModel> messagesList = [];
  TextEditingController messageController = TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Chat').orderBy('date').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        floatingActionButton: textField(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Chat Screen"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          reverse:true,
            child: Padding(
          padding: EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom ),
          child: messageWidget(),
        )),
      ),
    );
  }

  Widget messageWidget() {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          } else {
            messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              var data = snapshot.data!.docs[i].data()! as Map<String, dynamic>;

              MessageModel model = MessageModel(
                  message: data['message'], sender: data['sender']);
              messagesList.add(model);
            }

            return Padding(
              padding: EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 100),
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: messagesList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return listViewItem(messagesList[index]);
                  },
                ),
              ),
            );
          }
        });
  }

  Widget textField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          messageTextFiled(context),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: InkWell(
              onTap: (() {
                db.collection("Chat").add({
                  "sender": FirebaseAuth.instance.currentUser?.email,
                  "message": messageController.text,
                  "date": DateTime.now()
                }).then((documentSnapshot) =>
                    print("Added Data with ID: ${documentSnapshot.id}"));
                messageController.clear();
              }),
              child: Icon(
                Icons.send,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget messageTextFiled(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .80,
      child: TextField(
          controller: messageController,
          obscureText: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isDense: true,

            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(width: 0.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),

            hintText: 'Message',
            // label: Text("Your Password"),
          )),
    );
  }

  Widget listViewItem(MessageModel model) {
    return Directionality(
      textDirection: model.sender == FirebaseAuth.instance.currentUser?.email
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: model.sender ==
                              FirebaseAuth.instance.currentUser?.email
                          ? Colors.blue
                          : Colors.red),
                  child: Text(model.message!)),
            ],
          ),
        ),
      ),
    );
  }
}
