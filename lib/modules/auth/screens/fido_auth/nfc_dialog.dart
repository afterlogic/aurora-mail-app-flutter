import 'dart:async';
import 'dart:math';

import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yubico_flutter/yubico_flutter.dart';

class IosPressOnKeyDialog extends _IosDialog {
  final Function breaker;

  IosPressOnKeyDialog(Key key, this.breaker) : super(key);

  @override
  _IosDialogState createState() => IosPressOnKeyDialogState();
}

class IosPressOnKeyDialogState extends _IosDialogState<IosPressOnKeyDialog> {
  Future success() async {
    setState(() => isSuccess = true);
    await Future.delayed(Duration(seconds: 2));
    await _animationController.reverse();
    Navigator.pop(context);
  }

  @override
  Future close() async {
    if (isSuccess || isClosed) {
      return;
    }
    isClosed = true;
    widget.breaker();
    await _animationController.reverse();
    Navigator.pop(context);
  }

  @override
  Widget content(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: KeyedSubtree(
        key: ValueKey(isSuccess),
        child: isSuccess ? _successWidget() : _scanKeyWidget(),
      ),
    );
  }

  Widget _successWidget() {
    final size = 115.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: 0,
          child: Text(
            "Ready to Scan",
            style: TextStyle(
                fontSize: 26, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: SizedBox(
            height: size,
            width: size,
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size),
                  border: Border.all(color: Color(0xFF007bff), width: 6)),
              child: Center(
                child: Icon(
                  Icons.done_rounded,
                  size: size - 30,
                  color: Color(0xFF007bff),
                ),
              ),
            ),
          ),
        ),
        Text(
          i18n(context, S.fido_label_success),
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _scanKeyWidget() {
    final size = 115.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Ready to Scan",
          style: TextStyle(
              fontSize: 26, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                border: Border.all(color: Color(0xFF007bff), width: 6)),
            child: Image.asset(
              "assets/images/use_key.png",
              width: size,
              height: size,
            ),
          ),
        ),
        Text(
          "Touch your security key",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

abstract class _IosDialog extends StatefulWidget {
  _IosDialog(Key key) : super(key: key);

  Future show(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => DecoratedBox(
        decoration: BoxDecoration(color: Colors.black45),
        child: this,
      ),
    );
  }

  @override
  _IosDialogState createState();
}

abstract class _IosDialogState<W extends _IosDialog> extends State<W>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _offsetAnimation;
  bool isSuccess = false;
  bool isClosed = false;

  initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _animationController.forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));
  }

  Future close() async {
    await _animationController.reverse();
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;
    final displayHeight = displaySize.height;
    final minSize = displayHeight * 0.75;
    final size = min(min(minSize, displaySize.shortestSide), 500.0);
    return Stack(
      children: [
        Positioned.fill(
          top: null,
          child: Center(
            child: SlideTransition(
              position: _offsetAnimation,
              child: Container(
                width: size,
                height: size * 0.95,
                margin: EdgeInsets.all(6),
                padding: EdgeInsets.symmetric(vertical: 27, horizontal: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Material(
                          color: Colors.white,
                          child: Theme(
                            data: ThemeData.light(),
                            child: content(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Opacity(
                      opacity: isSuccess ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: isSuccess,
                        child: SizedBox(
                          width: double.infinity,
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              close();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget content(BuildContext context);
}
