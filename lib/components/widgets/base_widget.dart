import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import '../../redux/states/container_widget.dart';
import '../../redux/states/dashbaord.dart';
import '../../utilities/hooks.dart';
import 'container_widget.dart';
import 'text_widget.dart';

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
    }
  }
}
