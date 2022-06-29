import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

import 'constants.dart';

Widget textFormField({
  TextEditingController controller,
  Widget suffixIcon,
  Widget prefixIcon,
  OutlineInputBorder enabledBorder,
  OutlineInputBorder focusedBorder,
  Color fillColor,
  Color cursorColor,
  String hintText,
  String labelText,
  TextStyle hintStyle,
  TextStyle labelStyle,
  TextStyle style,
  bool filled,
  int maxLines,
//  TextInputAction textInputAction,
  TextInputType keyboardType,
  Function validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      fillColor: fillColor,
      hintText: hintText,
      hintStyle: hintStyle,
      labelText: labelText,
      labelStyle: labelStyle,
      filled: filled,
    ),
    style: style,
    // textInputAction: textInputAction,
    validator: validator,
    cursorColor: cursorColor,
    maxLines: maxLines,
    keyboardType: keyboardType,
  );
}

OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    width: 1.3,
    color: indigo,
  ),
);

OutlineInputBorder enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    color: Colors.grey[400],
  ),
);

navigatorPush(context, screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

navigatorReplacement(context, screen) {
  return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Widget profileItem({
  @required BuildContext context,
  String title,
  String content,
  Function onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 15.0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: indigo, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[50],
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    content,
                    style: TextStyle(
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white,
                    ),
                    width: 35,
                    height: 35,
                    child: Icon(
                      IconBroken.Edit,
                      color: indigo,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget gradientButton({@required BuildContext context,Function onPressed,Widget title}){
  return Container(
    clipBehavior: Clip.antiAlias,
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [
            indigo,
            Colors.blue[400],
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )),
    child: MaterialButton(
      onPressed: onPressed,
      child: title,
    ),
  );
}