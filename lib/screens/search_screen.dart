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
    _searchController.addListener(_onSearchChanged);
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
    Navigator.of(context).pushNamedAndRemoveUntil('/store', (Route<dynamic> route) => false);
  }

  void _handleTabSelection(int index) {
    if (index != 1) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        index == 0 ? '/store' : index == 2 ? '/shopping_cart' : '/admin',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _navigateToHome(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/logo.png', // Asegúrate de que el archivo logo.png esté en assets/images
              width: 100,
              height: 100,
            ),
          ),
        ],
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
        onTabSelected: _handleTabSelection,
      ),
    );
  }
}
