import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

extension BlocProviderExtensions on BlocProvider{
  static T? tryOf<T extends BlocBase<Object?>>(
      BuildContext context, {
        bool listen = false,
      }) {
    try {
      return Provider.of<T>(context, listen: listen);
    } on ProviderNotFoundException catch (e) {
      return null;
    }
  }
}