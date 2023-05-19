import 'package:flutter/material.dart';
import 'package:hsl_frontend_app/JourneyListPaginated.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JourneyScrollScreen extends StatefulWidget {
  @override
  _JourneyScrollScreenState createState() => _JourneyScrollScreenState();
}

class _JourneyScrollScreenState extends State<JourneyScrollScreen> {
  ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;
  bool _isLoading = false;
  List<FinalJourneyList> journeyItems = [];

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
          journeyItems.addAll(apiResponse.finalJourneyList);
          _pageNumber++;
          _isLoading = false;
        });
      } else {
        // Handle API error
      }
    }
  }

  bool scrollTop = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journey List'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Row(
              children: [
                scrollTop
                    ? const Text(
                        "Start ",
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        "End ",
                        style: TextStyle(color: Colors.white),
                      ),
                scrollTop
                    ? const Icon(
                        Icons.arrow_circle_up,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.arrow_circle_down,
                        color: Colors.white,
                      ),
              ],
            ),
            onPressed: () {
              if (scrollTop) {
                _scrollController.jumpTo(0);
                setState(() {
                  scrollTop = false;
                });
              } else {
                setState(() {
                  scrollTop = true;
                });

                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              }
            },
          )
        ],
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
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                "Distance (KM)",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                "Duration(M))",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: journeyItems.length + 1,
              shrinkWrap: true,
              clipBehavior: Clip.antiAlias,
              itemBuilder: (context, index) {
                if (index < journeyItems.length) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: Container(
                            width: 70,
                            child: Text(
                              journeyItems[index].departureStationName,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          Flexible(
                              child: Container(
                            width: 70,
                            child: Text(
                              journeyItems[index].returnStationName,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          Flexible(
                              child: Container(
                            child: Text(
                              journeyItems[index].coverDistance,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          Flexible(
                              child: Container(
                            child: Text(
                              journeyItems[index].duration,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Divider(
                        height: 5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
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
