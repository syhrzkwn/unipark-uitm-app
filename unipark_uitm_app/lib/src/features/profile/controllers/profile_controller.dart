import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class ProfileController extends GetxController {
  ProfileController get instance => Get.find();

  // To get set apps information
  Rx<PackageInfo> appInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '0.0.0',
    buildNumber: '0',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  ).obs;

  final switchTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    initPackageInfo();
  }

  // To get retrieve current apps information
  Future<void> initPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      appInfo(info);
    } catch (e) {
    // Show some Generic Error to the user
    SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }
}