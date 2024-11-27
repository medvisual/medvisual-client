import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.inputController,
      required this.text,
      required this.maxLines,
      this.obscureText});
  final bool? obscureText;
  final TextEditingController inputController;
  final String text;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          TextField(
            obscureText: obscureText ?? false,
            controller: inputController,
            onChanged: (value) {
              //Do something wi
            },
            cursorColor: theme.colorScheme.onSurface,
            maxLines: maxLines,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
                // prefixIcon: Icon(Icons.email),
                filled: theme.inputDecorationTheme.filled,
                fillColor: theme.inputDecorationTheme.fillColor,
                hintText: text,
                hintStyle: theme.inputDecorationTheme.hintStyle,
                contentPadding: theme.inputDecorationTheme.contentPadding,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
                errorBorder: theme.inputDecorationTheme.errorBorder,
                enabledBorder: theme.inputDecorationTheme.enabledBorder),
          ),
        ],
      ),
    );
  }
}
