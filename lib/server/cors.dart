import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_proxy/shelf_proxy.dart';

//前端页面访问本地域名
const String localHost = 'localhost';

//前端页面访问本地端口号
const int localPort = 6060;

//目标域名，这里我们将要请求火狐的这个地址
const String targetUrl = 'http://seo-report.yichadaodi.com';

void main() async {
  onServer();
}

void onServer() async {
  var server = await shelf_io.serve(
    proxyHandler(targetUrl),
    localHost,
    localPort,
  );
  // 添加上跨域的这几个header
  server.defaultResponseHeaders.add('Access-Control-Allow-Origin', '*');
  server.defaultResponseHeaders.add('Access-Control-Allow-Credentials', true);
}
