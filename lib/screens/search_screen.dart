import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_productos/widgets/bottom_bar.dart';
import 'package:mis_productos/widgets/store_disges.dart';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<Map<String, dynamic>>? _searchResults;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchResults = _fetchSearchResults();
  }

  Future<Map<String, dynamic>> _fetchSearchResults() async {
    final response = await http.get(Uri.https("atumesa-83fd8-default-rtdb.firebaseio.com", '/Comida.json'));
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load search results');
    }
  }

  void _onSearchChanged() {
    setState(() {
      _query = _searchController.text.toLowerCase();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateToHome(context);
        return false; // Prevent the default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Results'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _navigateToHome(context);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (text) => _onSearchChanged(),
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _searchResults,
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No results found'),
                    );
                  } else {
                    final filteredResults = snapshot.data!.entries.where((entry) {
                      final dishName = entry.value['name'].toString().toLowerCase();
                      return dishName.contains(_query);
                    });

                    final resultsMap = Map<String, dynamic>.fromEntries(filteredResults);

                    return StoreDishes(resultsMap);
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(
          selectedIndex: 1,
          onTabSelected: (index) {
            if (index == 0) {
              _navigateToHome(context);
            } else if (index == 1) {
              Navigator.pushNamed(context, '/search');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/shopping_cart');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/admin');
            }
          },
        ),
      ),
    );
  }
}
