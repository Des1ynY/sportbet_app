import 'package:flutter/material.dart';

import '/data/funcs.dart';
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
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getScaffoldSize(context) * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 100,
                          child: Image.asset('assets/logo.png'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'МЕНЮ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                      ],
                    ),
                  ],
                ),
              ),
              DrawerOption(
                icon: Icons.logout,
                label: 'Выйти',
                onPressed: () => AuthServices.signOut(),
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
              child: Icon(icon, size: 35, color: Colors.black),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
