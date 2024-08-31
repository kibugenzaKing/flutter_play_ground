import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(
    GetMaterialApp(
      home: const RobotPage(),
      theme: ThemeData.dark(),
    ),
  );
}

class RobotPage extends StatelessWidget {
  const RobotPage({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<MyRobotController>(
        init: MyRobotController(),
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Stack(
              children: <Widget>[
                const SizedBox(height: 400, width: 300),
                Positioned(
                  left: 15.5,
                  child: Stack(
                    children: <Widget>[
                      const SizedBox(height: 120, width: 170),
                      Positioned(
                        top: 40,
                        left: 18,
                        child: Container(
                          height: 30,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _.mainColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 18,
                        child: Container(
                          height: 30,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _.mainColor,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        right: 30,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _.mainColor,
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  const SizedBox(width: 25, height: 30),
                                  Positioned(
                                    left: 5,
                                    right: 5,
                                    child: Container(
                                      height: 30,
                                      width: 15,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.elliptical(15, 15),
                                          topRight: Radius.elliptical(15, 15),
                                        ),
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          const Spacer(),
                                          Container(
                                            height: 4,
                                            width: 4,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _.mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          const Spacer(),
                                          Container(
                                            height: 4,
                                            width: 4,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _.mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 30,
                                height: 5,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(30, 15),
                                    topRight: Radius.elliptical(30, 15),
                                  ),
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                    left: BorderSide(color: Colors.grey),
                                    right: BorderSide(color: Colors.grey),
                                  ),
                                  color: Colors.black,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 2.3,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _.mainColor,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 5,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.elliptical(30, 15),
                                    bottomRight: Radius.elliptical(30, 15),
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 113,
                  left: 5,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: _.mainColor,
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 0,
                  child: Container(
                    color: Colors.red,
                    height: 30,
                    width: 50,
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 0,
                  child: Container(
                    color: Colors.red,
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class MyRobotController extends GetxController {
  Color mainColor = const Color.fromARGB(255, 170, 130, 130);
}
