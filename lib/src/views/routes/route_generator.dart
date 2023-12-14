import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_admin/src/views/auth_views/login_view.dart';
import 'package:pos_admin/src/views/auth_views/splash_screen.dart';
import 'package:pos_admin/src/views/home_views/all_users_list_view.dart';
import 'package:pos_admin/src/views/home_views/list_users_view.dart';
import 'package:pos_admin/src/views/home_views/users_history_list.dart';
import 'package:pos_admin/src/views/route_view/user_location_timeline_view.dart';
import 'package:pos_admin/src/views/routes/route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.SPLASH_PAGE:
        return _GeneratePageRoute(
            widget: SplashScreenView(), routeName: settings.name);
      case RoutesName.HOME_PAGE:
        return _GeneratePageRoute(
            widget: UserListScreen(), routeName: settings.name);
      case RoutesName.SIGN_IN_PAGE:
        return _GeneratePageRoute(
            widget: SignINView(), routeName: settings.name);

      case RoutesName.USER_TIMELINE:
        Map args = settings.arguments as Map;
        print(args);
        return _GeneratePageRoute(
            widget: UserLocationTimeLineView(
              username: args['username'],
              dateTime: args['dateTime'],
              startLocation: args['startLocation'],
            ),
            routeName: settings.name);

      case RoutesName.USER_HISTORY_PAGE:
        Map args = settings.arguments as Map;
        return _GeneratePageRoute(
            widget: UserHistorys(
              userName: args['userName'],
            ),
            routeName: settings.name);

      default:
        return _GeneratePageRoute(
              widget: AllUsersView(), routeName: settings.name);
    }
  }
} // Navigator.pushNamed(context, RoutesName.name);

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                key: UniqueKey(),
                opacity: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(animation),
                child: child,
              );
            });
}
