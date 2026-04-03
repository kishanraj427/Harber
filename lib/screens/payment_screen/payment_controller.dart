import 'package:get/get.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';

class PaymentController extends GetxController {
  var name = "".obs;
  var loc = "".obs;
  var time = "".obs;
  var date = DateTime.now().obs;
  var apps = <ApplicationMeta>[].obs;
  var services = ['Hair Cut', 'Shave', 'Facial'].obs;
  var service = 0.obs;
  var prices = [100.0, 50.0, 70.0].obs;
  var payment = false.obs;
  @override
  void onInit() async {
    await UpiPay.getInstalledUpiApplications()
        .then((value) => apps.value = value);
    super.onInit();
  }

}
