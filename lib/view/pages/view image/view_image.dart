import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewImagePage extends StatelessWidget {
  const ViewImagePage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
          child: InteractiveViewer(
              child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (_, sa) =>
            const CupertinoActivityIndicator(color: Colors.white),
      ))),
    );
  }
}
