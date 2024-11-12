import 'dart:async';

import 'package:demo_app/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const WorldStats(),),),);
  }

  late final AnimationController _controller = AnimationController (
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              AnimatedBuilder(
                  animation: _controller,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Image(image: AssetImage('images/virus.png')),
                  ),
                  builder: (BuildContext context, Widget? child)
                  {
                    return Transform.rotate(
                        angle: 2 * math.pi * _controller.value,
                        child: child);
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                child: const Text('Covid-19\nTracker App', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}



//  DOCumentation
/*
The animation part of this code is handled primarily by the `AnimationController`, `AnimatedBuilder`, and `Transform.rotate` components to create a spinning animation for the image of the virus (`virus.png`). Here's a detailed breakdown of how it works:

### 1. **AnimationController**
The `AnimationController` is used to manage the animation. It controls the duration and progress of the animation and can be played, paused, or repeated.

- **Initialization**:
  ```dart
  late final AnimationController _controller = AnimationController (
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  ```
  - `duration`: The animation is set to last 3 seconds (`Duration(seconds: 3)`).
  - `vsync: this`: The `TickerProvider` (implemented through `with TickerProviderStateMixin`) is responsible for providing the necessary ticks to drive the animation.
  - `..repeat()`: This makes the animation loop continuously, giving the spinning effect that never stops.

### 2. **AnimatedBuilder**
`AnimatedBuilder` is a widget that helps rebuild its child whenever the animation changes its value (i.e., progresses).

- **Code**:
  ```dart
  AnimatedBuilder(
    animation: _controller,
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      child: const Image(image: AssetImage('images/virus.png')),
    ),
    builder: (BuildContext context, Widget? child) {
      return Transform.rotate(
        angle: 2 * math.pi * _controller.value,
        child: child
      );
    }
  )
  ```
  - `animation: _controller`: The `AnimatedBuilder` listens to the `_controller`, so whenever the controller's value changes, it triggers a rebuild of the widget.
  - `child`: The `child` in this case is the `SizedBox` containing the `Image` of the virus. This is passed down and reused for efficiency, avoiding rebuilding the image itself.
  
### 3. **Transform.rotate**
In the `builder` function, the `Transform.rotate` widget is used to rotate the child widget (the virus image).

- **Code**:
  ```dart
  return Transform.rotate(
    angle: 2 * math.pi * _controller.value,
    child: child
  );
  ```
  - `angle: 2 * math.pi * _controller.value`: This rotates the widget by an angle that is proportional to the current value of the animation. Since the `value` of `_controller` progresses from 0 to 1 over 3 seconds (based on the `duration`), multiplying this by `2 * math.pi` means the image will rotate a full circle (360 degrees) every 3 seconds.
  - The continuous `repeat()` method makes the rotation loop indefinitely.

### Summary:
- The `AnimationController` drives the animation, repeatedly updating its value between 0 and 1 over a 3-second duration.
- The `AnimatedBuilder` listens to the animation and rebuilds the widget tree every time the animation changes.
- The `Transform.rotate` applies a rotation transformation to the image based on the current animation value, creating the spinning effect.

This combination results in a continuously rotating virus image on the splash screen. */