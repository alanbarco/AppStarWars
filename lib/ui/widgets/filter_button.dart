import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../infraestructure/providers/filter_provider.dart';

class FilterButton extends StatefulWidget {
  FilterButton();

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final List<String> filters = ['Todos', 'Masculino', 'Femenino', 'Sin datos'];

  @override
  Widget build(BuildContext context) {
    var filterProvider = Provider.of<FilterProvider>(context);
    return DropdownButton<String>(
      value: filterProvider.value, 
    items: filters.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String? newValue){
      setState((){
        filterProvider.setFilter(newValue!);
      });
    });
  }
}