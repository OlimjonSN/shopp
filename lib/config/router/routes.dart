import 'package:flutter/material.dart';
import 'package:shopp/config/router/unknown_route.dart';
import 'package:shopp/features/auth/presentation/pages/registration_page.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/shopp/presentation/pages/cart_page.dart';
import '../../features/shopp/presentation/pages/home_page.dart';
import '../../features/shopp/presentation/pages/product_page.dart';
import '../../features/shopp/presentation/pages/profile_page.dart';
import '../../features/shopp_admin/presentation/pages/category_admin.dart';
import '../../features/shopp_admin/presentation/pages/product_admin.dart';
import '../../features/shopp_admin/presentation/pages/profile_admin.dart';
import '../../features/shopp_admin/presentation/widgets/add_category.dart';
import '../../features/shopp_admin/presentation/widgets/add_product.dart';

class RouteGenerator {
  //? Routes auth
  static const String splashScreen = '/splash';
  static const String login = '/login';
  static const String register = '/register';

  //? Routes shopp
  static const String home = '/';
  static const String productPage = '/productPage';
  static const String cartPage = '/cartPage';
  static const String profilePage = '/profilePage';

  //? Routes shopp admin
  static const String categoyAdmin = '/categoryAdmin';
  static const String productAdmin = '/productAdmin';
  static const String profileAdmin = '/profileAdmin';
  static const String addCategory = '/addCategory';
  static const String addProduct = '/addProduct';
  
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      case home:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const HomePage(), transitionDuration: Duration.zero);
      case productPage:
        return MaterialPageRoute(builder: (_) => const ProductPage());
      case cartPage:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const CartPage(), transitionDuration: Duration.zero);
      case profilePage:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(), transitionDuration: Duration.zero);
      case categoyAdmin:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const CategoyAdmin(), transitionDuration: Duration.zero);
      case productAdmin:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const ProductAdmin(), transitionDuration: Duration.zero);
      case profileAdmin:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const ProfileAdmin(), transitionDuration: Duration.zero);
      case addCategory:
        return MaterialPageRoute(builder: (_) => const AddCategory());
      case addProduct:
        return MaterialPageRoute(builder: (_) => const AddProduct());
      default:
        return MaterialPageRoute(builder: (_) => const UnknownRoute());
    }
  }
}
