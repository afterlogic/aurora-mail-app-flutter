import 'bloc.dart';
import 'contacts_state.dart';

Stream<ContactsState> reduceState(ContactsState state, dynamic event) async* {
  if (event is ReceivedContacts) {
    yield state.copyWith(
      contacts: event.contacts,
    );
  }
  if (event is ReceivedStorages) {
    yield state.copyWith(
      storages: event.storages,
    );
  }
  if (event is ReceivedGroups) {
    yield state.copyWith(
      groups: event.groups,
    );
  }
  if (event is SetSelectedStorage) {
    yield state.copyWith(
      selectedStorage: event.storageSqliteId,
      selectedGroup: "",
      showAllVisibleContacts: false,
    );
  }
  if (event is SetGroupSelected) {
    yield state.copyWith(
      selectedStorage: -1,
      selectedGroup: event.groupUuid,
      showAllVisibleContacts: false,
    );
  }
  if (event is SetAllVisibleContactsSelected) {
    yield state.copyWith(
      selectedStorage: -1,
      selectedGroup: "",
      showAllVisibleContacts: true,
    );
  }
  if (event is SetCurrentlySyncingStorages) {
    yield state.copyWith(
      currentlySyncingStorages: event.storageSqliteIds,
    );
  }
  if (event is AddError) {
    yield state.copyWith(
      error: event.error,
    );
  }
}
