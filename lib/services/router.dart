import 'package:flutter/material.dart';

import '/screens/auth/password_restore.dart';
import '/screens/auth/sign_in.dart';
import '/screens/auth/sign_up.dart';
import '/screens/statistics.dart';
import '/screens/vip.dart';
import '/screens/vip_store.dart';

const signInRoute = '/signIn';
const signUpRoute = '/signUp';
const restoreRoute = '/restore';
const statsRoute = '/stats';
const vipRoute = '/vip';
const storeRoute = '/vipStore';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case signInRoute:
      return MaterialPageRoute(builder: (context) => SignIn());
    case signUpRoute:
      return MaterialPageRoute(builder: (context) => SignUp());
    case restoreRoute:
      return MaterialPageRoute(builder: (context) => Restore());
    case statsRoute:
      return MaterialPageRoute(builder: (context) => Statistics());
    case vipRoute:
      return MaterialPageRoute(builder: (context) => VIP());
    case storeRoute:
      return MaterialPageRoute(builder: (conext) => Store());
    default:
      return MaterialPageRoute(builder: (context) => Error());
  }
}

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
