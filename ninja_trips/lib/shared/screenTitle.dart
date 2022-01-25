import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500),
      //tween后面要写明值的类型
      tween: Tween<double>(begin: 0, end: 1),
      //builder就是放回一个新的widget
      //第一个输入context指的是build后面的xontext
      //第二个输入tween的值，也就是开始0，结束1
      //第三个输入指的是这个builder的child也就是后面的Text
      //建立一个新的widget开头用的是tween开始值，结束用的tween结束值
      builder: (context, _value, _child) => Opacity(
        opacity: _value,
        child: Padding(
          padding: EdgeInsets.only(top: _value * 20),
          child: _child,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
