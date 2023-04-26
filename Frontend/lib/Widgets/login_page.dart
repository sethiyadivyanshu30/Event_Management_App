import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hide = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void toggle(){
    if(hide == false) {
      hide = true;
    } else {
      hide = false;
    }
  }

  Future login() async {
    var response = await http.post(
      // Uri.parse('http://192.168.1.95:4500/login'),
      Uri.parse('http://10.100.163.226:4500/login'),
      headers: {'Content-Type': 'application/json', 'Methods': 'POST'},
      body: jsonEncode( {
        'user_email': emailController.text,
        'user_password': passwordController.text,
      },
      ),
    );

    if (response.statusCode == 400) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: 'Login Unsuccessful'.text.bold.make(),
            content: "Invalid username or password".text.make(),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                // child: Container(
                //   color: Colors.white,
                //   padding: const EdgeInsets.all(14),
                //   child: "Okay".text.xl.make(),
                // ),
                  child: "Okay".text.make()
              ),
            ],
          )
      );
    }
    else if(response.statusCode == 200){
      Navigator.pop(context);
      await Navigator.pushNamed(context, '/home', arguments: {'user_email': emailController.text});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("Assets/images/login_image.png",
                      fit: BoxFit.cover,
                    ),
                    "Hello!!".text.xl4.bold.make().py(16),
                    "Welcome Back, You have been missed".text.xl.make().py(16),

                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(width: 1, color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: TextFormField(
                    //     controller: nameController,
                    //     decoration: const InputDecoration(
                    //         border: InputBorder.none,
                    //         hintText: 'Full Name',
                    //         prefixIcon: Icon(CupertinoIcons.person)
                    //     ),
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Please enter your name.';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    //
                    // const SizedBox(height: 20.0),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username',
                            prefixIcon: Icon(CupertinoIcons.person_crop_circle)
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username.';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !hide,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon: const Icon(CupertinoIcons.lock_circle),
                          suffixIcon: IconButton(
                            onPressed: (){toggle(); setState(() {});},
                            icon: hide ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                          ),
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password.';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 30.0),

                    ElevatedButton(
                      onPressed: () {
                        // final _MyAppState state =
                        // context.findAncestorStateOfType<_MyAppState>()!;
                        // state._setLoginStatus(true);
                        login();
                      },
                      child: "Login".text.xl.bold.make(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
