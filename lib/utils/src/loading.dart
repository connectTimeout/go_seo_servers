import 'package:go_seo_servers/components/components.dart';

Future loading(Function block, {bool isShowLoading = true}) async {
  if (isShowLoading) {
    showLoading();
  }
  try {
    await block();
  } catch (e) {
    rethrow;
  } finally {
    dismissLoading();
  }
  return;
}

void showLoading() {
  IToast.loading(message: "加载中...");
}

void dismissLoading() {
  IToast.dismiss();
}
