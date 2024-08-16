import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionRequestScreen extends StatefulWidget {
  const SessionRequestScreen({super.key});

  @override
  _SessionRequestScreenState createState() => _SessionRequestScreenState();
}

class _SessionRequestScreenState extends State<SessionRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String _topic = '';
  String _preferredDate = '';
  String _preferredTime = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _submitSessionRequest() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      User? user = _auth.currentUser;
      String studentId = user != null ? user.uid : 'unknown';

      // Construct the request payload
      final requestData = {
        'topic': _topic,
        'preferredDate': _preferredDate,
        'preferredTime': _preferredTime,
        'studentId': studentId,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Save the request to Firestore
      await _firestore.collection('sessionRequests').add(requestData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session request submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Schedule a Meet',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Topic'),
                    onSaved: (value) => _topic = value!,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Preferred Date'),
                    onSaved: (value) => _preferredDate = value!,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Preferred Time'),
                    onSaved: (value) => _preferredTime = value!,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitSessionRequest,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Submit Request'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}