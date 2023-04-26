import 'package:flutter/material.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key}) : super(key: key);
  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {

  List<dynamic> _eventsData = [];

  @override
  Widget build(BuildContext context) {
    _eventsData = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upcoming Events",
            style: TextStyle(
            color: Colors.tealAccent
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
        ),
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _eventsData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          _eventsData[index]['event_image'].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        _eventsData[index]['event_name'].toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        _eventsData[index]['event_date_time'].toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}