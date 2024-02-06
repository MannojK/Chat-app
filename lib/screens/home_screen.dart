
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
     List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: const Text('We Chat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add),
        ),
      ),
      body: StreamBuilder(
          stream: APIs.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              // data is loading 
              case ConnectionState.waiting:
              case ConnectionState.none:
              return const Center(child: CircularProgressIndicator(),);
              // if some ora ll data is loaded then show it 
              case ConnectionState.active:
              case ConnectionState.done:
              // case ConnectionState.waiting:
              final data = snapshot.data?.docs;
             list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
         if(list.isNotEmpty){
             return ListView.builder(
itemCount : list.length,
                itemBuilder: (context, index) {
                  return ChatUserCard(user:list[index]);
                });

         }
         else{
          return Text('No Connection Found',style: TextStyle(fontSize: 20),);
         }
            }
        
          }),
    );
  }
}
