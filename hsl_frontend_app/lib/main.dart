import 'package:flutter/material.dart';
import 'package:hsl_frontend_app/add_journey.dart';
import 'package:hsl_frontend_app/add_station.dart';
import 'package:hsl_frontend_app/journey_scroll_controller.dart';
import 'package:hsl_frontend_app/station_scroll_controller.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HSL Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  fetchJourneyList() async {
    final response =
        await http.get(Uri.parse('http://hsl-backend-app.herokuapp.com/'));
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error fetching data from API with response code ${response.statusCode}Exit to return to previous page'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Exit',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ));
    }
    print(response.statusCode);
  }

  bool loading = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    fetchJourneyList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: Text('View Journeys'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JourneyScrollScreen(),
                            ));
                      }),
                  ElevatedButton(
                      child: Text('View Stations'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationScrollScreen(),
                            ));
                      }),
                  ElevatedButton(
                      child: Text('Create Journey'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddJourney(),
                            ));
                      }),
                  ElevatedButton(
                      child: Text('Create Station'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddStation(),
                            ));
                      }),
                ],
              ),
            ),
    );
  }
}
