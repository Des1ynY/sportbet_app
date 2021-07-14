import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/logo.dart';
import '/widgets/drawer.dart';
import '/widgets/open_drawer_button.dart';

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
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                height: getScaffoldSize(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Logo(
                      label: 'VIP Подписка',
                    ),
                    Spacer(flex: 2),
                    VIPStoreTile(lastsFor: '1 день', cost: 250),
                    Spacer(),
                    VIPStoreTile(lastsFor: '3 дня', cost: 700),
                    Spacer(),
                    VIPStoreTile(
                        lastsFor: '7 дней', cost: 1250, profitable: true),
                    Spacer(flex: 3),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: OpenDrawerButton(),
              ),
            ],
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
  final int cost;
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
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          MaterialButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      '$lastsFor доступа\nк VIP Прогнозам',
                      style: TextStyle(
                        color: header,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Color(0xffD4D4D4),
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  width: 85,
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.center,
                  child: Text(
                    '$cost ₽',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE93E3E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          profitable
              ? Positioned(
                  top: 8,
                  right: -24,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(33 / 360),
                    child: Container(
                      color: Color(0xffE93E3E),
                      alignment: Alignment.center,
                      width: 100,
                      height: 20,
                      child: Text(
                        'Выгодно',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
