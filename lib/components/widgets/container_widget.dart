import 'package:flutter/material.dart';
import '../../redux/states/container_widget.dart';
import 'base_widget.dart';

class ContainerWidget extends DashboardWidget<ContainerWidgetState> {
  const ContainerWidget({super.key, required List<String> paths})
      : super(paths: paths);

  @override
  Widget build(BuildContext context) {
    final state = useWidgetState();

    if (state.ids.isEmpty) {
      return const Text("");
    }

    final widgetId = state.ids[0];
    final widgetState = state.byId[widgetId]!;
    final childPaths = List<String>.from(paths);
    childPaths.add(widgetId);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final cardHeight = size.height;
        final cardWidth = size.width;
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  height: cardHeight,
                  width: cardWidth,
                  child: DashboardWidget.fromState(widgetState, childPaths),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
