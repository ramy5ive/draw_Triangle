import 'package:flutter/material.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Offsets Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Home1 createState() {
    return Home1();
  }
}

class Home1 extends State<Home> {
  double x = 1;
  double y = 1;
  double x1 = 1;
  double y1 = 1;
  double x2 = 1;
  double y2 = 1;
  double distance(double x, double y, double x1, double y1) {
    return sqrt(pow(x - x1, 2) + pow(y - y1, 2));
  }

  double perimeter(double x, double y, double z) {
    return x + y + z;
  }

  double angle1() {
    return acos((pow(distance(x, y, x1, y1), 2) +
                pow(distance(x, y, x2, y2), 2) -
                pow(distance(x2, y2, x1, y1), 2)) /
            (2 * distance(x, y, x2, y2) * (distance(x, y, x1, y1)))) *
        (180 / pi);
  }

  double angle2() {
    return acos((pow(distance(x, y, x1, y1), 2) +
                pow(distance(x1, y1, x2, y2), 2) -
                pow(distance(x, y, x2, y2), 2)) /
            (2 * distance(x, y, x1, y1) * (distance(x, y, x1, y1)))) *
        (180 / pi);
  }

  double angle3() {
    return acos((pow(distance(x, y, x2, y2), 2) +
                pow(distance(x1, y1, x2, y2), 2) -
                pow(distance(x, y, x1, y1), 2)) /
            (2 * distance(x1, y1, x2, y2) * (distance(x, y, x2, y2)))) *
        (180 / pi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                "perimeter is ${perimeter(distance(x, y, x1, y1), distance(x, y, x2, y2), distance(x2, y1, x2, y1))}")),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 354,
                  height: 58,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 354,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xff00ffe4), Color(0x0000ffe4)],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 354,
                              height: 58,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff00ffe4),
                                    Color(0x0000ffe4)
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 351,
                                  height: 57,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xff0de8e8),
                                      width: 2,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color(0xff87f7f0),
                                        Color(0x0087f7f0)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //  Text("angle a: ${angle1()}"),
                //Text("angle b: ${(angle2())}"),
                //Text("angle c: ${(angle3())}"),
                //Text("${angle1()+angle2()+angle3()}")
              ],
            ),
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: PlaygroundPainter(
                  dx: x, dy: y, dx1: x1, dy1: y1, dx2: x2, dy2: y2),
            ),
            Positioned(
              width: 10,
              height: 10,
              left: y,
              top: x,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    x += details.delta.dy;
                    y += details.delta.dx;
                  });
                },
                child: Container(
                  color: Colors.red,
                  child: Text("A"),
                ),
              ),
            ),
            Positioned(
              width: 10,
              height: 10,
              left: y1,
              top: x1,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    x1 += details.delta.dy;
                    y1 += details.delta.dx;
                  });
                },
                child: Container(
                  color: Colors.red,
                  child: Text("B"),
                ),
              ),
            ),
            Positioned(
              width: 10,
              height: 10,
              left: y2,
              top: x2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    x2 += details.delta.dy;
                    y2 += details.delta.dx;
                  });
                },
                child: Container(
                  color: Colors.red,
                  child: Text("C"),
                ),
              ),
            )
          ],
        ));
  }
}

class PlaygroundPainter extends CustomPainter {
  double? dx;
  double? dy;
  double? dx1;
  double? dy1;
  double? dx2;
  double? dy2;
  PlaygroundPainter({this.dx, this.dy, this.dx1, this.dy1, this.dx2, this.dy2});
  @override
  void paint(Canvas canvas, Size size) {
    /// We shift the coordinates of the canvas
    /// so that the point of origin moves to the center of the screen
    //canvas.translate(size.width/2, size.height/2);

    canvas.drawLine(
        Offset(dy!, dx!),
        Offset(dy1!, dx1!),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);
    canvas.drawLine(
        Offset(dy1!, dx1!),
        Offset(dy2!, dx2!),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);
    canvas.drawLine(
        Offset(dy2!, dx2!),
        Offset(dy!, dx!),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);
  }

  /// Since this is a static drawing, we set this to false
  @override
  bool shouldRepaint(PlaygroundPainter oldDelegate) => true;
}
