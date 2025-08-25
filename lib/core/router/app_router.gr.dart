// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [UserDetailPage]
class UserDetailRoute extends PageRouteInfo<UserDetailRouteArgs> {
  UserDetailRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          UserDetailRoute.name,
          args: UserDetailRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'UserDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<UserDetailRouteArgs>(
          orElse: () => UserDetailRouteArgs(userId: pathParams.getInt('id')));
      return UserDetailPage(
        key: args.key,
        userId: args.userId,
      );
    },
  );
}

class UserDetailRouteArgs {
  const UserDetailRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserDetailRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [UsersListPage]
class UsersListRoute extends PageRouteInfo<void> {
  const UsersListRoute({List<PageRouteInfo>? children})
      : super(
          UsersListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UsersListPage();
    },
  );
}
