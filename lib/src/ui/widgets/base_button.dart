import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const BaseButton({required this.text, required this.onPressed, super.key});

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
                alignment: Alignment.center,
                padding: WidgetStateProperty.all(const EdgeInsets.only(
                    right: 75, left: 75, top: 15, bottom: 15)),
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                )),
            onPressed: onPressed,
            child: Text(
              text,
              style:
                  theme.textTheme.bodyLarge?.copyWith(color: theme.canvasColor),
            )));
  }
}
