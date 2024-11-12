// Credit: Vandad Nahavandipoor

import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(
    MaterialApp(
      home: const HomePage(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

const double size = 100;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: size,
            width: double.infinity,
          ),
          AnimatedBuilder(
            animation: Listenable.merge(
              <Listenable?>[
                _xController,
                _yController,
                _zController,
              ],
            ),
            builder: (BuildContext context, Widget? child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_animation.evaluate(_xController))
                ..rotateY(_animation.evaluate(_yController))
                ..rotateZ(_animation.evaluate(_zController)),
              child: Stack(
                children: <Widget>[
                  // front
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(Vector3(0, 0, -size)),
                    child: Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple,
                      ),
                    ),
                  ),

                  // left side
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(pi / 2.0),
                    child: Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                      ),
                    ),
                  ),

                  // right side
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(-pi / 2.0),
                    child: Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  // back
                  Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                  ),

                  // top side
                  Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..rotateX(-pi / 2.0),
                    child: Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange,
                      ),
                    ),
                  ),

                  // bottom side
                  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(pi / 2.0),
                    child: Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.brown,
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
  }
}
