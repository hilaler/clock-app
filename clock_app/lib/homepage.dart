import 'package:clock_app/clock_view.dart';
import 'package:clock_app/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/enums.dart';
import 'package:clock_app/data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var formattedTime = DateFormat('HH:mm').format(DateTime.now());
    var formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          const VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType != MenuType.clock) return Container();

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          "Clock",
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              formattedTime,
                              style: const TextStyle(
                                  fontFamily: 'avenir',
                                  color: Colors.white,
                                  fontSize: 64),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  fontFamily: 'avenir',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Align(
                              alignment: Alignment.center,
                              child: ClockView(
                                size: MediaQuery.of(context).size.height / 4,
                              ))),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: currentMenuInfo.menuType == value.menuType
                ? Colors.red
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                // bottomRight: Radius.circular(32),
              ),
            ),
          ),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 1.5,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title,
                style: const TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 14),
              )
            ],
          ),
        );
      },
    );
  }
}
