import 'package:flutter/material.dart';
import 'screens/index.dart';
import 'screens/booking_page.dart';
import 'screens/front_desk.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import '/screens/housekeeping.dart';

void main() {
  setUrlStrategy(PathUrlStrategy()); // Enables proper path parsing
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mews Chatbot Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const IndexPage());
          case '/booking':
            return MaterialPageRoute(builder: (_) => const BookingPageV2());
          case '/front-desk':
            return MaterialPageRoute(builder: (_) => const FrontDeskPage());
          case '/housekeeping':
            return MaterialPageRoute(builder: (_) => const HousekeepingPage());
          default:
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text('404 - Page not found')),
              ),
            );
        }
      },
    );
  }
}
