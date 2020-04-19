import 'package:flutter/material.dart';
import '../models/model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
class IndiaCases extends StatefulWidget {
  @override
  _IndiaCasesState createState() => _IndiaCasesState();
}

class _IndiaCasesState extends State<IndiaCases> {
  bool spinner = true;
  bool error=false;
  List<StateCases> stateCasesList = [];


 void getdata() async {

    List<StateCases> temp = [];
    setState(() {
      spinner = true;
      error=false;
    });

    var url = 'https://www.mohfw.gov.in/';
    try{
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var document = parse(response.body);
      List<dom.Element> table = document
          .getElementsByClassName("data-table table-responsive")[0]
          .children[0]
          .children[1].children;
      table.removeLast();
      table.removeLast();
      print(table.length);
      table.forEach((tr) {
        List children=tr.children;
        print(children.length);
        if(children.length==5){
        temp.add(StateCases(
            stateName: children[1].text,
            totalCases: children[2].text.trim(),
            totalDeaths: children[4].text.trim(),
            totalRecovered: children[3].text.trim(),
           ));
        }
      });
      temp.sort((a,b)=>int.tryParse(b.totalCases.replaceAll(",", "")).compareTo(int.tryParse(a.totalCases.replaceAll(",", ""))));
      
    }
    }
      catch(e){
        error=true;
        print(e);
      }
      if(mounted){
    setState(() {
        if(!error){
          stateCasesList = temp.toList();
        }
        spinner = false;
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
    final screenSize=MediaQuery.of(context).size;
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
          Container(
            color: Color.fromRGBO(47, 47, 49, 0.9),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      color: Color.fromRGBO(44, 44, 44, 0.9),
                      height: screenSize.height*.15,
                      child: Center(child:Text("Indian State Cases",style: TextStyle(color: Colors.white,fontSize: 25),)),
                    ),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8, left: 10),
                        alignment:Alignment.topLeft,child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,size:30),onPressed: (){
                        Navigator.of(context).pop();
                      },)),
                    )
                  ],
                ),
                Container(
                  color: Color.fromRGBO(44, 44, 44, 0.9),
                  height: screenSize.height*.05,
                  child: Row(
                    children:[
                      Container(
                          padding:const EdgeInsets.all(10),
                          height: 40,
                          width: screenSize.width*.5,
                          child: Text("State",style: TextStyle(color: Colors.white,fontSize: 20),)),
                        Container(width: screenSize.width*.2,child: Text("Cases",style: TextStyle(color: Colors.white,fontSize: 16),)),
                        Container(width: screenSize.width*.15,child: Text("Deaths",style: TextStyle(color: Colors.red,fontSize: 16))),
                        Container(width: screenSize.width*.15,child: Text("Cured",style: TextStyle(color: Colors.green,fontSize: 16)))
                    ]
                  ),
                ),
                Flexible(
                  child: (error)?Center(
                    child: Text("No Internet Connection!!",style: TextStyle(color:Colors.white),),):spinner?Center(child: CircularProgressIndicator(),):ListView.builder(
                    padding: const EdgeInsets.only(top:8),
                    itemCount: stateCasesList.length,
                    itemBuilder: (context,index)=>
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        Container(
                          padding:const EdgeInsets.only(left:10),
                          height: 40,
                          width: screenSize.width*.5,
                          child: Text(stateCasesList[index].stateName,style: TextStyle(fontSize: 17,color: Colors.white),)),
                        Container(padding:const EdgeInsets.only(left:10),width: screenSize.width*.2,child: Text(stateCasesList[index].totalCases,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                        Container(padding:const EdgeInsets.only(left:10),width: screenSize.width*.15,child: Text(stateCasesList[index].totalDeaths,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.red),)),
                        Container(padding:const EdgeInsets.only(left:10),width: screenSize.width*.15,child: Text(stateCasesList[index].totalRecovered,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.green),))
                      ],),
                      )
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
