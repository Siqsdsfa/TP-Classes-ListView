import 'package:go_router/go_router.dart';
import 'package:tp_classes_listview/screens/home_screen.dart';
import 'package:tp_classes_listview/screens/item_description_screen.dart';
import 'package:tp_classes_listview/screens/login_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: LoginScreen.name,
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: '/home',
      builder: (context, state) => HomeScreen(userName: state.extra as String),
    ),
    GoRoute(
      name: DescriptionScreen.name,
      path: '/description',
      builder: (context, state) => DescriptionScreen(
        localBookInfo: state.extra as BooksInfo,
      ),
    ),
  ],
);
