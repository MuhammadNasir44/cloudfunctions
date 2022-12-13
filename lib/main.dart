import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloudfunleanrning/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("lets print it========>" + message.notification!.title.toString());
    _firebaseMessagingForegroundHandler(message);
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

Future<void> _firebaseMessagingForegroundHandler(RemoteMessage message) async {
  print("heeelo there");
  print(message.notification!.title.toString());
  print("Foreground message=========>: ${message.data}");
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Here is your title:=> " + message.notification!.title.toString());
  print("Background message *88888888: ${message.data}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: MyRouter.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );

  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }

  List<String> myMessageList = [];

  var getNotificationTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var intilizationSettignAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var initializtionSettings =
        InitializationSettings(android: intilizationSettignAndroid);
    flutterLocalNotificationsPlugin.initialize(initializtionSettings);
    _getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        myMessageList.add(message.notification!.title.toString());
      });

      getNotificationTitle = message.notification!.title.toString();

      print(
          "here is my getNotfication Title:" + getNotificationTitle.toString());

      print("heloooooooooooo there");
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
                importance: Importance.high),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: myMessageList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text("Hello there"),
                        Text("message:" + myMessageList[index].toString())
                      ],
                    );
                  }),
            ),
            FloatingActionButton(
              //   color: Colors.grey,
              onPressed: () {
                Navigator.pushNamed(context, 'Home_Screen');
              },
              child: Text("Click meeeeee"),
            ),
          ],
        ));
  }
}
