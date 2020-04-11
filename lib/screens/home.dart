import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import './aboutScreen.dart';
import './inScreen.dart';
import './worldScreen.dart';
import '../screens/posterScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool networkError=false;
  bool spinner = true;
  String totalCases = "";
  String totalDeaths = "";
  String totalRecovered = "";

  getdata() async {
    setState(() {
      spinner = true;
      networkError=false;
    });
    try{
    var url = 'https://www.worldometers.info/coronavirus/';
    var response = await http.get(url);
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var document = parse(response.body);
      setState(() {
        totalCases = document
            .getElementsByClassName("maincounter-number")[0]
            .children[0]
            .firstChild
            .text;
        totalDeaths = document
            .getElementsByClassName("maincounter-number")[1]
            .children[0]
            .firstChild
            .text;
        totalRecovered = document
            .getElementsByClassName("maincounter-number")[2]
            .children[0]
            .firstChild
            .text;
        spinner = false;
      });
    }
    }
    catch(e){
      setState(() {
        networkError=true;
      });
    }
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
        Container(
            height: screenSize.height,
            width: screenSize.width,
            child: Image.asset(
              "assets/coronavirus1.jpg",
              fit: BoxFit.cover,
            )),
        SafeArea(
          child: Column(children: [
            Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  "COVID-19",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 44,
                      color: Colors.white),
                )),
            Container(
              width: screenSize.width * .9,
              height: screenSize.height * .35,
              child: Stack(
                children: <Widget>[
                  Card(
                      elevation: 20,
                      color: Color.fromRGBO(57, 57, 59, 0.9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: networkError?Center(child: Text("No Internet Connection !!",style: TextStyle(color:Colors.white),),):spinner
                          ? Center(child: CircularProgressIndicator())
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Infected",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      totalCases.trim(),
                                      style: TextStyle(
                                          fontSize: 40, color: Colors.lightBlue),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Deaths",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          totalDeaths,
                                          style: TextStyle(
                                              fontSize: 30, color: Colors.red),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Recovered",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          totalRecovered,
                                          style: TextStyle(
                                              fontSize: 30, color: Colors.green),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),
                          Container(alignment: Alignment.topRight,child:FlatButton(child: Text("Refresh",style:TextStyle(color:Colors.white)), onPressed: (){getdata();}))
                ],
              ),
            ),
            Flexible(
                child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              children: <Widget>[
                _gridItem(context, "assets/symptoms.jpg","Information",(){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return About();
                }));
                }),
                _gridItem(context, "assets/poster.jpg","Posters",(){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return PostersScreen();}));
                }),
                _gridItem(context, "assets/india.jpg","India",(){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return IndiaCases();
                }));}),
                _gridItem(context, "assets/world.jpg","World",(){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return WorldScreen();
                  }));
                }),
              ],
            ))
          ]),
        ),
        SafeArea(
          child: Column(children: [
            Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.topRight,
                child:IconButton(icon: Icon(Icons.info_outline,color:Colors.white,size:30), onPressed:null) ),]))
      ],
    ));
  }

  Widget _gridItem(BuildContext context, String imageAsset,String title,Function onTap) {
    return Container(
        child: Material(
      color: Colors.transparent,
      elevation: 20,
      child: LayoutBuilder(builder: (context, constatraints) {
        return GestureDetector(
          onTap: onTap,
          child: Stack(children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: constatraints.maxHeight,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                    ))),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: constatraints.maxHeight * .3,
                width: constatraints.maxHeight,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Center(child: Text(title,style: TextStyle(color: Colors.white,fontSize:20),)),
              ),
            )
          ]),
        );
      }),
    ));
  }
}
