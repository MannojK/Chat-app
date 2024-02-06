import 'package:chat_app/api/apis.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key,required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // margin: EdgeInsets.symmetric(horizontal: mq.width * 04),
      child: InkWell(
      onTap: (){},
      child: ListTile(
        title: Text(widget.user.name,style: TextStyle(color: Colors.black),),
        subtitle: Text('Last User message', maxLines: 1,),
        leading: CircleAvatar(child: Icon(Icons.person_4),),
        trailing: Text(
          '12:00 pm',
        ),
      )),);
  }
}