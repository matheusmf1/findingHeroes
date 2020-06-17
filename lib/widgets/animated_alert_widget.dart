import 'package:flutter/material.dart';


class AnimatedAlertWidget extends StatefulWidget {
  final Icon icon;
  final String title;
  const AnimatedAlertWidget(this.icon, this.title);
  
  @override
  _AnimatedAlertWidgetState createState() => _AnimatedAlertWidgetState();
}

class _AnimatedAlertWidgetState extends State<AnimatedAlertWidget> 
with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(30),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: <Widget>[
                widget.icon,
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(widget.title),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}

