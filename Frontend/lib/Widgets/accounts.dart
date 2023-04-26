import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'login_page.dart';


class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<dynamic> _data = [];
  List<dynamic> attributes1 = ['user_name'];
  List<dynamic> attributes2 = ['user_email'];
  List<dynamic> attributes3 = ['user_phoneno'];
  List<dynamic> attributes4 = ['user_position'];
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  // Future updatename() async {
  //   var response = await http.post(
  //     // Uri.parse('http://192.168.1.95:4500/update'),
  //     Uri.parse('http://10.100.163.226:4500/update'),
  //     headers: {'Content-Type': 'application/json', 'Methods': 'POST'},
  //     body: jsonEncode( {
  //       'user_name': nameController,
  //       'user_email': _data[0][attributes1[0]].toString(),
  //     },
  //     ),
  //   );
    // if(response.statusCode == 200){
    //   showDialog(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //         title: 'Successful!!'.text.xl2.bold.center.make(),
    //         content: "Username has been updated".text.xl.make(),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    //             },
    //             child: Container(
    //               color: Colors.white,
    //               padding: const EdgeInsets.all(14),
    //               child: "Okay".text.xl.make(),
    //             ),
    //           ),
    //         ],
    //       )
    //   );
    // }
  // }

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: "Account".text.color(Colors.black).make(),
        // actions: <Widget>[
        //   Padding(
        //     padding: EdgeInsets.fromLTRB(2, 2, 10, 2),
        //     child: IconButton(
        //         onPressed: () {
        //           Navigator.of(context).pushAndRemoveUntil(
        //                         MaterialPageRoute(builder: (context) => HomePage()),
        //                             (route) => false);
        //         },
        //         icon: Icon(Icons.home,
        //         size: 30,
        //         ),
        //     )
        //   )
        // ],
      ),

      body: ListView.builder(
          itemCount: attributes1.length,
          itemBuilder: (context, index) {
            if (_data.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                      NetworkImage('https://picsum.photos/id/237/200/300'),
                      radius: 80,
                    ),

                    const SizedBox(height: 20.0),

                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(_data[0][attributes1[index]].toString()),
                      trailing: IconButton(
                        onPressed: () {
                          opendialog();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(_data[0][attributes3[index]].toString()),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.add_card),
                      title: Text(_data[0][attributes4[index]].toString()),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => LoginPage()),
                                  (route) => false);
                        },
                        child: "Logout".text.make()
                    )
                  ],
                ),
              );
            }
            return const Center(child: Text('Wait'),);
          }
      ),
    );
  }

  Future opendialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: "Update your name".text.make(),
        key: _formKey,
        content: TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your name',
              prefixIcon: Icon(CupertinoIcons.person)
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name.';
            }
            return null;
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                // updatename();
                //Navigator.pushNamed(context, '/home');
                Navigator.of(context).pop();
              },
              child: "Submit".text.make()
          )
        ],
      ));
}