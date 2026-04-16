import 'package:flutter/material.dart';

import '../core/remote/local/prefs_manager.dart';

//  { publisher }
//  { observer  }
class ThemeProvider extends ChangeNotifier {
 late ThemeMode mode;

  void init(){
    mode = PrefsManager.getTheme();
  }

 void changhMode(ThemeMode mode){
   if(this.mode==mode) return;
   this.mode = mode;
   PrefsManager.saveTheme(mode);
   notifyListeners(); // notify all listeners (rebuilder)
 }
}