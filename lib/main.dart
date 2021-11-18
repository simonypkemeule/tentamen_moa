import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tentamen_moa/Page/menu.dart';
import 'dart:async';
//corona.lmao.ninja/v2/countries

void main() {
  runApp(MaterialApp(
    title: "tentamen_moa",
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.whatshot_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              //Add Link here!!
            }),
        title: const Text(
          "Corona-19 Information",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Countries extends StatefulWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<List<Land>> getLanden() async {
  Response data =
      await http.get(Uri.parse("https://corona.lmao.ninja/v2/countries%22"));
  List jsonData = json.decode(data.body);
  List<Land> landen = [];
  jsonData.forEach((c) {
    Map obj = c;
    Map countryInfoMap = obj['countryInfo'];
    String countryCode = countryInfoMap['iso2'].toString();
    String flagImg = countryInfoMap['flag'].toString();

    Land land = Land(c["country"], c["population"], c["active"], c["cases"],
        c["deaths"], c["recovered"], countryCode, flagImg);
    print(land.naam);
    print(land.countryCode);
    print(land.flag);
    landen.add(land);
  });
  return landen;
}

class Land {
  final String naam;
  final int population;
  final int active;
  final int cases;
  final int deaths;
  final int recovered;
  final String countryCode;
  final String flag;

  Land(this.naam, this.population, this.active, this.cases, this.deaths,
      this.recovered, this.countryCode, this.flag);
}
