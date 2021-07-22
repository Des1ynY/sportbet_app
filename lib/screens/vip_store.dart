import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/drawer.dart';
import '/widgets/logo.dart';
import '/widgets/open_drawer_button.dart';
import '/widgets/product_tile.dart';

const _productsIds = ['vip_forecast_2', 'vip_forecast_6', 'vip_forecast_14'];
const _autoConsume = true;

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false, _purchasePending = false, _isLoading = true;
  String? _queryError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> update = _iap.purchaseStream;
    _subscription = update.listen((purchaseList) {
      _listenToPurchaseUpdated(purchaseList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (e) {
      print(e.toString());
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = _isAvailable;
        _products = [];
        _purchases = [];
        _purchasePending = false;
        _isLoading = false;
      });
      return;
    }

    var detailResponse = await _iap.queryProductDetails(_productsIds.toSet());

    if (detailResponse.error != null) {
      setState(() {
        _queryError = detailResponse.error.toString();
        _isAvailable = isAvailable;
        _products = detailResponse.productDetails;
        _purchases = [];
        _purchasePending = false;
        _isLoading = false;
      });
      return;
    }

    if (detailResponse.productDetails.isEmpty) {
      setState(() {
        _isAvailable = isAvailable;
        _products = detailResponse.productDetails;
        _purchases = [];
        _purchasePending = false;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isAvailable = isAvailable;
      _products = detailResponse.productDetails;
      _purchases = [];
      _purchasePending = false;
      _isLoading = false;
    });
    return;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> detailsList) {
    detailsList.forEach((purchaseDetail) async {
      if (purchaseDetail.status == PurchaseStatus.pending) {
        setState(() {
          _purchasePending = true;
        });
      } else {
        if (purchaseDetail.status == PurchaseStatus.error) {
          print(purchaseDetail.error!.message);
        } else if (purchaseDetail.status == PurchaseStatus.purchased) {
          setState(() {
            _purchases.add(purchaseDetail);
            _purchasePending = false;
          });
        }

        if (Platform.isAndroid) {
          if (!_autoConsume) {
            final androidAddition = _iap
                .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetail);
          }
        }

        if (purchaseDetail.pendingCompletePurchase) {
          await _iap.completePurchase(purchaseDetail);
        }
      }
    });
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: !_isLoading
                  ? _isAvailable && _queryError != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Logo(label: 'VIP Подписка'),
                            Spacer(),
                            Center(
                              child: _buildProducts(),
                            ),
                            Spacer(),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Logo(label: 'VIP Подписка'),
                            Spacer(),
                            Center(
                              child: Text(
                                'Магазин недоступен',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Spacer(flex: 2),
                          ],
                        )
                  : CircularProgressIndicator(
                      color: mainColor,
                    ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: OpenDrawerButton(),
            ),
            if (_purchasePending)
              Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: ModalBarrier(dismissible: false, color: Colors.grey),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  _buildProducts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _products.map((productDetails) {
        return VIPStoreTile(
          title: productDetails.title,
          cost: int.parse(productDetails.price),
          profitable: productDetails.id == 'vip_forecast_14',
          onPressed: () {
            var purchaseParam = GooglePlayPurchaseParam(
              productDetails: productDetails,
            );
            _iap.buyConsumable(
              purchaseParam: purchaseParam,
              autoConsume: _autoConsume,
            );
          },
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
