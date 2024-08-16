import 'package:flutter/material.dart';
import 'package:hackathon/components/my_drawer.dart';
import 'package:hackathon/pages/meeting_request.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'The Career Company',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Ninad Lunge',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              'Final Year Computer Engineering Undergrad',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading : Icon(Icons.calendar_month),
              title: const Text(
                'Schedule a Meet',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SessionRequestScreen())
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
