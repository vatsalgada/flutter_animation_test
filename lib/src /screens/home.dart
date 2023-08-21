import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }

  @override
  Widget build(context) {
    //returning something(widget) so that the null is not hit for the parent
    return Scaffold(
        appBar: AppBar(
          title: Text("animation!"),
        ),
        body: GestureDetector(
          child: buildAnimation(),
          onTap: onTap,
        ));
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (context, child) {
          return Container(
            child: child,
            margin: EdgeInsets.only(top: catAnimation.value),
          );
        },
        child: Cat());
  }
}
