import 'package:firebase_core/firebase_core.dart';
import 'package:fitty/mainScreen/hydrationAlarmPage.dart';
import 'package:fitty/onboardingScreen.dart';
import 'package:fitty/user/editInformationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case intervalTask:
        await Noti.ShowNotification(
          title: "Hydration reminder!",
          body: "Remember to hydrate yourself!",
          fln: flutterLocalNotificationsPlugin,
        );
        print("BIGNOTIFIED");
        break;
      case oneTask:
        await Noti.ShowNotification(
          title: "One Time Task",
          body: "Remember to hydrate yourself!",
          fln: flutterLocalNotificationsPlugin,
        );
        print("Big notified one task");
        break;
      case "fakeTask":
        print("fakeTask");
        break;
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginScreen(),
        '/onboarding': (context) => OnBoardingScreen(),
        '/': (context) => HomePage(),
        '/editInfo': (context) => EditInformationPage(),
      },
      initialRoute: '/',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: OnBoardingScreen());
  }
}
