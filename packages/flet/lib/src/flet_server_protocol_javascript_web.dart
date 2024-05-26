@JS()
library script.js;

import 'dart:js_interop';

import 'package:flutter/foundation.dart';

import 'flet_server_protocol.dart';

@JS()
external JSPromise jsConnect(JSExportedDartFunction onMessage);

@JS()
external void jsSend(String data);

class FletJavaScriptServerProtocol implements FletServerProtocol {
  final String address;
  final FletServerProtocolOnMessageCallback onMessage;
  final FletServerProtocolOnDisconnectCallback onDisconnect;

  FletJavaScriptServerProtocol(
      {required this.address,
      required this.onDisconnect,
      required this.onMessage});

  @override
  connect() async {
    debugPrint("Connecting to JavaScript server $address...");
    await jsConnect(onMessage.toJS).toDart;
  }

  @override
  bool get isLocalConnection => true;

  @override
  int get defaultReconnectIntervalMs => 10;

  @override
  void send(String message) {
    jsSend(message);
  }

  @override
  void disconnect() {}
}
