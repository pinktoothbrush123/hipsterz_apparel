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
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text("Username: ${user['username']}"),
            SizedBox(height: 5),
            Text("Email: ${user['email']}"),
            SizedBox(height: 5),
            Text("Phone: ${user['phone']}"),
            SizedBox(height: 5),
            Text("Website: ${user['website']}"),
            SizedBox(height: 10),
            Text(
              "Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Street: ${user['address']['street']}"),
            Text("Suite: ${user['address']['suite']}"),
            Text("City: ${user['address']['city']}"),
            Text("Zipcode: ${user['address']['zipcode']}"),
            SizedBox(height: 10),
            Text(
              "Company",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Name: ${user['company']['name']}"),
            Text("Catch Phrase: ${user['company']['catchPhrase']}"),
            Text("BS: ${user['company']['bs']}"),
          ],
        ),
      ),
    );
  }
}
