import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final Widget content;
  final Function() onPressed;
  final double? width;
  final EdgeInsets? padding;

  const BaseButton(
      {required this.onPressed,
      super.key,
      required this.content,
      this.width,
      this.padding});

  final double borderRadius = 12;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: theme.primaryColor),
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: WidgetStateProperty.all(0),
                padding:
                    WidgetStatePropertyAll(padding ?? const EdgeInsets.all(0)),
                alignment: Alignment.center,
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                )),
            onPressed: onPressed,
            child: SizedBox(width: width, child: Center(child: content))));
  }
}
