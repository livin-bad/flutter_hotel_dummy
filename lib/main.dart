import 'package:dummy/dummy_data.dart';
import 'package:dummy/screens/categories_screen.dart';
import 'package:dummy/screens/filter_screen.dart';
import 'package:dummy/screens/meal_detail_screen.dart';
import 'package:dummy/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';
import 'screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals =[];

  void _setFilters(Map<String, bool> filterData) {
    print('filter function');
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        //...
        bool? gluten = _filters['gluten'] ;
        bool? lactose = _filters['lactose'] ;
        bool? vegan = _filters['vegan'] ;
        bool? vegetarian = _filters['vegetarian'] ;

        if (gluten! && (!meal.isGlutenFree)) {
          return false;
        }

        if (lactose! && !meal.isLactoseFree) {
          return false;
        }

        if (vegan! && !meal.isVegan) {
          return false;
        }

        if (vegetarian! && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoritedMeals.indexWhere((meal)=>meal.id==mealId);

    if(existingIndex>=0){
      setState((){
        _favoritedMeals.removeAt(existingIndex);
      });
    }else{
      setState((){
        _favoritedMeals.add(DUMMY_MEALS.firstWhere((element) => element.id==mealId));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoritedMeals.any((meal)=>meal.id==id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 299, 1),
        fontFamily: 'Ralway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              subtitle1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoritedMeals),
        '/category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters,_setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
