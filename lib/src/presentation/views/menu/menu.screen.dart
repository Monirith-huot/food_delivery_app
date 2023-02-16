import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';

import 'widget/categorySelection.widget.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class MenuScreen extends StatefulWidget {
  final List foodCategory;
  final String restaurantName;
  final String restaurantImage;
  final String discount;
  final String restaurantId;
  final String userId;
  const MenuScreen({
    Key? key,
    required this.foodCategory,
    required this.restaurantName,
    required this.restaurantImage,
    required this.discount,
    required this.restaurantId,
    required this.userId,
  }) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController =
        TabController(length: widget.foodCategory.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var top = 259.0;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final cartItem = snapshot.data!['order'];
        double totalCartPrice = cartItem
            .map((order) => order['orderFood']
                .fold(0, (sum, item) => sum + item['totalPrice']))
            .reduce((sum, value) => sum + value);

        return Scaffold(
          backgroundColor: Colors.white,
          body: VerticalScrollableTabView(
            tabController: tabController,
            listItemData: widget.foodCategory,
            verticalScrollPosition: VerticalScrollPosition.begin,
            eachItemChild: (object, index) => GestureDetector(
              onTap: () {},
              child: CategorySelectionWidget(
                userId: widget.userId,
                restaurantId: widget.restaurantId,
                discount: widget.discount,
                eachCategoryFood: object["food"],
                eachCategoryName: object['name'],
              ),
            ),
            slivers: [
              SliverAppBar(
                snap: false,
                pinned: true,
                floating: false,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    top = constraints.biggest.height;
                    print(top);
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: top < 165
                          ? Text(
                              widget.restaurantName,
                              style: const TextStyle(
                                color: COLORS.white,
                                fontSize: SIZE.textSize,
                                fontWeight: FontWeight.bold,
                              ), //TextStyle
                            )
                          : SizedBox(),
                      titlePadding: const EdgeInsets.only(
                        bottom: 70,
                      ),
                      background: Image(
                        image: NetworkImage(
                          widget.restaurantImage,
                        ),
                        fit: BoxFit.fill,
                        height: 150,
                      ),
                    ); //Text
                  },
                ), //FlexibleSpaceBar
                expandedHeight: 200, //FlexibleSpaceBar

                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    // if (itemsInCart.length > 0) {
                    //   print("back");
                    //   showAlertDialog(context);
                    // } else {
                    //   Navigator.pop(context);
                    // }
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: COLORS.primary,
                actions: <Widget>[
                  // Badge(
                  //   position: BadgePosition.topEnd(top: 0, end: 3),
                  //   animationDuration: Duration(milliseconds: 300),
                  //   animationType: BadgeAnimationType.slide,
                  //   badgeColor: Colors.white,
                  //   badgeContent: Text(
                  //     itemsInCart.length.toString(),
                  //   ),
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.shopping_cart,
                  //       color: Colors.white,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => CartScreen(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ), //IconButton
                ], //<Widget>[]
                bottom: TabBar(
                  isScrollable: true,
                  controller: tabController,
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicatorWeight: 3.0,
                  tabs: widget.foodCategory.map((e) {
                    return Tab(text: e["name"]);
                  }).toList(),
                  onTap: (index) {
                    VerticalScrollableTabBarStatus.setIndex(index);
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: cartItem.length > 0
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewCartScreen(),
                      ),
                    );
                  },
                  label: Row(
                    children: [
                      Text("(${cartItem.length.toString()})"),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text(
                        "View your charts",
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text("${totalCartPrice.toStringAsFixed(2)}\$"),
                    ],
                  ),
                  backgroundColor: COLORS.primary,
                )
              : SizedBox(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
