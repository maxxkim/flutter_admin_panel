import 'package:clean_arch_app/features/users/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  
  const factory UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
    String? phone,
    String? website,
    AddressModel? address,
    CompanyModel? company,
  }) = _UserModel;
  
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  
  User toEntity() => User(
    id: id,
    name: name,
    username: username,
    email: email,
    phone: phone,
    website: website,
    address: address?.toEntity(),
    company: company?.toEntity(),
  );
}

@freezed
class AddressModel with _$AddressModel {
  const AddressModel._();
  
  const factory AddressModel({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    GeoModel? geo,
  }) = _AddressModel;
  
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  
  Address toEntity() => Address(
    street: street,
    suite: suite,
    city: city,
    zipcode: zipcode,
    geo: geo?.toEntity(),
  );
}

@freezed
class GeoModel with _$GeoModel {
  const GeoModel._();
  
  const factory GeoModel({
    required String lat,
    required String lng,
  }) = _GeoModel;
  
  factory GeoModel.fromJson(Map<String, dynamic> json) =>
      _$GeoModelFromJson(json);
  
  Geo toEntity() => Geo(lat: lat, lng: lng);
}

@freezed
class CompanyModel with _$CompanyModel {
  const CompanyModel._();
  
  const factory CompanyModel({
    required String name,
    required String catchPhrase,
    required String bs,
  }) = _CompanyModel;
  
  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
  
  Company toEntity() => Company(
    name: name,
    catchPhrase: catchPhrase,
    bs: bs,
  );
}