import 'package:flutter/material.dart';

class BaseListContainer extends StatelessWidget {
  const BaseListContainer({
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.icon,
    this.width,
  }) : assert(text == null || child == null);
  final String? text;
  final Widget? child;
  final String? icon;
  final VoidCallback? onTap;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.57),
                blurRadius: 4,
                offset: const Offset(5, 5))
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon != null
                  ? Image.asset(
                      icon!,
                      height: 40,
                      width: 40,
                      color: Colors.white,
                    )
                  : const SizedBox.shrink(),
              text != null
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        text!,
                        style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    )
                  : child!
            ]),
      ),
    );
  }
}
