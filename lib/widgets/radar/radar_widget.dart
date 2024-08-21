import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RadarWidget extends StatelessWidget {
  final String url;
  const RadarWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..loadRequest(Uri.parse(url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white);
    return WebViewWidget(
      controller: controller,
    );
  }
}
