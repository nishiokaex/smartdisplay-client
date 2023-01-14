import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import 'package:smartdisplay/components/widgets/clock_widget.dart';
import '../../utilities/hooks.dart';
import '../dashboard.dart';
import 'container_widget.dart';
import 'text_widget.dart';

enum WidgetClass {
  text("9c4e0e4b-48f6-4bb4-9677-3d7d737b2813"),
  container("5a19746e-b048-47cc-b005-57bfed472114"),
  clock("fc4cd5cd-eb9c-4e4e-bbb6-8f56f5b80b77");

  const WidgetClass(this.id);
  final String id;

  static fromString(String id) {
    return WidgetClass.values.firstWhere((element) => element.id == id);
  }
}

abstract class WidgetState {
  final String id;
  final WidgetClass klass;

  WidgetState({required this.id, required this.klass});

  Map<String, dynamic> toMap();
  String toTypeName();

  static fromMap(Map<String, dynamic> map) {
    WidgetClass klass = WidgetClass.fromString(map['classId']);

    switch (klass) {
      case WidgetClass.container:
        return ContainerWidgetState.fromMap(map);

      case WidgetClass.text:
        return TextWidgetState.fromMap(map);
    }
  }
}

abstract class DashboardWidget<T> extends HookWidget {
  final List<String> paths;

  const DashboardWidget({super.key, required this.paths});

  T useWidgetState() {
    return useSelector<DashboardState, T>((state) {
      WidgetState curr = state.rootWidget;
      for (final path in paths) {
        ContainerWidgetState container = curr as ContainerWidgetState;
        curr = container.byId[path]!;
      }
      return curr as T;
    })!;
  }

  static DashboardWidget fromState(WidgetState state, List<String> paths) {
    switch (state.klass) {
      case WidgetClass.container:
        return ContainerWidget(paths: paths);

      case WidgetClass.text:
        return TextWidget(paths: paths);

      case WidgetClass.clock:
        return ClockWidget(paths: paths);
    }
  }
}
