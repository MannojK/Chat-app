import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimate = false;
  
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 1700),  (){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      if(FirebaseAuth.instance.currentUser != null){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));

      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

      }
    });
  }
  @override

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: const Text('We Chat'),
      ),
      body: Column(
        
        children: [
           Container(
         height: 50,
         width: 50,
         child: Image.asset('assets/live-chat.png'),
        ),

        Center(child: Text("MADE IN INDIA WITH ❤️",style: TextStyle(fontSize: 30),)),
         
        ],
      ),
    );
  }
}
