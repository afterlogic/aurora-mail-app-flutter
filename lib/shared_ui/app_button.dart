import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool isLoading;
  final void Function() onPressed;
  final String text;

  const AppButton({
    Key key,
    this.isLoading,
    @required this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 100),
      opacity: isLoading == true ? 0.4 : 1.0,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.8), blurRadius: 8.0, offset: Offset(0.0, 3.0))
          ],
        ),
        child: Material(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(50.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(50.0),
            onTap: isLoading == true ? null : onPressed,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: isLoading == true ? SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                )
                    : Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
