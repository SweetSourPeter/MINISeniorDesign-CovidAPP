import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImageDialog extends StatelessWidget {
  final String qr_link;

  const QRImageDialog({Key key, this.qr_link}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: QrImage(
      data: qr_link,
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    ));
  }
}
