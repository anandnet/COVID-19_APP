import './countryScreen.dart';
import 'package:flutter/material.dart';
import '../models/model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class WorldScreen extends StatefulWidget {
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  bool spinner = true;
  bool error = false;
  List<CountryCases> countryCasesList = [];
  getdata() async {
    List<CountryCases> temp = [];
    setState(() {
      spinner = true;
      error = false;
    });

    try {
      var url = 'https://www.worldometers.info/coronavirus/';
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var document = parse(response.body);
        List<dom.Element> table = document
            .getElementById("main_table_countries_today")
            .children[1]
            .children;
        table.forEach((tr) {
          var children = tr.children;
          if (!(children[0].text.trim() == "South America" ||
              children[0].text.trim() == "North America" ||
              children[0].text.trim() == "Asia" ||
              children[0].text.trim() == "Europe"||
              children[0].text.trim() == "Africa")){
            temp.add(CountryCases(
                countryName: children[0].text,
                totalCases: children[1].text.trim(),
                newCases: children[2].text.trim(),
                totalDeaths: children[3].text.trim(),
                newDeaths: children[4].text.trim(),
                totalRecovered: children[5].text.trim(),
                activeCases: children[6].text.trim(),
                seriousCases: children[7].text.trim()));
              }
              else{
                print("yess");
              }
        });
        temp.sort((a, b) => int.tryParse(b.totalCases.replaceAll(",", ""))
            .compareTo(int.tryParse(a.totalCases.replaceAll(",", ""))));
        print(temp[1].countryName);
      }
    } catch (e) {
      error = true;
    }
    setState(() {
      if (!error) {
        countryCasesList = temp.toList();
        spinner = false;
      }
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 180,
              width: screenSize.width,
              child: Image.asset(
                "assets/world_map.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
            Material(
              elevation: 20,
              color: Color.fromRGBO(47, 47, 49, 0.9),
              child: Container(
                height: 35,
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    width: screenSize.width * .55,
                    child: Text(
                      "Country",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: screenSize.width * .25,
                    child: Text("Cases",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: screenSize.width * .20,
                    child: Text("Deaths",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )
                ]),
              ),
            ),
            Flexible(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: screenSize.width,
                    child: Image.asset(
                      "assets/coronavirus1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: error
                        ? Container(
                            color: Color.fromRGBO(57, 57, 59, 0.9),
                            child: Center(
                              child: Text(
                                "No Internet Connection !!",
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                        : spinner
                            ? Container(
                                color: Color.fromRGBO(57, 57, 59, 0.9),
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : ListView.builder(
                                padding: EdgeInsets.only(),
                                itemCount: countryCasesList.length,
                                itemBuilder: (context, index) {
                                  return Material(
                                    color: Color.fromRGBO(57, 57, 59, 0.9),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Country(
                                              countryCasesList[index]);
                                        }));
                                      },
                                      hoverColor: Colors.white,
                                      child: Container(
                                        height: 60,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              width: screenSize.width * .55,
                                              child: Text(
                                                countryCasesList[index]
                                                    .countryName,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              width: screenSize.width * .25,
                                              child: Text(
                                                countryCasesList[index]
                                                    .totalCases,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              width: screenSize.width * .20,
                                              child: Center(
                                                  child: Text(
                                                countryCasesList[index]
                                                    .totalDeaths,
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                  ),
                ],
              ),
            ),
          ],
        ),
        SafeArea(
            child: Container(
          margin: const EdgeInsets.only(left: 8, top: 5),
          alignment: Alignment.topLeft,
          child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ))
      ],
    ));
  }
}
