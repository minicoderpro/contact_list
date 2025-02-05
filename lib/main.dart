import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  ContactListScreenState createState() => ContactListScreenState();
}

class ContactListScreenState extends State<ContactListScreen> {
  final List<Map<String, String>> _contacts = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  void _addContact() {
    final String name = _nameController.text;
    final String number = _numberController.text;
    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        _contacts.add({'name': name, 'number': number});
      });
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _contacts.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact List',
          textAlign: TextAlign.center, // Center the title
          style: TextStyle(color: Colors.white), // Title color white
        ),
        centerTitle: true, // Center the app bar title
        backgroundColor: Colors.blueGrey, // AppBar color blue-grey
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(), // Outline input box
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(), // Outline input box
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey, // Button color same as AppBar
              ),
              child: Text(
                'Add',
                textAlign: TextAlign.center, // Center the title
                style: TextStyle(color: Colors.white), // Title color white
              ),
            ),
            SizedBox(height: 20), // Space between the button and the ListView
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0), // Gap between list items
                    child: ListTile(
                      tileColor: Colors.grey[200], // Soft gray background for list items
                      leading: Icon(
                        Icons.person,
                        color: Colors.lime[900], // Person icon color lime
                      ),
                      title: Text(
                        _contacts[index]['name']!,
                        style: TextStyle(color: Colors.red), // Name text color red
                      ),
                      subtitle: Text(_contacts[index]['number']!),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.blue, // Phone icon color blue
                      ),
                      onLongPress: () => _deleteContact(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
