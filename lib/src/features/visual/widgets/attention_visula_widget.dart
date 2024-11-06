import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medvisual/src/ui/widgets/widgets.dart';

class AttentionVisualWidget extends StatelessWidget {
  const AttentionVisualWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/attention.svg'),
              const SizedBox(width: 10),
              Text(
                'Обратите внимание',
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Этот инструмент использует экспериментальную функцию распознавания образов на основе искусственного интеллекта для оценки вероятности наличия определенных заболеваний по фотографии. Он не предназначен для замены профессиональной медицинской консультации, диагностики или лечения.',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
