import 'dart:convert';

import 'package:demo_app/Modal/world_stats_modal.dart';
import 'package:demo_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

Future<WorldStatsModal> fetchStats () async
{
  final response = await http.get(
    Uri.parse(AppUrl.worldStatsApi)
  );

  var data = jsonDecode(response.body);

  if (response.statusCode == 200)
  { 
    return WorldStatsModal.fromJson(data);
  }
  else 
  {
    throw Exception('Error');
  }
}

Future<List<dynamic>> fetchCountries () async
{
  final response = await http.get(
    Uri.parse(AppUrl.countriesList)
  );

  var data = jsonDecode(response.body);

  if (response.statusCode == 200)
  { 
    return data;
  }
  else 
  {
    throw Exception('Error');
  }
}