import 'package:app4/style.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App name',
      home: SplashScreenView(
        navigateRoute: const Dashboard(),
        duration: 3000,
        imageSize: 130,
        imageSrc: "assets/icons8-flutter-240.png",
        text: "App name",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
          fontSize: 30.0,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}



class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  num salinity = 0;
  num temp = 0;


  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        Map<String, dynamic> _post = Map<String, dynamic>.from(
            event.snapshot.value as Map);
        salinity = _post["ppm"];
        temp = _post["temp"];
        setState(() {});
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff080e2b),
              Color(0xff010209),
            ],
          ),
        ),
        child: ListView(
          children: [
            customAppBar(),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
              child: PrimaryText(
                text: 'Data',
                size: 24,
              ),
            ),
            Lottie.asset("assets/63902-data.json"),
            SizedBox(
              height: 200,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                 children: [
              Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff080e2b),
                        Color(0xff010209),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                      height: 100,
                        width: 140,
                        padding: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Lottie.asset("assets/128527-saline-lottie-animation.json"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: PrimaryText(
                            text: "Salinity", size: 15, fontWeight: FontWeight.bold),
                      ),
                      PrimaryText(
                        text: "$salinity%",
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff080e2b),
                    Color(0xff010209),
                  ],
                ),
              ),
              child: Column(
                  children: [
                Container(
                  height: 100,
                  width: 140,
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Lottie.asset("assets/16747-thermometer.json"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: PrimaryText(
                      text: "Temperature", size: 15, fontWeight: FontWeight.w800),
                ),
                PrimaryText(
                    text: "$temp%",
                    size: 15,),
              ]),
            ),
          )
                 ]),
  ]),
            )]
        ),
      ),
    );
  }


  Padding customAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryText(
            text: 'App Name',
            size: 32,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
  }
