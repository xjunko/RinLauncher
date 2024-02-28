import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'applications/launcher/rin_launcher.dart';
// import 'applications/notes/leafy_notes.dart';
import 'utils/app_flavour/app_flavour.dart';

// NOTE: Might be useful.
// const _appChannel = MethodChannel('me.rinari.love/app');

void main() => mainCommon(AppFlavour.dev);

Future mainCommon(AppFlavour flavour) async {
  // NOTE: Removed notes, as it is useless. (For me, atleast.)
  WidgetsFlutterBinding.ensureInitialized();
  return RinLauncher.run(flavour);
}
