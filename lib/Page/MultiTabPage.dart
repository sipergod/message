import 'package:flutter/material.dart';
import 'package:message/Component/Fragment/AnimatedDialog.dart';
import 'package:message/Event/PageEvent/MultiTabPageEvent.dart';
import 'package:message/Static/Constants.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Static/ListBuildItem/ListTabItem.dart';
import 'package:message/Template/MultiTabTemplate.dart';

class MultiTabPage extends StatefulWidget {
  MultiTabPage({Key? key}) : super(key: key);

  @override
  MultiTabPageState createState() => new MultiTabPageState();
}

class MultiTabPageState extends State<MultiTabPage>
    with TickerProviderStateMixin {
  late MultiTabPageEvent multiTabEvent;
  late OverlayEntry _popupDialog;
  List<String> imageUrls = [
    'assets/ic_launcher.png',
    'assets/ic_launcher.png',
    'assets/ic_launcher.png',
    'assets/ic_launcher.png',
    'assets/ic_launcher.png',
    'assets/ic_launcher.png',
  ];

  @override
  void initState() {
    multiTabEvent = new MultiTabPageEvent(this);
    multiTabEvent.tabController = new TabController(
      length: ListTabItem.list.length,
      vsync: this,
    );
    multiTabEvent.preLoad();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiTabTemplate(
      listTab: ListTabItem.list,
      tabController: multiTabEvent.tabController,
      bodyWidget: TabBarView(
        controller: multiTabEvent.tabController,
        children: ListTabItem.list.map((Map<String, dynamic> item) {
          return Center(
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              children: List.generate(multiTabEvent.tabController.index + 1,
                      (index) => imageUrls[index])
                  .map(_createGridTileWidget)
                  .toList(),
            ),
          );
        }).toList(),
      ),
      listBottomNavigateBar: ListBottomNavigateItem.list,
      bottomNavigateBarIndex: 1,
    );
  }

  Widget _createGridTileWidget(String image) {
    return Container(
      padding: EdgeInsets.all(Constants.paddingMedium),
      child: GestureDetector(
        onLongPress: () {
          _popupDialog = _createPopupDialog(image);
          Overlay.of(context)!.insert(_popupDialog);
        },
        onLongPressEnd: (details) => _popupDialog.remove(),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }

  OverlayEntry _createPopupDialog(String image) {
    return OverlayEntry(
      builder: (context) => AnimatedDialog(
        child: _createPopupContent(image),
      ),
    );
  }

  Widget _createPhotoTitle() {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/ic_launcher.png'),
          ),
          title: Text(
            'flutter',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ));
  }

  Widget _createPopupContent(String image) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _createPhotoTitle(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Image.asset(image, fit: BoxFit.none),
            ),
            _createActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _createActionBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.favorite_border,
            color: Colors.black,
          ),
          Icon(
            Icons.chat_bubble_outline_outlined,
            color: Colors.black,
          ),
          Icon(
            Icons.send,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
