import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Cerebro extends StatefulWidget {
  @override
  State<Cerebro> createState() => _CerebroState();
}

class _CerebroState extends State<Cerebro> {

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
      if(event == 'Cook-A-Code')
      Navigator.pushNamed(context, '/cookACode', arguments: _data3);
      else if(event == 'CS GO') {
        Navigator.pushNamed(context, '/csGo', arguments: _data3);
      }
      else if(event == 'Valorant') {
        Navigator.pushNamed(context, '/valorant', arguments: _data3);
      }
      else if(event == 'Robo Race') {
        Navigator.pushNamed(context, '/roboRace', arguments: _data3);
      }
      else if(event == 'Prudentia') {
        Navigator.pushNamed(context, '/prudentia', arguments: _data3);
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
          "CEREBRO",
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
            //const SizedBox(height: 16),
            Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('CS GO'),
                  child: Image.asset("Assets/images/csGo1.jpg", ),
                )
            ),

            // const SizedBox(height: 16),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Valorant'),
                  child: Image.asset("Assets/images/valorant1.jpg"),
                )
            ),

            // const SizedBox(height: 16),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Robo Race'),
                  child: Image.asset("Assets/images/roboRace1.jpg"),
                )
            ),

            // const SizedBox(height: 16),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Cook-A-Code'),
                  child: Image.asset("Assets/images/cookACode1.png"),
                )
            ),

            // const SizedBox(height: 16),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Prudentia'),
                  child: Image.asset("Assets/images/prudentia1.png"),
                )
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registercerebro');
        },
        child: const Icon(Icons.app_registration),
      ),
    );
  }
}