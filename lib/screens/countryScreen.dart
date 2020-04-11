import 'package:flutter/material.dart';
import "../models/model.dart";

class Country extends StatelessWidget {
  final CountryCases cases;
  Country(this.cases);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    String flagUrl = this.flagUrl;
    print(cases.countryName);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                      height: screenSize.height * .3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: screenSize.height * .15,
                                width: screenSize.width * .6,
                                child: FadeInImage.assetNetwork(
                                  placeholderScale:0.1 ,
                                  placeholder: "assets/loader.gif",
                                  image: flagUrl,
                                )),
                            Text(
                              cases.countryName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 10),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Colors.white, size: 30),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              ),
            ),
            Container(
              child: Container(
                height: screenSize.height * .65,
                width: screenSize.width * .9,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Infected",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            cases.totalCases,
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Divider(),
                      _row(context, ["Active Cases", "New Cases"],
                          [cases.activeCases, cases.newCases]),
                      Divider(),
                      _row(context, ["Deaths", "New Deaths"],
                          [cases.totalDeaths, cases.newDeaths]),
                      Divider(),
                      _row(context, ["Serious Cases", "Recovered"],
                          [cases.seriousCases, cases.totalRecovered]),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, List<String> title, List<String> value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              title[0],
              style: TextStyle(fontSize: 20),
            ),
            Text(
              value[0] == "" ? "NA" : value[0],
              style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25,color:(title[0]=="Deaths")?Colors.red:(title[0]=="Serious Cases")?Colors.red:Colors.black)),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              title[1],
              style: TextStyle(fontSize: 20),
            ),
            Text(
              value[1] == "" ? "NA" : value[1],
              style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25,color: (title[1]=="New Deaths")?Colors.red:(title[1]=="Recovered")?Colors.green:Colors.black),
            )
          ],
        ),
      ],
    );
  }

  get flagUrl {
    String flagName = "";
    String _flagUrl = "";
    if (cases.countryName == "USA") {
      flagName = "united-states-of-america";
    } else if (cases.countryName == "UK") {
      flagName = "united-kingdom";
    } else if (cases.countryName == "S. Korea") {
      flagName = "south-korea";
    } else if (cases.countryName == "Réunion" ||
        cases.countryName == "Mayotte" ||
        cases.countryName == "French Guiana" ||
        cases.countryName == "New Caledonia" ||
        cases.countryName == "Saint Martin" ||
        cases.countryName == "St. Barth") {
      flagName = "france";
    } else if (cases.countryName == "St. Vincent Grenadines") {
      flagName = "saint-vincent-and-the-grenadines";
    } else if (cases.countryName == "Czechia") {
      flagName = "czech-republic";
    } else if (cases.countryName == "North Macedonia") {
      flagName = "macedonia";
    } else if (cases.countryName.split(" ").length == 1) {
      flagName = cases.countryName.toLowerCase();
    } else if (cases.countryName.split(" ").length > 1) {
      flagName = cases.countryName.toLowerCase().replaceAll(" ", "-");
    }

    _flagUrl = (cases.countryName == "Diamond Princess")
        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Diamond_Princess_%28ship%2C_2004%29_-_cropped.jpg/300px-Diamond_Princess_%28ship%2C_2004%29_-_cropped.jpg"
        : (cases.countryName == "Timor-Leste")
            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Flag_of_East_Timor.svg/125px-Flag_of_East_Timor.svg.png"
            : (cases.countryName == "British Virgin Islands")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Flag_of_the_British_Virgin_Islands.svg/153px-Flag_of_the_British_Virgin_Islands.svg.png"
                : (cases.countryName == "CAR")
                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Central_African_Republic.svg/255px-Flag_of_the_Central_African_Republic.svg.png"
                    : (cases.countryName == "Greenland")
                        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_Greenland.svg/255px-Flag_of_Greenland.svg.png"
                        : (cases.countryName == "Bermuda")
                            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bermuda.svg/255px-Flag_of_Bermuda.svg.png"
                            : (cases.countryName == "Chad")
                                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag_of_Chad.svg/255px-Flag_of_Chad.svg.png"
                                : (cases.countryName == "French Polynesia")
                                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Flag_of_French_Polynesia.svg/250px-Flag_of_French_Polynesia.svg.png"
                                    : (cases.countryName == "Macao")
                                        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Flag_of_Macau.svg/255px-Flag_of_Macau.svg.png"
                                        : (cases.countryName == "Aruba")
                                            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Aruba.svg/250px-Flag_of_Aruba.svg.png"
                                            : (cases.countryName == "Gibraltar")
                                                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Flag_of_Gibraltar.svg/255px-Flag_of_Gibraltar.svg.png"
                                                : (cases.countryName ==
                                                        "Brunei")
                                                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Brunei.svg/255px-Flag_of_Brunei.svg.png"
                                                    : (cases.countryName ==
                                                            "Curaçao")
                                                        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_Cura%C3%A7ao.svg/250px-Flag_of_Cura%C3%A7ao.svg.png"
                                                        : (cases.countryName ==
                                                                "World")
                                                            ?"https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/COVID-19_Outbreak_World_Map_per_Capita.svg/330px-COVID-19_Outbreak_World_Map_per_Capita.svg.png"
                                                        : (cases.countryName ==
                                                                "Sint Maarten")
                                                            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Sint_Maarten.svg/250px-Flag_of_Sint_Maarten.svg.png"
                                                            : (cases.countryName ==
                                                                    "MS Zaandam")
                                                                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/MS_Zaandam.JPG/300px-MS_Zaandam.JPG"
                                                                : (cases.countryName ==
                                                                        "Anguilla")
                                                                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Anguilla.svg/250px-Flag_of_Anguilla.svg.png"
                                                                    : (cases.countryName ==
                                                                            "Isle of Man")
                                                                        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Flag_of_the_Isle_of_Mann.svg/320px-Flag_of_the_Isle_of_Mann.svg.png"
                                                                        : (cases.countryName ==
                                                                                "DRC")
                                                                            ? "https://cdn.countryflags.com/thumbs/congo-democratic-republic-of-the/flag-800.png"
                                                                            : (cases.countryName == "UAE")
                                                                                ? "https://cdn.countryflags.com/thumbs/united-arab-emirates/flag-800.png"
                                                                                : (cases.countryName == "Congo") ? "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_the_Republic_of_the_Congo.svg/255px-Flag_of_the_Republic_of_the_Congo.svg.png" : (cases.countryName == "Cabo Verde") ? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Flag_of_Cape_Verde_%282-3_ratio%29.svg/255px-Flag_of_Cape_Verde_%282-3_ratio%29.svg.png" : (cases.countryName == "Montserrat") ? "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Montserrat.svg/250px-Flag_of_Montserrat.svg.png" : (cases.countryName == "Hong Kong") ? "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Flag_of_Hong_Kong.svg/125px-Flag_of_Hong_Kong.svg.png" : (cases.countryName == "Faeroe Islands") ? "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Flag_of_the_Faroe_Islands.svg/320px-Flag_of_the_Faroe_Islands.svg.png" : (cases.countryName == "Channel Islands") ? "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Channel_Islands_by_Sentinel-2.jpg/260px-Channel_Islands_by_Sentinel-2.jpg" : "https://cdn.countryflags.com/thumbs/$flagName/flag-400.png";
    return _flagUrl;
  }
}
