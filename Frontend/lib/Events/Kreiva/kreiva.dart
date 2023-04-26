import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Kreiva extends StatefulWidget {
  const Kreiva({Key? key}) : super(key: key);

  @override
  State<Kreiva> createState() => _KreivaState();
}

class _KreivaState extends State<Kreiva> {

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
      if(event == 'Artistico')
        Navigator.pushNamed(context, '/artistico', arguments: _data3);
      else if(event == 'Euphoria') {
        Navigator.pushNamed(context, '/euphoria', arguments: _data3);
      }
      else if(event == 'Sync The Snaps') {
        Navigator.pushNamed(context, '/syncTheSnaps', arguments: _data3);
      }
      else if(event == 'Kahanikar') {
        Navigator.pushNamed(context, '/kahanikar', arguments: _data3);
      }
      else if(event == 'Retro Den') {
        Navigator.pushNamed(context, '/retroDen', arguments: _data3);
      }
      else if(event == 'Scavenge The Treasure') {
        Navigator.pushNamed(context, '/scavengeTheTreasure', arguments: _data3);
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
          "KREIVA",
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

            Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Artistico'),
                  child: Image.asset("Assets/images/artistico1.png"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Euphoria'),
                  child: Image.asset("Assets/images/euphoria1.png"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Sync The Snaps'),
                  child: Image.asset("Assets/images/syncTheSnaps1.png"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Kahanikar'),
                  child: Image.asset("Assets/images/kahanikar1.png"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Retro Den'),
                  child: Image.asset("Assets/images/retroDen1.png"),
                )
            ),

            const SizedBox(height: 10),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  onTap: () => teamData('Scavenge The Treasure'),
                  child: Image.asset("Assets/images/scavengeTheTreasure1.png"),
                )
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registerkreiva');
        },
        child: const Icon(Icons.app_registration),
        //label: const Text("Register"),
      ),
    );
  }
}
