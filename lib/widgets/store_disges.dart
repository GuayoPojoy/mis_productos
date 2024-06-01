import 'package:flutter/material.dart';
import 'package:mis_productos/models/dish.dart';
import 'package:mis_productos/widgets/custom_dish.dart';

class StoreDishes extends StatelessWidget {
  final Map<String, dynamic>? data;

  const StoreDishes(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return Center(child: Text('No data available'));
    }

    List<Dish> dishes = data!.entries.map((entry) {
      return Dish.fromJson(entry.value);
    }).toList();

    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];
        return CustomDish(dish: dish);
      },
    );
  }
}
