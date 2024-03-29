import 'package:flutter/material.dart';
import '../../utilities/ui_helper.dart';
import 'app_card.dart';
import 'base_widget.dart';

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

class TextWidget extends DashboardWidget<TextWidgetState> {
  const TextWidget({super.key, required List<String> paths})
      : super(paths: paths);

  @override
  Widget build(BuildContext context) {
    final state = useWidgetState();

    return AppCard(
      icon: Icons.title,
      title: "メモ",
      child: TextContent(
        content: state.content,
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  final String content;

  TextContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            TextStyle valueTextStyle = TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: wp(constraints, 10),
            );

            // 文字列が長すぎる場合、...で省略する
            return Text(
              content,
              style: valueTextStyle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
    );
  }
}
