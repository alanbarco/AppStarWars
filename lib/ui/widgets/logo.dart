import 'dart:math';

import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  const Logo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OrientationBuilder(builder: (context, orientation) {
        return orientation == Orientation.landscape
            ? Transform.rotate(
                angle: 90 * pi / 180,
                child: Image.asset('assets/images/cubo.png', width: 50))
            : Image.asset('assets/images/cubo.png', width: 50);
      }),
    );
  }
}
