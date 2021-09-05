import 'package:flutter/material.dart';
import 'package:message/Static/Constants.dart';

class SkeletonLoadWidget extends StatefulWidget {
  final Color? beginColor;
  final Color? endColor;
  final Widget? child;
  SkeletonLoadWidget({
    Key? key,
    this.beginColor,
    this.endColor,
    this.child,
  }) : super(key: key);

  @override
  SkeletonLoadWidgetState createState() => new SkeletonLoadWidgetState();
}

class SkeletonLoadWidgetState extends State<SkeletonLoadWidget>
    with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<Color?> animationOne;
  late Animation<Color?> animationTwo;
  late Color beginColor;
  late Color endColor;

  BoxDecoration defaultBoxDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.white70,
  );

  @override
  void initState() {
    super.initState();

    if (widget.beginColor == null) {
      beginColor = Colors.grey.shade100;
    } else {
      beginColor = widget.beginColor!;
    }
    if (widget.endColor == null) {
      endColor = Colors.grey;
    } else {
      endColor = widget.endColor!;
    }

    animationController = new AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    animationOne = ColorTween(
      begin: beginColor,
      end: endColor,
    ).animate(animationController);

    animationTwo = ColorTween(
      begin: endColor,
      end: beginColor,
    ).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
                  colors: [animationOne.value!, animationTwo.value!])
              .createShader(bounds);
        },
        child: Container(
          width: double.infinity,
          /*decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white70,
          ),*/
          child: widget.child == null
              ? Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: Constants.paddingSmall,
                                bottom: Constants.paddingSmall,
                              ),
                              width: double.infinity,
                              height: 15,
                              decoration: defaultBoxDecor,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: Constants.paddingSmall,
                                bottom: Constants.paddingSmall,
                              ),
                              width: double.infinity,
                              height: 15,
                              decoration: defaultBoxDecor,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: Constants.paddingSmall,
                                bottom: Constants.paddingSmall,
                              ),
                              width: double.infinity,
                              height: 50,
                              decoration: defaultBoxDecor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : widget.child,
        ),
      ),
    );
  }
}
