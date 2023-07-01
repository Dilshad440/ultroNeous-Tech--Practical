import 'package:flutter/material.dart';
import 'package:ultroneous_practical/screen/favourite_screen.dart';
import 'package:ultroneous_practical/screen/user_screen.dart';

enum ApiState { loading, loaded, error }

class GlobalConst {
  static const List<String> tabsLabel = ["All Users", "Favourite"];
  static const List<Widget> tabsScreen = [
    UserScreen(),
    FavouriteScreen(),
  ];
}
