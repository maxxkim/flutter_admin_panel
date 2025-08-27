import 'package:auto_route/auto_route.dart';
import 'package:clean_arch_app/core/router/app_router.gr.dart';


@AutoRouterConfig()
class AdminRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    /* логин страница
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ), */
    
    // основной shell с сайдбаром
    AutoRoute(
      page: AdminShellRoute.page,
      path: '/',
      initial: true,
      children: [
        // дашборд
        AutoRoute(
          page: DashboardRoute.page,
          path: 'dashboard',
          initial: true,
        ),
        
        // юзеры
        AutoRoute(
          page: UsersListRoute.page,
          path: 'users',
        ),
        AutoRoute(
          page: UserDetailRoute.page,
          path: 'users/:id',
        ),
        
        /* чеки 
        AutoRoute(
          page: ChecksListRoute.page,
          path: 'checks',
        ),
        
        // бонусы
        AutoRoute(
          page: BonusesListRoute.page,
          path: 'bonuses',
        ),
        
        // операции
        AutoRoute(
          page: OperationsListRoute.page,
          path: 'operations',
        ),
        
        // магазины
        AutoRoute(
          page: ShopsListRoute.page,
          path: 'shops',
        ),
        
        // пуши
        AutoRoute(
          page: PushListRoute.page,
          path: 'push',
        ),
        
        // настройки
        AutoRoute(
          page: SettingsRoute.page,
          path: 'settings',
        ), */
      ],
    ),
  ];
  
  // guard для проверки авторизации
  @override
  late final List<AutoRouteGuard> guards = [
    AuthGuard(),
  ];
}

// Guard для проверки авторизации
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // тут будем проверять токен из стейта
    // пока просто пропускаем
    resolver.next(true);
  }
}