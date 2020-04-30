import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

import 'contacts_event.dart';

class ReceivedStorages extends ContactsEvent {
  final List<ContactsStorage> storages;

  const ReceivedStorages(this.storages);

  @override
  List<Object> get props => [storages];
}

class SetSelectedStorage extends ContactsEvent {
  final String storageSqliteId;

  const SetSelectedStorage(this.storageSqliteId);

  @override
  List<Object> get props => [storageSqliteId];
}

class SetCurrentlySyncingStorages extends ContactsEvent {
  final List<int> storageSqliteIds;

  const SetCurrentlySyncingStorages(this.storageSqliteIds);

  @override
  List<Object> get props => [storageSqliteIds];
}
