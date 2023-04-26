import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Ventura extends StatefulWidget {
  const Ventura({Key? key}) : super(key: key);

  @override
  State<Ventura> createState() => _VenturaState();
}

class _VenturaState extends State<Ventura> {
  late List _data3;

  void teamData(String event) async {
    var response = await http.post(
      //Uri.parse('http://192.168.1.95:4500/teamData'),
      Uri.parse('http://10.100.163.226:4500/teamData'),
      headers: {'Content-Type': 'application/json', 'Methods': 'GET'},
      body: jsonEncode( {
        'event_name': event,
      },
      ),
    );
    if(response.statusCode == 200) {
      _data3 = jsonDecode(response.body);
      if(event == 'Cricket')
        Navigator.pushNamed(context, '/cricketLeague', arguments: _data3);
      else if(event == 'Table Tennis') {
        Navigator.pushNamed(context, '/tableTennis', arguments: _data3);
      }
      else if(event == 'Football') {
        Navigator.pushNamed(context, '/football', arguments: _data3);
      }
      else if(event == 'Badminton') {
        Navigator.pushNamed(context, '/badminton', arguments: _data3);
      }
      else if(event == 'Volleyball') {
        Navigator.pushNamed(context, '/volleyball', arguments: _data3);
      }
    }
    else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "VENTURA",
          style: TextStyle(
              color: Colors.tealAccent
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 16),

            Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Cricket'),
                  child: Image.asset("Assets/images/cricket1.jpg"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Table Tennis'),
                  child: Image.asset("Assets/images/tableTennis1.jpg"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => teamData('Football'),
                  child: Image.asset("Assets/images/football1.jpg"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Badminton'),
                  child: Image.asset("Assets/images/badminton1.jpg"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Volleyball'),
                  child: Image.asset("Assets/images/volleyball1.jpg"),
                )
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registerventura');
        },
        child: const Icon(Icons.app_registration),
      ),

    );
  }
}
