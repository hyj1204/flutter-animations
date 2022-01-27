import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  //1. 创建一个animationcontroller
  // 在initState里面创建它

  AnimationController _controller;
  bool isFav = false;

//4. 创建一个动画，这个动画是使用当前的_controller去实现一个colorTween
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  Animation _curve;

  @override
  void initState() {
    super.initState();
    //2. vsync 里面放的是一个tickerProvider 所以我们要给这个state TickerProvider的功能
    //vsync里面的this指的是这个state本身（因为with所以有了singleTicker的能力)
    //意思就是说让这个controller跟这个state的ticker同步
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
//5. 这一步就是给tween一个controller然后它就变成了一个animation
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInExpo);

    _colorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_curve);

//9.变大再变小，也就是一组tween的list用TweenSequence
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      //weight指的是这部分所占的时间
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_curve);

//3. 播放动画，会默认从0-1走ticker,也就是controller.value会从0到1
    _controller.addListener(() {
      // print(_controller.value); //6. 还是显示0-1的值
      // print(_colorAnimation.value);
      //6. 显示的是从grey到red的颜色
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //7. animation里面放AnimationController
      animation: _controller,
      //8. builder里面放要做的动画，child指的是动画里面包的子widget(当前没有)
      builder: (context, child) => IconButton(
        icon: Icon(
          Icons.favorite,
          color: _colorAnimation.value,
          size: _sizeAnimation.value,
        ),
        onPressed: () {
          isFav ? _controller.reverse() : _controller.forward();
        },
      ),
    );
  }
}
