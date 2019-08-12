import 'package:shared_preferences/shared_preferences.dart';

import 'WebModel.dart';

const String SP_KEY_POETRY_TOKEN = "peotryTOKEN";

getPoetryToken() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString(SP_KEY_POETRY_TOKEN);
  if (token == null) {
    print("Empty");
    var poetryTokenResponse = await getPoetryTokenFromWeb();
    token = poetryTokenResponse.data["data"];
    prefs.setString(SP_KEY_POETRY_TOKEN, token);
  }
  return token;
}
