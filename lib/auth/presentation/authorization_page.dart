import 'dart:io';

import 'package:flutter/material.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationPage extends StatefulWidget {
  final Uri authorizationUri;
  final void Function(Uri redirectUri) onAuthorizationCodeRedirectAttempt;
  const AuthorizationPage({
    Key? key,
    required this.authorizationUri,
    required this.onAuthorizationCodeRedirectAttempt,
  }) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.authorizationUri.toString(),
          onWebViewCreated: (controller) {
            controller.clearCache();
            CookieManager().clearCookies();
          },
          navigationDelegate: (navReq) {
            if (navReq.url
                .startsWith(GithubAuthenticator.redirectEndpoint.toString())) {
              widget.onAuthorizationCodeRedirectAttempt(Uri.parse(navReq.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
