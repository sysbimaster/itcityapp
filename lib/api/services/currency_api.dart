import 'package:http/http.dart';
import 'package:itcity_online_store/api/models/Currency.dart';
import 'dart:convert';

import '../api_client.dart';

class CurrencyApi {
  ApiClient _apiclient = ApiClient();
  String _currencyChangeApi = 'https://api.currencylayer.com/convert?access_key=3917078f11ba5a7adfdde6c9c37c26db';

  Future<Currency> getChangedCurrency(String currency,String? currencyToChange,var price) async {
    String url = '$_currencyChangeApi&from=$currency&to=$currencyToChange&amount=$price';
    print(url);
    Response response =await get(Uri.parse(url),);
    print(response.body.toString());
    return Currency.fromJson(jsonDecode(response.body));
  }

}