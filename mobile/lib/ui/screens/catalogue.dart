import 'package:flutter/material.dart';
import 'package:pfe/ui/widgets/furniture.dart';
import 'package:pfe/ui/widgets/trustyhorizontalmenu.dart';

import '../tabicon.dart';
import 'maps.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({Key key, AnimationController animationController});
  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Maps();

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = Maps(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Furniture",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                alignment: Alignment.center,
                child: TrustyHorizontalMenu(
                  list: [
                    "T-shirt",
                    "shorts",
                    "Sneaker",
                    "ball",
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 17,
                  ),
                  itemBuilder: (ctx, i) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(0, 3),
                              blurRadius: 3.0),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(9.0),
                                  topRight: Radius.circular(9.0),
                                ),
                                color: Color(0xffe5e6ea),
                              ),
                              child: Image.network(
                                  "https://yi-files.s3.amazonaws.com/products/30000/30412/30420-cover.jpg"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "T-shirt",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                Text(
                                  "Free mind and body",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .apply(color: Colors.grey[500]),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "\$29",
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .apply(fontWeightDelta: 2),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) {
                                              return CartScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.tealAccent[700],
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[500],
                                              blurRadius: 5.0,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
