import 'package:flutter/material.dart';
import '../../redux/states/text_widget.dart';
import '../../utilities/ui_helper.dart';
import 'app_card.dart';
import 'base_widget.dart';

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
