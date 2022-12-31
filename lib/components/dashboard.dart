import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;

import '../redux/states/dashbaord.dart';
import '../utilities/hooks.dart';
import 'widgets/base_widget.dart';

class Dashboard extends HookWidget {
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetState =
        useSelector<DashboardState, WidgetState>((state) => state.rootWidget)!;
    return DashboardWidget.fromState(widgetState, []);
  }
}
