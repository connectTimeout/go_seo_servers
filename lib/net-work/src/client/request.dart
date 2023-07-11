import 'package:go_seo_servers/net-work/src/client/exception.dart';
import 'package:go_seo_servers/net-work/src/client/exception_handle.dart';
import 'package:go_seo_servers/utils/utils.dart';

Future request(
  Function() block, {
  bool showLoading = true,
  bool Function(ApiException)? onError,
}) async {
  try {
    await loading(block, isShowLoading: showLoading);
  } catch (e) {
    handleException(e, onError: onError);
  }
  return;
}
