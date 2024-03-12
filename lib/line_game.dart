// import 'dart:math';
// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
// import 'package:flame/input.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// /*  Instructions */

// // Up & Down Controls:
// // Left Player: [W] & [S] keys
// // Right Player: [Up Arrow] & [Down Arrow] keys

// class ScoreNotifier extends ChangeNotifier {
//   int leftScore = 0;
//   int rightScore = 0;

//   void leftScored() {
//     leftScore += 1;
//     notifyListeners();
//   }

//   void rightScored() {
//     rightScore += 1;
//     notifyListeners();
//   }
// }

// late ScoreNotifier scoreNotifier;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   scoreNotifier = ScoreNotifier();
//   runApp(const PongApp());
// }

// class PongApp extends StatelessWidget {
//   const PongApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Column(
//           children: <Widget>[
//             ChangeNotifierProvider.value(
//               value: scoreNotifier,
//               child: Builder(
//                 builder: (context) {
//                   return SizedBox(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//                     child: ColoredBox(
//                       color: Colors.black,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Text(
//                               Provider.of<ScoreNotifier>(context)
//                                   .leftScore
//                                   .toString(),
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 24)),
//                           Text(
//                               Provider.of<ScoreNotifier>(context)
//                                   .rightScore
//                                   .toString(),
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 24)),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const Flexible(
//               child: SizeAwareGame(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SizeAwareGame extends StatelessWidget {
//   const SizeAwareGame({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return GameWidget(game: Pong(constraints));
//       },
//     );
//   }
// }

// enum PaddleMovement { up, down, idle }

// class Paddle extends RectangleComponent
//     with HasGameRef<Pong>, CollisionCallbacks {
//   Paddle({
//     super.position,
//     super.size,
//     super.angle,
//     super.anchor,
//     super.children,
//     super.priority,
//     super.paint,
//   });

//   late ShapeHitbox hitbox;

//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     final defaultPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     hitbox = RectangleHitbox()
//       ..paint = defaultPaint
//       ..renderShape = true;
//     add(hitbox);
//   }
// }

// class Ball extends CircleComponent with HasGameRef<Pong>, CollisionCallbacks {
//   Ball({required super.position, required super.radius});

//   late ShapeHitbox hitbox;

//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     final defaultPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     hitbox = CircleHitbox()
//       ..paint = defaultPaint
//       ..renderShape = true;
//     add(hitbox);
//   }

//   @override
//   void onCollisionStart(
//     Set<Vector2> intersectionPoints,
//     PositionComponent other,
//   ) {
//     super.onCollisionStart(intersectionPoints, other);
//     if (other is Paddle) {
//       gameRef.ballMovingLeft = !gameRef.ballMovingLeft;
//       gameRef.increaseBallSpeed();
//       return;
//     }
//   }
// }

// class Pong extends FlameGame with HasCollisionDetection, KeyboardEvents {
//   Pong(this.constraints)
//       : ballMovingUp = random.nextBool(),
//         ballMovingLeft = random.nextBool();

//   static Random random = Random();

//   BoxConstraints constraints;
//   bool ballMovingUp;
//   bool ballMovingLeft;

//   PaddleMovement leftPaddleMovement = PaddleMovement.idle;
//   PaddleMovement rightPaddleMovement = PaddleMovement.idle;

//   static const double paddlePadding = 30;
//   static const double paddleHeight = 50;
//   static const double paddleWidth = 10;
//   static const double ballRadius = 10;

//   // Pixels per second.
//   static const double startingBallSpeed = 1.5;
//   double ballSpeed = Pong.startingBallSpeed;

//   // Pixels per second.
//   static const double paddleSpeed = 1.5;

//   late Paddle leftPaddle;
//   late Paddle rightPaddle;
//   late CircleComponent ball;

//   bool isPaused = false;

//   @override
//   Color backgroundColor() => Colors.red;

//   @override
//   Future<void> onLoad() async {
//     final whiteFill = Paint()
//       ..style = PaintingStyle.fill
//       ..color = Colors.white;

//     leftPaddle = Paddle(
//       position: startingLeftPaddlePosition,
//       anchor: Anchor.center,
//       size: Vector2(paddleWidth, paddleHeight),
//     )..paint = whiteFill;

//     rightPaddle = Paddle(
//       position: startingRightPaddlePosition,
//       anchor: Anchor.center,
//       size: Vector2(paddleWidth, paddleHeight),
//     )..paint = whiteFill;

//     ball = Ball(
//       radius: ballRadius,
//       position: startingBallPosition,
//     );

//     add(leftPaddle);
//     add(rightPaddle);
//     add(ball);
//   }

//   Vector2 get startingBallPosition => Vector2(
//         constraints.maxWidth / 2,
//         constraints.maxHeight / 2,
//       );

//   Vector2 get startingRightPaddlePosition => Vector2(
//         constraints.maxWidth - paddlePadding,
//         constraints.maxHeight / 2,
//       );

//   Vector2 get startingLeftPaddlePosition => Vector2(
//         paddlePadding,
//         constraints.maxHeight / 2,
//       );

//   @override
//   void update(double dt) {
//     if (isPaused) return;
//     _updatePaddles(dt);
//     _updateBall(dt);
//     super.update(dt);
//   }

//   @override
//   KeyEventResult onKeyEvent(
//     KeyEvent event,
//     Set<LogicalKeyboardKey> keysPressed,
//   ) {
//     final isKeyDown = event is KeyDownEvent || event is KeyRepeatEvent;
//     if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
//       rightPaddleMovement = isKeyDown ? PaddleMovement.up : PaddleMovement.idle;
//     } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
//       rightPaddleMovement =
//           isKeyDown ? PaddleMovement.down : PaddleMovement.idle;
//     } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
//       leftPaddleMovement = isKeyDown ? PaddleMovement.up : PaddleMovement.idle;
//     } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
//       leftPaddleMovement =
//           isKeyDown ? PaddleMovement.down : PaddleMovement.idle;
//     }

//     return super.onKeyEvent(event, keysPressed);
//   }

//   void _updatePaddles(double dt) {
//     final double distanceTraveled = dt * 100 * paddleSpeed;
//     if (leftPaddleMovement != PaddleMovement.idle) {
//       leftPaddle.center += Vector2(
//         0,
//         leftPaddleMovement != PaddleMovement.up
//             ? distanceTraveled
//             : -distanceTraveled,
//       );
//     }
//     if (rightPaddleMovement != PaddleMovement.idle) {
//       rightPaddle.center += Vector2(
//         0,
//         rightPaddleMovement != PaddleMovement.up
//             ? distanceTraveled
//             : -distanceTraveled,
//       );
//     }

//     leftPaddle.center.y = leftPaddle.center.y
//         .clamp(paddleHeight / 2, constraints.maxHeight - paddleHeight / 2);
//     rightPaddle.center.y = rightPaddle.center.y
//         .clamp(paddleHeight / 2, constraints.maxHeight - paddleHeight / 2);
//   }

//   void _updateBall(double dt) {
//     final double distanceTraveled = dt * 100 * ballSpeed;
//     double dx = ballMovingLeft ? distanceTraveled * -1 : distanceTraveled;
//     double dy = ballMovingUp ? distanceTraveled * -1 : distanceTraveled;

//     ball.center += Vector2(dx, dy);

//     if (ball.center.x <= ballRadius) {
//       scoreNotifier.rightScored();
//       _resetPositions();
//       _pauseBriefly();
//       ballMovingUp = random.nextBool();
//       ballMovingLeft = random.nextBool();
//     } else if (ball.center.x >= constraints.maxWidth - ballRadius) {
//       scoreNotifier.leftScored();
//       _resetPositions();
//       _pauseBriefly();
//       ballMovingUp = random.nextBool();
//       ballMovingLeft = random.nextBool();
//     }

//     if (ball.center.y <= ballRadius / 2) {
//       ballMovingUp = false;
//       ball.center = Vector2(ball.center.x, ballRadius);
//     } else if (ball.center.y >= constraints.maxHeight - ballRadius) {
//       ballMovingUp = true;
//       ball.center = Vector2(ball.center.x, constraints.maxHeight - ballRadius);
//     }
//   }

//   void _pauseBriefly() {
//     isPaused = true;
//     Future<void>.delayed(const Duration(seconds: 3))
//         .then((_) => isPaused = false);
//   }

//   void increaseBallSpeed() => ballSpeed = ballSpeed * 1.1;

//   void _resetPositions() {
//     leftPaddle.center = startingLeftPaddlePosition;
//     rightPaddle.center = startingRightPaddlePosition;
//     ball.center = startingBallPosition;
//     ballSpeed = Pong.startingBallSpeed;
//   }
// }
