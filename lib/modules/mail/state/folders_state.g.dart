// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folders_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FoldersState on _FoldersState, Store {
  final _$isFoldersLoadingAtom = Atom(name: '_FoldersState.isFoldersLoading');

  @override
  LoadingType get isFoldersLoading {
    _$isFoldersLoadingAtom.context.enforceReadPolicy(_$isFoldersLoadingAtom);
    _$isFoldersLoadingAtom.reportObserved();
    return super.isFoldersLoading;
  }

  @override
  set isFoldersLoading(LoadingType value) {
    _$isFoldersLoadingAtom.context.conditionallyRunInAction(() {
      super.isFoldersLoading = value;
      _$isFoldersLoadingAtom.reportChanged();
    }, _$isFoldersLoadingAtom, name: '${_$isFoldersLoadingAtom.name}_set');
  }
}
