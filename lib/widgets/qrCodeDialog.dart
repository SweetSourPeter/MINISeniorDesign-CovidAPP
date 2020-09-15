import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImageDialog extends StatefulWidget {
  final String qr_link;

  const QRImageDialog({Key key, this.qr_link}) : super(key: key);

  @override
  _QRImageDialogState createState() => _QRImageDialogState();
}

class _QRImageDialogState extends State<QRImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: QrImage(
      data: widget.qr_link,
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    ));
  }
}
