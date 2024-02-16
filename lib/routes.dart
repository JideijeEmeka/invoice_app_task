import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invoice_app/views/details_view.dart';
import 'package:invoice_app/views/home_view.dart';
import 'package:invoice_app/views/splash_view.dart';

class AppRouter {
  static const begin = Offset(0.0, 1.0);
  static const end = Offset.zero;
  static const curve = Curves.ease;
  static var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeView(),
        ),
        // GoRoute(
        //   path: '/details_view/:id?createdAt=&name=&price=&quantity=&total=&description=&address=&signature=&avatar',
        //   builder: (context, state) => DetailsView(
        //       id: state.pathParameters['id']!,
        //       createdAt: state.pathParameters['createdAt']!,
        //       name: state.pathParameters['name']!,
        //       price: state.pathParameters['price']!,
        //       quantity: state.pathParameters['quantity']!,
        //       total: state.pathParameters['total']!,
        //       description: state.pathParameters['description']!,
        //       address: state.pathParameters['address']!,
        //       signature: state.pathParameters['signature']!,
        //       avatar: state.pathParameters['avatar']!),
        // ),
      ],
      initialLocation: '/'
  );
}