//@dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebViewWrap extends StatefulWidget {
  final bool simplified;
  final Widget webView;
  final Widget Function(VoidCallback) closeWebView;
  final Widget topWidget;

  const WebViewWrap({
    Key key,
    this.webView,
    this.simplified = false,
    this.closeWebView,
    this.topWidget,
  }) : super(key: key);

  @override
  _WebViewWrapState createState() => _WebViewWrapState();
}

class _WebViewWrapState extends State<WebViewWrap> {
  ScrollController scroll = ScrollController();
  bool focused = false;

  @override
  void initState() {
    super.initState();
    scroll.addListener(listener);
  }

  @override
  dispose() {
    super.dispose();
    scroll.removeListener(listener);
  }

  listener() {
    if (scroll.offset >= scroll.position.maxScrollExtent) {
      setState(() {
        setFocus(true);
      });
    }
  }

  setFocus(bool value) async {
    final position = value
        ? scroll.position.maxScrollExtent
        : scroll.position.minScrollExtent;
    scroll
        .animateTo(
      position,
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    )
        .then((_) {
      scroll.jumpTo(position);
    });

    if (value) {
      FocusScope.of(context).unfocus();
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    focused = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final bottom = MediaQuery.of(context).padding.bottom;
        final closeWebView = widget.closeWebView(() => setFocus(false));
        return SingleChildScrollView(
          controller: scroll,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.simplified) widget.topWidget,
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.maxHeight,
                    child: widget.simplified
                        ? widget.webView
                        : GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapDown: focused
                                ? null
                                : (_) {
                                    setFocus(true);
                                  },
                            child: IgnorePointer(
                              ignoring: !focused,
                              child: widget.webView,
                            ),
                          ),
                  ),
                  if (!widget.simplified) Positioned(
                    bottom: bottom + 15,
                    right: 15,
                    child: closeWebView,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
