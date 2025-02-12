import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService extends GetxService {
  RxBool isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkConnection();
  }

  void _checkConnection() async {
    isConnected.value = await InternetConnection().hasInternetAccess;
    InternetConnection().onStatusChange.listen((status) {
      isConnected.value = (status == InternetStatus.connected);
    });
  }
}
