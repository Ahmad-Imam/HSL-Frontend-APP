import 'package:flutter/material.dart';
import 'package:hsl_frontend_app/JourneyListPaginated.dart';
import 'package:hsl_frontend_app/StationList.dart';
import 'package:hsl_frontend_app/single_station_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StationScrollScreen extends StatefulWidget {
  @override
  _StationScrollScreenState createState() => _StationScrollScreenState();
}

class _StationScrollScreenState extends State<StationScrollScreen> {
  ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;
  bool _isLoading = false;
  List<FinalStationList> _items = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse('http://hsl-backend-app.herokuapp.com/StationList');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({'pageNumber': _pageNumber});

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final apiResponse = StationList.fromJson(json.decode(response.body));
        setState(() {
          _items.addAll(apiResponse.finalStationList);
          _pageNumber++;
          _isLoading = false;
        });
      } else {
        // Handle API error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Error fetching data from API with response code ${response.statusCode}Exit to return to previous page'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Exit',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
      }
    }
  }

  bool scrollTop = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Station List'),
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
                "Name",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "Adress",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "Kapasiteet",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "Operaattor",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _items.length,
              shrinkWrap: true,
              clipBehavior: Clip.antiAlias,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('ok');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationSingleView(
                                station: _items[index],
                              ),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: Container(
                            width: 60,
                            child: Text(
                              _items[index].Name,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          Flexible(
                              child: Container(
                            width: 60,
                            child: Text(
                              _items[index].Adress,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          Flexible(
                              child: Text(
                            _items[index].Kapasiteet,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Flexible(
                              child: Text(
                            _items[index].Operaattor,
                            overflow: TextOverflow.ellipsis,
                          )),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                );
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
