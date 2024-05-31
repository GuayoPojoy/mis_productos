import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_productos/screens/search_screen.dart';
import 'package:mis_productos/widgets/bottom_bar.dart';
import 'package:mis_productos/widgets/hero.dart';
import 'package:mis_productos/widgets/store_disges.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Future<Map<String, dynamic>> _fetchData() async {
    final String _baseUrl = "atumesa-83fd8-default-rtdb.firebaseio.com";
    final response = await http.get(Uri.https(_baseUrl, '/Comida.json'));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFC),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return _getBody(_selectedIndex, snapshot.data);
          }
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _navigateToScreen(context, index);
        },
      ),
    );
  }

  Widget _getBody(int index, Map<String, dynamic>? data) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            children: [
              const CustomHero(),
              const SizedBox(height: 16),
              const SizedBox(height: 32),
              StoreDishes(data), // Pasamos los datos obtenidos de Firebase a StoreDishes
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      case 1:
        return const SearchScreen();
      default:
        return Container();
    }
  }

  void _navigateToScreen(BuildContext context, int index) {
    String routeName = '';
    switch (index) {
      case 0:
        routeName = '/shop';
        break;
      case 1:
        routeName = '/search';
        break;
      case 2:
        routeName = '/shopping_cart';
        break;
      case 3:
        routeName = '/admin';
        break;
      default:
        routeName = '/shop';
        break;
    }
    Navigator.pushNamed(context, routeName);
  }
}
