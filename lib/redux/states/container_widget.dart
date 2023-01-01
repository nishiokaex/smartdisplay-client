import 'dashbaord.dart';

class ContainerWidgetState extends WidgetState {
  final List<String> ids;
  final Map<String, WidgetState> byId;

  ContainerWidgetState({
    required id,
    required this.ids,
    required this.byId,
  }) : super(id: id, klass: WidgetClass.container);

  addWidget(WidgetState widget) {
    final ids = List<String>.from(this.ids);
    final byId = Map<String, WidgetState>.from(this.byId);

    return ContainerWidgetState(
      id: id,
      ids: ids..add(widget.id),
      byId: byId..addAll({widget.id: widget}),
    );
  }

  deleteWidget(WidgetState widget) {
    var items = byId.entries;

    return ContainerWidgetState(
      id: id,
      ids: List<String>.from(ids.where((id) => (id != widget.id))),
      byId: Map.fromEntries(items.where((item) => (item.key != widget.id))),
    );
  }

  updateWidget(WidgetState widget) {
    final byId = Map<String, WidgetState>.from(this.byId);

    return ContainerWidgetState(
      id: id,
      ids: ids,
      byId: byId..addAll({widget.id: widget}),
    );
  }

  reorderWidget(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final ids = List<String>.from(this.ids);
    final item = ids.removeAt(oldIndex);
    ids.insert(newIndex, item);

    return ContainerWidgetState(
      id: id,
      ids: ids,
      byId: byId,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ids': ids.map((i) => i.toString()).toList(),
      'byId': byId.map(
        (key, value) => MapEntry(
          key,
          value.toMap(),
        ),
      ),
    };
  }

  @override
  String toTypeName() {
    return "コンテナウィジェット";
  }

  static fromMap(Map<String, dynamic> map) {
    String id = map['id'];
    List<dynamic> ids = map['ids'];
    Map<String, dynamic> byId = map['byId'];

    return ContainerWidgetState(
      id: id,
      ids: ids.map((id) => id.toString()).toList(),
      byId: byId.map(
        (key, value) => MapEntry(
          key,
          WidgetState.fromMap(value),
        ),
      ),
    );
  }
}