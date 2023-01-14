import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import '../utilities/hooks.dart';
import 'widgets/base_widget.dart';

class DashboardState {
  final String id;
  final String name;
  final String description;
  final WidgetState rootWidget;

  DashboardState({
    required this.id,
    required this.name,
    required this.description,
    required this.rootWidget,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rootWidget': rootWidget.toMap(),
    };
  }

  static DashboardState fromMap(Map<String, dynamic> map) {
    return DashboardState(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      rootWidget: WidgetState.fromMap(map['rootWidget']),
    );
  }
}

class Dashboard extends HookWidget {
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetState =
        useSelector<DashboardState, WidgetState>((state) => state.rootWidget)!;
    return DashboardWidget.fromState(widgetState, []);
  }
}
