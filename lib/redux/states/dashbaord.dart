import 'text_widget.dart';
import 'container_widget.dart';

enum WidgetClass {
  text("9c4e0e4b-48f6-4bb4-9677-3d7d737b2813"),
  container("5a19746e-b048-47cc-b005-57bfed472114");

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
