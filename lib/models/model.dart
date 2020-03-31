class CountryCases {
  final String countryName;
  final String totalCases;
  final String totalDeaths;
  final String newCases;
  final String newDeaths;
  final String totalRecovered;
  final String activeCases;
  final String seriousCases;
  CountryCases(
      {this.countryName,
      this.activeCases,
      this.newCases,
      this.newDeaths,
      this.seriousCases,
      this.totalCases,
      this.totalDeaths,
      this.totalRecovered});
}

class StateCases{
  final String stateName;
  final String totalCases;
  final String totalDeaths;
  final String totalRecovered;
  StateCases({this.stateName,this.totalCases,this.totalDeaths,this.totalRecovered});
}
