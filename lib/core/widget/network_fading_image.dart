import 'package:flutter/material.dart';

class NetworkFadingImage extends StatelessWidget {
  const NetworkFadingImage({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: ((context, error, stackTrace) {
        return const SizedBox();
      }),
    );
  }
}
