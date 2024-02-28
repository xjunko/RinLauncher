import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeButtonListener {
  const HomeButtonListener();

  static const _channel = EventChannel(
    'me.rinari.love/homePressedChannel',
  );

  static final Stream _stream = _channel.receiveBroadcastStream();

  StreamSubscription addCallback(VoidCallback callback) {
    return _stream.listen(
      (_) {
        callback();
      },
    );
  }
}
