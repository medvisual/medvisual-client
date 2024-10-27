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
          gradient: LinearGradient(colors: [
            const Color(0xFF3838f5),
            theme.primaryColor,
          ]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.57),
                blurRadius: 4,
                offset: Offset(5, 5))
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    icon!, // путь к вашему SVG файлу
                    height: 50, // размер по высоте
                    width: 50, // размер по ширине
                    colorFilter: ColorFilter.mode(
                        theme.colorScheme.surface, BlendMode.srcIn),
                    // FIXME: Change deprecated color
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              text,
              style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.surface),
            ),
          ),
        ]),
      ),
    );
  }
}
