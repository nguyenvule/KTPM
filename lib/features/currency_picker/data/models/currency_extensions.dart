import 'package:country_flags/country_flags.dart';
import 'package:moneynest/features/currency_picker/data/models/currency.dart';

extension CurrencyExtensions on Currency {
  CountryFlag get flag => CountryFlag.fromCountryCode(countryCode);
}
