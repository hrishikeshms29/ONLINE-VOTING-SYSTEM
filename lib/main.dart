import 'package:electro_vote/screens/ElectionDetailsScreen.dart';
import 'package:electro_vote/screens/UpcomingElectionsScreen.dart';
import 'package:electro_vote/screens/home_screen.dart';
import 'package:electro_vote/screens/host_election_screen.dart';
import 'package:electro_vote/screens/manage_election.dart';
import 'package:electro_vote/screens/profile_screen.dart';
import 'package:electro_vote/screens/voter_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';
import 'utils/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Set themeMode to ThemeMode.system
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        // '/settings': (context) => const SettingsScreen(),
        '/upcoming-elections': (context) => const ElectionsListScreen(),
        '/host-election': (context) => const HostElectionScreen(),
        '/manage-election': (context) => ManageElectionScreen(
          userId: ModalRoute.of(context)!.settings.arguments as String,
        ),
        '/election-details': (context) => ElectionDetailsScreen(
          electionId: ModalRoute.of(context)!.settings.arguments as String,
        ),
        '/voter': (context) {
          // Fetch dynamic values for electionId and classId
          String electionId = ''; // Fetch dynamically
          String classId = ''; // Fetch dynamically
          return VoterScreen(electionId: electionId, classId: classId);
        },
        // '/join-party': (context) => const JoinPartyScreen(),
        // '/election-results': (context) => const ElectionResultsScreen(),
      },

    );
  }
}
