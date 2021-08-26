import 'package:flutter/material.dart';
import 'package:message/Template/CustomDrawerTemplate.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawerTemplate(
      appBarAction: Icon(Icons.settings, color: Colors.white),
      bodyWidget: dashboard(),
      drawerMenu: menu(),
    );
  }

  Widget menu() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Dashboard",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            SizedBox(height: 10),
            Text("Messages",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            SizedBox(height: 10),
            Text("Utility Bills",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            SizedBox(height: 10),
            Text("Funds Transfer",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            SizedBox(height: 10),
            Text("Branches",
                style: TextStyle(color: Colors.white, fontSize: 22)),
          ],
        ),
      ),
    );
  }

  Widget dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              child: PageView(
                controller: PageController(viewportFraction: 0.8),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.redAccent,
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.blueAccent,
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.greenAccent,
                    width: 100,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Transactions",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Macbook"),
                  subtitle: Text("Apple"),
                  trailing: Text("-2900"),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(height: 16);
              },
              itemCount: 10,
            )
          ],
        ),
      ),
    );
  }
}
