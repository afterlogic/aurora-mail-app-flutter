import 'package:aurora_mail/shared_ui/loading_indicator.dart';
import 'package:flutter/material.dart';

class LoadingContainerIndicator extends StatelessWidget {
  final bool loading;

  const LoadingContainerIndicator({
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: loading
          ? Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: LoadingIndicator(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
