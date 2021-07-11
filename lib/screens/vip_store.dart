import 'package:betting_tips/data/funcs.dart';
import 'package:betting_tips/data/theme.dart';
import 'package:betting_tips/widgets/drawer.dart';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Area(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            height: getScaffoldSize(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    LogoButton(),
                    Text(
                      'Магазин VIP',
                      style: TextStyle(
                        color: header,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 2),
                VIPStoreTile(lastsFor: '1 день', cost: 3.5),
                Spacer(),
                VIPStoreTile(lastsFor: '3 дня', cost: 7),
                Spacer(),
                VIPStoreTile(lastsFor: '7 дней', cost: 12),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VIPStoreTile extends StatelessWidget {
  const VIPStoreTile({
    Key? key,
    required this.lastsFor,
    required this.cost,
    this.profitable = false,
  }) : super(key: key);

  final String lastsFor;
  final double cost;
  final bool profitable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xff3955B6), width: 2),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Text(
                  '$lastsFor доступа к VIP',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            VerticalDivider(
              thickness: 1.5,
              color: Color(0xff9498A1),
              indent: 20,
              endIndent: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                sprintf('%.02f ₽', [cost]),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoButton extends StatelessWidget {
  const LogoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: RawMaterialButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
