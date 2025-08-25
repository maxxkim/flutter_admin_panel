import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    String? phone,
    String? website,
    Address? address,
    Company? company,
  }) = _User;
}

@freezed
class Address with _$Address {
  const factory Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    Geo? geo,
  }) = _Address;
}

@freezed
class Geo with _$Geo {
  const factory Geo({
    required String lat,
    required String lng,
  }) = _Geo;
}

@freezed
class Company with _$Company {
  const factory Company({
    required String name,
    required String catchPhrase,
    required String bs,
  }) = _Company;
}