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
TextStyle textRegular14CardDescription = _text.copyWith(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: textColorCardDescription,
);

//Medium
TextStyle textMedium16Primary = _text.copyWith(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: textColorPrimary,
);

TextStyle textMedium18PrimaryHeader = _text.copyWith(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: textColorPrimaryHeader,
);

TextStyle textMedium18Secondary = _text.copyWith(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: textColorSecondary,
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

TextStyle textBold14 = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 14,
);

TextStyle textBold24Primary = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 24,
  color: textColorPrimary,
);

TextStyle textBold32PrimaryHeader = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 32,
  color: textColorPrimary,
);

TextStyle textBold14PrimaryWhite = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: textColorWhite,
);
