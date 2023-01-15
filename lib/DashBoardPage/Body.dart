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

// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: const EdgeInsets.symmetric(
//         horizontal: 30,
//         vertical: 30,
//       ),
//       height: 160,
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             height: 136,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(22), color: kPrimaryColor),
//             child: Container(
//               margin: const EdgeInsets.only(left: 10),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     const BoxShadow(color: kPrimaryColor, blurRadius: 1)
//                   ],
//                   borderRadius: BorderRadius.circular(22)),
//             ),
//           ),
//           //image
//           Positioned(
//               top: 0,
//               left: 0,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 height: 160,
//                 width: 200,
//                 child: Image.asset(
//                   "images/gas.png",
//                   fit: BoxFit.cover,
//                 ),
//               )),
//           //title and price etc
//           Positioned(
//             right: 0,
//             bottom: 0,
//             child: SizedBox(
//               height: 136,
//               width: size.width - 200,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Spacer(),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       "Gas Avalability",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: kPrimaryColor),
//                     ),
//                   ),
//                   const Spacer(),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//                     decoration: const BoxDecoration(
//                         color: Colors.amberAccent,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(22),
//                           topRight: Radius.circular(22),
//                         )),
//                     child: const Text(
//                       "Available",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: kPrimaryColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:fuel_app/theme.dart';

// import 'SearchBox.dart';
// import 'categoryList.dart';

// class Body extends StatefulWidget {
//   static const routName = "/body";

//   const Body({super.key});

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 201, 157, 216),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Fuel Dashboard",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ),
//                 Stack(
//                   children: [
//                     IconButton(
//                         onPressed: () {}, icon: Icon(Icons.notifications_none)),
//                     Positioned(
//                         top: 12,
//                         right: 12,
//                         child: Container(
//                           height: 10,
//                           width: 10,
//                           decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(20)),
//                         ))
//                   ],
//                 )
//               ],
//             ),
//             Column(children: [
//               SearchBox(
//                 onChanged: (value) {},
//               ),
//               CategoryList(),
//               SizedBox(
//                 height: 40,
//               ),
//               Expanded(
//                 child: Stack(
//                   children: [
//                     Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(40),
//                               topRight: Radius.circular(40),
//                             )))
//                   ],
//                 ),
//               ),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class User {
//   final String dealer, location, petrolStatus, dieselStatus;

//   User(this.dealer, this.location, this.petrolStatus, this.dieselStatus);
// }

