import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import 'package:qr_flutter/qr_flutter.dart';
import '../utilities/hooks.dart';
import '../redux/states/viewer.dart';

class ViewerPeeringPage extends HookWidget {
  ViewerPeeringPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceId =
        useSelector<ViewerState, String>((state) => state.deviceId)!;

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
