import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

import '/data/theme.dart';
import '/widgets/drawer.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _ids = [
    'vip_forecast_2',
    'vip_forecast_6',
    'vip_forecast_14',
  ];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false;
  String? _errorMessage;
  bool _loading = true;
  bool _purchasePending = false;
  bool _autoConsume = true;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((list) {
      _listenToPurchaseUpdated(list);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (e) {
      print(e.toString());
    });
    initStoreInfo();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_ids.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _errorMessage = productDetailResponse.error.toString();
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    await _inAppPurchase.restorePurchases();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchasePending = false;
      _loading = false;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setState(() => _purchasePending = true);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          setState(() => _purchasePending = false);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          _deliverProduct(purchaseDetails);
        }

        if (!_autoConsume) {
          final InAppPurchaseAndroidPlatformAddition addition =
              InAppPurchasePlatformAddition.instance
                  as InAppPurchaseAndroidPlatformAddition;
          await addition.consumePurchase(purchaseDetails);
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async {
    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];

    if (_errorMessage == null) {
      stack.addAll(
        [
          _buildConnectionCheckTile(),
          _buildProductList(),
        ],
      );
    } else {
      stack.add(
        Center(
          child: Text(
            _errorMessage!,
          ),
        ),
      );
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return Area(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Stack(
            children: stack,
          ),
        ),
      ),
    );
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return Card(
        child: ListTile(
          title: Text('Пытаемся подключиться...'),
        ),
      );
    }
    final Widget storeHeader = ListTile(
      leading: Icon(
        _isAvailable ? Icons.check : Icons.block,
        color: _isAvailable ? Colors.green : Colors.red,
      ),
      title: Text(
        'Магазин ' + (_isAvailable ? 'доступен.' : 'недоступен.'),
      ),
    );
    final List<Widget> children = [storeHeader];

    if (!_isAvailable) {
      children.addAll(
        [
          Divider(),
          ListTile(
            title: Text('Нет подключения'),
            subtitle: Text('Нет подключения к серверам'),
          ),
        ],
      );
    }
    return Card(
      child: Column(
        children: children,
      ),
    );
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(
        child: ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Загружаем товары...'),
        ),
      );
    }
    if (!_isAvailable) {
      return Card();
    }
    final ListTile productHeader = ListTile(
      title: Text('Список товаров'),
    );
    List<ListTile> productList = [];

    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry(purchase.productID, purchase);
    }));
    productList.addAll(_products.map((productDetails) {
      var prevPurchase = purchases[productDetails.id];
      return ListTile(
        title: Text(
          productDetails.title,
        ),
        subtitle: Text(
          productDetails.description,
        ),
        trailing: prevPurchase != null
            ? IconButton(
                icon: Icon(Icons.upgrade),
                onPressed: () {
                  final InAppPurchaseAndroidPlatformAddition addition =
                      InAppPurchasePlatformAddition.instance
                          as InAppPurchaseAndroidPlatformAddition;
                  var skuDetails =
                      (productDetails as GooglePlayProductDetails).skuDetails;
                  addition
                      .launchPriceChangeConfirmationFlow(sku: skuDetails.sku)
                      .then(
                        (value) => print(value.responseCode),
                      );
                },
              )
            : TextButton(
                onPressed: () {
                  _inAppPurchase.buyConsumable(
                    purchaseParam: GooglePlayPurchaseParam(
                      productDetails: productDetails,
                    ),
                  );
                },
                child: Text(
                  productDetails.price,
                ),
              ),
      );
    }));
    return Card(
      child: Column(
        children: [productHeader, Divider()] + productList,
      ),
    );
  }
}

class VIPStoreTile extends StatelessWidget {
  const VIPStoreTile({
    Key? key,
    required this.count,
    required this.cost,
    this.profitable = false,
  }) : super(key: key);

  final int cost, count;
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
                      count == 2
                          ? '$count VIP прогноза'
                          : '$count VIP прогнозов',
                      softWrap: true,
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
