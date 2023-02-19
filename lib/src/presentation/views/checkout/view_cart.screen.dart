import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class ViewCartScreen extends StatefulWidget {
  final String userId;
  const ViewCartScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ViewCartScreenState createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  @override
  int _currentStep = 1;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Cart",
          style: TextStyle(color: COLORS.primary),
        ),
        // centerTitle: false,
        backgroundColor: COLORS.white,
        leading: IconButton(
          icon: _currentStep == 2
              ? Icon(Icons.arrow_back_ios)
              : Icon(Icons.clear),
          color: COLORS.primary,
          onPressed: () {
            if (_currentStep == 2) {
              setState(() {
                _currentStep = 1;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (snapshot.hasData) {
            print(snapshot.data?.data());
          }
          final cartItem = snapshot.data!['order'];

          double totalCartPrice = cartItem.isEmpty
              ? 0
              : cartItem
                  .map((order) => order['orderFood']
                      .fold(0, (sum, item) => sum + item['totalPrice']))
                  .reduce((sum, value) => sum + value);
          final height = MediaQuery.of(context).size.height;
          return Theme(
            data: ThemeData(
              canvasColor: COLORS.white,
              colorScheme: ColorScheme.light(
                primary: COLORS.primary,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    controlsBuilder: (context, controller) {
                      return const SizedBox.shrink();
                    },
                    type: StepperType.horizontal,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    steps: <Step>[
                      //Menu
                      Step(
                        title: new Text('Menu'),
                        content: SizedBox(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),

                      //Carts
                      Step(
                        title: const Text('Carts'),
                        content: SizedBox(
                          height: height - 300,
                          child: ListView.builder(
                            itemCount: cartItem.length,
                            itemBuilder: (context, index) {
                              var order = cartItem[index]['orderFood'][0];

                              int _counterValue =
                                  cartItem[index]['orderFood'][0]['quantity'];

                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(
                                                  50), // Image radius
                                              child: Image.network(
                                                order['food']['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15.0),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 200,
                                                child: CustomText(
                                                  text: order['food']['name'],
                                                  size: SIZE.textSize,
                                                  color: COLORS.black,
                                                  weight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                height: SIZE.buttonHeight,
                                                color: COLORS.primary,
                                                child: CounterButton(
                                                  removeIcon: _counterValue == 1
                                                      ? Icon(Icons.delete)
                                                      : Icon(Icons.remove),
                                                  countColor: COLORS.white,
                                                  loading: false,
                                                  onChange: (int val) {
                                                    setState(() {
                                                      if (cartItem.length ==
                                                          1) {
                                                        if (val == 0) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(
                                                                  widget.userId)
                                                              .update({
                                                            'order': FieldValue
                                                                .arrayRemove([
                                                              cartItem[index]
                                                            ]),
                                                          }).then((value) =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop());
                                                        } else {
                                                          //bug fix this bug
                                                          //update their quality
                                                          _counterValue = val;
                                                        }
                                                      } else {
                                                        if (val == 0) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(
                                                                  widget.userId)
                                                              .update({
                                                            'order': FieldValue
                                                                .arrayRemove([
                                                              cartItem[index]
                                                            ]),
                                                          });
                                                        } else {
                                                          print(
                                                              cartItem[index]);
                                                          //update their value
                                                          //bug: fix this by today
                                                          // FirebaseFirestore
                                                          //     .instance
                                                          //     .collection(
                                                          //         "users")
                                                          //     .doc(
                                                          //         widget.userId)
                                                          //     .update(
                                                          //   {
                                                          //     "order": FieldValue
                                                          //         .arrayUnion(
                                                          //       [
                                                          //         {

                                                          //         },
                                                          //       ],
                                                          //     )
                                                          //   },
                                                          // );
                                                        }

                                                        // FirebaseFirestore
                                                        //     .instance
                                                        //     .collection('users')
                                                        //     .doc(widget.userId)
                                                        //     .update({
                                                        //   'order': FieldValue
                                                        //       .arrayRemove([
                                                        //     cartItem[index]
                                                        //   ]),
                                                        // });
                                                      }
                                                    });
                                                  },
                                                  count: _counterValue,
                                                  buttonColor: COLORS.white,
                                                  progressColor: COLORS.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          CustomText(
                                            text: order['totalPrice']
                                                    .toStringAsFixed(2) +
                                                "\$",
                                            size: SIZE.textSize,
                                            color: COLORS.primary,
                                            weight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),

                      //review
                      Step(
                        title: new Text("Review"),
                        content: Column(
                            // children: <Widget>[
                            //   TextFormField(
                            //     decoration:
                            //         InputDecoration(labelText: 'Mobile Number'),
                            //   ),
                            // ],
                            ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
                Material(
                  elevation: 20,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: const [
                                CustomText(
                                  text: "Total",
                                  size: SIZE.textSize,
                                  color: COLORS.black,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  text: "(incl.VAT)",
                                  size: SIZE.textSize,
                                  color: COLORS.grey,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Spacer(),
                            CustomText(
                              text: totalCartPrice.toStringAsFixed(2) + " \$",
                              size: SIZE.textSize,
                              color: COLORS.black,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // ElevatedButton(onPressed: onPressed, child: child)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // _currentStep == 1 ? _currentStep += 1 : null;
                              _currentStep == 1
                                  ? _currentStep += 1
                                  : _currentStep == 2
                                      ? print("Hello world")
                                      : null;
                            });
                          },
                          child: Container(
                            height: SIZE.buttonHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: COLORS.primary,
                            ),
                            child: Center(
                              child: CustomText(
                                text: _currentStep == 1
                                    ? "Review your order"
                                    : "Checkout",
                                size: SIZE.textSize,
                                color: COLORS.white,
                                weight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0
        ? setState(
            () => _currentStep != 1 ? _currentStep -= 1 : _currentStep = 1)
        : null;
  }
}

// Define a list of steps for the stepper
