import 'package:demo_app/Services/stats_services.dart';
import 'package:demo_app/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  final TextEditingController _serachCountry = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,
                vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      
                    });
                  },
                  controller: _serachCountry, 
                  decoration: InputDecoration(
                    hintText: 'Search Country',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                    )
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(future: fetchCountries(), builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                 if (snapshot.hasData)
                 {
                   return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      String name = snapshot.data![index]['country'].toString();

                    if (_serachCountry.text.isEmpty) 
                    {
                      return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return  DetailsScreen(
                                name : snapshot.data![index]['country'].toString(),
                                image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                totalReccovered: snapshot.data![index]['recovered'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                active: snapshot.data![index]['active'],
                                critical: snapshot.data![index]['critical'],
                                test: snapshot.data![index]['tests'],

                              );
                            }));
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country'].toString()),
                            subtitle:Text(snapshot.data![index]['cases'].toString()),
                            leading: Image(
                              width: 50,
                              height: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString())),
                          ),
                        ),
                      ],
                    );
                    }
                    else if(name.toLowerCase().contains(_serachCountry.text.toLowerCase()))
                    
                    {
                      return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return  DetailsScreen(
                                name : snapshot.data![index]['country'].toString(),
                                image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                totalReccovered: snapshot.data![index]['recovered'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                active: snapshot.data![index]['active'],
                                critical: snapshot.data![index]['critical'],
                                test: snapshot.data![index]['tests'],

                              );
                            }));
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country'].toString()),
                            subtitle:Text(snapshot.data![index]['cases'].toString()),
                            leading: Hero(
                              tag: 'Dash',
                              child: Image(
                                width: 50,
                                height: 50,
                                
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString())),
                            ),
                          ),
                        ),
                      ],
                    );
                    }
                    else{
                      return Container();
                    }
                  });
                 }
                 else 
                 {
                  return ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors( baseColor: Colors.grey.shade700, highlightColor: Colors.grey.shade100, child: ListTile(
                        title: Container(height: 10, width: 80, color: Colors.white,),
                        subtitle: Container(height: 10, width: 80, color: Colors.white,),
                        leading: Container(height: 50, width: 50, color: Colors.white),
                      ),);
                  });
                 }
                }),
              )
          ],
      ),
    ),
    );
  }
}