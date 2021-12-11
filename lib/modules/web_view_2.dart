//https://www.worldometers.info/coronavirus/country/egypt/

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EgyptWebViewScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(



        title: Text(
          'I-Health',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WebView(
        initialUrl: "https://www.worldometers.info/coronavirus/country/egypt/" ,
        javascriptMode: JavascriptMode.unrestricted,

      ),
    );
  }
}
