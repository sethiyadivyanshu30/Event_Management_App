import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'committee.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count=0;
  final List<String> urlImages=[
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx1blldRHji_kNcaHS-MVfRxZvMwAg5HsTRx4H_IsCQ6S-8OP_4nm6Zta4fHwAXaTWUmg&usqp=CAU',
    'https://i.ytimg.com/vi/QUARb-45FoI/maxresdefault.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPoAsTC2GHkBIX1MpYzghWJOpCyTj0Z3Uedg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkkc5GLCe8cRTWdOo0Vkx41lfHXeBPjyszFw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLc1Jodk3bu7ag5KsutS89TUxb3gyak4WF5Q&usqp=CAU',
  ];

  final List<String> dec=[
    'Tedx',
    'Mod5',
    'Arcadia',
    'Robo race',
    'Masquerade',
  ];

  List<Widget> generate(){
    return urlImages.map((element)=>ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.network(element,
        fit: BoxFit.cover,
      ),
    )) .toList();

  }

  late var _data1;
  late String _username;
  late List _accountData;
  late List _data3;

  Future<List<dynamic>> _fetchData() async {
    var response = await http.post(
      // Uri.parse('http://192.168.1.95:4500/accounts'),
      Uri.parse('http://10.100.163.226:4500/accounts'),
      headers: {'Content-Type': 'application/json', 'Methods': 'POST'},
      body: jsonEncode( {
        'user_email': _username,
      },
      ),
    );
    if(response.statusCode == 200){
      _accountData = jsonDecode(response.body);
      Navigator.pushNamed(context, '/account', arguments: _accountData);
      return _accountData;
    } else {
      throw Exception('Failed to fetch data');}
  }

  Future<List<dynamic>> _eventData() async {
    var response = await http.get(
      //Uri.parse('http://192.168.1.95:4500/events'),
      Uri.parse('http://10.100.163.226:4500/events'),
      headers: {'Content-Type': 'application/json', 'Methods': 'GET'},
    );

    if(response.statusCode == 200) {
      _data3 = jsonDecode(response.body);
      Navigator.pushNamed(context, '/upcomingEvents', arguments: _data3);
      return _data3;
    }
    else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    _data1 = ModalRoute.of(context)?.settings.arguments;
    _username = _data1['user_email'];
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
              'Event Management'
          ),
          actions: <Widget> [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: IconButton(onPressed: () {
                // Navigator.pushNamed(context, '/upcomingEvents');
                _eventData();
              },
                  icon: const Icon(Icons.calendar_month),
              )
            ),
          ],
        ),

        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: null,
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8Vd1N6Dpu-uwgV6HvohXDCbOsxl68h8JdCA&usqp=CAU'),
                  backgroundColor: Colors.grey,
                ), accountEmail: null,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey
                  ),
                  child:  ListTile(
                    leading: const Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    title: const Text(
                      "Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                    onTap: (){
                      // Navigator.pushNamed(context, '/account', arguments: _username);
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>Accounts(),));
                      _fetchData();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey
                  ),
                  child:  ListTile(
                    title: const Text(
                      "Committee",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(
                      Icons.group,
                      size: 30,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> const Committee(),));
                    },
                  ),
                ),
              ),

              const SizedBox(height: 50),

            ],
          ),
        ),

        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
              children:[
                Column(
                  children: [
                    Padding(
                      padding:  const EdgeInsets.only(top: 35),
                      child: Stack(
                          children:[
                            CarouselSlider(
                              items: generate(),
                              options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  onPageChanged: (index,other){
                                    setState(() {
                                      _count=index;
                                    });
                                  }
                              ),

                            ),
                            AspectRatio(
                              aspectRatio: 18/8,
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    dec[_count],
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.width/15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.grey,
                              ),
                              child: ListTile(
                                title: const Text('CEREBRO',),
                                subtitle: const Text('TECH COMMITTEE'),
                                leading: Image.network('https://drive.google.com/uc?export=view&id=1OvRQiBERzNgint6xA5vyxXJ8NCr1sGX6'),
                                contentPadding: const EdgeInsets.all(8.0),
                                trailing: const Text('9 AM - 11 AM'),
                                textColor: Colors.black,
                                onTap: (){
                                  Navigator.pushNamed(context, '/cerebro');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> Cerebro()));
                                },
                              ),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.grey,
                              ),
                              child: ListTile(
                                title: const Text('VENTURA',),
                                subtitle: const Text('SPORTS COMMITTEE'),
                                leading: Image.network('https://media.licdn.com/dms/image/C4D0BAQEuBrdVNvSfjg/company-logo_200_200/0/1656739637346?e=2147483647&v=beta&t=z67r6GbwRPjhFKYbyJZAG5gX-G55Qm9g-gO7H-va-9Q',
                                ),
                                trailing: const Text('12 PM'),
                                contentPadding: const EdgeInsets.all(8.0),
                                onTap: (){
                                  Navigator.pushNamed(context, '/ventura');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> Ventura()));
                                },
                              ),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.grey,
                              ),
                              child: ListTile(
                                title: const Text('KREIVA'),
                                subtitle: const Text('CULT COMMITTEE'),
                                leading: Image.network('https://drive.google.com/uc?export=view&id=1cBiIMnMx5Dr46bxiDbJJuktQBHR_Aaac',
                                ),
                                trailing: const Text('2 PM'),
                                contentPadding: const EdgeInsets.all(8.0),
                                onTap: (){
                                  Navigator.pushNamed(context, '/kreiva');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> Kreiva()));
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}