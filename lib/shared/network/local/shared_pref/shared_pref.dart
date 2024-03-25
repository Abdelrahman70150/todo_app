
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static late SharedPreferences pref;

  static Future<void> setTheme (String theme)async{
    await pref.setString("theme",theme);
  }
  static String getTheme (){
    return pref.getString("theme")??'light';
  }

}