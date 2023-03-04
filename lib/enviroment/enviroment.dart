
import 'dart:io';

class Enviroment{

  static String apiUrl = Platform.isAndroid ? 'http://10.0.2.2:5230/api' : 'http://localhost:5230/api' ; 

}