import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final sidController = TextEditingController();
  final fnameController = TextEditingController();

  Future register() async {
    var response = await http.post(
      Uri.parse('http://192.168.1.95:4500/insert'),
      // Uri.parse('http://10.100.163.226:4500/'),
      headers: {'Content-Type': 'application/json', 'Methods': 'POST'},
      body: jsonEncode( {
        'sid': sidController.text,
        'fname': fnameController.text,
      },
      ),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      AlertDialog(
        title: "Registered".text.make(),
        content: "New user has been registered".text.make(),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: "okay".text.make()
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Register".text.make(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: sidController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'sid',
                          prefixIcon: Icon(CupertinoIcons.person)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter sid.';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 20.0),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: fnameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full Name',
                          prefixIcon: Icon(CupertinoIcons.person)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name.';
                        }
                        return null;
                      },
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: "Register".text.xl.bold.make(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}