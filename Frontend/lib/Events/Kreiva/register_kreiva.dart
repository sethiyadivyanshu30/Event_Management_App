import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;


class Register_Kreiva extends StatefulWidget{
  @override
  State<Register_Kreiva> createState() => _RegisterKreivaState();
}

class _RegisterKreivaState extends State<Register_Kreiva>{
  final _formKey = GlobalKey<FormState>();
  late String team;
  late String college;
  late String contact;
  String dropdownValue = 'Artistico';

  Future register() async{
    final response = await http.post(
        //Uri.parse('http://192.168.1.95:4500/registerTeam'),
      Uri.parse('http://10.100.163.226:4500/registerTeam'),
      headers: {'Content-Type': 'application/json', 'Methods': 'POST'},
      body: jsonEncode( {
        'team_name': team,
        'college_name': college,
        'team_contact': contact,
        'event_name': dropdownValue
      },
      ),
    );

    if(response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registered'),
            content: Text('You have been registered successfully.'),
            actions: <Widget>[
              MaterialButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                  Navigator.pushNamed(context, '/kreiva');
                  },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "REGISTER",
            style: TextStyle(
                color: Colors.tealAccent
            ),
          ),
          centerTitle: true,
          //backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: NetworkImage(
            //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA0eU_PA1ZZOH88Prq71b3_usZTH-LSoc3IQ&usqp=CAU',
            //         ),
            //         fit: BoxFit.cover
            //     )
            // ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Center(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),

                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.person_add),
                              iconColor: Colors.black26,
                              label: Text("Team Name")
                          ),
                          onChanged: (value) {
                            team = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter team name.';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.work),
                              iconColor: Colors.black26,
                              label: Text("Institute Name")
                          ),
                          onChanged: (value) {
                            college = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter college name.';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.phone_rounded),
                              iconColor: Colors.black26,
                              label: Text("Contact Number")
                          ),
                          onChanged: (value) {
                            contact = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter contact number.';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.event),
                              label: Text("Event Name"),
                            ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter event name.';
                                }
                                return null;
                              },
                            value: dropdownValue,
                              items: <String>['Artistico', 'Euphoria', 'Sync The Snaps',
                                'Kahanikar', 'Retro Den', 'Scavenge The Treasure'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      //style: TextStyle(fontSize: 30),
                                    ),
                                  );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              }
                          ),
                        ),

                        const SizedBox(height: 50),

                        SizedBox(
                          width: 120,
                          height: 38,
                          child: ElevatedButton(
                              onPressed: () {
                                register();
                              },
                              child: "Register".text.xl.make()
                          ),
                        )
                      ],
                    ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
