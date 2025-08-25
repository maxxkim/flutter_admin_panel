import 'package:auto_route/auto_route.dart';
import 'package:clean_arch_app/features/users/presentation/pages/user_detail_page.dart';
import 'package:clean_arch_app/features/users/presentation/pages/user_list_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: UsersListRoute.page, initial: true),
    AutoRoute(page: UserDetailRoute.page),
  ];
}