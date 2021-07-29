import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '/data/app_state.dart';

class PurchaseApi {
  static const _apiKey = 'PdvrqagkiyFjeWAsZQPJSJTpyyLSarrB';

  static Future<void> init() async {
    await Purchases.setDebugLogsEnabled(false);
    await Purchases.setup(_apiKey, appUserId: userEmail);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      var offers = await Purchases.getOfferings();
      var current = offers.all.values.toList();

      return current;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }
}
