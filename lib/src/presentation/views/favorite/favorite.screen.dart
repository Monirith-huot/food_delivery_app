import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/widget/widget.dart';

class FavoriteScreen extends StatefulWidget {
  final String uuid;
  const FavoriteScreen({Key? key, required this.uuid}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uuid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:
                  const HeroIcon(HeroIcons.chevronLeft, color: COLORS.primary),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: COLORS.white,
            title: const CustomText(
              text: "Favorite",
              size: SIZE.titleTextSize,
              color: COLORS.primary,
              weight: FontWeight.normal,
            ),
            actions: [
              GestureDetector(
                child: const HeroIcon(
                  HeroIcons.trash,
                  color: COLORS.primary,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(30),
            child: snapshot.data!['favorite'].length > 0
                ? ListView.builder(
                    itemCount: snapshot.data!['favorite'].length,
                    itemBuilder: (ctx, index) {
                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("restaurant ")
                            .doc(snapshot.data!['favorite'][index].trim())
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          print(snapshot.data);
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return SpecialOfferCardWidget(
                              restaurant: snapshot.data!.data()
                                  as Map<String, dynamic>);
                        },
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/bookmark.png",
                          width: 100,
                          height: 100,
                        ),
                        const CustomText(
                          text: "You dont have any favorite restaurants yet !!",
                          size: SIZE.subTextSize,
                          color: COLORS.primary,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}


//  Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
                    // GestureDetector(
                    //   child: const HeroIcon(
                    //     HeroIcons.chevronLeft,
                    //     color: COLORS.primary,
                    //   ),
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    // ),
//                     const CustomText(
//                       text: "Favorite",
//                       size: SIZE.titleTextSize,
//                       color: COLORS.primary,
//                       weight: FontWeight.normal,
//                     ),
//                     GestureDetector(
//                       child: const HeroIcon(
//                         HeroIcons.trash,
//                         color: COLORS.primary,
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),

// return ListView(
//   children: snapshot.data!.docs.map((DocumentSnapshot document) {
//     Map<String, dynamic> data =
//         document.data()! as Map<String, dynamic>;
//     return ListTile(
//       title: Text(data['full_name']),
//       subtitle: Text(data['company']),
//     );
//   }).toList(),
// );

// return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance
//         .collection("users")
//         .doc("documentID")
//         .snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return Text('Something went wrong');
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Text("Loading");
//       }
//       return Scaffold(
//         body: Padding(
//           padding: EdgeInsets.all(30),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     child: const HeroIcon(
//                       HeroIcons.chevronLeft,
//                       color: COLORS.primary,
//                     ),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const CustomText(
//                     text: "Favorite",
//                     size: SIZE.titleTextSize,
//                     color: COLORS.primary,
//                     weight: FontWeight.normal,
//                   ),
//                   GestureDetector(
//                     child: const HeroIcon(
//                       HeroIcons.trash,
//                       color: COLORS.primary,
//                     ),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//               Container(
//                 height: 150,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children:
//                       snapshot.data!.docs.map((DocumentSnapshot document) {
//                     String data = document.data()! as String;
//                     print(data);
//                     return Padding(
//                       padding: const EdgeInsets.only(
//                         right: 50,
//                       ),
//                       child: Container(
//                         height: 150,
//                         width: SIZE.cardWidth,
//                         // child: SpecialOfferCardWidget(
//                         //   restaurant: data,
//                         // ),
//                         child: Container(),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
