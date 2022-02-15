import 'package:flutter/material.dart';
import 'package:gmap/screens/Recess.dart';
import 'package:http/http.dart' as http;

class Example extends StatefulWidget {
  const Example({Key key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  fetch() async {
    var response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=0.3476,32.5825&type=gyms&rankby=distance&key=AIzaSyAPjPbrKO3uRQ80E0ue6g4XoSgBIcNucgQ"));
    if (response.statusCode == 200) {
      return recessFromJson(response.body);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: FutureBuilder(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  Photo posts = snapshot.data[index];
                  return Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${posts.height}",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
