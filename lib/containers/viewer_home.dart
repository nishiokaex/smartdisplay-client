import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import '../components/dashboard.dart';
import '../redux/dashboard_store.dart';
import '../redux/states/viewer.dart';
import '../utilities/hooks.dart';

class ViewerHomePage extends HookWidget {
  ViewerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardId =
        useSelector<ViewerState, String>((state) => state.dashboardId)!;

    return DashbaordStoreProvider(
      dashboardId: dashboardId,
      child: Scaffold(
        body: Dashboard(),
      ),
    );
  }
}
