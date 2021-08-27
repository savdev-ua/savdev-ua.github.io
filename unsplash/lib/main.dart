import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'destination_screen.dart';
import 'colored_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _isContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Unsplash Fetcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var urlData;

  bool _isContainerVisible = false;

  void getApiData() async {
    var url = Uri.parse(
        "https://api.unsplash.com/photos/?client_id=wVHxj5xqNidNGy4pCsA_dNzFsVIBhCxfc5i65KNGRG4");
    final res = await http.get(url);
    setState(() {
      urlData = jsonDecode(res.body);
      print(urlData);
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int i) => const Divider(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int i) {
          var link = urlData[i]['urls']['small'];
          return SingleChildScrollView(
              child: Material(
            color: Colors.black54,
            child: Column(
              children: <Widget>[
                (urlData[i]["description"] == null)
                    ? Text(
                        "Title not specified :(",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      )
                    : Text(
                        urlData[i]["description"],
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                (urlData[i]["user"]["name"] == null)
                    ? Text("Name not specofied :(",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            decoration: TextDecoration.none))
                    : Text(urlData[i]["user"]["name"],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            decoration: TextDecoration.none)),

                //   GestureDetector(
                // onTap: (){
                //   print(link);
                //   //Navigator.push(context,  DestinationScreen(url: link))
                //  setState(() {
                //               _isContainerVisible = !_isContainerVisible;
                //             });
                // },

                // child:Image.network(link)
                //   )   ,
                Image.network(link),
                // ElevatedButton(
                //     onPressed: () {
                //       // When the user taps the button, navigate
                //       // to a named route and provide the arguments
                //       // as an optional parameter.
                //       Navigator.pushNamed(
                //         context,
                //         PassArgumentsScreen.routeName,
                //         arguments: ScreenArguments(urlData[i]['urls']['raw']),
                //       );
                //     },
                //     child: const Text('Navigate to a named that accepts arguments'),
                //   ),

                //  IconButton(
                //     onPressed: () {
                //       setState(() {
                //         _isContainerVisible = !_isContainerVisible;
                //       });
                //     },
                //     icon: Image.network(link),
                //     iconSize: 40.0,
                //   ),
                //   ColoredContainer(_isContainerVisible)
              ],
            ),
          ));
        });
  }
}

//additional class for PassArgumentsScreen
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String url;

  const PassArgumentsScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      body: Center(
        child: Image.network(url),
      ),
    );
  }
}

class ScreenArguments {
  final String url;

  ScreenArguments(this.url);
}
