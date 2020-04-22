import 'package:flutter/material.dart';

import 'logger.dart';

class LoggerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoggerViewState();
  }

  static Widget wrap(Widget widget) {
    return Column(
      children: <Widget>[
        Expanded(
          child: widget,
        ),
        LoggerView(),
      ],
    );
  }
}

class LoggerViewState extends State<LoggerView> {
  @override
  void initState() {
    super.initState();
    logger.onEdit = onChange;
  }

  @override
  void dispose() {
    super.dispose();
    logger.onEdit = null;
  }

  onChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!logger.enable) {
      return SizedBox.shrink();
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Colors.white,
        height: 40,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.delete),
                  ),
                  onTap: () {
                    logger.clear();
                    setState(() {});
                  },
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      logger.isRun
                          ? Icons.pause_circle_filled
                          : Icons.fiber_manual_record,
                      color: Colors.red,
                    ),
                  ),
                  onTap: logger.isRun
                      ? () {
                          logger.pause();
                        }
                      : () {
                          logger.start();
                        },
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.save),
                  ),
                  onTap: (logger?.count ?? 0) > 0
                      ? () async {
                          await logger.save();
                        }
                      : null,
                )
              ],
            ),
            Text(
              "Recorded entries: " + logger.count.toString(),
              style: TextStyle(
                fontSize: 9,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
