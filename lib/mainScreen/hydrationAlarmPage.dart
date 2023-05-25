import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HydrationAlarmPage extends StatefulWidget {
  @override
  _HydrationAlarmPageState createState() => _HydrationAlarmPageState();
}

class _HydrationAlarmPageState extends State<HydrationAlarmPage> {
  int minutes = 0;
  int hours = 0;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // Initialize the plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> scheduleNotification() async {
    // Cancel any previously scheduled notifications
    await flutterLocalNotificationsPlugin.cancelAll();

    // Configure the notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Calculate the scheduled time based on the selected hours and minutes
    final now = tz.TZDateTime.now(tz.local);
    final duration = Duration(hours: hours, minutes: minutes);
    final scheduledDate = now.add(duration);

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Hydration Reminder',
      'Time to hydrate!',
      scheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'hydrate_payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hydration Alarm'),
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
                  ),
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
                              icon: Icon(Icons.arrow_upward),
                            ),
                            Text(
                              '${hours.toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 50.0),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (hours > 0) hours--;
                                });
                              },
                              icon: Icon(Icons.arrow_downward),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(fontSize: 50.0),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          int delta = (details.delta.dy / 4).round();
                          minutes -= delta;
                          if (minutes < 0) {
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
                              icon: Icon(Icons.arrow_upward),
                            ),
                            Text(
                              '${minutes.toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 50.0),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (minutes > 0) minutes--;
                                });
                              },
                              icon: Icon(Icons.arrow_downward),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    scheduleNotification();
                  },
                  child: Text('Set Alarm'),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Handle alarm removal
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
