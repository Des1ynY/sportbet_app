import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '/data/app_state.dart';
import '/data/funcs.dart';
import '/data/theme.dart';
import '/services/database.dart';
import '/services/in_app_purchases.dart';
import '/widgets/drawer.dart';
import '/widgets/logo.dart';
import '/widgets/open_drawer_button.dart';
import '/widgets/product_tile.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  late List<Package> packages;
  bool isLoaded = false;

  @override
  void initState() {
    _initStore();
    super.initState();
  }

  Future<void> _initStore() async {
    await Purchases.logIn(userEmail);
    var offers = await PurchaseApi.fetchOffers();

    if (offers.isEmpty) {
      Fluttertoast.showToast(msg: 'Товаров не найдено');
    } else {
      packages = offers
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Area(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Container(
              height: getScaffoldSize(context),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Logo(
                      label: 'VIP Магазин',
                    ),
                  ),
                  Spacer(),
                  isLoaded
                      ? ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: packages.length,
                          itemBuilder: (context, index) {
                            var package = packages[index];

                            return VIPStoreTile(
                              title: package.product.title,
                              cost: package.product.price,
                              profitable:
                                  package.product.title.startsWith('14'),
                              onPressed: () async {
                                var res =
                                    await PurchaseApi.purchasePackage(package);
                                int vips = 0;

                                switch (package.product.identifier) {
                                  case 'vip_forecast_2':
                                    vips = 2;
                                    break;
                                  case 'vip_forecast_6':
                                    vips = 6;
                                    break;
                                  case 'vip_forecast_14':
                                    vips = 14;
                                    break;
                                }

                                if (res) {
                                  await UsersDB.addVIPs(
                                      userEmail, vipCount + vips);
                                }
                              },
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: OpenDrawerButton(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Purchases.logOut();
    super.dispose();
  }
}
