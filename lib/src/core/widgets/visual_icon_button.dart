import 'package:flutter/material.dart';

class VisualIconButton extends StatefulWidget {
  const VisualIconButton(
      {super.key,
      required this.icon,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.duration = const Duration(milliseconds: 150),
      this.onPressed,
      this.margin,
      this.buttonRadius = 8})
      : assert(
          (borderColor == null && borderWidth == null) ||
              (borderColor != null && borderWidth != null),
          'If borderWidth is set borderColor also should be set. Also contrarily',
        );

  /// The icon to display inside [VisualIconButton]
  ///
  /// It's could be any widget. In example:
  /// ```dart
  /// Icon(Icons.send)
  /// Image.asset('example.png')
  /// SvgPicture.asset('example.svg')
  /// ```
  final Widget icon;

  /// Color which would be displayed in back side
  ///
  /// Default is equal null
  /// if it's equal null it use Colors.transparment color
  final Color? backgroundColor;

  /// Color used for border
  /// ```dart
  /// Colors.white
  /// ```
  final Color? borderColor;
  final double? borderWidth;

  /// Animation duration in changing state [isActive]
  /// Default value is 150 milliseconds
  final Duration duration;

  /// Function which would be called when
  /// this button would be tapped
  final VoidCallback? onPressed;

  final double buttonRadius;

  final EdgeInsets? margin;

  @override
  State<VisualIconButton> createState() => _VisualIconButtonState();
}

class _VisualIconButtonState extends State<VisualIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        margin: widget.margin,
        duration: widget.duration,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: widget.backgroundColor,
            // If set border width we use border style
            // because assertation prohibits the use of borderWidth without border
            // If none still use null value in border property
            border: widget.borderWidth != null
                ? Border.all(
                    color: widget.borderColor!, width: widget.borderWidth!)
                : null),
        padding: EdgeInsets.all(widget.buttonRadius),
        child: widget.icon,
      ),
    );
  }
}
