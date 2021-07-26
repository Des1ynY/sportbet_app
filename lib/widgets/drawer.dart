import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/services/auth.dart';
import '/services/router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: Drawer(
        child: Container(
          color: mainColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 100,
                          child: Image.asset('assets/logo_white.png'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'МЕНЮ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        DrawerOption(
                          icon: Icons.query_stats,
                          label: 'Статистика',
                          onPressed: () =>
                              Navigator.pushNamed(context, statsRoute),
                        ),
                        DrawerOption(
                          icon: Icons.monetization_on,
                          label: 'VIP прогноз',
                          onPressed: () =>
                              Navigator.pushNamed(context, vipRoute),
                        ),
                        DrawerOption(
                          icon: Icons.store,
                          label: 'VIP магазин',
                          onPressed: () =>
                              Navigator.pushNamed(context, storeRoute),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DrawerOption(
                icon: Icons.logout,
                label: 'Выйти',
                onPressed: () {
                  AuthServices.signOut();
                  currentFilterStats = 'Все';
                  currentFilterVIP = 'Все';
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    signInRoute,
                    (route) => false,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
        onPressed();
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12, top: 12, right: 10),
              child: Icon(icon, size: 33, color: Colors.white),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
