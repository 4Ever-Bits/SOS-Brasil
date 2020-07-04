import 'package:flutter/material.dart';

ClipRRect buildImage(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
    child: Image.asset(url),
  );
}

ClipRRect buildImageGreyFilter(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
    child: ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
      child: Image.asset(url),
    ),
  );
}

Container buildSubmitButton(Function handleSubmit) {
  return Container(
    width: 160,
    height: 50,
    margin: EdgeInsets.only(bottom: 20),
    child: OutlineButton(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "Próximo",
          style: TextStyle(fontSize: 18),
        ),
      ),
      textColor: Colors.white,
      borderSide: BorderSide(color: Colors.white),
      highlightedBorderColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: handleSubmit,
    ),
  );
}

Color getCardColor(Color mainColor) {
  Color color;

  print(mainColor);

  if (mainColor.value == Color(0xffef5350).value)
    color = Colors.red;
  else if (mainColor.value == Color(0xff3f51b5).value)
    color = Color(0xFF1A237E);
  else
    color = Color(0xFFFF6130);

  return color;
}

String getImageString(Color mainColor) {
  String str;

  print(mainColor);

  if (mainColor.value == Color(0xffef5350).value)
    str = "Red";
  else if (mainColor.value == Color(0xff3f51b5).value)
    str = "Blue";
  else
    str = "Orange";

  return str;
}
