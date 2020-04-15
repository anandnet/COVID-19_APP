import 'package:COVID_19/widgets/imageviewer.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class PostersScreen extends StatefulWidget {
  @override
  _PostersScreenState createState() => _PostersScreenState();
}

class _PostersScreenState extends State<PostersScreen> {
  bool spinner = true;
  String testedSample = "";
  String newtest = "";
  String cumulative="";
  String  newcasesperday="";
  String recoveriesperday="";
  String newdeathsperday="";
  void getData() async {
    setState(() {
      spinner = true;
    });
    var url =
        'https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_India';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var document = parse(response.body);
      setState(() {
        testedSample = document
            .getElementsByClassName("mw-graph-img")[0]
            .attributes['src'];
        newtest = document
            .getElementsByClassName("mw-graph-img")[1]
            .attributes['src'];
        cumulative =document
            .getElementsByClassName("mw-graph-img")[2]
            .attributes['src'];
        newcasesperday =document
            .getElementsByClassName("mw-graph-img")[3]
            .attributes['src'];
        recoveriesperday =document
            .getElementsByClassName("mw-graph-img")[4]
            .attributes['src'];
        newdeathsperday =document
            .getElementsByClassName("mw-graph-img")[5]
            .attributes['src'];
        spinner = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: screenSize.height,
              width: screenSize.width,
              child: Image.asset(
                "assets/coronavirus1.jpg",
                fit: BoxFit.cover,
              )),
          Column(
            children: <Widget>[
              Container(
                  color: Color.fromRGBO(47, 47, 49, 0.7),
                  height: screenSize.height * .15,
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  child: Text(
                    "Graphs",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.white),
                  )),
              Flexible(
                child: Container(
                  color: Color.fromRGBO(47, 47, 49, 0.7),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          " India ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.white24),
                        ),
                      ),
                      spinner?Center(child: CircularProgressIndicator(),):_listItem("Cumulative Graph", "https://en.wikipedia.org"+cumulative),
                      spinner?Center(child: CircularProgressIndicator(),):_listItem("New cases per day", "https://en.wikipedia.org"+newcasesperday),
                      spinner?Center(child: CircularProgressIndicator(),):_listItem("Deaths", "https://en.wikipedia.org"+newdeathsperday),
                      spinner?Center(child: CircularProgressIndicator(),):_listItem("Recoveries per day", "https://en.wikipedia.org"+recoveriesperday),
                      spinner?Center(child: CircularProgressIndicator(),):_listItem("new test per day", "https://en.wikipedia.org"+newtest),
                      spinner?Center(child: CircularProgressIndicator(),):_listItem("Tested sample per day", "https://en.wikipedia.org"+testedSample),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          " World ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.white24),
                        ),
                      ),
                      _listItem("Confirmed Cases per million", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Total-confirmed-cases-of-covid-19-per-million-people.png/800px-Total-confirmed-cases-of-covid-19-per-million-people.png"),
                     _listItem("Deaths per millon", "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Total-covid-deaths-per-million.png/800px-Total-covid-deaths-per-million.png"),
                      _listItem("Cases vs Deaths", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Covid-19-total-confirmed-cases-vs-total-confirmed-deaths.png/800px-Covid-19-total-confirmed-cases-vs-total-confirmed-deaths.png"),
                     _listItem("Total Confirmed Cases", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Trakectproes-Covid-confirmed-cases-since-100th-case.svg/800px-Trakectproes-Covid-confirmed-cases-since-100th-case.svg.png"),
                      _listItem("New Cases", "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/2020_coronavirus_cases_by_date_of_report.svg/1024px-2020_coronavirus_cases_by_date_of_report.svg.png"),
                      _listItem("Daily new cases of top 5 coun.", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/New_cases_daily_for_Covid-19_in_world_and_top_5_countries_Jan-Mar.png/1024px-New_cases_daily_for_Covid-19_in_world_and_top_5_countries_Jan-Mar.png"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 8,top:19),
        alignment: Alignment.topLeft,
        child: IconButton(icon: Icon(Icons.arrow_back,color:Colors.white,size:30), onPressed:(){
          Navigator.of(context).pop();
        }),
      ),
          )
        ],
      ),
    );
  }

  Widget _listItem(String title, String url) {
    return Container(
        margin: EdgeInsets.only(left: 20, top: 5),
        height: 50,
        child: Material(
          color: Colors.white24,
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return ImageViewer(title: title,url: url,);
                  })
                );
              },
                child: Center(
                    child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )))));
  }
}
