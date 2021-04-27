import 'package:flutter/material.dart';

final ButtonStyle cardActionStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0.0),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  padding: MaterialStateProperty.all(EdgeInsets.zero),
  minimumSize: MaterialStateProperty.all(
    Size(
      24,
      24,
    ),
  ),
);

final ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.green),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final ButtonStyle placeActionButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all(EdgeInsets.zero),
);

final ButtonStyle backButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0.0),
  padding: MaterialStateProperty.all(EdgeInsets.zero),
  backgroundColor: MaterialStateProperty.all(Colors.white),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
