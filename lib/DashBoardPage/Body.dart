// ignore: file_names
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuel_app/theme.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

//import 'SearchBox.dart';
//import 'categoryList.dart';

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(
      Uri.parse('https://fuel-app-backend.up.railway.app/api/fuelStation'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    // return Album.fromJson(jsonDecode(response.body));

    // final jsonresponse = jsonDecode(response.body);
    // return Album.fromJson(jsonresponse.body);
    final List result = json.decode(response.body);
    return result.map((e) => Album.fromJson(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String dealer;
  final String Location;
  final String petrolStatus;
  final String dieselStatus;

  const Album({
    required this.dealer,
    required this.Location,
    required this.petrolStatus,
    required this.dieselStatus,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        dealer: json['dealer'],
        Location: json['location'],
        petrolStatus: json['petrolStatus'],
        dieselStatus: json['dieselStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealer'] = dealer;
    data['Location'] = Location;
    data['petrolStatus'] = petrolStatus;
    data['dieselStatus'] = dieselStatus;
    return data;
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Fuel House"),
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashBoard');
              },
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/viewQueue');
              },
              icon: Icon(Icons.car_crash_outlined),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/joinQueue');
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => Scan()));
              },
              icon: Icon(
                Icons.queue,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fuelStateUpdate');
              },
              icon: Icon(Icons.update),
            ),
          ],
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                // style: ButtonStyle(backgroundColor: Colors.amber),
                onPressed: () {
                  Navigator.pushNamed(context, '/selectNearestShed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  // primary: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: const Text("Search Nearest Fuel station"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                // style: ButtonStyle(backgroundColor: Colors.amber),
                onPressed: () {
                  Navigator.pushNamed(context, '/joinQueue');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  // primary: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: const Text("Join To The Queue"),
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder<List<Album>>(
                future: fetchAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: Colors.white,
                          color: Colors.tealAccent,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(
                              snapshot.data![index].dealer.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                                snapshot.data![index].petrolStatus.toString()),
                            subtitle: Text(
                                snapshot.data![index].dieselStatus.toString()),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
