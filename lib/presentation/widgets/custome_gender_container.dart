import 'package:bmi_calculator/utilities/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomeGenderContainer extends StatelessWidget {
  final String text;
  final Icon icon;
  final bool isSelected;

  CustomeGenderContainer({
    super.key,
    required this.text,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : darkGrey,
        borderRadius: BorderRadius.circular(10),
   border: Border.all(
      color:isSelected? Colors.white: Colors.grey[600]!, // The color of your border
      width: 1.0,              // The thickness of the border
    ), ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon.icon,
            size: isSmallScreen ? 24.0 : 32.0,
            color: Colors.white,
          ),
          SizedBox(width: isSmallScreen ? 8.0 : 12.0),
          Text(
            text,
            style: TextStyle(
              fontSize: isSmallScreen ? 16.0 : 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
