// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:clean_arch_app/features/users/presentation/pages/admin_shell_page.dart'
    as _i1;
import 'package:clean_arch_app/features/users/presentation/pages/dashboard_page.dart'
    as _i2;
import 'package:clean_arch_app/features/users/presentation/pages/user_detail_page.dart'
    as _i3;
import 'package:clean_arch_app/features/users/presentation/pages/user_list_page.dart'
    as _i4;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.AdminShellPage]
class AdminShellRoute extends _i5.PageRouteInfo<void> {
  const AdminShellRoute({List<_i5.PageRouteInfo>? children})
      : super(AdminShellRoute.name, initialChildren: children);

  static const String name = 'AdminShellRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.AdminShellPage();
    },
  );
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute({List<_i5.PageRouteInfo>? children})
      : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardPage();
    },
  );
}

/// generated route for
/// [_i3.UserDetailPage]
class UserDetailRoute extends _i5.PageRouteInfo<UserDetailRouteArgs> {
  UserDetailRoute({
    _i6.Key? key,
    required int userId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          UserDetailRoute.name,
          args: UserDetailRouteArgs(key: key, userId: userId),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'UserDetailRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<UserDetailRouteArgs>(
        orElse: () => UserDetailRouteArgs(userId: pathParams.getInt('id')),
      );
      return _i3.UserDetailPage(key: args.key, userId: args.userId);
    },
  );
}

class UserDetailRouteArgs {
  const UserDetailRouteArgs({this.key, required this.userId});

  final _i6.Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserDetailRouteArgs{key: $key, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserDetailRouteArgs) return false;
    return key == other.key && userId == other.userId;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode;
}

/// generated route for
/// [_i4.UsersListPage]
class UsersListRoute extends _i5.PageRouteInfo<void> {
  const UsersListRoute({List<_i5.PageRouteInfo>? children})
      : super(UsersListRoute.name, initialChildren: children);

  static const String name = 'UsersListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.UsersListPage();
    },
  );
}
