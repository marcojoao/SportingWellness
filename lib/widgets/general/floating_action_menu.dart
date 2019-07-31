import 'package:flutter/material.dart';

class FloatingActionMenu extends StatefulWidget {
  static String tag = 'FloatingActionMenu';
  List<Widget> children = const <Widget>[];
  final void Function(double) onProgressChanged;

  final Color closedColor;
  final Color openedColor;
  final AnimatedIconData toogleAnimatedIconData;

  FloatingActionMenu(
      {this.children,
      this.onProgressChanged,
      this.openedColor,
      this.closedColor,
      this.toogleAnimatedIconData});

  @override
  _FloatingActionMenu createState() => _FloatingActionMenu();
}

class _FloatingActionMenu extends State<FloatingActionMenu>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 50;
  double _childSpacing = 10;
  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: widget.closedColor ?? Colors.green,
      end: widget.openedColor ?? Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.00, 1.00, curve: Curves.linear),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -_childSpacing,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.75, curve: _curve),
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {

    return Container(
      child: FloatingActionButton(
        heroTag: "floating_action_menu_toggle",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        child: AnimatedIcon(
          icon: widget.toogleAnimatedIconData ?? AnimatedIcons.menu_close,
          progress: _animateIcon
        ),
      ),
    );
  }

  List<Widget> getWidgets(List<Widget> items) {
    List<Widget> list = new List<Widget>();
    if (items == null) {
      list.add(toggle());
      return list;
    }
   

    for (var i = 0; i < items.length; i++) {
      list.add(
        Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * (items.length - i),
              0.0,
            ),
            child: items[i]),
      );
    }

    list.add(toggle());
    if (widget.onProgressChanged != null) {
      widget.onProgressChanged(_animateIcon.value);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: getWidgets(widget.children),
    );
  }
}