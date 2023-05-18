import 'package:flutter/material.dart';
import 'package:hsl_frontend_app/JourneyListPaginated.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class ApiResponse {
//   List<Item> items;

//   ApiResponse({required this.items});

//   factory ApiResponse.fromJson(Map<String, dynamic> json) {
//     return ApiResponse(
//       items: (json['items'] as List)
//           .map((itemJson) => Item.fromJson(itemJson))
//           .toList(),
//     );
//   }
// }

// class Item {
//   final String title;

//   Item({required this.title});

//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       title: json['title'],
//     );
//   }
// }

class ScrollScreen extends StatefulWidget {
  @override
  _ScrollScreenState createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;
  bool _isLoading = false;
  List<FinalJourneyList> _items = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse('http://192.168.31.109:8080/JourneyListByPage');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({'pageNumber': _pageNumber});

      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final apiResponse =
            AutoGenerateJourney.fromJson(json.decode(response.body));
        setState(() {
          _items.addAll(apiResponse.finalJourneyList);
          _pageNumber++;
          _isLoading = false;
        });
      } else {
        // Handle API error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Scroll Demo'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Departure Station",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                "Return Station",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Covered Distance (KM)",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Duration(M))",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _items.length + 1,
              shrinkWrap: true,
              clipBehavior: Clip.antiAlias,
              itemBuilder: (context, index) {
                if (index < _items.length) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(_items[index].departureStationName),
                      Text(_items[index].returnStationName),
                      Text(_items[index].coverDistance),
                      Text(_items[index].duration),
                    ],
                  );
                } else {
                  return _buildProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
