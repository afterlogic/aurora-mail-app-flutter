// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Message extends DataClass implements Insertable<Message> {
  final int localId;
  Message({@required this.localId});
  factory Message.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Message(
      localId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
    );
  }
  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Message(
      localId: serializer.fromJson<int>(json['localId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'localId': serializer.toJson<int>(localId),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Message>>(bool nullToAbsent) {
    return MailCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
    ) as T;
  }

  Message copyWith({int localId}) => Message(
        localId: localId ?? this.localId,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')..write('localId: $localId')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(localId.hashCode);
  @override
  bool operator ==(other) =>
      identical(this, other) || (other is Message && other.localId == localId);
}

class MailCompanion extends UpdateCompanion<Message> {
  final Value<int> localId;
  const MailCompanion({
    this.localId = const Value.absent(),
  });
  MailCompanion copyWith({Value<int> localId}) {
    return MailCompanion(
      localId: localId ?? this.localId,
    );
  }
}

class $MailTable extends Mail with TableInfo<$MailTable, Message> {
  final GeneratedDatabase _db;
  final String _alias;
  $MailTable(this._db, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedIntColumn _localId;
  @override
  GeneratedIntColumn get localId => _localId ??= _constructLocalId();
  GeneratedIntColumn _constructLocalId() {
    return GeneratedIntColumn('local_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  @override
  List<GeneratedColumn> get $columns => [localId];
  @override
  $MailTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'mail';
  @override
  final String actualTableName = 'mail';
  @override
  VerificationContext validateIntegrity(MailCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    } else if (localId.isRequired && isInserting) {
      context.missing(_localIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Message map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Message.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MailCompanion d) {
    final map = <String, Variable>{};
    if (d.localId.present) {
      map['local_id'] = Variable<int, IntType>(d.localId.value);
    }
    return map;
  }

  @override
  $MailTable createAlias(String alias) {
    return $MailTable(_db, alias);
  }
}

class LocalFolder extends DataClass implements Insertable<LocalFolder> {
  final int localId;
  final String guid;
  final String parentGuid;
  final int accountId;
  final int type;
  final int folderOrder;
  final String name;
  final String fullName;
  final String fullNameRaw;
  final String fullNameHash;
  final String delimiter;
  final bool isSubscribed;
  final bool isSelectable;
  final bool folderExists;
  final bool extended;
  final bool alwaysRefresh;
  LocalFolder(
      {@required this.localId,
      @required this.guid,
      this.parentGuid,
      @required this.accountId,
      @required this.type,
      @required this.folderOrder,
      @required this.name,
      @required this.fullName,
      @required this.fullNameRaw,
      @required this.fullNameHash,
      @required this.delimiter,
      @required this.isSubscribed,
      @required this.isSelectable,
      @required this.folderExists,
      this.extended,
      @required this.alwaysRefresh});
  factory LocalFolder.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return LocalFolder(
      localId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      guid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}guid']),
      parentGuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_guid']),
      accountId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}account_id']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      folderOrder: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_order']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      fullNameRaw: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_raw']),
      fullNameHash: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_hash']),
      delimiter: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}delimiter']),
      isSubscribed: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_subscribed']),
      isSelectable: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_selectable']),
      folderExists: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_exists']),
      extended:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}extended']),
      alwaysRefresh: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}always_refresh']),
    );
  }
  factory LocalFolder.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return LocalFolder(
      localId: serializer.fromJson<int>(json['localId']),
      guid: serializer.fromJson<String>(json['guid']),
      parentGuid: serializer.fromJson<String>(json['parentGuid']),
      accountId: serializer.fromJson<int>(json['accountId']),
      type: serializer.fromJson<int>(json['type']),
      folderOrder: serializer.fromJson<int>(json['folderOrder']),
      name: serializer.fromJson<String>(json['name']),
      fullName: serializer.fromJson<String>(json['fullName']),
      fullNameRaw: serializer.fromJson<String>(json['fullNameRaw']),
      fullNameHash: serializer.fromJson<String>(json['fullNameHash']),
      delimiter: serializer.fromJson<String>(json['delimiter']),
      isSubscribed: serializer.fromJson<bool>(json['isSubscribed']),
      isSelectable: serializer.fromJson<bool>(json['isSelectable']),
      folderExists: serializer.fromJson<bool>(json['folderExists']),
      extended: serializer.fromJson<bool>(json['extended']),
      alwaysRefresh: serializer.fromJson<bool>(json['alwaysRefresh']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'localId': serializer.toJson<int>(localId),
      'guid': serializer.toJson<String>(guid),
      'parentGuid': serializer.toJson<String>(parentGuid),
      'accountId': serializer.toJson<int>(accountId),
      'type': serializer.toJson<int>(type),
      'folderOrder': serializer.toJson<int>(folderOrder),
      'name': serializer.toJson<String>(name),
      'fullName': serializer.toJson<String>(fullName),
      'fullNameRaw': serializer.toJson<String>(fullNameRaw),
      'fullNameHash': serializer.toJson<String>(fullNameHash),
      'delimiter': serializer.toJson<String>(delimiter),
      'isSubscribed': serializer.toJson<bool>(isSubscribed),
      'isSelectable': serializer.toJson<bool>(isSelectable),
      'folderExists': serializer.toJson<bool>(folderExists),
      'extended': serializer.toJson<bool>(extended),
      'alwaysRefresh': serializer.toJson<bool>(alwaysRefresh),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<LocalFolder>>(bool nullToAbsent) {
    return FoldersCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      guid: guid == null && nullToAbsent ? const Value.absent() : Value(guid),
      parentGuid: parentGuid == null && nullToAbsent
          ? const Value.absent()
          : Value(parentGuid),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      folderOrder: folderOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(folderOrder),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      fullNameRaw: fullNameRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(fullNameRaw),
      fullNameHash: fullNameHash == null && nullToAbsent
          ? const Value.absent()
          : Value(fullNameHash),
      delimiter: delimiter == null && nullToAbsent
          ? const Value.absent()
          : Value(delimiter),
      isSubscribed: isSubscribed == null && nullToAbsent
          ? const Value.absent()
          : Value(isSubscribed),
      isSelectable: isSelectable == null && nullToAbsent
          ? const Value.absent()
          : Value(isSelectable),
      folderExists: folderExists == null && nullToAbsent
          ? const Value.absent()
          : Value(folderExists),
      extended: extended == null && nullToAbsent
          ? const Value.absent()
          : Value(extended),
      alwaysRefresh: alwaysRefresh == null && nullToAbsent
          ? const Value.absent()
          : Value(alwaysRefresh),
    ) as T;
  }

  LocalFolder copyWith(
          {int localId,
          String guid,
          String parentGuid,
          int accountId,
          int type,
          int folderOrder,
          String name,
          String fullName,
          String fullNameRaw,
          String fullNameHash,
          String delimiter,
          bool isSubscribed,
          bool isSelectable,
          bool folderExists,
          bool extended,
          bool alwaysRefresh}) =>
      LocalFolder(
        localId: localId ?? this.localId,
        guid: guid ?? this.guid,
        parentGuid: parentGuid ?? this.parentGuid,
        accountId: accountId ?? this.accountId,
        type: type ?? this.type,
        folderOrder: folderOrder ?? this.folderOrder,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
        fullNameRaw: fullNameRaw ?? this.fullNameRaw,
        fullNameHash: fullNameHash ?? this.fullNameHash,
        delimiter: delimiter ?? this.delimiter,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        isSelectable: isSelectable ?? this.isSelectable,
        folderExists: folderExists ?? this.folderExists,
        extended: extended ?? this.extended,
        alwaysRefresh: alwaysRefresh ?? this.alwaysRefresh,
      );
  @override
  String toString() {
    return (StringBuffer('LocalFolder(')
          ..write('localId: $localId, ')
          ..write('guid: $guid, ')
          ..write('parentGuid: $parentGuid, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('folderOrder: $folderOrder, ')
          ..write('name: $name, ')
          ..write('fullName: $fullName, ')
          ..write('fullNameRaw: $fullNameRaw, ')
          ..write('fullNameHash: $fullNameHash, ')
          ..write('delimiter: $delimiter, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('isSelectable: $isSelectable, ')
          ..write('folderExists: $folderExists, ')
          ..write('extended: $extended, ')
          ..write('alwaysRefresh: $alwaysRefresh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      localId.hashCode,
      $mrjc(
          guid.hashCode,
          $mrjc(
              parentGuid.hashCode,
              $mrjc(
                  accountId.hashCode,
                  $mrjc(
                      type.hashCode,
                      $mrjc(
                          folderOrder.hashCode,
                          $mrjc(
                              name.hashCode,
                              $mrjc(
                                  fullName.hashCode,
                                  $mrjc(
                                      fullNameRaw.hashCode,
                                      $mrjc(
                                          fullNameHash.hashCode,
                                          $mrjc(
                                              delimiter.hashCode,
                                              $mrjc(
                                                  isSubscribed.hashCode,
                                                  $mrjc(
                                                      isSelectable.hashCode,
                                                      $mrjc(
                                                          folderExists.hashCode,
                                                          $mrjc(
                                                              extended.hashCode,
                                                              alwaysRefresh
                                                                  .hashCode))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is LocalFolder &&
          other.localId == localId &&
          other.guid == guid &&
          other.parentGuid == parentGuid &&
          other.accountId == accountId &&
          other.type == type &&
          other.folderOrder == folderOrder &&
          other.name == name &&
          other.fullName == fullName &&
          other.fullNameRaw == fullNameRaw &&
          other.fullNameHash == fullNameHash &&
          other.delimiter == delimiter &&
          other.isSubscribed == isSubscribed &&
          other.isSelectable == isSelectable &&
          other.folderExists == folderExists &&
          other.extended == extended &&
          other.alwaysRefresh == alwaysRefresh);
}

class FoldersCompanion extends UpdateCompanion<LocalFolder> {
  final Value<int> localId;
  final Value<String> guid;
  final Value<String> parentGuid;
  final Value<int> accountId;
  final Value<int> type;
  final Value<int> folderOrder;
  final Value<String> name;
  final Value<String> fullName;
  final Value<String> fullNameRaw;
  final Value<String> fullNameHash;
  final Value<String> delimiter;
  final Value<bool> isSubscribed;
  final Value<bool> isSelectable;
  final Value<bool> folderExists;
  final Value<bool> extended;
  final Value<bool> alwaysRefresh;
  const FoldersCompanion({
    this.localId = const Value.absent(),
    this.guid = const Value.absent(),
    this.parentGuid = const Value.absent(),
    this.accountId = const Value.absent(),
    this.type = const Value.absent(),
    this.folderOrder = const Value.absent(),
    this.name = const Value.absent(),
    this.fullName = const Value.absent(),
    this.fullNameRaw = const Value.absent(),
    this.fullNameHash = const Value.absent(),
    this.delimiter = const Value.absent(),
    this.isSubscribed = const Value.absent(),
    this.isSelectable = const Value.absent(),
    this.folderExists = const Value.absent(),
    this.extended = const Value.absent(),
    this.alwaysRefresh = const Value.absent(),
  });
  FoldersCompanion copyWith(
      {Value<int> localId,
      Value<String> guid,
      Value<String> parentGuid,
      Value<int> accountId,
      Value<int> type,
      Value<int> folderOrder,
      Value<String> name,
      Value<String> fullName,
      Value<String> fullNameRaw,
      Value<String> fullNameHash,
      Value<String> delimiter,
      Value<bool> isSubscribed,
      Value<bool> isSelectable,
      Value<bool> folderExists,
      Value<bool> extended,
      Value<bool> alwaysRefresh}) {
    return FoldersCompanion(
      localId: localId ?? this.localId,
      guid: guid ?? this.guid,
      parentGuid: parentGuid ?? this.parentGuid,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      folderOrder: folderOrder ?? this.folderOrder,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      fullNameRaw: fullNameRaw ?? this.fullNameRaw,
      fullNameHash: fullNameHash ?? this.fullNameHash,
      delimiter: delimiter ?? this.delimiter,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isSelectable: isSelectable ?? this.isSelectable,
      folderExists: folderExists ?? this.folderExists,
      extended: extended ?? this.extended,
      alwaysRefresh: alwaysRefresh ?? this.alwaysRefresh,
    );
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, LocalFolder> {
  final GeneratedDatabase _db;
  final String _alias;
  $FoldersTable(this._db, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedIntColumn _localId;
  @override
  GeneratedIntColumn get localId => _localId ??= _constructLocalId();
  GeneratedIntColumn _constructLocalId() {
    return GeneratedIntColumn('local_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _guidMeta = const VerificationMeta('guid');
  GeneratedTextColumn _guid;
  @override
  GeneratedTextColumn get guid => _guid ??= _constructGuid();
  GeneratedTextColumn _constructGuid() {
    return GeneratedTextColumn(
      'guid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _parentGuidMeta = const VerificationMeta('parentGuid');
  GeneratedTextColumn _parentGuid;
  @override
  GeneratedTextColumn get parentGuid => _parentGuid ??= _constructParentGuid();
  GeneratedTextColumn _constructParentGuid() {
    return GeneratedTextColumn(
      'parent_guid',
      $tableName,
      true,
    );
  }

  final VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  GeneratedIntColumn _accountId;
  @override
  GeneratedIntColumn get accountId => _accountId ??= _constructAccountId();
  GeneratedIntColumn _constructAccountId() {
    return GeneratedIntColumn(
      'account_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _folderOrderMeta =
      const VerificationMeta('folderOrder');
  GeneratedIntColumn _folderOrder;
  @override
  GeneratedIntColumn get folderOrder =>
      _folderOrder ??= _constructFolderOrder();
  GeneratedIntColumn _constructFolderOrder() {
    return GeneratedIntColumn(
      'folder_order',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  GeneratedTextColumn _fullName;
  @override
  GeneratedTextColumn get fullName => _fullName ??= _constructFullName();
  GeneratedTextColumn _constructFullName() {
    return GeneratedTextColumn(
      'full_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fullNameRawMeta =
      const VerificationMeta('fullNameRaw');
  GeneratedTextColumn _fullNameRaw;
  @override
  GeneratedTextColumn get fullNameRaw =>
      _fullNameRaw ??= _constructFullNameRaw();
  GeneratedTextColumn _constructFullNameRaw() {
    return GeneratedTextColumn(
      'full_name_raw',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fullNameHashMeta =
      const VerificationMeta('fullNameHash');
  GeneratedTextColumn _fullNameHash;
  @override
  GeneratedTextColumn get fullNameHash =>
      _fullNameHash ??= _constructFullNameHash();
  GeneratedTextColumn _constructFullNameHash() {
    return GeneratedTextColumn(
      'full_name_hash',
      $tableName,
      false,
    );
  }

  final VerificationMeta _delimiterMeta = const VerificationMeta('delimiter');
  GeneratedTextColumn _delimiter;
  @override
  GeneratedTextColumn get delimiter => _delimiter ??= _constructDelimiter();
  GeneratedTextColumn _constructDelimiter() {
    return GeneratedTextColumn(
      'delimiter',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isSubscribedMeta =
      const VerificationMeta('isSubscribed');
  GeneratedBoolColumn _isSubscribed;
  @override
  GeneratedBoolColumn get isSubscribed =>
      _isSubscribed ??= _constructIsSubscribed();
  GeneratedBoolColumn _constructIsSubscribed() {
    return GeneratedBoolColumn(
      'is_subscribed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isSelectableMeta =
      const VerificationMeta('isSelectable');
  GeneratedBoolColumn _isSelectable;
  @override
  GeneratedBoolColumn get isSelectable =>
      _isSelectable ??= _constructIsSelectable();
  GeneratedBoolColumn _constructIsSelectable() {
    return GeneratedBoolColumn(
      'is_selectable',
      $tableName,
      false,
    );
  }

  final VerificationMeta _folderExistsMeta =
      const VerificationMeta('folderExists');
  GeneratedBoolColumn _folderExists;
  @override
  GeneratedBoolColumn get folderExists =>
      _folderExists ??= _constructFolderExists();
  GeneratedBoolColumn _constructFolderExists() {
    return GeneratedBoolColumn(
      'folder_exists',
      $tableName,
      false,
    );
  }

  final VerificationMeta _extendedMeta = const VerificationMeta('extended');
  GeneratedBoolColumn _extended;
  @override
  GeneratedBoolColumn get extended => _extended ??= _constructExtended();
  GeneratedBoolColumn _constructExtended() {
    return GeneratedBoolColumn(
      'extended',
      $tableName,
      true,
    );
  }

  final VerificationMeta _alwaysRefreshMeta =
      const VerificationMeta('alwaysRefresh');
  GeneratedBoolColumn _alwaysRefresh;
  @override
  GeneratedBoolColumn get alwaysRefresh =>
      _alwaysRefresh ??= _constructAlwaysRefresh();
  GeneratedBoolColumn _constructAlwaysRefresh() {
    return GeneratedBoolColumn(
      'always_refresh',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        localId,
        guid,
        parentGuid,
        accountId,
        type,
        folderOrder,
        name,
        fullName,
        fullNameRaw,
        fullNameHash,
        delimiter,
        isSubscribed,
        isSelectable,
        folderExists,
        extended,
        alwaysRefresh
      ];
  @override
  $FoldersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'folders';
  @override
  final String actualTableName = 'folders';
  @override
  VerificationContext validateIntegrity(FoldersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    } else if (localId.isRequired && isInserting) {
      context.missing(_localIdMeta);
    }
    if (d.guid.present) {
      context.handle(
          _guidMeta, guid.isAcceptableValue(d.guid.value, _guidMeta));
    } else if (guid.isRequired && isInserting) {
      context.missing(_guidMeta);
    }
    if (d.parentGuid.present) {
      context.handle(_parentGuidMeta,
          parentGuid.isAcceptableValue(d.parentGuid.value, _parentGuidMeta));
    } else if (parentGuid.isRequired && isInserting) {
      context.missing(_parentGuidMeta);
    }
    if (d.accountId.present) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableValue(d.accountId.value, _accountIdMeta));
    } else if (accountId.isRequired && isInserting) {
      context.missing(_accountIdMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (type.isRequired && isInserting) {
      context.missing(_typeMeta);
    }
    if (d.folderOrder.present) {
      context.handle(_folderOrderMeta,
          folderOrder.isAcceptableValue(d.folderOrder.value, _folderOrderMeta));
    } else if (folderOrder.isRequired && isInserting) {
      context.missing(_folderOrderMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.fullName.present) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableValue(d.fullName.value, _fullNameMeta));
    } else if (fullName.isRequired && isInserting) {
      context.missing(_fullNameMeta);
    }
    if (d.fullNameRaw.present) {
      context.handle(_fullNameRawMeta,
          fullNameRaw.isAcceptableValue(d.fullNameRaw.value, _fullNameRawMeta));
    } else if (fullNameRaw.isRequired && isInserting) {
      context.missing(_fullNameRawMeta);
    }
    if (d.fullNameHash.present) {
      context.handle(
          _fullNameHashMeta,
          fullNameHash.isAcceptableValue(
              d.fullNameHash.value, _fullNameHashMeta));
    } else if (fullNameHash.isRequired && isInserting) {
      context.missing(_fullNameHashMeta);
    }
    if (d.delimiter.present) {
      context.handle(_delimiterMeta,
          delimiter.isAcceptableValue(d.delimiter.value, _delimiterMeta));
    } else if (delimiter.isRequired && isInserting) {
      context.missing(_delimiterMeta);
    }
    if (d.isSubscribed.present) {
      context.handle(
          _isSubscribedMeta,
          isSubscribed.isAcceptableValue(
              d.isSubscribed.value, _isSubscribedMeta));
    } else if (isSubscribed.isRequired && isInserting) {
      context.missing(_isSubscribedMeta);
    }
    if (d.isSelectable.present) {
      context.handle(
          _isSelectableMeta,
          isSelectable.isAcceptableValue(
              d.isSelectable.value, _isSelectableMeta));
    } else if (isSelectable.isRequired && isInserting) {
      context.missing(_isSelectableMeta);
    }
    if (d.folderExists.present) {
      context.handle(
          _folderExistsMeta,
          folderExists.isAcceptableValue(
              d.folderExists.value, _folderExistsMeta));
    } else if (folderExists.isRequired && isInserting) {
      context.missing(_folderExistsMeta);
    }
    if (d.extended.present) {
      context.handle(_extendedMeta,
          extended.isAcceptableValue(d.extended.value, _extendedMeta));
    } else if (extended.isRequired && isInserting) {
      context.missing(_extendedMeta);
    }
    if (d.alwaysRefresh.present) {
      context.handle(
          _alwaysRefreshMeta,
          alwaysRefresh.isAcceptableValue(
              d.alwaysRefresh.value, _alwaysRefreshMeta));
    } else if (alwaysRefresh.isRequired && isInserting) {
      context.missing(_alwaysRefreshMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  LocalFolder map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return LocalFolder.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FoldersCompanion d) {
    final map = <String, Variable>{};
    if (d.localId.present) {
      map['local_id'] = Variable<int, IntType>(d.localId.value);
    }
    if (d.guid.present) {
      map['guid'] = Variable<String, StringType>(d.guid.value);
    }
    if (d.parentGuid.present) {
      map['parent_guid'] = Variable<String, StringType>(d.parentGuid.value);
    }
    if (d.accountId.present) {
      map['account_id'] = Variable<int, IntType>(d.accountId.value);
    }
    if (d.type.present) {
      map['type'] = Variable<int, IntType>(d.type.value);
    }
    if (d.folderOrder.present) {
      map['folder_order'] = Variable<int, IntType>(d.folderOrder.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.fullName.present) {
      map['full_name'] = Variable<String, StringType>(d.fullName.value);
    }
    if (d.fullNameRaw.present) {
      map['full_name_raw'] = Variable<String, StringType>(d.fullNameRaw.value);
    }
    if (d.fullNameHash.present) {
      map['full_name_hash'] =
          Variable<String, StringType>(d.fullNameHash.value);
    }
    if (d.delimiter.present) {
      map['delimiter'] = Variable<String, StringType>(d.delimiter.value);
    }
    if (d.isSubscribed.present) {
      map['is_subscribed'] = Variable<bool, BoolType>(d.isSubscribed.value);
    }
    if (d.isSelectable.present) {
      map['is_selectable'] = Variable<bool, BoolType>(d.isSelectable.value);
    }
    if (d.folderExists.present) {
      map['folder_exists'] = Variable<bool, BoolType>(d.folderExists.value);
    }
    if (d.extended.present) {
      map['extended'] = Variable<bool, BoolType>(d.extended.value);
    }
    if (d.alwaysRefresh.present) {
      map['always_refresh'] = Variable<bool, BoolType>(d.alwaysRefresh.value);
    }
    return map;
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $MailTable _mail;
  $MailTable get mail => _mail ??= $MailTable(this);
  $FoldersTable _folders;
  $FoldersTable get folders => _folders ??= $FoldersTable(this);
  @override
  List<TableInfo> get allTables => [mail, folders];
}
