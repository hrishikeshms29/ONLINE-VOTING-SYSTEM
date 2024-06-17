import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Add logout functionality
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('Upcoming Elections'),
              subtitle: const Text('View and participate in upcoming elections.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, '/upcoming-elections');
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('Host an Election'),
              subtitle: const Text('Host your own election and invite participants.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, '/host-election');
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('Join a Party'),
              subtitle: const Text('Join a political party and contest in elections.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, '/join-party');
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('View Election Results'),
              subtitle: const Text('See the results of past elections.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, '/election-results');
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            child: ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('Manage Elections'),
              onTap: () {
                final FirebaseAuth _auth = FirebaseAuth.instance;
                final User? user = _auth.currentUser;

                if (user != null) {
                  String userId = user.uid;
                  Navigator.pushNamed(context, '/manage-election', arguments: userId);
                } else {
                  // User is not signed in
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
