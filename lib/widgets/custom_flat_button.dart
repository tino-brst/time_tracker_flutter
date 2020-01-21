import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final Image trailing;
  final VoidCallback onPressed;

  const CustomFlatButton(
    this.text, {
    this.color,
    this.textColor,
    this.padding,
    this.trailing,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: color,
      onPressed: onPressed,
      disabledColor: color?.withOpacity(0.5),
      disabledTextColor: textColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
          SizedBox(
            height: 22,
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
          )
        ],
      ),
    );
  }
}
