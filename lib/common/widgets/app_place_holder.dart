import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppPlaceholder extends StatelessWidget {
  final Widget child;
  const AppPlaceholder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Theme.of(context).colorScheme.secondary,
      enabled: true,
      child: child,
    );
  }
}
