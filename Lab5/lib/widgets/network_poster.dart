import 'package:flutter/material.dart';

class NetworkPoster extends StatelessWidget {
  const NetworkPoster({
    required this.imageUrl,
    required this.label,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String imageUrl;
  final String label;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      semanticLabel: '$label poster',
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) return child;
        return const ColoredBox(
          color: Color(0xFFE8E4F0),
          child: Center(child: CircularProgressIndicator.adaptive()),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const ColoredBox(
          color: Color(0xFFE8E4F0),
          child: Center(child: Icon(Icons.movie_outlined, size: 36)),
        );
      },
    );
  }
}
