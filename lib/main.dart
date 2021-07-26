import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:provider/provider.dart';

import 'screens/auth/sign_in.dart';
import 'services/router.dart';
import 'data/app_state.dart';
import 'services/auth.dart';
import 'data/theme.dart';
import '/data/funcs.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (context) => AuthServices(),
        ),
        StreamProvider(
          create: (context) => AuthServices.authStateChanges(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
              behavior: NoGlowScrollEffect(), child: child ?? Container());
        },
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        title: 'Betting Tips',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        home: AuthChecker(),
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<User?>();

    if (currentUser != null) userEmail = currentUser.email!;

    return currentUser == null ? SignIn() : onStats();
  }
}
