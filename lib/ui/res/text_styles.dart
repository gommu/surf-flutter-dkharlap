import 'package:flutter/painting.dart';
import 'package:places/ui/res/colors.dart';

// Text Styles
TextStyle _text = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  color: textColorPrimary,
);

//Regular
TextStyle textRegular14Primary = _text.copyWith(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: textColorPrimary,
);
TextStyle textRegular14Secondary = _text.copyWith(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: textColorSecondary,
);

//Medium
TextStyle textMedium16Primary = _text.copyWith(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: textColorPrimary,
);

//Bold
TextStyle textButtonBoldActive = _text.copyWith(
  fontWeight: FontWeight.bold,
  color: textButtonActive,
);

TextStyle textBold14Primary = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: textColorPrimary,
);

TextStyle textBold24Primary = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 24,
  color: textColorPrimary,
);

TextStyle textBold14PrimaryWhite = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: textColorWhite,
);
