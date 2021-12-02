import 'package:dummy/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

typedef void MyCallBack(Map<String, bool> filterData);

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilters, {Key? key})
      : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool? _glutenFree = false;
  bool? _vegetarian = false;
  bool? _vegan = false;
  bool? _lactoseFree = false;

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, ValueChanged<bool>? updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  void initState() {
     _glutenFree = widget.currentFilters['gluten'];
     _vegetarian = widget.currentFilters['lactose'];
     _vegan = widget.currentFilters['vegan'];
     _lactoseFree = widget.currentFilters['vegetarian'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _vegetarian,
                'vegan': _vegan,
                'vegetarian': _lactoseFree,
              };

              widget.saveFilters();
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                    'Gluten-free', 'Only include gluten-free', _glutenFree!,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Only include gluten-free', _vegetarian!,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTile('Vegan', 'Only include vegan-free', _vegan!,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile('LactoseFree',
                    'Only include lactoseFree-free', _lactoseFree!, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
