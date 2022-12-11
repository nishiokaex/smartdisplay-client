import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewerPeeringPage extends StatelessWidget {
  ViewerPeeringPage({super.key});

  @override
  Widget build(BuildContext context) {
    const deviceId = "1234567890";

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "QRコードまたは端末IDを登録してください",
              style: Theme.of(context).textTheme.headline5,
            ),
            QrImage(
              data: deviceId,
              version: QrVersions.auto,
              size: 200.0,
            ),
            Text(
              deviceId,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
