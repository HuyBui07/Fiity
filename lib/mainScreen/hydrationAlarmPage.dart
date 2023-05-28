import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

const intervalTask = "interval";
const oneTask = "oneTask";

class HydrationAlarmPage extends StatefulWidget {
  const HydrationAlarmPage({super.key});
  @override
  _HydrationAlarmPageState createState() => _HydrationAlarmPageState();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _HydrationAlarmPageState extends State<HydrationAlarmPage> {
  Color textColor = Color(0xFFffffff);
  Color backgroundColor = Color(0xFF000000);
  Color mainButtonColor = Color(0xFF9d34da);
  Color secondaryButtonColor = Color(0xFF1a1a1a);
  Color accentColor = Color(0xFFbd73e8);

  int minutes = 15;
  int hours = 0;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Hydration Alarm'),
        backgroundColor: mainButtonColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Set Hydration Alarm',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  '(Minimum value is 15 minutes)',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          int delta = (details.delta.dy / 6).round();
                          hours -= delta;
                          if (hours < 0) hours = 0;
                          if (hours > 24) hours = 24;
                          if (minutes == 0 && hours > 0 && delta < 0) hours--;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (hours < 24) hours++;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_upward,
                                color: textColor,
                              ),
                            ),
                            Text(
                              '${hours.toString().padLeft(2, '0')}',
                              style:
                                  TextStyle(fontSize: 50.0, color: textColor),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (hours > 0) hours--;
                                });
                              },
                              icon: Icon(Icons.arrow_downward),
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(fontSize: 50.0, color: textColor),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          int delta = (details.delta.dy / 4).round();
                          minutes -= delta;
                          if (minutes < 15 && hours == 0) {
                            minutes = 15;
                          } else if (minutes < 0) {
                            if (hours > 0) {
                              hours--;
                              minutes = 59;
                            } else {
                              minutes = 0;
                            }
                          } else if (minutes > 59) {
                            hours++;
                            minutes = 0;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (minutes < 59) minutes++;
                                });
                              },
                              icon: Icon(Icons.arrow_upward, color: textColor),
                            ),
                            Text(
                              '${minutes.toString().padLeft(2, '0')}',
                              style:
                                  TextStyle(fontSize: 50.0, color: textColor),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (minutes <= 15 && hours == 0) {
                                    minutes = 15;
                                  } else if (minutes > 0) minutes--;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_downward,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainButtonColor),
                  ),
                  onPressed: () {
                    //Convert minute and hours to second in tz.Datetime. If it's zero, alarm user to  make it bigger than zero. Other wise start schedule
                    int seconds = minutes * 60 + hours * 3600;

                    if (seconds < 900) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(
                                  'Please set the alarm to a time equal or greater than 15 minutes.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });
                    } else {
                      //alarm user of successful notification
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Your reminder has been set!.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });
                      Workmanager().cancelAll();
                      Workmanager().registerPeriodicTask(
                        intervalTask,
                        intervalTask,
                        frequency: Duration(seconds: seconds),
                      );

                      // Workmanager().registerOneOffTask(oneTask, oneTask);
                      //Pop this page
                    }
                  },
                  child: Text('Set Alarm'),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainButtonColor),
                  ),
                  onPressed: () {
                    // TODO: Handle alarm removal
                    Workmanager().cancelAll();
                    //Alert user that all task is cancelled
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Your reminder has been cancelled!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        });
                    print("All task cancelled");
                  },
                  child: Text('Remove Alarm'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Noti {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = new AndroidInitializationSettings('app_icon');
    var iOSInitialize = new DarwinInitializationSettings();
    var initializeSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializeSettings);
  }

  static Future ShowNotification({
    required String title,
    required String body,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    await fln.cancelAll();

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "Channel 1",
      "Hydration Alarm",
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(body),
    );
    var not = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    fln.show(0, title, body, not);
    if (title == "Hydration reminder!") print("Success");
  }
}
