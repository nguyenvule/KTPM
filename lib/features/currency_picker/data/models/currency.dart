import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
class Currency with _$Currency {
  const factory Currency({
    required String symbol,
    required String name,
    @JsonKey(name: 'decimal_digits') required int decimalDigits,
    required double rounding,
    @JsonKey(name: 'iso_code') required String isoCode,
    @JsonKey(name: 'name_plural') required String namePlural,
    required String country,
    @JsonKey(name: 'country_code') required String countryCode,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
}

// Chỉ giữ lại VND
const Currency vndCurrency = Currency(
  symbol: '₫',
  name: 'Vietnamese Dong',
  decimalDigits: 0,
  rounding: 0,
  isoCode: 'VND',
  namePlural: 'Vietnamese dong',
  country: 'Vietnam',
  countryCode: 'VN',
);

// Nếu có danh sách currency mặc định, chỉ chứa VND:
final List<Currency> defaultCurrencies = [vndCurrency];

extension CurrencyUtils on List<Currency> {
  Currency? fromIsoCode(String code) {
    return firstWhereOrNull((currency) => currency.isoCode == code);
  }
}