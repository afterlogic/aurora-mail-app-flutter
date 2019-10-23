// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MailState on _MailState, Store {
  final _$isMessagesLoadingAtom = Atom(name: '_MailState.isMessagesLoading');

  @override
  LoadingType get isMessagesLoading {
    _$isMessagesLoadingAtom.context.enforceReadPolicy(_$isMessagesLoadingAtom);
    _$isMessagesLoadingAtom.reportObserved();
    return super.isMessagesLoading;
  }

  @override
  set isMessagesLoading(LoadingType value) {
    _$isMessagesLoadingAtom.context.conditionallyRunInAction(() {
      super.isMessagesLoading = value;
      _$isMessagesLoadingAtom.reportChanged();
    }, _$isMessagesLoadingAtom, name: '${_$isMessagesLoadingAtom.name}_set');
  }
}
