import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseListContainer extends StatelessWidget {
  const BaseListContainer({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
  });
  final String text;
  final String? icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: MediaQuery.of(context).size.width,
        height: 150,
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    icon!,
                    height: 50,
                    width: 50,
                    colorFilter: ColorFilter.mode(
                        theme.colorScheme.onSurface, BlendMode.srcIn),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              text,
              style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface),
            ),
          ),
        ]),
      ),
    );
  }
}
