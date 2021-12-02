import 'package:dummy/models/meal.dart';
import 'package:dummy/screens/categories_screen.dart';
import 'package:dummy/screens/favorites_screen.dart';
import 'package:dummy/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals) ;

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

   late List<Widget> _pages;
  int selectedPageIndex = 0;

  void _selectPage(int index){
    setState((){
      selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages=[
      CategoriesScreen(),
      FavoritesScreen(widget.favoriteMeals)
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
        // bottom: TabBar(tabs: [
        //   Tab(icon: Icon(Icons.category), text: 'Categories'),
        //   Tab(icon: Icon(Icons.star), text: 'Favorites'),
        // ]),
      ),
      drawer: MainDrawer(),
      body: _pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap:_selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text('Categories'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text('Favorites'),
            )
          ]),
    );
  }
}
