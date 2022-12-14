import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import 'package:smartdisplay/containers/viewer_home.dart';
import '../redux/states/viewer.dart';
import '../utilities/hooks.dart';
import 'viewer_peering.dart';

class ViewerRoot extends HookWidget {
  ViewerRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardId =
        useSelector<ViewerState, String>((state) => state.dashboardId)!;

    if (dashboardId == "") {
      return ViewerPeeringPage();
    } else {
      return ViewerHomePage();
    }
  }
}
