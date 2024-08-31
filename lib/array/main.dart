import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(
    GetMaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<Cont>(
        init: Cont(),
        builder: (_) {
          final int? nob = _.number;
          final List<String> images = <String>[
            'images/array/el1.png',
            'images/array/el2.png',
            'images/array/el3.webp',
            'images/array/el4.webp',
          ];
          return Scaffold(
            body: Center(
              child: Container(
                height: 520,
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 600,
                      height: 40,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          'Array Index Example',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 600,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(images[0]),
                              ),
                            ),
                          ),
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(images[1]),
                              ),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(images[2]),
                              ),
                            ),
                          ),
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(images[3]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Index number: ${_.number ?? ''} ',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: _.add,
                                child: const Icon(
                                  Icons.arrow_drop_up_outlined,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              ),
                              InkWell(
                                onTap: _.reduce,
                                child: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (nob != null && nob > images.length - 1)
                      const SelectableText(
                        'un defined index',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else if (nob != null && nob < 0)
                      const SelectableText(
                        'arrays don\'t have negatives (-)',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else if (nob != null &&
                        !nob.isNegative &&
                        images.elementAtOrNull(nob) != null)
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(images[nob]),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class Cont extends GetxController {
  int? number;

  void add() {
    number = (number ??= 0) + 1;
    update();
  }

  void reduce() {
    number = (number ??= 0) - 1;
    update();
  }
}
