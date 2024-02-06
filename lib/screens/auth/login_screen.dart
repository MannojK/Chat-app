import 'dart:developer';
import 'dart:io';

import 'package:chat_app/api/apis.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../helper/dialogs.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressbar(context, 'Do Nothing');
    _signInWithGoogle().then((user)async {
      // for hiding progress bar 
      Navigator.pop(context);
      if(user != null){
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        if(( await APIs.userExists())){
               Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        else{
          APIs.createUser().then((value) {
 Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        }
      }
    
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('googlecom');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Something went Wrong');
     return null;
    }
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // *** GOOGLE
              GestureDetector(
                onTap: () {
                  _handleGoogleBtnClick();
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 29),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/search.png',
                          cacheWidth: 10,
                          height: 10,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ' Google ',
                          style: GoogleFonts.openSans(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          //***  FACEBOOK  */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 29),
                  // padding values are vertical is 10, horizonal is 29
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/facebook.png',
                        cacheWidth: 10,
                        height: 10,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        ' facebook',
                        style: GoogleFonts.openSans(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
      },
      child: const Icon(Icons.abc_sharp),
      ),
    );
  }
}
