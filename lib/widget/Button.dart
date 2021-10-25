
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Widget? child;
  final double? height;
  final double? topRightRound;
  final double? topLeftRound;
  final double? bottomRightRound;
  final double? bottomLeftRound;
  final Color? borderColor;
  final Color? buttonColor;
  final Color? textColor;
  final String? text;
  final VoidCallback? functionClick;
  Button({
    key,
    this.child,
    this.topRightRound,
    this.topLeftRound,
    this.bottomRightRound,
    this.bottomLeftRound,
    this.borderColor,
    this.buttonColor,
    this.height,
    this.textColor,
    this.text,
    this.functionClick,
  }) : super(key: key);
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      child: RaisedButton(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(widget.bottomLeftRound??0),
                bottomRight: Radius.circular(widget.bottomRightRound??0),
                topLeft: Radius.circular(widget.topLeftRound??0),
                topRight: Radius.circular(widget.topRightRound??0)),
            side: BorderSide(color: widget.borderColor??Colors.white)),
        textColor: widget.textColor,
        color: widget.buttonColor,
        child: widget.child,
        onPressed: widget.functionClick,
      ),
    );
  }
}
