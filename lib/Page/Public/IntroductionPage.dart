import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/ListBuildItem/ListIntroductionScreenItem.dart';

class IntroductionPage extends StatefulWidget {
  IntroductionPage({Key? key}) : super(key: key);

  @override
  IntroductionPageState createState() => new IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Image.asset('assets/ic_launcher.png', height: 100,),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: onDoneIntroduction,
        ),
      ),
      pages: ListIntroductionScreenItem.list.map((item) {
        return PageViewModel(
          title: item['title'],
          body: item['body'],
          image: Image.asset('assets/' + item['image']),
        );
      }).toList(),
      onDone: onDoneIntroduction,
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  void onDoneIntroduction() {
    ApplicationInitSettings.instance.sharedPreferences.setBool('Welcome', false);
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
