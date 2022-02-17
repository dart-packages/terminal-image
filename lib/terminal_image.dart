library terminal_image;

import 'dart:convert';
import 'dart:io';

String? terminalImage(String src) {
  RegExp _base64 = RegExp(
      r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');

  if (!_base64.hasMatch(src)) {
    if (!File(src).existsSync()) {
      throw Exception('Image ' + src + ' not found.');
    }

    List<int> imageBytes = new File(src).readAsBytesSync();

    String? termName = Platform.environment['TERM_PROGRAM'];
    String? termVersion = Platform.environment['TERM_PROGRAM_VERSION'];

    if (termName != null && termVersion != null) {
      var version = int.parse(termVersion.split('.').join());
      if (termName == 'iTerm.app' && version > 3000) {
        return '\u001B]1337;File=inline=1:' +
            base64.encode(imageBytes) +
            '\u0007';
      }
    }
  }
}
