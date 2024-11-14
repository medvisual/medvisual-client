import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final double borderRadius = 12;
  final Widget? child;
  final String? text;
  final Function() onPressed;
  final Color? color;
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const BaseButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.color,
    this.width,
    this.padding,
    this.margin,
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? theme.primaryColor,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(padding ?? const EdgeInsets.all(0)),
          alignment: Alignment.center,
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: width,
          child: text != null
              ? Center(
                  child:
                      Text(text!, style: const TextStyle(color: Colors.white)))
              : Center(child: child),
        ),
      ),
    );
  }
}
