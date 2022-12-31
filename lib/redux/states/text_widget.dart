import 'dashbaord.dart';

class TextWidgetState extends WidgetState {
  final String content;

  TextWidgetState({
    required String id,
    required this.content,
  }) : super(id: id, klass: WidgetClass.text);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classId': klass.id,
      'content': content,
    };
  }

  @override
  String toTypeName() {
    return "テキストウィジェット";
  }

  TextWidgetState copyWith({String? content}) {
    return TextWidgetState(
      id: id,
      content: content ?? this.content,
    );
  }

  static TextWidgetState fromMap(Map<String, dynamic> map) {
    return TextWidgetState(
      id: map['id'],
      content: map['content'],
    );
  }
}
