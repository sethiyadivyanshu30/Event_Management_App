import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RoboRace extends StatefulWidget
{
  @override
  State<RoboRace> createState() => _RoboRaceState();
}

class Item {
  String headerValue;
  String expandedValue;
  List<Item> children;
  bool isExpanded;

  Item({
    required this.headerValue,
    required this.expandedValue,
    required this.children,
    this.isExpanded = false,
  });
}

List<dynamic> _teamData = [];

class _RoboRaceState extends State<RoboRace> {
  late List<Item> _items = generateItems();
  List<Item> generateItems() {
    return List.generate(1, (index) => Item(
      headerValue: "Teams",
      expandedValue: '',
      children: generateSubItems(),
    ));
  }

  List<Item> generateSubItems() {
    return List.generate(_teamData.length, (index) => Item(
      headerValue: _teamData[index]['team_name'].toString(),
      expandedValue: _teamData[index]['college_name'].toString()+"\t\t\t\t" + _teamData[index]['team_contact'].toString(),
      children: [],
    ));
  }
  @override
  Widget build(BuildContext context) {
    _teamData = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: "ROBO RACE".text.color(Colors.tealAccent).make(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'Assets/images/roboRace2.jpg',
              fit: BoxFit.fill,
              width: 500,
            ),

            const SizedBox(height: 20),
            "Description".text.white.bold.start.xl2.make(),
            const Text("Robo Race-Design a robot either wired or wireless within the specified dimensions that can operated manually and can travel through all turns of the track.", style: TextStyle(color: Colors.white),).p16(),
            const SizedBox(height: 20,),

            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _items[index].isExpanded = !isExpanded;
                });
              },
              children: _items.map((Item item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.headerValue),
                    );
                  },
                  body: item.children.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          item.children[index].isExpanded = !isExpanded;
                        });
                      },
                      children: item.children.map((Item subItem) {
                        return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(subItem.headerValue),
                            );
                          },
                          body: ListTile(
                            title: Text(subItem.expandedValue),
                          ),
                          isExpanded: subItem.isExpanded,
                        );
                      }).toList(),
                    ),
                  )
                      : ListTile(
                    title: Text(item.expandedValue),
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
