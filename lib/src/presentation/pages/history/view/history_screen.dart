import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:medvisual/src/presentation/core/widgets/widgets.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the size of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: 10, // 1 for the message + 10 history items
        itemBuilder: (context, index) {
          // History items
          return BaseListContainer(
            child: Row(
              children: [
                SizedBox(width: screenWidth * 0.05), // Responsive width
                SizedBox(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.04,
                  child: Text(
                    '${Random().nextInt(101)}%',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05, // Reduced font size
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05), // Responsive width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Болезнь',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Reduced font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ), // Responsive height
                      Text(
                        'Дата: 18.03.2022',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035, // Reduced font size
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Время: 16:31',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035, // Reduced font size
                          color: Colors.white,
                        ),
                      ),
                      Random().nextInt(2) == 0
                          ? Text(
                              'Уведомлено пациенту',
                              style: TextStyle(
                                fontSize:
                                    screenWidth * 0.035, // Reduced font size
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                SizedBox(width: screenWidth * 0.05),
              ],
            ),
          );
        },
      ),
    );
  }
}
