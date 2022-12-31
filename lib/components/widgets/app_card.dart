import 'package:flutter/material.dart';
import '../../utilities/ui_helper.dart';

class AppCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final bool hasError;

  AppCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final onError = colorScheme.onError;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          TextStyle? titleTextStyle = textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: wp(constraints, 6),
          );

          double iconSize = wp(constraints, 8);
          double titleSpace = wp(constraints, 1);

          Widget card = Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // タイトル
                  Row(
                    children: <Widget>[
                      Icon(icon, size: iconSize),
                      SizedBox(width: titleSpace),
                      // 文字列が長すぎる場合、...で省略する
                      Flexible(
                        child: Text(
                          title,
                          style: titleTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),

                  // divider
                  Divider(
                    height: 8,
                    thickness: 2,
                  ),

                  // content
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          );

          if (hasError) {
            return AnimatedTheme(
              data: theme.copyWith(
                textTheme: theme.textTheme.apply(
                  bodyColor: onError,
                  displayColor: onError,
                ),
                cardTheme: theme.cardTheme.copyWith(
                  color: colorScheme.error,
                ),
              ),
              duration: const Duration(milliseconds: 500),
              child: card,
            );
          } else {
            return card;
          }
        },
      ),
    );
  }
}
