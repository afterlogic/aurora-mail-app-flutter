// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folders_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FoldersState on _FoldersState, Store {
  final _$foldersLoadingAtom = Atom(name: '_FoldersState.foldersLoading');

  @override
  LoadingType get foldersLoading {
    _$foldersLoadingAtom.context.enforceReadPolicy(_$foldersLoadingAtom);
    _$foldersLoadingAtom.reportObserved();
    return super.foldersLoading;
  }

  @override
  set foldersLoading(LoadingType value) {
    _$foldersLoadingAtom.context.conditionallyRunInAction(() {
      super.foldersLoading = value;
      _$foldersLoadingAtom.reportChanged();
    }, _$foldersLoadingAtom, name: '${_$foldersLoadingAtom.name}_set');
  }

  final _$selectedFolderAtom = Atom(name: '_FoldersState.selectedFolder');

  @override
  Folder get selectedFolder {
    _$selectedFolderAtom.context.enforceReadPolicy(_$selectedFolderAtom);
    _$selectedFolderAtom.reportObserved();
    return super.selectedFolder;
  }

  @override
  set selectedFolder(Folder value) {
    _$selectedFolderAtom.context.conditionallyRunInAction(() {
      super.selectedFolder = value;
      _$selectedFolderAtom.reportChanged();
    }, _$selectedFolderAtom, name: '${_$selectedFolderAtom.name}_set');
  }

  final _$messagesLoadingAtom = Atom(name: '_FoldersState.messagesLoading');

  @override
  LoadingType get messagesLoading {
    _$messagesLoadingAtom.context.enforceReadPolicy(_$messagesLoadingAtom);
    _$messagesLoadingAtom.reportObserved();
    return super.messagesLoading;
  }

  @override
  set messagesLoading(LoadingType value) {
    _$messagesLoadingAtom.context.conditionallyRunInAction(() {
      super.messagesLoading = value;
      _$messagesLoadingAtom.reportChanged();
    }, _$messagesLoadingAtom, name: '${_$messagesLoadingAtom.name}_set');
  }
}
