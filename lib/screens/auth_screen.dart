import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_firebase/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String userEmail,
    String username,
    String userPassword,
    bool isLogin,
  ) async {
    // ignore: unused_local_variable
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: userEmail, password: userPassword);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'username': username, 'email': userEmail});
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred,please check your credentials';
      if (err.message != null) {
        if (err.code == 'INVALID_LOGIN_CREDENTIALS') {
          message = 'INVALID_LOGIN_CREDENTIALS.';
        } else {
          message = err.message!;
        }
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      // ignore: avoid_print
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(submitFn: _submitAuthForm, isLoading: _isLoading));
  }
}
