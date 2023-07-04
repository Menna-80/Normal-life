import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

final String url;
WebViewScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Angel Control'),
      ),
      body: WebView(
        initialUrl:url ,
        javascriptMode: JavascriptMode.unrestricted,

      ),
    );
  }
}
