import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetSvgIcon extends StatefulWidget {
  final bool showSvg;
  final String svgPath;
  final IconData iconData;
  final Color? color;
  final double width;
  final double height;

  const AssetSvgIcon({
    required this.showSvg,
    required this.svgPath,
    required this.iconData,
    this.color,
    this.width = 24,
    this.height = 24,
    super.key,
  });

  @override
  State<AssetSvgIcon> createState() => _AssetSvgIconState();
}

class _AssetSvgIconState extends State<AssetSvgIcon> {
  Future<ByteData> get svgData =>
      DefaultAssetBundle.of(context).load(widget.svgPath);

  @override
  Widget build(BuildContext context) {
    if (!widget.showSvg) {
      return Icon(
        widget.iconData,
        color: widget.color,
        size: max(widget.width, widget.height),
      );
    }

    return FutureBuilder<ByteData>(
      future: svgData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Icon(
            widget.iconData,
            color: widget.color,
            size: max(widget.width, widget.height),
          );
        }

        if (snapshot.hasData) {
          final bytes = snapshot.data?.buffer.asUint8List();
          if (bytes == null) {
            return Icon(
              widget.iconData,
              color: widget.color,
              size: max(widget.width, widget.height),
            );
          }

          return SvgPicture.memory(
            bytes,
            width: widget.width,
            height: widget.height,
            color: widget.color,
          );
        }

        // When future haven't loaded yet
        return SizedBox(
          width: widget.width,
          height: widget.height,
        );
      },
    );
  }
}
