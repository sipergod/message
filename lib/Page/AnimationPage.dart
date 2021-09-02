import 'package:flutter/material.dart';
import 'package:message/Event/PageEvent/AnimationPageEvent.dart';
import 'package:message/Static/Constants.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';

class AnimationPage extends StatefulWidget {
  AnimationPage({Key? key}) : super(key: key);

  @override
  AnimationPageState createState() => new AnimationPageState();
}

class AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationPageEvent animationPageEvent;

  @override
  void initState() {
    animationPageEvent = new AnimationPageEvent(this);

    animationPageEvent.controller = AnimationController(
      duration: animationPageEvent.duration,
      vsync: this,
    )..repeat(reverse: true);

    animationPageEvent.animation = CurvedAnimation(
      parent: animationPageEvent.controller,
      curve: animationPageEvent.curve,
    );

    animationPageEvent.offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(animationPageEvent.animation);

    super.initState();

    animationPageEvent.preLoad();
  }

  @override
  void dispose() {
    animationPageEvent.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarTemplate(
      bodyWidget: Container(
        child: ListView(
          children: [
            buildContainer(),
            buildFadeTransition(),
            buildDecoratedBoxTransition(),
            buildPositionedTransition(),
            buildRotationTransition(),
            buildScaleTransition(),
            buildSizeTransition(),
            buildSlideTransition(),
          ],
        ),
      ),
      listBottomNavigateBar: ListBottomNavigateItem.list,
      bottomNavigateBarIndex: ListBottomNavigateItem.animationIndex,
    );
  }

  Widget buildContainer() {
    return AnimatedContainer(
      duration: animationPageEvent.duration,
      curve: animationPageEvent.curve,
      padding: EdgeInsets.all(Constants.padding),
      width: MediaQuery.of(context).size.width,
      height: animationPageEvent.height + Constants.padding * 2,
      child: AnimatedAlign(
        duration: animationPageEvent.duration,
        alignment: animationPageEvent.randomAlignment(),
        curve: animationPageEvent.curve,
        child: GestureDetector(
          child: AnimatedContainer(
            duration: animationPageEvent.duration,
            width: animationPageEvent.width,
            height: animationPageEvent.height,
            decoration: BoxDecoration(
              color: animationPageEvent.color,
              borderRadius: animationPageEvent.borderRadius,
            ),
            curve: animationPageEvent.curve,
            child: Center(
              child: AnimatedCrossFade(
                firstChild: Image.asset('assets/ic_launcher.png'),
                secondChild: buildAnimatedText(),
                crossFadeState: animationPageEvent.crossFadeState
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: animationPageEvent.duration,
                firstCurve: animationPageEvent.curve,
                secondCurve: animationPageEvent.curve,
                sizeCurve: animationPageEvent.curve,
              ),
            ),
          ),
          onTap: animationPageEvent.doContainerAnimation,
        ),
      ),
    );
  }

  Widget buildAnimatedText() {
    return AnimatedDefaultTextStyle(
      duration: animationPageEvent.duration,
      curve: animationPageEvent.curve,
      child: Text(
        'Animated text',
        textAlign: TextAlign.center,
      ),
      style: TextStyle(
        color: animationPageEvent.textColor,
        fontSize: (animationPageEvent.height + animationPageEvent.width) * 0.1,
      ),
    );
  }

  Widget buildTitleAndExample(String title, Widget example) {
    return Container(
      padding: EdgeInsets.all(Constants.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(child: Text(title)),
          Container(child: example),
        ],
      ),
    );
  }

  Widget buildDecoratedBoxTransition() {
    return buildTitleAndExample(
      'DecoratedBoxTransition',
      DecoratedBoxTransition(
        position: DecorationPosition.background,
        decoration: animationPageEvent.decorationTween
            .animate(animationPageEvent.controller),
        child: Container(
          padding: EdgeInsets.all(Constants.paddingSmall),
          child: FlutterLogo(size: 75),
        ),
      ),
    );
  }

  Widget buildFadeTransition() {
    return buildTitleAndExample(
      'FadeTransition',
      FadeTransition(
        opacity: animationPageEvent.animation,
        child: Container(
          padding: EdgeInsets.all(Constants.paddingSmall),
          child: FlutterLogo(size: 75),
        ),
      ),
    );
  }

  Widget buildPositionedTransition() {
    return buildTitleAndExample(
      'PositionedTransition',
      Container(
        width: 100,
        height: 100,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final Size biggest = constraints.biggest;
          return Stack(
            children: <Widget>[
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                      Rect.fromLTWH(0, 0, 25, 25), biggest),
                  end: RelativeRect.fromSize(
                      Rect.fromLTWH(
                          biggest.width - 75, biggest.height - 75, 75, 75),
                      biggest),
                ).animate(
                  CurvedAnimation(
                    parent: animationPageEvent.controller,
                    curve: Curves.elasticInOut,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(Constants.paddingSmall),
                  child: FlutterLogo(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildRotationTransition() {
    return buildTitleAndExample(
      'RotationTransition',
      RotationTransition(
        turns: animationPageEvent.animation,
        child: Container(
          padding: EdgeInsets.all(Constants.paddingSmall),
          child: FlutterLogo(size: 75),
        ),
      ),
    );
  }

  Widget buildScaleTransition() {
    return buildTitleAndExample(
      'ScaleTransition',
      ScaleTransition(
        scale: animationPageEvent.animation,
        child: Container(
          padding: EdgeInsets.all(Constants.paddingSmall),
          child: FlutterLogo(size: 75),
        ),
      ),
    );
  }

  Widget buildSizeTransition() {
    return buildTitleAndExample(
      'SizeTransition',
      SizeTransition(
        sizeFactor: animationPageEvent.animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: Container(
          padding: EdgeInsets.all(Constants.paddingSmall),
          child: FlutterLogo(size: 75),
        ),
      ),
    );
  }

  Widget buildSlideTransition() {
    return buildTitleAndExample(
      'SlideTransition',
      SlideTransition(
        position: animationPageEvent.offsetAnimation,
        child: Container(
          padding: EdgeInsets.all(Constants.paddingSmall),
          child: FlutterLogo(size: 75),
        ),
      ),
    );
  }
}
