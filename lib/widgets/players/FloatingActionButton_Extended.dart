import 'package:flutter/material.dart';

class FloatingActionButton_Extended extends StatefulWidget {
  final BuildContext buildContext;
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FloatingActionButton_Extended(BuildContext this.buildContext,{this.onPressed, this.tooltip, this.icon});

  @override
  _FloatingActionButton_Extended createState() => _FloatingActionButton_Extended();
}

class _FloatingActionButton_Extended extends State<FloatingActionButton_Extended>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 52.0;


  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Theme.of(widget.buildContext).accentColor,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval( 0.00, 1.00, curve: Curves.linear),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval( 0.0, 0.75, curve: _curve),
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

  Widget addReport() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        mini: true,
        disabledElevation: _animateIcon.value * 4,
        onPressed: null,
        tooltip: 'Add Report',
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(Icons.add,color: Theme.of(context).accentColor),
      ),
    );
  }


  Widget editProfile() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        mini: true,
        disabledElevation: _animateIcon.value * 4,
        onPressed: null,
        tooltip: 'Edit Profile',
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(Icons.edit,color: Theme.of(context).accentColor),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: addReport(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 1.0,
            0.0,
          ),
          child: editProfile(),
        ),
        toggle(),
      ],
    );
  }
}