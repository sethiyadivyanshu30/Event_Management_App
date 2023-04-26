import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CsGo extends StatefulWidget {
  @override
  State<CsGo> createState() => _CsGoState();
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

class _CsGoState extends State<CsGo> {



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
        title: "CS:GO".text.color(Colors.tealAccent).make(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'Assets/images/csGo2.jpg',
              fit: BoxFit.fill,
              width: 500,
            ),

            const SizedBox(height: 20),
            "Description".text.white.bold.start.xl2.make(),
            const Text("CS GO-the CS GO Tournament presented by Arcadia organized under Cerebro ’23 - The annual Tech Fest of IIIT V.", style: TextStyle(color: Colors.white),).p16(),
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
