// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WikipediaWebViewScreen extends StatefulWidget {
//   final String url;

//   WikipediaWebViewScreen({required this.url});

//   @override
//   _WikipediaWebViewScreenState createState() => _WikipediaWebViewScreenState();
// }

// class _WikipediaWebViewScreenState extends State<WikipediaWebViewScreen> {
//   late WebViewController _webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Wikipedia'),
//       ),
//       body: WebViewWidget(
//         controller: _webViewController,
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initWebViewController();
//   }

//   void _initWebViewController() {
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavascriptMode.unrestricted)
//       ..loadRequest(Uri.parse(widget.url));
//   }
// }