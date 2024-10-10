import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserListScreen();
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // Fetch the API data
  Future<List<dynamic>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var user = snapshot.data![index];
                return UserCard(user: user);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final dynamic user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User's name
            Text(
              user['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            SizedBox(height: 8),
            // User's username
            Text(
              "Username: ${user['username']}",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            // User's email
            Text(
              "Email: ${user['email']}",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            // User's phone
            Text(
              "Phone: ${user['phone']}",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            // User's website
            Text(
              "Website: ${user['website']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 12),
            // Address section
            Text(
              "Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            SizedBox(height: 8),
            Text("Street: ${user['address']['street']}"),
            Text("Suite: ${user['address']['suite']}"),
            Text("City: ${user['address']['city']}"),
            Text("Zipcode: ${user['address']['zipcode']}"),
            SizedBox(height: 12),
            // Company section
            Text(
              "Company",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            SizedBox(height: 8),
            Text("Name: ${user['company']['name']}"),
            Text("Catch Phrase: ${user['company']['catchPhrase']}"),
            Text("BS: ${user['company']['bs']}"),
          ],
        ),
      ),
    );
  }
}
