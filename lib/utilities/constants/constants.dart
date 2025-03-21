import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6200EE); // Purple
  static const Color secondaryColor = Color(0xFF03DAC6); // Teal
  static const Color backgroundColor = Color(0xFFFFFFFF); // White
  static const Color errorColor = Color(0xFFB00020); // Red
  static const Color textColor = Color(0xFF000000); // Black
}

// ignore: constant_identifier_names
const Color login_bg = Color.fromARGB(0, 0, 0, 0);
const Color signup_bg = Color.fromARGB(0, 31, 112, 24);

const Color green = Colors.green;
const Color white = Colors.white;
const Color red = Colors.red;
const Color blue = Colors.blue;
const Color purple = Colors.purple;
const lightgrey = Color.fromARGB(255, 210, 210, 210);
const darkgreymain = Color.fromARGB(255, 21, 21, 22);




var  greyshade =Colors.grey.shade300;
const Color black =Colors.black;

const Color floatingActionButtoncolor=Colors.blue;


const kPrimaryColor = Color(0xFF00D1FF);
const textFieldBorderColor = Color(0xFFCDCDCD);
const grey = Colors.grey;

const amber = Colors.amber;
final grey300 = Colors.grey[300];
final grey100 = Colors.grey[100];
const kwhiteColor = Colors.white;
const Color oceanGreen = Color(0xFF48A9A6);
const blueAccent = Colors.blueAccent;


const Color customIconColor = green;






const double defaultpadding = 16.0;
// const String  header =  "Content-Type": "application/json";
const Duration defaultDuration = Duration(microseconds: 300);

const Gradient gradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 232, 218, 218),
    Color.fromARGB(255, 232, 218, 218),
    // Color.fromARGB(255, 223, 187, 187),
  ],
);

const TextStyle colorizeTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Horizon',
);


//auth key
const authKey = 'UserLoggedIn';

//token key sharedpreference
const tokenKey = 'userToken';

//userid key sharedpreference
const userIdKey = 'userId';

//userRole key sharedpreference
const userRolekey = 'userRole';

//userEmail key sharedpreference
const userEmailkey = 'userEmail';

//userName key sharedpreference
const userNamekey = 'userName';

//userProfilepic key sharedpreference
const userProfilePickey = 'userProfilePic';


// Text Styles
TextStyle profileStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp);
TextStyle profileStyle2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp);

// SizedBoxes for heights (using .h for responsive height)
SizedBox h5 = SizedBox(height: 5.h);
SizedBox h10 = SizedBox(height: 10.h);
SizedBox h15 = SizedBox(height: 15.h);
SizedBox h16 = SizedBox(height: 16.h);
SizedBox h20 = SizedBox(height: 20.h);
SizedBox h30 = SizedBox(height: 30.h);
SizedBox h40 = SizedBox(height: 40.h);
SizedBox h50 = SizedBox(height: 50.h);
SizedBox h80 = SizedBox(height: 80.h);
SizedBox h100 = SizedBox(height: 100.h);

// SizedBoxes for widths (using .w for responsive width)
SizedBox w10 = SizedBox(width: 10.w);
SizedBox w20 = SizedBox(width: 20.w);
SizedBox w30 = SizedBox(width: 30.w);
SizedBox w40 = SizedBox(width: 40.w);
SizedBox kwidth = SizedBox(width: 10.w);

// Other Styles
TextStyle appBarTitleStyle = TextStyle(
  fontSize: 22.sp,
  fontWeight: FontWeight.w500,
);

TextStyle profileColumnStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w800,
);

// Border Radii (using .r for responsive radius)
BorderRadius kradius10 = BorderRadius.circular(10.r);
BorderRadius kradius20 = BorderRadius.circular(20.r);
BorderRadius kradius30 = BorderRadius.circular(30.r);
BorderRadius kradius100 = BorderRadius.circular(100);
