import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset("lib/assets/load.json",height: 500,width: 500),
    );
  }
}
