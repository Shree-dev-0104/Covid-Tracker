import 'package:demo_app/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases,
      totalDeaths,
      totalReccovered,
      active,
      critical,
      todayRecovered,
      test;

  const DetailsScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalReccovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name.toUpperCase()),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:  EdgeInsets.only( top: MediaQuery.of(context).size.height * .06),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'Recovered', value: widget.totalReccovered.toString()),
                        ReusableRow(title: 'Death', value: widget.totalDeaths.toString()),
                        ReusableRow(title: "Today's Recovered", value: widget.todayRecovered.toString()),
                        ReusableRow(title: 'Critical', value: widget.critical.toString()),
                  
                      ],
                    ),
                    
                  ),
                ),
                Hero(
                  tag: 'Dash',
                  child: Image(image: NetworkImage(widget.image),
                  width: 80,
                  height: 80,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      ),
    );
  }
}
