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
  );
  
  @override
  // TODO: implement email
  String get email => throw UnimplementedError();
  
  @override
  // TODO: implement id
  int get id => throw UnimplementedError();
  
  @override
  // TODO: implement name
  String get name => throw UnimplementedError();
  
  @override
  // TODO: implement phone
  String? get phone => throw UnimplementedError();
  
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement username
  String get username => throw UnimplementedError();
  
  @override
  // TODO: implement website
  String? get website => throw UnimplementedError();
}

