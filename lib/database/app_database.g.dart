// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Message extends DataClass implements Insertable<Message> {
  final int localId;
  final int uid;
  final int accountEntityId;
  final int userLocalId;
  final String uniqueUidInFolder;
  final int parentUid;
  final String messageId;
  final String folder;
  final String flagsInJson;
  final bool hasThread;
  final String subject;
  final int size;
  final int textSize;
  final bool truncated;
  final int internalTimeStampInUTC;
  final int receivedOrDateTimeStampInUTC;
  final int timeStampInUTC;
  final String toInJson;
  final String fromInJson;
  final String fromToDisplay;
  final String ccInJson;
  final String bccInJson;
  final String senderInJson;
  final String replyToInJson;
  final bool hasAttachments;
  final bool hasVcardAttachment;
  final bool hasIcalAttachment;
  final int importance;
  final String draftInfoInJson;
  final int sensitivity;
  final String downloadAsEmlUrl;
  final String hash;
  final String headers;
  final String inReplyTo;
  final String references;
  final String readingConfirmationAddressee;
  final String html;
  final String plain;
  final bool rtl;
  final String extendInJson;
  final bool safety;
  final bool hasExternals;
  final String foundedCIDsInJson;
  final String foundedContentLocationUrlsInJson;
  final String attachmentsInJson;
  final String customInJson;
  Message(
      {@required this.localId,
      @required this.uid,
      @required this.accountEntityId,
      @required this.userLocalId,
      @required this.uniqueUidInFolder,
      this.parentUid,
      @required this.messageId,
      @required this.folder,
      @required this.flagsInJson,
      @required this.hasThread,
      @required this.subject,
      @required this.size,
      @required this.textSize,
      @required this.truncated,
      @required this.internalTimeStampInUTC,
      @required this.receivedOrDateTimeStampInUTC,
      @required this.timeStampInUTC,
      this.toInJson,
      this.fromInJson,
      @required this.fromToDisplay,
      this.ccInJson,
      this.bccInJson,
      this.senderInJson,
      this.replyToInJson,
      @required this.hasAttachments,
      @required this.hasVcardAttachment,
      @required this.hasIcalAttachment,
      @required this.importance,
      this.draftInfoInJson,
      @required this.sensitivity,
      @required this.downloadAsEmlUrl,
      @required this.hash,
      @required this.headers,
      @required this.inReplyTo,
      @required this.references,
      @required this.readingConfirmationAddressee,
      this.html,
      @required this.plain,
      @required this.rtl,
      @required this.extendInJson,
      @required this.safety,
      @required this.hasExternals,
      @required this.foundedCIDsInJson,
      @required this.foundedContentLocationUrlsInJson,
      this.attachmentsInJson,
      @required this.customInJson});
  factory Message.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Message(
      localId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      uid: intType.mapFromDatabaseResponse(data['${effectivePrefix}uid']),
      accountEntityId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}account_entity_id']),
      userLocalId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id']),
      uniqueUidInFolder: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}unique_uid_in_folder']),
      parentUid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_uid']),
      messageId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}message_id']),
      folder:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}folder']),
      flagsInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}flags_in_json']),
      hasThread: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}has_thread']),
      subject:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}subject']),
      size: intType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
      textSize:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}text_size']),
      truncated:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}truncated']),
      internalTimeStampInUTC: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}internal_time_stamp_in_u_t_c']),
      receivedOrDateTimeStampInUTC: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}received_or_date_time_stamp_in_u_t_c']),
      timeStampInUTC: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}time_stamp_in_u_t_c']),
      toInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}to_in_json']),
      fromInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}from_in_json']),
      fromToDisplay: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}from_to_display']),
      ccInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}cc_in_json']),
      bccInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}bcc_in_json']),
      senderInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sender_in_json']),
      replyToInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}reply_to_in_json']),
      hasAttachments: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}has_attachments']),
      hasVcardAttachment: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}has_vcard_attachment']),
      hasIcalAttachment: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}has_ical_attachment']),
      importance:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}importance']),
      draftInfoInJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}draft_info_in_json']),
      sensitivity: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}sensitivity']),
      downloadAsEmlUrl: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}download_as_eml_url']),
      hash: stringType.mapFromDatabaseResponse(data['${effectivePrefix}hash']),
      headers:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}headers']),
      inReplyTo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}in_reply_to']),
      references: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}message_references']),
      readingConfirmationAddressee: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}reading_confirmation_addressee']),
      html: stringType.mapFromDatabaseResponse(data['${effectivePrefix}html']),
      plain:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}plain']),
      rtl: boolType.mapFromDatabaseResponse(data['${effectivePrefix}rtl']),
      extendInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}extend_in_json']),
      safety:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}safety']),
      hasExternals: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}has_externals']),
      foundedCIDsInJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}founded_c_i_ds_in_json']),
      foundedContentLocationUrlsInJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}founded_content_location_urls_in_json']),
      attachmentsInJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}attachments_in_json']),
      customInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}custom_in_json']),
    );
  }
  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Message(
      localId: serializer.fromJson<int>(json['localId']),
      uid: serializer.fromJson<int>(json['uid']),
      accountEntityId: serializer.fromJson<int>(json['accountEntityId']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      uniqueUidInFolder: serializer.fromJson<String>(json['uniqueUidInFolder']),
      parentUid: serializer.fromJson<int>(json['parentUid']),
      messageId: serializer.fromJson<String>(json['messageId']),
      folder: serializer.fromJson<String>(json['folder']),
      flagsInJson: serializer.fromJson<String>(json['flagsInJson']),
      hasThread: serializer.fromJson<bool>(json['hasThread']),
      subject: serializer.fromJson<String>(json['subject']),
      size: serializer.fromJson<int>(json['size']),
      textSize: serializer.fromJson<int>(json['textSize']),
      truncated: serializer.fromJson<bool>(json['truncated']),
      internalTimeStampInUTC:
          serializer.fromJson<int>(json['internalTimeStampInUTC']),
      receivedOrDateTimeStampInUTC:
          serializer.fromJson<int>(json['receivedOrDateTimeStampInUTC']),
      timeStampInUTC: serializer.fromJson<int>(json['timeStampInUTC']),
      toInJson: serializer.fromJson<String>(json['toInJson']),
      fromInJson: serializer.fromJson<String>(json['fromInJson']),
      fromToDisplay: serializer.fromJson<String>(json['fromToDisplay']),
      ccInJson: serializer.fromJson<String>(json['ccInJson']),
      bccInJson: serializer.fromJson<String>(json['bccInJson']),
      senderInJson: serializer.fromJson<String>(json['senderInJson']),
      replyToInJson: serializer.fromJson<String>(json['replyToInJson']),
      hasAttachments: serializer.fromJson<bool>(json['hasAttachments']),
      hasVcardAttachment: serializer.fromJson<bool>(json['hasVcardAttachment']),
      hasIcalAttachment: serializer.fromJson<bool>(json['hasIcalAttachment']),
      importance: serializer.fromJson<int>(json['importance']),
      draftInfoInJson: serializer.fromJson<String>(json['draftInfoInJson']),
      sensitivity: serializer.fromJson<int>(json['sensitivity']),
      downloadAsEmlUrl: serializer.fromJson<String>(json['downloadAsEmlUrl']),
      hash: serializer.fromJson<String>(json['hash']),
      headers: serializer.fromJson<String>(json['headers']),
      inReplyTo: serializer.fromJson<String>(json['inReplyTo']),
      references: serializer.fromJson<String>(json['references']),
      readingConfirmationAddressee:
          serializer.fromJson<String>(json['readingConfirmationAddressee']),
      html: serializer.fromJson<String>(json['html']),
      plain: serializer.fromJson<String>(json['plain']),
      rtl: serializer.fromJson<bool>(json['rtl']),
      extendInJson: serializer.fromJson<String>(json['extendInJson']),
      safety: serializer.fromJson<bool>(json['safety']),
      hasExternals: serializer.fromJson<bool>(json['hasExternals']),
      foundedCIDsInJson: serializer.fromJson<String>(json['foundedCIDsInJson']),
      foundedContentLocationUrlsInJson:
          serializer.fromJson<String>(json['foundedContentLocationUrlsInJson']),
      attachmentsInJson: serializer.fromJson<String>(json['attachmentsInJson']),
      customInJson: serializer.fromJson<String>(json['customInJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'uid': serializer.toJson<int>(uid),
      'accountEntityId': serializer.toJson<int>(accountEntityId),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'uniqueUidInFolder': serializer.toJson<String>(uniqueUidInFolder),
      'parentUid': serializer.toJson<int>(parentUid),
      'messageId': serializer.toJson<String>(messageId),
      'folder': serializer.toJson<String>(folder),
      'flagsInJson': serializer.toJson<String>(flagsInJson),
      'hasThread': serializer.toJson<bool>(hasThread),
      'subject': serializer.toJson<String>(subject),
      'size': serializer.toJson<int>(size),
      'textSize': serializer.toJson<int>(textSize),
      'truncated': serializer.toJson<bool>(truncated),
      'internalTimeStampInUTC': serializer.toJson<int>(internalTimeStampInUTC),
      'receivedOrDateTimeStampInUTC':
          serializer.toJson<int>(receivedOrDateTimeStampInUTC),
      'timeStampInUTC': serializer.toJson<int>(timeStampInUTC),
      'toInJson': serializer.toJson<String>(toInJson),
      'fromInJson': serializer.toJson<String>(fromInJson),
      'fromToDisplay': serializer.toJson<String>(fromToDisplay),
      'ccInJson': serializer.toJson<String>(ccInJson),
      'bccInJson': serializer.toJson<String>(bccInJson),
      'senderInJson': serializer.toJson<String>(senderInJson),
      'replyToInJson': serializer.toJson<String>(replyToInJson),
      'hasAttachments': serializer.toJson<bool>(hasAttachments),
      'hasVcardAttachment': serializer.toJson<bool>(hasVcardAttachment),
      'hasIcalAttachment': serializer.toJson<bool>(hasIcalAttachment),
      'importance': serializer.toJson<int>(importance),
      'draftInfoInJson': serializer.toJson<String>(draftInfoInJson),
      'sensitivity': serializer.toJson<int>(sensitivity),
      'downloadAsEmlUrl': serializer.toJson<String>(downloadAsEmlUrl),
      'hash': serializer.toJson<String>(hash),
      'headers': serializer.toJson<String>(headers),
      'inReplyTo': serializer.toJson<String>(inReplyTo),
      'references': serializer.toJson<String>(references),
      'readingConfirmationAddressee':
          serializer.toJson<String>(readingConfirmationAddressee),
      'html': serializer.toJson<String>(html),
      'plain': serializer.toJson<String>(plain),
      'rtl': serializer.toJson<bool>(rtl),
      'extendInJson': serializer.toJson<String>(extendInJson),
      'safety': serializer.toJson<bool>(safety),
      'hasExternals': serializer.toJson<bool>(hasExternals),
      'foundedCIDsInJson': serializer.toJson<String>(foundedCIDsInJson),
      'foundedContentLocationUrlsInJson':
          serializer.toJson<String>(foundedContentLocationUrlsInJson),
      'attachmentsInJson': serializer.toJson<String>(attachmentsInJson),
      'customInJson': serializer.toJson<String>(customInJson),
    };
  }

  @override
  MailCompanion createCompanion(bool nullToAbsent) {
    return MailCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      uid: uid == null && nullToAbsent ? const Value.absent() : Value(uid),
      accountEntityId: accountEntityId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountEntityId),
      userLocalId: userLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(userLocalId),
      uniqueUidInFolder: uniqueUidInFolder == null && nullToAbsent
          ? const Value.absent()
          : Value(uniqueUidInFolder),
      parentUid: parentUid == null && nullToAbsent
          ? const Value.absent()
          : Value(parentUid),
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
      folder:
          folder == null && nullToAbsent ? const Value.absent() : Value(folder),
      flagsInJson: flagsInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(flagsInJson),
      hasThread: hasThread == null && nullToAbsent
          ? const Value.absent()
          : Value(hasThread),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      textSize: textSize == null && nullToAbsent
          ? const Value.absent()
          : Value(textSize),
      truncated: truncated == null && nullToAbsent
          ? const Value.absent()
          : Value(truncated),
      internalTimeStampInUTC: internalTimeStampInUTC == null && nullToAbsent
          ? const Value.absent()
          : Value(internalTimeStampInUTC),
      receivedOrDateTimeStampInUTC:
          receivedOrDateTimeStampInUTC == null && nullToAbsent
              ? const Value.absent()
              : Value(receivedOrDateTimeStampInUTC),
      timeStampInUTC: timeStampInUTC == null && nullToAbsent
          ? const Value.absent()
          : Value(timeStampInUTC),
      toInJson: toInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(toInJson),
      fromInJson: fromInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(fromInJson),
      fromToDisplay: fromToDisplay == null && nullToAbsent
          ? const Value.absent()
          : Value(fromToDisplay),
      ccInJson: ccInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(ccInJson),
      bccInJson: bccInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(bccInJson),
      senderInJson: senderInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(senderInJson),
      replyToInJson: replyToInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToInJson),
      hasAttachments: hasAttachments == null && nullToAbsent
          ? const Value.absent()
          : Value(hasAttachments),
      hasVcardAttachment: hasVcardAttachment == null && nullToAbsent
          ? const Value.absent()
          : Value(hasVcardAttachment),
      hasIcalAttachment: hasIcalAttachment == null && nullToAbsent
          ? const Value.absent()
          : Value(hasIcalAttachment),
      importance: importance == null && nullToAbsent
          ? const Value.absent()
          : Value(importance),
      draftInfoInJson: draftInfoInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(draftInfoInJson),
      sensitivity: sensitivity == null && nullToAbsent
          ? const Value.absent()
          : Value(sensitivity),
      downloadAsEmlUrl: downloadAsEmlUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadAsEmlUrl),
      hash: hash == null && nullToAbsent ? const Value.absent() : Value(hash),
      headers: headers == null && nullToAbsent
          ? const Value.absent()
          : Value(headers),
      inReplyTo: inReplyTo == null && nullToAbsent
          ? const Value.absent()
          : Value(inReplyTo),
      references: references == null && nullToAbsent
          ? const Value.absent()
          : Value(references),
      readingConfirmationAddressee:
          readingConfirmationAddressee == null && nullToAbsent
              ? const Value.absent()
              : Value(readingConfirmationAddressee),
      html: html == null && nullToAbsent ? const Value.absent() : Value(html),
      plain:
          plain == null && nullToAbsent ? const Value.absent() : Value(plain),
      rtl: rtl == null && nullToAbsent ? const Value.absent() : Value(rtl),
      extendInJson: extendInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(extendInJson),
      safety:
          safety == null && nullToAbsent ? const Value.absent() : Value(safety),
      hasExternals: hasExternals == null && nullToAbsent
          ? const Value.absent()
          : Value(hasExternals),
      foundedCIDsInJson: foundedCIDsInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(foundedCIDsInJson),
      foundedContentLocationUrlsInJson:
          foundedContentLocationUrlsInJson == null && nullToAbsent
              ? const Value.absent()
              : Value(foundedContentLocationUrlsInJson),
      attachmentsInJson: attachmentsInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentsInJson),
      customInJson: customInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customInJson),
    );
  }

  Message copyWith(
          {int localId,
          int uid,
          int accountEntityId,
          int userLocalId,
          String uniqueUidInFolder,
          int parentUid,
          String messageId,
          String folder,
          String flagsInJson,
          bool hasThread,
          String subject,
          int size,
          int textSize,
          bool truncated,
          int internalTimeStampInUTC,
          int receivedOrDateTimeStampInUTC,
          int timeStampInUTC,
          String toInJson,
          String fromInJson,
          String fromToDisplay,
          String ccInJson,
          String bccInJson,
          String senderInJson,
          String replyToInJson,
          bool hasAttachments,
          bool hasVcardAttachment,
          bool hasIcalAttachment,
          int importance,
          String draftInfoInJson,
          int sensitivity,
          String downloadAsEmlUrl,
          String hash,
          String headers,
          String inReplyTo,
          String references,
          String readingConfirmationAddressee,
          String html,
          String plain,
          bool rtl,
          String extendInJson,
          bool safety,
          bool hasExternals,
          String foundedCIDsInJson,
          String foundedContentLocationUrlsInJson,
          String attachmentsInJson,
          String customInJson}) =>
      Message(
        localId: localId ?? this.localId,
        uid: uid ?? this.uid,
        accountEntityId: accountEntityId ?? this.accountEntityId,
        userLocalId: userLocalId ?? this.userLocalId,
        uniqueUidInFolder: uniqueUidInFolder ?? this.uniqueUidInFolder,
        parentUid: parentUid ?? this.parentUid,
        messageId: messageId ?? this.messageId,
        folder: folder ?? this.folder,
        flagsInJson: flagsInJson ?? this.flagsInJson,
        hasThread: hasThread ?? this.hasThread,
        subject: subject ?? this.subject,
        size: size ?? this.size,
        textSize: textSize ?? this.textSize,
        truncated: truncated ?? this.truncated,
        internalTimeStampInUTC:
            internalTimeStampInUTC ?? this.internalTimeStampInUTC,
        receivedOrDateTimeStampInUTC:
            receivedOrDateTimeStampInUTC ?? this.receivedOrDateTimeStampInUTC,
        timeStampInUTC: timeStampInUTC ?? this.timeStampInUTC,
        toInJson: toInJson ?? this.toInJson,
        fromInJson: fromInJson ?? this.fromInJson,
        fromToDisplay: fromToDisplay ?? this.fromToDisplay,
        ccInJson: ccInJson ?? this.ccInJson,
        bccInJson: bccInJson ?? this.bccInJson,
        senderInJson: senderInJson ?? this.senderInJson,
        replyToInJson: replyToInJson ?? this.replyToInJson,
        hasAttachments: hasAttachments ?? this.hasAttachments,
        hasVcardAttachment: hasVcardAttachment ?? this.hasVcardAttachment,
        hasIcalAttachment: hasIcalAttachment ?? this.hasIcalAttachment,
        importance: importance ?? this.importance,
        draftInfoInJson: draftInfoInJson ?? this.draftInfoInJson,
        sensitivity: sensitivity ?? this.sensitivity,
        downloadAsEmlUrl: downloadAsEmlUrl ?? this.downloadAsEmlUrl,
        hash: hash ?? this.hash,
        headers: headers ?? this.headers,
        inReplyTo: inReplyTo ?? this.inReplyTo,
        references: references ?? this.references,
        readingConfirmationAddressee:
            readingConfirmationAddressee ?? this.readingConfirmationAddressee,
        html: html ?? this.html,
        plain: plain ?? this.plain,
        rtl: rtl ?? this.rtl,
        extendInJson: extendInJson ?? this.extendInJson,
        safety: safety ?? this.safety,
        hasExternals: hasExternals ?? this.hasExternals,
        foundedCIDsInJson: foundedCIDsInJson ?? this.foundedCIDsInJson,
        foundedContentLocationUrlsInJson: foundedContentLocationUrlsInJson ??
            this.foundedContentLocationUrlsInJson,
        attachmentsInJson: attachmentsInJson ?? this.attachmentsInJson,
        customInJson: customInJson ?? this.customInJson,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('localId: $localId, ')
          ..write('uid: $uid, ')
          ..write('accountEntityId: $accountEntityId, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('uniqueUidInFolder: $uniqueUidInFolder, ')
          ..write('parentUid: $parentUid, ')
          ..write('messageId: $messageId, ')
          ..write('folder: $folder, ')
          ..write('flagsInJson: $flagsInJson, ')
          ..write('hasThread: $hasThread, ')
          ..write('subject: $subject, ')
          ..write('size: $size, ')
          ..write('textSize: $textSize, ')
          ..write('truncated: $truncated, ')
          ..write('internalTimeStampInUTC: $internalTimeStampInUTC, ')
          ..write(
              'receivedOrDateTimeStampInUTC: $receivedOrDateTimeStampInUTC, ')
          ..write('timeStampInUTC: $timeStampInUTC, ')
          ..write('toInJson: $toInJson, ')
          ..write('fromInJson: $fromInJson, ')
          ..write('fromToDisplay: $fromToDisplay, ')
          ..write('ccInJson: $ccInJson, ')
          ..write('bccInJson: $bccInJson, ')
          ..write('senderInJson: $senderInJson, ')
          ..write('replyToInJson: $replyToInJson, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('hasVcardAttachment: $hasVcardAttachment, ')
          ..write('hasIcalAttachment: $hasIcalAttachment, ')
          ..write('importance: $importance, ')
          ..write('draftInfoInJson: $draftInfoInJson, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('downloadAsEmlUrl: $downloadAsEmlUrl, ')
          ..write('hash: $hash, ')
          ..write('headers: $headers, ')
          ..write('inReplyTo: $inReplyTo, ')
          ..write('references: $references, ')
          ..write(
              'readingConfirmationAddressee: $readingConfirmationAddressee, ')
          ..write('html: $html, ')
          ..write('plain: $plain, ')
          ..write('rtl: $rtl, ')
          ..write('extendInJson: $extendInJson, ')
          ..write('safety: $safety, ')
          ..write('hasExternals: $hasExternals, ')
          ..write('foundedCIDsInJson: $foundedCIDsInJson, ')
          ..write(
              'foundedContentLocationUrlsInJson: $foundedContentLocationUrlsInJson, ')
          ..write('attachmentsInJson: $attachmentsInJson, ')
          ..write('customInJson: $customInJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      localId.hashCode,
      $mrjc(
          uid.hashCode,
          $mrjc(
              accountEntityId.hashCode,
              $mrjc(
                  userLocalId.hashCode,
                  $mrjc(
                      uniqueUidInFolder.hashCode,
                      $mrjc(
                          parentUid.hashCode,
                          $mrjc(
                              messageId.hashCode,
                              $mrjc(
                                  folder.hashCode,
                                  $mrjc(
                                      flagsInJson.hashCode,
                                      $mrjc(
                                          hasThread.hashCode,
                                          $mrjc(
                                              subject.hashCode,
                                              $mrjc(
                                                  size.hashCode,
                                                  $mrjc(
                                                      textSize.hashCode,
                                                      $mrjc(
                                                          truncated.hashCode,
                                                          $mrjc(
                                                              internalTimeStampInUTC
                                                                  .hashCode,
                                                              $mrjc(
                                                                  receivedOrDateTimeStampInUTC
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      timeStampInUTC
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          toInJson
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              fromInJson.hashCode,
                                                                              $mrjc(fromToDisplay.hashCode, $mrjc(ccInJson.hashCode, $mrjc(bccInJson.hashCode, $mrjc(senderInJson.hashCode, $mrjc(replyToInJson.hashCode, $mrjc(hasAttachments.hashCode, $mrjc(hasVcardAttachment.hashCode, $mrjc(hasIcalAttachment.hashCode, $mrjc(importance.hashCode, $mrjc(draftInfoInJson.hashCode, $mrjc(sensitivity.hashCode, $mrjc(downloadAsEmlUrl.hashCode, $mrjc(hash.hashCode, $mrjc(headers.hashCode, $mrjc(inReplyTo.hashCode, $mrjc(references.hashCode, $mrjc(readingConfirmationAddressee.hashCode, $mrjc(html.hashCode, $mrjc(plain.hashCode, $mrjc(rtl.hashCode, $mrjc(extendInJson.hashCode, $mrjc(safety.hashCode, $mrjc(hasExternals.hashCode, $mrjc(foundedCIDsInJson.hashCode, $mrjc(foundedContentLocationUrlsInJson.hashCode, $mrjc(attachmentsInJson.hashCode, customInJson.hashCode))))))))))))))))))))))))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Message &&
          other.localId == this.localId &&
          other.uid == this.uid &&
          other.accountEntityId == this.accountEntityId &&
          other.userLocalId == this.userLocalId &&
          other.uniqueUidInFolder == this.uniqueUidInFolder &&
          other.parentUid == this.parentUid &&
          other.messageId == this.messageId &&
          other.folder == this.folder &&
          other.flagsInJson == this.flagsInJson &&
          other.hasThread == this.hasThread &&
          other.subject == this.subject &&
          other.size == this.size &&
          other.textSize == this.textSize &&
          other.truncated == this.truncated &&
          other.internalTimeStampInUTC == this.internalTimeStampInUTC &&
          other.receivedOrDateTimeStampInUTC ==
              this.receivedOrDateTimeStampInUTC &&
          other.timeStampInUTC == this.timeStampInUTC &&
          other.toInJson == this.toInJson &&
          other.fromInJson == this.fromInJson &&
          other.fromToDisplay == this.fromToDisplay &&
          other.ccInJson == this.ccInJson &&
          other.bccInJson == this.bccInJson &&
          other.senderInJson == this.senderInJson &&
          other.replyToInJson == this.replyToInJson &&
          other.hasAttachments == this.hasAttachments &&
          other.hasVcardAttachment == this.hasVcardAttachment &&
          other.hasIcalAttachment == this.hasIcalAttachment &&
          other.importance == this.importance &&
          other.draftInfoInJson == this.draftInfoInJson &&
          other.sensitivity == this.sensitivity &&
          other.downloadAsEmlUrl == this.downloadAsEmlUrl &&
          other.hash == this.hash &&
          other.headers == this.headers &&
          other.inReplyTo == this.inReplyTo &&
          other.references == this.references &&
          other.readingConfirmationAddressee ==
              this.readingConfirmationAddressee &&
          other.html == this.html &&
          other.plain == this.plain &&
          other.rtl == this.rtl &&
          other.extendInJson == this.extendInJson &&
          other.safety == this.safety &&
          other.hasExternals == this.hasExternals &&
          other.foundedCIDsInJson == this.foundedCIDsInJson &&
          other.foundedContentLocationUrlsInJson ==
              this.foundedContentLocationUrlsInJson &&
          other.attachmentsInJson == this.attachmentsInJson &&
          other.customInJson == this.customInJson);
}

class MailCompanion extends UpdateCompanion<Message> {
  final Value<int> localId;
  final Value<int> uid;
  final Value<int> accountEntityId;
  final Value<int> userLocalId;
  final Value<String> uniqueUidInFolder;
  final Value<int> parentUid;
  final Value<String> messageId;
  final Value<String> folder;
  final Value<String> flagsInJson;
  final Value<bool> hasThread;
  final Value<String> subject;
  final Value<int> size;
  final Value<int> textSize;
  final Value<bool> truncated;
  final Value<int> internalTimeStampInUTC;
  final Value<int> receivedOrDateTimeStampInUTC;
  final Value<int> timeStampInUTC;
  final Value<String> toInJson;
  final Value<String> fromInJson;
  final Value<String> fromToDisplay;
  final Value<String> ccInJson;
  final Value<String> bccInJson;
  final Value<String> senderInJson;
  final Value<String> replyToInJson;
  final Value<bool> hasAttachments;
  final Value<bool> hasVcardAttachment;
  final Value<bool> hasIcalAttachment;
  final Value<int> importance;
  final Value<String> draftInfoInJson;
  final Value<int> sensitivity;
  final Value<String> downloadAsEmlUrl;
  final Value<String> hash;
  final Value<String> headers;
  final Value<String> inReplyTo;
  final Value<String> references;
  final Value<String> readingConfirmationAddressee;
  final Value<String> html;
  final Value<String> plain;
  final Value<bool> rtl;
  final Value<String> extendInJson;
  final Value<bool> safety;
  final Value<bool> hasExternals;
  final Value<String> foundedCIDsInJson;
  final Value<String> foundedContentLocationUrlsInJson;
  final Value<String> attachmentsInJson;
  final Value<String> customInJson;
  const MailCompanion({
    this.localId = const Value.absent(),
    this.uid = const Value.absent(),
    this.accountEntityId = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.uniqueUidInFolder = const Value.absent(),
    this.parentUid = const Value.absent(),
    this.messageId = const Value.absent(),
    this.folder = const Value.absent(),
    this.flagsInJson = const Value.absent(),
    this.hasThread = const Value.absent(),
    this.subject = const Value.absent(),
    this.size = const Value.absent(),
    this.textSize = const Value.absent(),
    this.truncated = const Value.absent(),
    this.internalTimeStampInUTC = const Value.absent(),
    this.receivedOrDateTimeStampInUTC = const Value.absent(),
    this.timeStampInUTC = const Value.absent(),
    this.toInJson = const Value.absent(),
    this.fromInJson = const Value.absent(),
    this.fromToDisplay = const Value.absent(),
    this.ccInJson = const Value.absent(),
    this.bccInJson = const Value.absent(),
    this.senderInJson = const Value.absent(),
    this.replyToInJson = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.hasVcardAttachment = const Value.absent(),
    this.hasIcalAttachment = const Value.absent(),
    this.importance = const Value.absent(),
    this.draftInfoInJson = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.downloadAsEmlUrl = const Value.absent(),
    this.hash = const Value.absent(),
    this.headers = const Value.absent(),
    this.inReplyTo = const Value.absent(),
    this.references = const Value.absent(),
    this.readingConfirmationAddressee = const Value.absent(),
    this.html = const Value.absent(),
    this.plain = const Value.absent(),
    this.rtl = const Value.absent(),
    this.extendInJson = const Value.absent(),
    this.safety = const Value.absent(),
    this.hasExternals = const Value.absent(),
    this.foundedCIDsInJson = const Value.absent(),
    this.foundedContentLocationUrlsInJson = const Value.absent(),
    this.attachmentsInJson = const Value.absent(),
    this.customInJson = const Value.absent(),
  });
  MailCompanion.insert({
    this.localId = const Value.absent(),
    @required int uid,
    @required int accountEntityId,
    @required int userLocalId,
    @required String uniqueUidInFolder,
    this.parentUid = const Value.absent(),
    @required String messageId,
    @required String folder,
    @required String flagsInJson,
    @required bool hasThread,
    @required String subject,
    @required int size,
    @required int textSize,
    @required bool truncated,
    @required int internalTimeStampInUTC,
    @required int receivedOrDateTimeStampInUTC,
    @required int timeStampInUTC,
    this.toInJson = const Value.absent(),
    this.fromInJson = const Value.absent(),
    @required String fromToDisplay,
    this.ccInJson = const Value.absent(),
    this.bccInJson = const Value.absent(),
    this.senderInJson = const Value.absent(),
    this.replyToInJson = const Value.absent(),
    @required bool hasAttachments,
    @required bool hasVcardAttachment,
    @required bool hasIcalAttachment,
    @required int importance,
    this.draftInfoInJson = const Value.absent(),
    @required int sensitivity,
    @required String downloadAsEmlUrl,
    @required String hash,
    @required String headers,
    @required String inReplyTo,
    @required String references,
    @required String readingConfirmationAddressee,
    this.html = const Value.absent(),
    @required String plain,
    @required bool rtl,
    @required String extendInJson,
    @required bool safety,
    @required bool hasExternals,
    @required String foundedCIDsInJson,
    @required String foundedContentLocationUrlsInJson,
    this.attachmentsInJson = const Value.absent(),
    @required String customInJson,
  })  : uid = Value(uid),
        accountEntityId = Value(accountEntityId),
        userLocalId = Value(userLocalId),
        uniqueUidInFolder = Value(uniqueUidInFolder),
        messageId = Value(messageId),
        folder = Value(folder),
        flagsInJson = Value(flagsInJson),
        hasThread = Value(hasThread),
        subject = Value(subject),
        size = Value(size),
        textSize = Value(textSize),
        truncated = Value(truncated),
        internalTimeStampInUTC = Value(internalTimeStampInUTC),
        receivedOrDateTimeStampInUTC = Value(receivedOrDateTimeStampInUTC),
        timeStampInUTC = Value(timeStampInUTC),
        fromToDisplay = Value(fromToDisplay),
        hasAttachments = Value(hasAttachments),
        hasVcardAttachment = Value(hasVcardAttachment),
        hasIcalAttachment = Value(hasIcalAttachment),
        importance = Value(importance),
        sensitivity = Value(sensitivity),
        downloadAsEmlUrl = Value(downloadAsEmlUrl),
        hash = Value(hash),
        headers = Value(headers),
        inReplyTo = Value(inReplyTo),
        references = Value(references),
        readingConfirmationAddressee = Value(readingConfirmationAddressee),
        plain = Value(plain),
        rtl = Value(rtl),
        extendInJson = Value(extendInJson),
        safety = Value(safety),
        hasExternals = Value(hasExternals),
        foundedCIDsInJson = Value(foundedCIDsInJson),
        foundedContentLocationUrlsInJson =
            Value(foundedContentLocationUrlsInJson),
        customInJson = Value(customInJson);
  MailCompanion copyWith(
      {Value<int> localId,
      Value<int> uid,
      Value<int> accountEntityId,
      Value<int> userLocalId,
      Value<String> uniqueUidInFolder,
      Value<int> parentUid,
      Value<String> messageId,
      Value<String> folder,
      Value<String> flagsInJson,
      Value<bool> hasThread,
      Value<String> subject,
      Value<int> size,
      Value<int> textSize,
      Value<bool> truncated,
      Value<int> internalTimeStampInUTC,
      Value<int> receivedOrDateTimeStampInUTC,
      Value<int> timeStampInUTC,
      Value<String> toInJson,
      Value<String> fromInJson,
      Value<String> fromToDisplay,
      Value<String> ccInJson,
      Value<String> bccInJson,
      Value<String> senderInJson,
      Value<String> replyToInJson,
      Value<bool> hasAttachments,
      Value<bool> hasVcardAttachment,
      Value<bool> hasIcalAttachment,
      Value<int> importance,
      Value<String> draftInfoInJson,
      Value<int> sensitivity,
      Value<String> downloadAsEmlUrl,
      Value<String> hash,
      Value<String> headers,
      Value<String> inReplyTo,
      Value<String> references,
      Value<String> readingConfirmationAddressee,
      Value<String> html,
      Value<String> plain,
      Value<bool> rtl,
      Value<String> extendInJson,
      Value<bool> safety,
      Value<bool> hasExternals,
      Value<String> foundedCIDsInJson,
      Value<String> foundedContentLocationUrlsInJson,
      Value<String> attachmentsInJson,
      Value<String> customInJson}) {
    return MailCompanion(
      localId: localId ?? this.localId,
      uid: uid ?? this.uid,
      accountEntityId: accountEntityId ?? this.accountEntityId,
      userLocalId: userLocalId ?? this.userLocalId,
      uniqueUidInFolder: uniqueUidInFolder ?? this.uniqueUidInFolder,
      parentUid: parentUid ?? this.parentUid,
      messageId: messageId ?? this.messageId,
      folder: folder ?? this.folder,
      flagsInJson: flagsInJson ?? this.flagsInJson,
      hasThread: hasThread ?? this.hasThread,
      subject: subject ?? this.subject,
      size: size ?? this.size,
      textSize: textSize ?? this.textSize,
      truncated: truncated ?? this.truncated,
      internalTimeStampInUTC:
          internalTimeStampInUTC ?? this.internalTimeStampInUTC,
      receivedOrDateTimeStampInUTC:
          receivedOrDateTimeStampInUTC ?? this.receivedOrDateTimeStampInUTC,
      timeStampInUTC: timeStampInUTC ?? this.timeStampInUTC,
      toInJson: toInJson ?? this.toInJson,
      fromInJson: fromInJson ?? this.fromInJson,
      fromToDisplay: fromToDisplay ?? this.fromToDisplay,
      ccInJson: ccInJson ?? this.ccInJson,
      bccInJson: bccInJson ?? this.bccInJson,
      senderInJson: senderInJson ?? this.senderInJson,
      replyToInJson: replyToInJson ?? this.replyToInJson,
      hasAttachments: hasAttachments ?? this.hasAttachments,
      hasVcardAttachment: hasVcardAttachment ?? this.hasVcardAttachment,
      hasIcalAttachment: hasIcalAttachment ?? this.hasIcalAttachment,
      importance: importance ?? this.importance,
      draftInfoInJson: draftInfoInJson ?? this.draftInfoInJson,
      sensitivity: sensitivity ?? this.sensitivity,
      downloadAsEmlUrl: downloadAsEmlUrl ?? this.downloadAsEmlUrl,
      hash: hash ?? this.hash,
      headers: headers ?? this.headers,
      inReplyTo: inReplyTo ?? this.inReplyTo,
      references: references ?? this.references,
      readingConfirmationAddressee:
          readingConfirmationAddressee ?? this.readingConfirmationAddressee,
      html: html ?? this.html,
      plain: plain ?? this.plain,
      rtl: rtl ?? this.rtl,
      extendInJson: extendInJson ?? this.extendInJson,
      safety: safety ?? this.safety,
      hasExternals: hasExternals ?? this.hasExternals,
      foundedCIDsInJson: foundedCIDsInJson ?? this.foundedCIDsInJson,
      foundedContentLocationUrlsInJson: foundedContentLocationUrlsInJson ??
          this.foundedContentLocationUrlsInJson,
      attachmentsInJson: attachmentsInJson ?? this.attachmentsInJson,
      customInJson: customInJson ?? this.customInJson,
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

  final VerificationMeta _uidMeta = const VerificationMeta('uid');
  GeneratedIntColumn _uid;
  @override
  GeneratedIntColumn get uid => _uid ??= _constructUid();
  GeneratedIntColumn _constructUid() {
    return GeneratedIntColumn(
      'uid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _accountEntityIdMeta =
      const VerificationMeta('accountEntityId');
  GeneratedIntColumn _accountEntityId;
  @override
  GeneratedIntColumn get accountEntityId =>
      _accountEntityId ??= _constructAccountEntityId();
  GeneratedIntColumn _constructAccountEntityId() {
    return GeneratedIntColumn(
      'account_entity_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  GeneratedIntColumn _userLocalId;
  @override
  GeneratedIntColumn get userLocalId =>
      _userLocalId ??= _constructUserLocalId();
  GeneratedIntColumn _constructUserLocalId() {
    return GeneratedIntColumn(
      'user_local_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uniqueUidInFolderMeta =
      const VerificationMeta('uniqueUidInFolder');
  GeneratedTextColumn _uniqueUidInFolder;
  @override
  GeneratedTextColumn get uniqueUidInFolder =>
      _uniqueUidInFolder ??= _constructUniqueUidInFolder();
  GeneratedTextColumn _constructUniqueUidInFolder() {
    return GeneratedTextColumn('unique_uid_in_folder', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _parentUidMeta = const VerificationMeta('parentUid');
  GeneratedIntColumn _parentUid;
  @override
  GeneratedIntColumn get parentUid => _parentUid ??= _constructParentUid();
  GeneratedIntColumn _constructParentUid() {
    return GeneratedIntColumn(
      'parent_uid',
      $tableName,
      true,
    );
  }

  final VerificationMeta _messageIdMeta = const VerificationMeta('messageId');
  GeneratedTextColumn _messageId;
  @override
  GeneratedTextColumn get messageId => _messageId ??= _constructMessageId();
  GeneratedTextColumn _constructMessageId() {
    return GeneratedTextColumn(
      'message_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _folderMeta = const VerificationMeta('folder');
  GeneratedTextColumn _folder;
  @override
  GeneratedTextColumn get folder => _folder ??= _constructFolder();
  GeneratedTextColumn _constructFolder() {
    return GeneratedTextColumn(
      'folder',
      $tableName,
      false,
    );
  }

  final VerificationMeta _flagsInJsonMeta =
      const VerificationMeta('flagsInJson');
  GeneratedTextColumn _flagsInJson;
  @override
  GeneratedTextColumn get flagsInJson =>
      _flagsInJson ??= _constructFlagsInJson();
  GeneratedTextColumn _constructFlagsInJson() {
    return GeneratedTextColumn(
      'flags_in_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hasThreadMeta = const VerificationMeta('hasThread');
  GeneratedBoolColumn _hasThread;
  @override
  GeneratedBoolColumn get hasThread => _hasThread ??= _constructHasThread();
  GeneratedBoolColumn _constructHasThread() {
    return GeneratedBoolColumn(
      'has_thread',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subjectMeta = const VerificationMeta('subject');
  GeneratedTextColumn _subject;
  @override
  GeneratedTextColumn get subject => _subject ??= _constructSubject();
  GeneratedTextColumn _constructSubject() {
    return GeneratedTextColumn(
      'subject',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedIntColumn _size;
  @override
  GeneratedIntColumn get size => _size ??= _constructSize();
  GeneratedIntColumn _constructSize() {
    return GeneratedIntColumn(
      'size',
      $tableName,
      false,
    );
  }

  final VerificationMeta _textSizeMeta = const VerificationMeta('textSize');
  GeneratedIntColumn _textSize;
  @override
  GeneratedIntColumn get textSize => _textSize ??= _constructTextSize();
  GeneratedIntColumn _constructTextSize() {
    return GeneratedIntColumn(
      'text_size',
      $tableName,
      false,
    );
  }

  final VerificationMeta _truncatedMeta = const VerificationMeta('truncated');
  GeneratedBoolColumn _truncated;
  @override
  GeneratedBoolColumn get truncated => _truncated ??= _constructTruncated();
  GeneratedBoolColumn _constructTruncated() {
    return GeneratedBoolColumn(
      'truncated',
      $tableName,
      false,
    );
  }

  final VerificationMeta _internalTimeStampInUTCMeta =
      const VerificationMeta('internalTimeStampInUTC');
  GeneratedIntColumn _internalTimeStampInUTC;
  @override
  GeneratedIntColumn get internalTimeStampInUTC =>
      _internalTimeStampInUTC ??= _constructInternalTimeStampInUTC();
  GeneratedIntColumn _constructInternalTimeStampInUTC() {
    return GeneratedIntColumn(
      'internal_time_stamp_in_u_t_c',
      $tableName,
      false,
    );
  }

  final VerificationMeta _receivedOrDateTimeStampInUTCMeta =
      const VerificationMeta('receivedOrDateTimeStampInUTC');
  GeneratedIntColumn _receivedOrDateTimeStampInUTC;
  @override
  GeneratedIntColumn get receivedOrDateTimeStampInUTC =>
      _receivedOrDateTimeStampInUTC ??=
          _constructReceivedOrDateTimeStampInUTC();
  GeneratedIntColumn _constructReceivedOrDateTimeStampInUTC() {
    return GeneratedIntColumn(
      'received_or_date_time_stamp_in_u_t_c',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeStampInUTCMeta =
      const VerificationMeta('timeStampInUTC');
  GeneratedIntColumn _timeStampInUTC;
  @override
  GeneratedIntColumn get timeStampInUTC =>
      _timeStampInUTC ??= _constructTimeStampInUTC();
  GeneratedIntColumn _constructTimeStampInUTC() {
    return GeneratedIntColumn(
      'time_stamp_in_u_t_c',
      $tableName,
      false,
    );
  }

  final VerificationMeta _toInJsonMeta = const VerificationMeta('toInJson');
  GeneratedTextColumn _toInJson;
  @override
  GeneratedTextColumn get toInJson => _toInJson ??= _constructToInJson();
  GeneratedTextColumn _constructToInJson() {
    return GeneratedTextColumn(
      'to_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fromInJsonMeta = const VerificationMeta('fromInJson');
  GeneratedTextColumn _fromInJson;
  @override
  GeneratedTextColumn get fromInJson => _fromInJson ??= _constructFromInJson();
  GeneratedTextColumn _constructFromInJson() {
    return GeneratedTextColumn(
      'from_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fromToDisplayMeta =
      const VerificationMeta('fromToDisplay');
  GeneratedTextColumn _fromToDisplay;
  @override
  GeneratedTextColumn get fromToDisplay =>
      _fromToDisplay ??= _constructFromToDisplay();
  GeneratedTextColumn _constructFromToDisplay() {
    return GeneratedTextColumn(
      'from_to_display',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ccInJsonMeta = const VerificationMeta('ccInJson');
  GeneratedTextColumn _ccInJson;
  @override
  GeneratedTextColumn get ccInJson => _ccInJson ??= _constructCcInJson();
  GeneratedTextColumn _constructCcInJson() {
    return GeneratedTextColumn(
      'cc_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _bccInJsonMeta = const VerificationMeta('bccInJson');
  GeneratedTextColumn _bccInJson;
  @override
  GeneratedTextColumn get bccInJson => _bccInJson ??= _constructBccInJson();
  GeneratedTextColumn _constructBccInJson() {
    return GeneratedTextColumn(
      'bcc_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _senderInJsonMeta =
      const VerificationMeta('senderInJson');
  GeneratedTextColumn _senderInJson;
  @override
  GeneratedTextColumn get senderInJson =>
      _senderInJson ??= _constructSenderInJson();
  GeneratedTextColumn _constructSenderInJson() {
    return GeneratedTextColumn(
      'sender_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _replyToInJsonMeta =
      const VerificationMeta('replyToInJson');
  GeneratedTextColumn _replyToInJson;
  @override
  GeneratedTextColumn get replyToInJson =>
      _replyToInJson ??= _constructReplyToInJson();
  GeneratedTextColumn _constructReplyToInJson() {
    return GeneratedTextColumn(
      'reply_to_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _hasAttachmentsMeta =
      const VerificationMeta('hasAttachments');
  GeneratedBoolColumn _hasAttachments;
  @override
  GeneratedBoolColumn get hasAttachments =>
      _hasAttachments ??= _constructHasAttachments();
  GeneratedBoolColumn _constructHasAttachments() {
    return GeneratedBoolColumn(
      'has_attachments',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hasVcardAttachmentMeta =
      const VerificationMeta('hasVcardAttachment');
  GeneratedBoolColumn _hasVcardAttachment;
  @override
  GeneratedBoolColumn get hasVcardAttachment =>
      _hasVcardAttachment ??= _constructHasVcardAttachment();
  GeneratedBoolColumn _constructHasVcardAttachment() {
    return GeneratedBoolColumn(
      'has_vcard_attachment',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hasIcalAttachmentMeta =
      const VerificationMeta('hasIcalAttachment');
  GeneratedBoolColumn _hasIcalAttachment;
  @override
  GeneratedBoolColumn get hasIcalAttachment =>
      _hasIcalAttachment ??= _constructHasIcalAttachment();
  GeneratedBoolColumn _constructHasIcalAttachment() {
    return GeneratedBoolColumn(
      'has_ical_attachment',
      $tableName,
      false,
    );
  }

  final VerificationMeta _importanceMeta = const VerificationMeta('importance');
  GeneratedIntColumn _importance;
  @override
  GeneratedIntColumn get importance => _importance ??= _constructImportance();
  GeneratedIntColumn _constructImportance() {
    return GeneratedIntColumn(
      'importance',
      $tableName,
      false,
    );
  }

  final VerificationMeta _draftInfoInJsonMeta =
      const VerificationMeta('draftInfoInJson');
  GeneratedTextColumn _draftInfoInJson;
  @override
  GeneratedTextColumn get draftInfoInJson =>
      _draftInfoInJson ??= _constructDraftInfoInJson();
  GeneratedTextColumn _constructDraftInfoInJson() {
    return GeneratedTextColumn(
      'draft_info_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sensitivityMeta =
      const VerificationMeta('sensitivity');
  GeneratedIntColumn _sensitivity;
  @override
  GeneratedIntColumn get sensitivity =>
      _sensitivity ??= _constructSensitivity();
  GeneratedIntColumn _constructSensitivity() {
    return GeneratedIntColumn(
      'sensitivity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _downloadAsEmlUrlMeta =
      const VerificationMeta('downloadAsEmlUrl');
  GeneratedTextColumn _downloadAsEmlUrl;
  @override
  GeneratedTextColumn get downloadAsEmlUrl =>
      _downloadAsEmlUrl ??= _constructDownloadAsEmlUrl();
  GeneratedTextColumn _constructDownloadAsEmlUrl() {
    return GeneratedTextColumn(
      'download_as_eml_url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hashMeta = const VerificationMeta('hash');
  GeneratedTextColumn _hash;
  @override
  GeneratedTextColumn get hash => _hash ??= _constructHash();
  GeneratedTextColumn _constructHash() {
    return GeneratedTextColumn(
      'hash',
      $tableName,
      false,
    );
  }

  final VerificationMeta _headersMeta = const VerificationMeta('headers');
  GeneratedTextColumn _headers;
  @override
  GeneratedTextColumn get headers => _headers ??= _constructHeaders();
  GeneratedTextColumn _constructHeaders() {
    return GeneratedTextColumn(
      'headers',
      $tableName,
      false,
    );
  }

  final VerificationMeta _inReplyToMeta = const VerificationMeta('inReplyTo');
  GeneratedTextColumn _inReplyTo;
  @override
  GeneratedTextColumn get inReplyTo => _inReplyTo ??= _constructInReplyTo();
  GeneratedTextColumn _constructInReplyTo() {
    return GeneratedTextColumn(
      'in_reply_to',
      $tableName,
      false,
    );
  }

  final VerificationMeta _referencesMeta = const VerificationMeta('references');
  GeneratedTextColumn _references;
  @override
  GeneratedTextColumn get references => _references ??= _constructReferences();
  GeneratedTextColumn _constructReferences() {
    return GeneratedTextColumn(
      'message_references',
      $tableName,
      false,
    );
  }

  final VerificationMeta _readingConfirmationAddresseeMeta =
      const VerificationMeta('readingConfirmationAddressee');
  GeneratedTextColumn _readingConfirmationAddressee;
  @override
  GeneratedTextColumn get readingConfirmationAddressee =>
      _readingConfirmationAddressee ??=
          _constructReadingConfirmationAddressee();
  GeneratedTextColumn _constructReadingConfirmationAddressee() {
    return GeneratedTextColumn(
      'reading_confirmation_addressee',
      $tableName,
      false,
    );
  }

  final VerificationMeta _htmlMeta = const VerificationMeta('html');
  GeneratedTextColumn _html;
  @override
  GeneratedTextColumn get html => _html ??= _constructHtml();
  GeneratedTextColumn _constructHtml() {
    return GeneratedTextColumn(
      'html',
      $tableName,
      true,
    );
  }

  final VerificationMeta _plainMeta = const VerificationMeta('plain');
  GeneratedTextColumn _plain;
  @override
  GeneratedTextColumn get plain => _plain ??= _constructPlain();
  GeneratedTextColumn _constructPlain() {
    return GeneratedTextColumn(
      'plain',
      $tableName,
      false,
    );
  }

  final VerificationMeta _rtlMeta = const VerificationMeta('rtl');
  GeneratedBoolColumn _rtl;
  @override
  GeneratedBoolColumn get rtl => _rtl ??= _constructRtl();
  GeneratedBoolColumn _constructRtl() {
    return GeneratedBoolColumn(
      'rtl',
      $tableName,
      false,
    );
  }

  final VerificationMeta _extendInJsonMeta =
      const VerificationMeta('extendInJson');
  GeneratedTextColumn _extendInJson;
  @override
  GeneratedTextColumn get extendInJson =>
      _extendInJson ??= _constructExtendInJson();
  GeneratedTextColumn _constructExtendInJson() {
    return GeneratedTextColumn(
      'extend_in_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _safetyMeta = const VerificationMeta('safety');
  GeneratedBoolColumn _safety;
  @override
  GeneratedBoolColumn get safety => _safety ??= _constructSafety();
  GeneratedBoolColumn _constructSafety() {
    return GeneratedBoolColumn(
      'safety',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hasExternalsMeta =
      const VerificationMeta('hasExternals');
  GeneratedBoolColumn _hasExternals;
  @override
  GeneratedBoolColumn get hasExternals =>
      _hasExternals ??= _constructHasExternals();
  GeneratedBoolColumn _constructHasExternals() {
    return GeneratedBoolColumn(
      'has_externals',
      $tableName,
      false,
    );
  }

  final VerificationMeta _foundedCIDsInJsonMeta =
      const VerificationMeta('foundedCIDsInJson');
  GeneratedTextColumn _foundedCIDsInJson;
  @override
  GeneratedTextColumn get foundedCIDsInJson =>
      _foundedCIDsInJson ??= _constructFoundedCIDsInJson();
  GeneratedTextColumn _constructFoundedCIDsInJson() {
    return GeneratedTextColumn(
      'founded_c_i_ds_in_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _foundedContentLocationUrlsInJsonMeta =
      const VerificationMeta('foundedContentLocationUrlsInJson');
  GeneratedTextColumn _foundedContentLocationUrlsInJson;
  @override
  GeneratedTextColumn get foundedContentLocationUrlsInJson =>
      _foundedContentLocationUrlsInJson ??=
          _constructFoundedContentLocationUrlsInJson();
  GeneratedTextColumn _constructFoundedContentLocationUrlsInJson() {
    return GeneratedTextColumn(
      'founded_content_location_urls_in_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _attachmentsInJsonMeta =
      const VerificationMeta('attachmentsInJson');
  GeneratedTextColumn _attachmentsInJson;
  @override
  GeneratedTextColumn get attachmentsInJson =>
      _attachmentsInJson ??= _constructAttachmentsInJson();
  GeneratedTextColumn _constructAttachmentsInJson() {
    return GeneratedTextColumn(
      'attachments_in_json',
      $tableName,
      true,
    );
  }

  final VerificationMeta _customInJsonMeta =
      const VerificationMeta('customInJson');
  GeneratedTextColumn _customInJson;
  @override
  GeneratedTextColumn get customInJson =>
      _customInJson ??= _constructCustomInJson();
  GeneratedTextColumn _constructCustomInJson() {
    return GeneratedTextColumn(
      'custom_in_json',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        localId,
        uid,
        accountEntityId,
        userLocalId,
        uniqueUidInFolder,
        parentUid,
        messageId,
        folder,
        flagsInJson,
        hasThread,
        subject,
        size,
        textSize,
        truncated,
        internalTimeStampInUTC,
        receivedOrDateTimeStampInUTC,
        timeStampInUTC,
        toInJson,
        fromInJson,
        fromToDisplay,
        ccInJson,
        bccInJson,
        senderInJson,
        replyToInJson,
        hasAttachments,
        hasVcardAttachment,
        hasIcalAttachment,
        importance,
        draftInfoInJson,
        sensitivity,
        downloadAsEmlUrl,
        hash,
        headers,
        inReplyTo,
        references,
        readingConfirmationAddressee,
        html,
        plain,
        rtl,
        extendInJson,
        safety,
        hasExternals,
        foundedCIDsInJson,
        foundedContentLocationUrlsInJson,
        attachmentsInJson,
        customInJson
      ];
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
    }
    if (d.uid.present) {
      context.handle(_uidMeta, uid.isAcceptableValue(d.uid.value, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (d.accountEntityId.present) {
      context.handle(
          _accountEntityIdMeta,
          accountEntityId.isAcceptableValue(
              d.accountEntityId.value, _accountEntityIdMeta));
    } else if (isInserting) {
      context.missing(_accountEntityIdMeta);
    }
    if (d.userLocalId.present) {
      context.handle(_userLocalIdMeta,
          userLocalId.isAcceptableValue(d.userLocalId.value, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (d.uniqueUidInFolder.present) {
      context.handle(
          _uniqueUidInFolderMeta,
          uniqueUidInFolder.isAcceptableValue(
              d.uniqueUidInFolder.value, _uniqueUidInFolderMeta));
    } else if (isInserting) {
      context.missing(_uniqueUidInFolderMeta);
    }
    if (d.parentUid.present) {
      context.handle(_parentUidMeta,
          parentUid.isAcceptableValue(d.parentUid.value, _parentUidMeta));
    }
    if (d.messageId.present) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableValue(d.messageId.value, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (d.folder.present) {
      context.handle(
          _folderMeta, folder.isAcceptableValue(d.folder.value, _folderMeta));
    } else if (isInserting) {
      context.missing(_folderMeta);
    }
    if (d.flagsInJson.present) {
      context.handle(_flagsInJsonMeta,
          flagsInJson.isAcceptableValue(d.flagsInJson.value, _flagsInJsonMeta));
    } else if (isInserting) {
      context.missing(_flagsInJsonMeta);
    }
    if (d.hasThread.present) {
      context.handle(_hasThreadMeta,
          hasThread.isAcceptableValue(d.hasThread.value, _hasThreadMeta));
    } else if (isInserting) {
      context.missing(_hasThreadMeta);
    }
    if (d.subject.present) {
      context.handle(_subjectMeta,
          subject.isAcceptableValue(d.subject.value, _subjectMeta));
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (d.size.present) {
      context.handle(
          _sizeMeta, size.isAcceptableValue(d.size.value, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (d.textSize.present) {
      context.handle(_textSizeMeta,
          textSize.isAcceptableValue(d.textSize.value, _textSizeMeta));
    } else if (isInserting) {
      context.missing(_textSizeMeta);
    }
    if (d.truncated.present) {
      context.handle(_truncatedMeta,
          truncated.isAcceptableValue(d.truncated.value, _truncatedMeta));
    } else if (isInserting) {
      context.missing(_truncatedMeta);
    }
    if (d.internalTimeStampInUTC.present) {
      context.handle(
          _internalTimeStampInUTCMeta,
          internalTimeStampInUTC.isAcceptableValue(
              d.internalTimeStampInUTC.value, _internalTimeStampInUTCMeta));
    } else if (isInserting) {
      context.missing(_internalTimeStampInUTCMeta);
    }
    if (d.receivedOrDateTimeStampInUTC.present) {
      context.handle(
          _receivedOrDateTimeStampInUTCMeta,
          receivedOrDateTimeStampInUTC.isAcceptableValue(
              d.receivedOrDateTimeStampInUTC.value,
              _receivedOrDateTimeStampInUTCMeta));
    } else if (isInserting) {
      context.missing(_receivedOrDateTimeStampInUTCMeta);
    }
    if (d.timeStampInUTC.present) {
      context.handle(
          _timeStampInUTCMeta,
          timeStampInUTC.isAcceptableValue(
              d.timeStampInUTC.value, _timeStampInUTCMeta));
    } else if (isInserting) {
      context.missing(_timeStampInUTCMeta);
    }
    if (d.toInJson.present) {
      context.handle(_toInJsonMeta,
          toInJson.isAcceptableValue(d.toInJson.value, _toInJsonMeta));
    }
    if (d.fromInJson.present) {
      context.handle(_fromInJsonMeta,
          fromInJson.isAcceptableValue(d.fromInJson.value, _fromInJsonMeta));
    }
    if (d.fromToDisplay.present) {
      context.handle(
          _fromToDisplayMeta,
          fromToDisplay.isAcceptableValue(
              d.fromToDisplay.value, _fromToDisplayMeta));
    } else if (isInserting) {
      context.missing(_fromToDisplayMeta);
    }
    if (d.ccInJson.present) {
      context.handle(_ccInJsonMeta,
          ccInJson.isAcceptableValue(d.ccInJson.value, _ccInJsonMeta));
    }
    if (d.bccInJson.present) {
      context.handle(_bccInJsonMeta,
          bccInJson.isAcceptableValue(d.bccInJson.value, _bccInJsonMeta));
    }
    if (d.senderInJson.present) {
      context.handle(
          _senderInJsonMeta,
          senderInJson.isAcceptableValue(
              d.senderInJson.value, _senderInJsonMeta));
    }
    if (d.replyToInJson.present) {
      context.handle(
          _replyToInJsonMeta,
          replyToInJson.isAcceptableValue(
              d.replyToInJson.value, _replyToInJsonMeta));
    }
    if (d.hasAttachments.present) {
      context.handle(
          _hasAttachmentsMeta,
          hasAttachments.isAcceptableValue(
              d.hasAttachments.value, _hasAttachmentsMeta));
    } else if (isInserting) {
      context.missing(_hasAttachmentsMeta);
    }
    if (d.hasVcardAttachment.present) {
      context.handle(
          _hasVcardAttachmentMeta,
          hasVcardAttachment.isAcceptableValue(
              d.hasVcardAttachment.value, _hasVcardAttachmentMeta));
    } else if (isInserting) {
      context.missing(_hasVcardAttachmentMeta);
    }
    if (d.hasIcalAttachment.present) {
      context.handle(
          _hasIcalAttachmentMeta,
          hasIcalAttachment.isAcceptableValue(
              d.hasIcalAttachment.value, _hasIcalAttachmentMeta));
    } else if (isInserting) {
      context.missing(_hasIcalAttachmentMeta);
    }
    if (d.importance.present) {
      context.handle(_importanceMeta,
          importance.isAcceptableValue(d.importance.value, _importanceMeta));
    } else if (isInserting) {
      context.missing(_importanceMeta);
    }
    if (d.draftInfoInJson.present) {
      context.handle(
          _draftInfoInJsonMeta,
          draftInfoInJson.isAcceptableValue(
              d.draftInfoInJson.value, _draftInfoInJsonMeta));
    }
    if (d.sensitivity.present) {
      context.handle(_sensitivityMeta,
          sensitivity.isAcceptableValue(d.sensitivity.value, _sensitivityMeta));
    } else if (isInserting) {
      context.missing(_sensitivityMeta);
    }
    if (d.downloadAsEmlUrl.present) {
      context.handle(
          _downloadAsEmlUrlMeta,
          downloadAsEmlUrl.isAcceptableValue(
              d.downloadAsEmlUrl.value, _downloadAsEmlUrlMeta));
    } else if (isInserting) {
      context.missing(_downloadAsEmlUrlMeta);
    }
    if (d.hash.present) {
      context.handle(
          _hashMeta, hash.isAcceptableValue(d.hash.value, _hashMeta));
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    if (d.headers.present) {
      context.handle(_headersMeta,
          headers.isAcceptableValue(d.headers.value, _headersMeta));
    } else if (isInserting) {
      context.missing(_headersMeta);
    }
    if (d.inReplyTo.present) {
      context.handle(_inReplyToMeta,
          inReplyTo.isAcceptableValue(d.inReplyTo.value, _inReplyToMeta));
    } else if (isInserting) {
      context.missing(_inReplyToMeta);
    }
    if (d.references.present) {
      context.handle(_referencesMeta,
          references.isAcceptableValue(d.references.value, _referencesMeta));
    } else if (isInserting) {
      context.missing(_referencesMeta);
    }
    if (d.readingConfirmationAddressee.present) {
      context.handle(
          _readingConfirmationAddresseeMeta,
          readingConfirmationAddressee.isAcceptableValue(
              d.readingConfirmationAddressee.value,
              _readingConfirmationAddresseeMeta));
    } else if (isInserting) {
      context.missing(_readingConfirmationAddresseeMeta);
    }
    if (d.html.present) {
      context.handle(
          _htmlMeta, html.isAcceptableValue(d.html.value, _htmlMeta));
    }
    if (d.plain.present) {
      context.handle(
          _plainMeta, plain.isAcceptableValue(d.plain.value, _plainMeta));
    } else if (isInserting) {
      context.missing(_plainMeta);
    }
    if (d.rtl.present) {
      context.handle(_rtlMeta, rtl.isAcceptableValue(d.rtl.value, _rtlMeta));
    } else if (isInserting) {
      context.missing(_rtlMeta);
    }
    if (d.extendInJson.present) {
      context.handle(
          _extendInJsonMeta,
          extendInJson.isAcceptableValue(
              d.extendInJson.value, _extendInJsonMeta));
    } else if (isInserting) {
      context.missing(_extendInJsonMeta);
    }
    if (d.safety.present) {
      context.handle(
          _safetyMeta, safety.isAcceptableValue(d.safety.value, _safetyMeta));
    } else if (isInserting) {
      context.missing(_safetyMeta);
    }
    if (d.hasExternals.present) {
      context.handle(
          _hasExternalsMeta,
          hasExternals.isAcceptableValue(
              d.hasExternals.value, _hasExternalsMeta));
    } else if (isInserting) {
      context.missing(_hasExternalsMeta);
    }
    if (d.foundedCIDsInJson.present) {
      context.handle(
          _foundedCIDsInJsonMeta,
          foundedCIDsInJson.isAcceptableValue(
              d.foundedCIDsInJson.value, _foundedCIDsInJsonMeta));
    } else if (isInserting) {
      context.missing(_foundedCIDsInJsonMeta);
    }
    if (d.foundedContentLocationUrlsInJson.present) {
      context.handle(
          _foundedContentLocationUrlsInJsonMeta,
          foundedContentLocationUrlsInJson.isAcceptableValue(
              d.foundedContentLocationUrlsInJson.value,
              _foundedContentLocationUrlsInJsonMeta));
    } else if (isInserting) {
      context.missing(_foundedContentLocationUrlsInJsonMeta);
    }
    if (d.attachmentsInJson.present) {
      context.handle(
          _attachmentsInJsonMeta,
          attachmentsInJson.isAcceptableValue(
              d.attachmentsInJson.value, _attachmentsInJsonMeta));
    }
    if (d.customInJson.present) {
      context.handle(
          _customInJsonMeta,
          customInJson.isAcceptableValue(
              d.customInJson.value, _customInJsonMeta));
    } else if (isInserting) {
      context.missing(_customInJsonMeta);
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
    if (d.uid.present) {
      map['uid'] = Variable<int, IntType>(d.uid.value);
    }
    if (d.accountEntityId.present) {
      map['account_entity_id'] =
          Variable<int, IntType>(d.accountEntityId.value);
    }
    if (d.userLocalId.present) {
      map['user_local_id'] = Variable<int, IntType>(d.userLocalId.value);
    }
    if (d.uniqueUidInFolder.present) {
      map['unique_uid_in_folder'] =
          Variable<String, StringType>(d.uniqueUidInFolder.value);
    }
    if (d.parentUid.present) {
      map['parent_uid'] = Variable<int, IntType>(d.parentUid.value);
    }
    if (d.messageId.present) {
      map['message_id'] = Variable<String, StringType>(d.messageId.value);
    }
    if (d.folder.present) {
      map['folder'] = Variable<String, StringType>(d.folder.value);
    }
    if (d.flagsInJson.present) {
      map['flags_in_json'] = Variable<String, StringType>(d.flagsInJson.value);
    }
    if (d.hasThread.present) {
      map['has_thread'] = Variable<bool, BoolType>(d.hasThread.value);
    }
    if (d.subject.present) {
      map['subject'] = Variable<String, StringType>(d.subject.value);
    }
    if (d.size.present) {
      map['size'] = Variable<int, IntType>(d.size.value);
    }
    if (d.textSize.present) {
      map['text_size'] = Variable<int, IntType>(d.textSize.value);
    }
    if (d.truncated.present) {
      map['truncated'] = Variable<bool, BoolType>(d.truncated.value);
    }
    if (d.internalTimeStampInUTC.present) {
      map['internal_time_stamp_in_u_t_c'] =
          Variable<int, IntType>(d.internalTimeStampInUTC.value);
    }
    if (d.receivedOrDateTimeStampInUTC.present) {
      map['received_or_date_time_stamp_in_u_t_c'] =
          Variable<int, IntType>(d.receivedOrDateTimeStampInUTC.value);
    }
    if (d.timeStampInUTC.present) {
      map['time_stamp_in_u_t_c'] =
          Variable<int, IntType>(d.timeStampInUTC.value);
    }
    if (d.toInJson.present) {
      map['to_in_json'] = Variable<String, StringType>(d.toInJson.value);
    }
    if (d.fromInJson.present) {
      map['from_in_json'] = Variable<String, StringType>(d.fromInJson.value);
    }
    if (d.fromToDisplay.present) {
      map['from_to_display'] =
          Variable<String, StringType>(d.fromToDisplay.value);
    }
    if (d.ccInJson.present) {
      map['cc_in_json'] = Variable<String, StringType>(d.ccInJson.value);
    }
    if (d.bccInJson.present) {
      map['bcc_in_json'] = Variable<String, StringType>(d.bccInJson.value);
    }
    if (d.senderInJson.present) {
      map['sender_in_json'] =
          Variable<String, StringType>(d.senderInJson.value);
    }
    if (d.replyToInJson.present) {
      map['reply_to_in_json'] =
          Variable<String, StringType>(d.replyToInJson.value);
    }
    if (d.hasAttachments.present) {
      map['has_attachments'] = Variable<bool, BoolType>(d.hasAttachments.value);
    }
    if (d.hasVcardAttachment.present) {
      map['has_vcard_attachment'] =
          Variable<bool, BoolType>(d.hasVcardAttachment.value);
    }
    if (d.hasIcalAttachment.present) {
      map['has_ical_attachment'] =
          Variable<bool, BoolType>(d.hasIcalAttachment.value);
    }
    if (d.importance.present) {
      map['importance'] = Variable<int, IntType>(d.importance.value);
    }
    if (d.draftInfoInJson.present) {
      map['draft_info_in_json'] =
          Variable<String, StringType>(d.draftInfoInJson.value);
    }
    if (d.sensitivity.present) {
      map['sensitivity'] = Variable<int, IntType>(d.sensitivity.value);
    }
    if (d.downloadAsEmlUrl.present) {
      map['download_as_eml_url'] =
          Variable<String, StringType>(d.downloadAsEmlUrl.value);
    }
    if (d.hash.present) {
      map['hash'] = Variable<String, StringType>(d.hash.value);
    }
    if (d.headers.present) {
      map['headers'] = Variable<String, StringType>(d.headers.value);
    }
    if (d.inReplyTo.present) {
      map['in_reply_to'] = Variable<String, StringType>(d.inReplyTo.value);
    }
    if (d.references.present) {
      map['message_references'] =
          Variable<String, StringType>(d.references.value);
    }
    if (d.readingConfirmationAddressee.present) {
      map['reading_confirmation_addressee'] =
          Variable<String, StringType>(d.readingConfirmationAddressee.value);
    }
    if (d.html.present) {
      map['html'] = Variable<String, StringType>(d.html.value);
    }
    if (d.plain.present) {
      map['plain'] = Variable<String, StringType>(d.plain.value);
    }
    if (d.rtl.present) {
      map['rtl'] = Variable<bool, BoolType>(d.rtl.value);
    }
    if (d.extendInJson.present) {
      map['extend_in_json'] =
          Variable<String, StringType>(d.extendInJson.value);
    }
    if (d.safety.present) {
      map['safety'] = Variable<bool, BoolType>(d.safety.value);
    }
    if (d.hasExternals.present) {
      map['has_externals'] = Variable<bool, BoolType>(d.hasExternals.value);
    }
    if (d.foundedCIDsInJson.present) {
      map['founded_c_i_ds_in_json'] =
          Variable<String, StringType>(d.foundedCIDsInJson.value);
    }
    if (d.foundedContentLocationUrlsInJson.present) {
      map['founded_content_location_urls_in_json'] =
          Variable<String, StringType>(
              d.foundedContentLocationUrlsInJson.value);
    }
    if (d.attachmentsInJson.present) {
      map['attachments_in_json'] =
          Variable<String, StringType>(d.attachmentsInJson.value);
    }
    if (d.customInJson.present) {
      map['custom_in_json'] =
          Variable<String, StringType>(d.customInJson.value);
    }
    return map;
  }

  @override
  $MailTable createAlias(String alias) {
    return $MailTable(_db, alias);
  }
}

class LocalFolder extends DataClass implements Insertable<LocalFolder> {
  final String fullName;
  final int accountLocalId;
  final int userLocalId;
  final String guid;
  final String parentGuid;
  final int accountId;
  final int type;
  final int folderOrder;
  final int count;
  final int unread;
  final String name;
  final String fullNameRaw;
  final String fullNameHash;
  final String folderHash;
  final String delimiter;
  final bool needsInfoUpdate;
  final bool isSystemFolder;
  final bool isSubscribed;
  final bool isSelectable;
  final bool folderExists;
  final bool extended;
  final bool alwaysRefresh;
  final String messagesInfoInJson;
  LocalFolder(
      {@required this.fullName,
      @required this.accountLocalId,
      @required this.userLocalId,
      @required this.guid,
      this.parentGuid,
      @required this.accountId,
      @required this.type,
      @required this.folderOrder,
      this.count,
      this.unread,
      @required this.name,
      @required this.fullNameRaw,
      @required this.fullNameHash,
      @required this.folderHash,
      @required this.delimiter,
      @required this.needsInfoUpdate,
      @required this.isSystemFolder,
      @required this.isSubscribed,
      @required this.isSelectable,
      @required this.folderExists,
      this.extended,
      @required this.alwaysRefresh,
      this.messagesInfoInJson});
  factory LocalFolder.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return LocalFolder(
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      accountLocalId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}account_local_id']),
      userLocalId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id']),
      guid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}guid']),
      parentGuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_guid']),
      accountId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}account_id']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      folderOrder: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_order']),
      count: intType.mapFromDatabaseResponse(data['${effectivePrefix}count']),
      unread: intType.mapFromDatabaseResponse(data['${effectivePrefix}unread']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      fullNameRaw: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_raw']),
      fullNameHash: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_hash']),
      folderHash: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_hash']),
      delimiter: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}delimiter']),
      needsInfoUpdate: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}needs_info_update']),
      isSystemFolder: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_system_folder']),
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
      messagesInfoInJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}messages_info_in_json']),
    );
  }
  factory LocalFolder.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalFolder(
      fullName: serializer.fromJson<String>(json['fullName']),
      accountLocalId: serializer.fromJson<int>(json['accountLocalId']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      guid: serializer.fromJson<String>(json['guid']),
      parentGuid: serializer.fromJson<String>(json['parentGuid']),
      accountId: serializer.fromJson<int>(json['accountId']),
      type: serializer.fromJson<int>(json['type']),
      folderOrder: serializer.fromJson<int>(json['folderOrder']),
      count: serializer.fromJson<int>(json['count']),
      unread: serializer.fromJson<int>(json['unread']),
      name: serializer.fromJson<String>(json['name']),
      fullNameRaw: serializer.fromJson<String>(json['fullNameRaw']),
      fullNameHash: serializer.fromJson<String>(json['fullNameHash']),
      folderHash: serializer.fromJson<String>(json['folderHash']),
      delimiter: serializer.fromJson<String>(json['delimiter']),
      needsInfoUpdate: serializer.fromJson<bool>(json['needsInfoUpdate']),
      isSystemFolder: serializer.fromJson<bool>(json['isSystemFolder']),
      isSubscribed: serializer.fromJson<bool>(json['isSubscribed']),
      isSelectable: serializer.fromJson<bool>(json['isSelectable']),
      folderExists: serializer.fromJson<bool>(json['folderExists']),
      extended: serializer.fromJson<bool>(json['extended']),
      alwaysRefresh: serializer.fromJson<bool>(json['alwaysRefresh']),
      messagesInfoInJson:
          serializer.fromJson<String>(json['messagesInfoInJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fullName': serializer.toJson<String>(fullName),
      'accountLocalId': serializer.toJson<int>(accountLocalId),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'guid': serializer.toJson<String>(guid),
      'parentGuid': serializer.toJson<String>(parentGuid),
      'accountId': serializer.toJson<int>(accountId),
      'type': serializer.toJson<int>(type),
      'folderOrder': serializer.toJson<int>(folderOrder),
      'count': serializer.toJson<int>(count),
      'unread': serializer.toJson<int>(unread),
      'name': serializer.toJson<String>(name),
      'fullNameRaw': serializer.toJson<String>(fullNameRaw),
      'fullNameHash': serializer.toJson<String>(fullNameHash),
      'folderHash': serializer.toJson<String>(folderHash),
      'delimiter': serializer.toJson<String>(delimiter),
      'needsInfoUpdate': serializer.toJson<bool>(needsInfoUpdate),
      'isSystemFolder': serializer.toJson<bool>(isSystemFolder),
      'isSubscribed': serializer.toJson<bool>(isSubscribed),
      'isSelectable': serializer.toJson<bool>(isSelectable),
      'folderExists': serializer.toJson<bool>(folderExists),
      'extended': serializer.toJson<bool>(extended),
      'alwaysRefresh': serializer.toJson<bool>(alwaysRefresh),
      'messagesInfoInJson': serializer.toJson<String>(messagesInfoInJson),
    };
  }

  @override
  FoldersCompanion createCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      accountLocalId: accountLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountLocalId),
      userLocalId: userLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(userLocalId),
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
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      unread:
          unread == null && nullToAbsent ? const Value.absent() : Value(unread),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      fullNameRaw: fullNameRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(fullNameRaw),
      fullNameHash: fullNameHash == null && nullToAbsent
          ? const Value.absent()
          : Value(fullNameHash),
      folderHash: folderHash == null && nullToAbsent
          ? const Value.absent()
          : Value(folderHash),
      delimiter: delimiter == null && nullToAbsent
          ? const Value.absent()
          : Value(delimiter),
      needsInfoUpdate: needsInfoUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(needsInfoUpdate),
      isSystemFolder: isSystemFolder == null && nullToAbsent
          ? const Value.absent()
          : Value(isSystemFolder),
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
      messagesInfoInJson: messagesInfoInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(messagesInfoInJson),
    );
  }

  LocalFolder copyWith(
          {String fullName,
          int accountLocalId,
          int userLocalId,
          String guid,
          String parentGuid,
          int accountId,
          int type,
          int folderOrder,
          int count,
          int unread,
          String name,
          String fullNameRaw,
          String fullNameHash,
          String folderHash,
          String delimiter,
          bool needsInfoUpdate,
          bool isSystemFolder,
          bool isSubscribed,
          bool isSelectable,
          bool folderExists,
          bool extended,
          bool alwaysRefresh,
          String messagesInfoInJson}) =>
      LocalFolder(
        fullName: fullName ?? this.fullName,
        accountLocalId: accountLocalId ?? this.accountLocalId,
        userLocalId: userLocalId ?? this.userLocalId,
        guid: guid ?? this.guid,
        parentGuid: parentGuid ?? this.parentGuid,
        accountId: accountId ?? this.accountId,
        type: type ?? this.type,
        folderOrder: folderOrder ?? this.folderOrder,
        count: count ?? this.count,
        unread: unread ?? this.unread,
        name: name ?? this.name,
        fullNameRaw: fullNameRaw ?? this.fullNameRaw,
        fullNameHash: fullNameHash ?? this.fullNameHash,
        folderHash: folderHash ?? this.folderHash,
        delimiter: delimiter ?? this.delimiter,
        needsInfoUpdate: needsInfoUpdate ?? this.needsInfoUpdate,
        isSystemFolder: isSystemFolder ?? this.isSystemFolder,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        isSelectable: isSelectable ?? this.isSelectable,
        folderExists: folderExists ?? this.folderExists,
        extended: extended ?? this.extended,
        alwaysRefresh: alwaysRefresh ?? this.alwaysRefresh,
        messagesInfoInJson: messagesInfoInJson ?? this.messagesInfoInJson,
      );
  @override
  String toString() {
    return (StringBuffer('LocalFolder(')
          ..write('fullName: $fullName, ')
          ..write('accountLocalId: $accountLocalId, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('guid: $guid, ')
          ..write('parentGuid: $parentGuid, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('folderOrder: $folderOrder, ')
          ..write('count: $count, ')
          ..write('unread: $unread, ')
          ..write('name: $name, ')
          ..write('fullNameRaw: $fullNameRaw, ')
          ..write('fullNameHash: $fullNameHash, ')
          ..write('folderHash: $folderHash, ')
          ..write('delimiter: $delimiter, ')
          ..write('needsInfoUpdate: $needsInfoUpdate, ')
          ..write('isSystemFolder: $isSystemFolder, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('isSelectable: $isSelectable, ')
          ..write('folderExists: $folderExists, ')
          ..write('extended: $extended, ')
          ..write('alwaysRefresh: $alwaysRefresh, ')
          ..write('messagesInfoInJson: $messagesInfoInJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      fullName.hashCode,
      $mrjc(
          accountLocalId.hashCode,
          $mrjc(
              userLocalId.hashCode,
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
                                      count.hashCode,
                                      $mrjc(
                                          unread.hashCode,
                                          $mrjc(
                                              name.hashCode,
                                              $mrjc(
                                                  fullNameRaw.hashCode,
                                                  $mrjc(
                                                      fullNameHash.hashCode,
                                                      $mrjc(
                                                          folderHash.hashCode,
                                                          $mrjc(
                                                              delimiter
                                                                  .hashCode,
                                                              $mrjc(
                                                                  needsInfoUpdate
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      isSystemFolder
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          isSubscribed
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              isSelectable.hashCode,
                                                                              $mrjc(folderExists.hashCode, $mrjc(extended.hashCode, $mrjc(alwaysRefresh.hashCode, messagesInfoInJson.hashCode)))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is LocalFolder &&
          other.fullName == this.fullName &&
          other.accountLocalId == this.accountLocalId &&
          other.userLocalId == this.userLocalId &&
          other.guid == this.guid &&
          other.parentGuid == this.parentGuid &&
          other.accountId == this.accountId &&
          other.type == this.type &&
          other.folderOrder == this.folderOrder &&
          other.count == this.count &&
          other.unread == this.unread &&
          other.name == this.name &&
          other.fullNameRaw == this.fullNameRaw &&
          other.fullNameHash == this.fullNameHash &&
          other.folderHash == this.folderHash &&
          other.delimiter == this.delimiter &&
          other.needsInfoUpdate == this.needsInfoUpdate &&
          other.isSystemFolder == this.isSystemFolder &&
          other.isSubscribed == this.isSubscribed &&
          other.isSelectable == this.isSelectable &&
          other.folderExists == this.folderExists &&
          other.extended == this.extended &&
          other.alwaysRefresh == this.alwaysRefresh &&
          other.messagesInfoInJson == this.messagesInfoInJson);
}

class FoldersCompanion extends UpdateCompanion<LocalFolder> {
  final Value<String> fullName;
  final Value<int> accountLocalId;
  final Value<int> userLocalId;
  final Value<String> guid;
  final Value<String> parentGuid;
  final Value<int> accountId;
  final Value<int> type;
  final Value<int> folderOrder;
  final Value<int> count;
  final Value<int> unread;
  final Value<String> name;
  final Value<String> fullNameRaw;
  final Value<String> fullNameHash;
  final Value<String> folderHash;
  final Value<String> delimiter;
  final Value<bool> needsInfoUpdate;
  final Value<bool> isSystemFolder;
  final Value<bool> isSubscribed;
  final Value<bool> isSelectable;
  final Value<bool> folderExists;
  final Value<bool> extended;
  final Value<bool> alwaysRefresh;
  final Value<String> messagesInfoInJson;
  const FoldersCompanion({
    this.fullName = const Value.absent(),
    this.accountLocalId = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.guid = const Value.absent(),
    this.parentGuid = const Value.absent(),
    this.accountId = const Value.absent(),
    this.type = const Value.absent(),
    this.folderOrder = const Value.absent(),
    this.count = const Value.absent(),
    this.unread = const Value.absent(),
    this.name = const Value.absent(),
    this.fullNameRaw = const Value.absent(),
    this.fullNameHash = const Value.absent(),
    this.folderHash = const Value.absent(),
    this.delimiter = const Value.absent(),
    this.needsInfoUpdate = const Value.absent(),
    this.isSystemFolder = const Value.absent(),
    this.isSubscribed = const Value.absent(),
    this.isSelectable = const Value.absent(),
    this.folderExists = const Value.absent(),
    this.extended = const Value.absent(),
    this.alwaysRefresh = const Value.absent(),
    this.messagesInfoInJson = const Value.absent(),
  });
  FoldersCompanion.insert({
    @required String fullName,
    @required int accountLocalId,
    @required int userLocalId,
    @required String guid,
    this.parentGuid = const Value.absent(),
    @required int accountId,
    @required int type,
    @required int folderOrder,
    this.count = const Value.absent(),
    this.unread = const Value.absent(),
    @required String name,
    @required String fullNameRaw,
    @required String fullNameHash,
    @required String folderHash,
    @required String delimiter,
    @required bool needsInfoUpdate,
    @required bool isSystemFolder,
    @required bool isSubscribed,
    @required bool isSelectable,
    @required bool folderExists,
    this.extended = const Value.absent(),
    @required bool alwaysRefresh,
    this.messagesInfoInJson = const Value.absent(),
  })  : fullName = Value(fullName),
        accountLocalId = Value(accountLocalId),
        userLocalId = Value(userLocalId),
        guid = Value(guid),
        accountId = Value(accountId),
        type = Value(type),
        folderOrder = Value(folderOrder),
        name = Value(name),
        fullNameRaw = Value(fullNameRaw),
        fullNameHash = Value(fullNameHash),
        folderHash = Value(folderHash),
        delimiter = Value(delimiter),
        needsInfoUpdate = Value(needsInfoUpdate),
        isSystemFolder = Value(isSystemFolder),
        isSubscribed = Value(isSubscribed),
        isSelectable = Value(isSelectable),
        folderExists = Value(folderExists),
        alwaysRefresh = Value(alwaysRefresh);
  FoldersCompanion copyWith(
      {Value<String> fullName,
      Value<int> accountLocalId,
      Value<int> userLocalId,
      Value<String> guid,
      Value<String> parentGuid,
      Value<int> accountId,
      Value<int> type,
      Value<int> folderOrder,
      Value<int> count,
      Value<int> unread,
      Value<String> name,
      Value<String> fullNameRaw,
      Value<String> fullNameHash,
      Value<String> folderHash,
      Value<String> delimiter,
      Value<bool> needsInfoUpdate,
      Value<bool> isSystemFolder,
      Value<bool> isSubscribed,
      Value<bool> isSelectable,
      Value<bool> folderExists,
      Value<bool> extended,
      Value<bool> alwaysRefresh,
      Value<String> messagesInfoInJson}) {
    return FoldersCompanion(
      fullName: fullName ?? this.fullName,
      accountLocalId: accountLocalId ?? this.accountLocalId,
      userLocalId: userLocalId ?? this.userLocalId,
      guid: guid ?? this.guid,
      parentGuid: parentGuid ?? this.parentGuid,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      folderOrder: folderOrder ?? this.folderOrder,
      count: count ?? this.count,
      unread: unread ?? this.unread,
      name: name ?? this.name,
      fullNameRaw: fullNameRaw ?? this.fullNameRaw,
      fullNameHash: fullNameHash ?? this.fullNameHash,
      folderHash: folderHash ?? this.folderHash,
      delimiter: delimiter ?? this.delimiter,
      needsInfoUpdate: needsInfoUpdate ?? this.needsInfoUpdate,
      isSystemFolder: isSystemFolder ?? this.isSystemFolder,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isSelectable: isSelectable ?? this.isSelectable,
      folderExists: folderExists ?? this.folderExists,
      extended: extended ?? this.extended,
      alwaysRefresh: alwaysRefresh ?? this.alwaysRefresh,
      messagesInfoInJson: messagesInfoInJson ?? this.messagesInfoInJson,
    );
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, LocalFolder> {
  final GeneratedDatabase _db;
  final String _alias;
  $FoldersTable(this._db, [this._alias]);
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

  final VerificationMeta _accountLocalIdMeta =
      const VerificationMeta('accountLocalId');
  GeneratedIntColumn _accountLocalId;
  @override
  GeneratedIntColumn get accountLocalId =>
      _accountLocalId ??= _constructAccountLocalId();
  GeneratedIntColumn _constructAccountLocalId() {
    return GeneratedIntColumn(
      'account_local_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  GeneratedIntColumn _userLocalId;
  @override
  GeneratedIntColumn get userLocalId =>
      _userLocalId ??= _constructUserLocalId();
  GeneratedIntColumn _constructUserLocalId() {
    return GeneratedIntColumn(
      'user_local_id',
      $tableName,
      false,
    );
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

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedIntColumn _count;
  @override
  GeneratedIntColumn get count => _count ??= _constructCount();
  GeneratedIntColumn _constructCount() {
    return GeneratedIntColumn(
      'count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _unreadMeta = const VerificationMeta('unread');
  GeneratedIntColumn _unread;
  @override
  GeneratedIntColumn get unread => _unread ??= _constructUnread();
  GeneratedIntColumn _constructUnread() {
    return GeneratedIntColumn(
      'unread',
      $tableName,
      true,
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

  final VerificationMeta _folderHashMeta = const VerificationMeta('folderHash');
  GeneratedTextColumn _folderHash;
  @override
  GeneratedTextColumn get folderHash => _folderHash ??= _constructFolderHash();
  GeneratedTextColumn _constructFolderHash() {
    return GeneratedTextColumn(
      'folder_hash',
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

  final VerificationMeta _needsInfoUpdateMeta =
      const VerificationMeta('needsInfoUpdate');
  GeneratedBoolColumn _needsInfoUpdate;
  @override
  GeneratedBoolColumn get needsInfoUpdate =>
      _needsInfoUpdate ??= _constructNeedsInfoUpdate();
  GeneratedBoolColumn _constructNeedsInfoUpdate() {
    return GeneratedBoolColumn(
      'needs_info_update',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isSystemFolderMeta =
      const VerificationMeta('isSystemFolder');
  GeneratedBoolColumn _isSystemFolder;
  @override
  GeneratedBoolColumn get isSystemFolder =>
      _isSystemFolder ??= _constructIsSystemFolder();
  GeneratedBoolColumn _constructIsSystemFolder() {
    return GeneratedBoolColumn(
      'is_system_folder',
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

  final VerificationMeta _messagesInfoInJsonMeta =
      const VerificationMeta('messagesInfoInJson');
  GeneratedTextColumn _messagesInfoInJson;
  @override
  GeneratedTextColumn get messagesInfoInJson =>
      _messagesInfoInJson ??= _constructMessagesInfoInJson();
  GeneratedTextColumn _constructMessagesInfoInJson() {
    return GeneratedTextColumn(
      'messages_info_in_json',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        fullName,
        accountLocalId,
        userLocalId,
        guid,
        parentGuid,
        accountId,
        type,
        folderOrder,
        count,
        unread,
        name,
        fullNameRaw,
        fullNameHash,
        folderHash,
        delimiter,
        needsInfoUpdate,
        isSystemFolder,
        isSubscribed,
        isSelectable,
        folderExists,
        extended,
        alwaysRefresh,
        messagesInfoInJson
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
    if (d.fullName.present) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableValue(d.fullName.value, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (d.accountLocalId.present) {
      context.handle(
          _accountLocalIdMeta,
          accountLocalId.isAcceptableValue(
              d.accountLocalId.value, _accountLocalIdMeta));
    } else if (isInserting) {
      context.missing(_accountLocalIdMeta);
    }
    if (d.userLocalId.present) {
      context.handle(_userLocalIdMeta,
          userLocalId.isAcceptableValue(d.userLocalId.value, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (d.guid.present) {
      context.handle(
          _guidMeta, guid.isAcceptableValue(d.guid.value, _guidMeta));
    } else if (isInserting) {
      context.missing(_guidMeta);
    }
    if (d.parentGuid.present) {
      context.handle(_parentGuidMeta,
          parentGuid.isAcceptableValue(d.parentGuid.value, _parentGuidMeta));
    }
    if (d.accountId.present) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableValue(d.accountId.value, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (d.folderOrder.present) {
      context.handle(_folderOrderMeta,
          folderOrder.isAcceptableValue(d.folderOrder.value, _folderOrderMeta));
    } else if (isInserting) {
      context.missing(_folderOrderMeta);
    }
    if (d.count.present) {
      context.handle(
          _countMeta, count.isAcceptableValue(d.count.value, _countMeta));
    }
    if (d.unread.present) {
      context.handle(
          _unreadMeta, unread.isAcceptableValue(d.unread.value, _unreadMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.fullNameRaw.present) {
      context.handle(_fullNameRawMeta,
          fullNameRaw.isAcceptableValue(d.fullNameRaw.value, _fullNameRawMeta));
    } else if (isInserting) {
      context.missing(_fullNameRawMeta);
    }
    if (d.fullNameHash.present) {
      context.handle(
          _fullNameHashMeta,
          fullNameHash.isAcceptableValue(
              d.fullNameHash.value, _fullNameHashMeta));
    } else if (isInserting) {
      context.missing(_fullNameHashMeta);
    }
    if (d.folderHash.present) {
      context.handle(_folderHashMeta,
          folderHash.isAcceptableValue(d.folderHash.value, _folderHashMeta));
    } else if (isInserting) {
      context.missing(_folderHashMeta);
    }
    if (d.delimiter.present) {
      context.handle(_delimiterMeta,
          delimiter.isAcceptableValue(d.delimiter.value, _delimiterMeta));
    } else if (isInserting) {
      context.missing(_delimiterMeta);
    }
    if (d.needsInfoUpdate.present) {
      context.handle(
          _needsInfoUpdateMeta,
          needsInfoUpdate.isAcceptableValue(
              d.needsInfoUpdate.value, _needsInfoUpdateMeta));
    } else if (isInserting) {
      context.missing(_needsInfoUpdateMeta);
    }
    if (d.isSystemFolder.present) {
      context.handle(
          _isSystemFolderMeta,
          isSystemFolder.isAcceptableValue(
              d.isSystemFolder.value, _isSystemFolderMeta));
    } else if (isInserting) {
      context.missing(_isSystemFolderMeta);
    }
    if (d.isSubscribed.present) {
      context.handle(
          _isSubscribedMeta,
          isSubscribed.isAcceptableValue(
              d.isSubscribed.value, _isSubscribedMeta));
    } else if (isInserting) {
      context.missing(_isSubscribedMeta);
    }
    if (d.isSelectable.present) {
      context.handle(
          _isSelectableMeta,
          isSelectable.isAcceptableValue(
              d.isSelectable.value, _isSelectableMeta));
    } else if (isInserting) {
      context.missing(_isSelectableMeta);
    }
    if (d.folderExists.present) {
      context.handle(
          _folderExistsMeta,
          folderExists.isAcceptableValue(
              d.folderExists.value, _folderExistsMeta));
    } else if (isInserting) {
      context.missing(_folderExistsMeta);
    }
    if (d.extended.present) {
      context.handle(_extendedMeta,
          extended.isAcceptableValue(d.extended.value, _extendedMeta));
    }
    if (d.alwaysRefresh.present) {
      context.handle(
          _alwaysRefreshMeta,
          alwaysRefresh.isAcceptableValue(
              d.alwaysRefresh.value, _alwaysRefreshMeta));
    } else if (isInserting) {
      context.missing(_alwaysRefreshMeta);
    }
    if (d.messagesInfoInJson.present) {
      context.handle(
          _messagesInfoInJsonMeta,
          messagesInfoInJson.isAcceptableValue(
              d.messagesInfoInJson.value, _messagesInfoInJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {fullName, accountLocalId};
  @override
  LocalFolder map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return LocalFolder.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FoldersCompanion d) {
    final map = <String, Variable>{};
    if (d.fullName.present) {
      map['full_name'] = Variable<String, StringType>(d.fullName.value);
    }
    if (d.accountLocalId.present) {
      map['account_local_id'] = Variable<int, IntType>(d.accountLocalId.value);
    }
    if (d.userLocalId.present) {
      map['user_local_id'] = Variable<int, IntType>(d.userLocalId.value);
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
    if (d.count.present) {
      map['count'] = Variable<int, IntType>(d.count.value);
    }
    if (d.unread.present) {
      map['unread'] = Variable<int, IntType>(d.unread.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.fullNameRaw.present) {
      map['full_name_raw'] = Variable<String, StringType>(d.fullNameRaw.value);
    }
    if (d.fullNameHash.present) {
      map['full_name_hash'] =
          Variable<String, StringType>(d.fullNameHash.value);
    }
    if (d.folderHash.present) {
      map['folder_hash'] = Variable<String, StringType>(d.folderHash.value);
    }
    if (d.delimiter.present) {
      map['delimiter'] = Variable<String, StringType>(d.delimiter.value);
    }
    if (d.needsInfoUpdate.present) {
      map['needs_info_update'] =
          Variable<bool, BoolType>(d.needsInfoUpdate.value);
    }
    if (d.isSystemFolder.present) {
      map['is_system_folder'] =
          Variable<bool, BoolType>(d.isSystemFolder.value);
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
    if (d.messagesInfoInJson.present) {
      map['messages_info_in_json'] =
          Variable<String, StringType>(d.messagesInfoInJson.value);
    }
    return map;
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int localId;
  final int serverId;
  final String hostname;
  final String emailFromLogin;
  final String token;
  final int syncFreqInSeconds;
  final String syncPeriod;
  final String language;
  User(
      {@required this.localId,
      @required this.serverId,
      @required this.hostname,
      @required this.emailFromLogin,
      @required this.token,
      this.syncFreqInSeconds,
      this.syncPeriod,
      this.language});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      localId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      serverId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}server_id']),
      hostname: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}hostname']),
      emailFromLogin: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}email_from_login']),
      token:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}token']),
      syncFreqInSeconds: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}sync_freq_in_seconds']),
      syncPeriod: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_period']),
      language: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language']),
    );
  }
  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      localId: serializer.fromJson<int>(json['localId']),
      serverId: serializer.fromJson<int>(json['serverId']),
      hostname: serializer.fromJson<String>(json['hostname']),
      emailFromLogin: serializer.fromJson<String>(json['emailFromLogin']),
      token: serializer.fromJson<String>(json['token']),
      syncFreqInSeconds: serializer.fromJson<int>(json['syncFreqInSeconds']),
      syncPeriod: serializer.fromJson<String>(json['syncPeriod']),
      language: serializer.fromJson<String>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'serverId': serializer.toJson<int>(serverId),
      'hostname': serializer.toJson<String>(hostname),
      'emailFromLogin': serializer.toJson<String>(emailFromLogin),
      'token': serializer.toJson<String>(token),
      'syncFreqInSeconds': serializer.toJson<int>(syncFreqInSeconds),
      'syncPeriod': serializer.toJson<String>(syncPeriod),
      'language': serializer.toJson<String>(language),
    };
  }

  @override
  UsersCompanion createCompanion(bool nullToAbsent) {
    return UsersCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      hostname: hostname == null && nullToAbsent
          ? const Value.absent()
          : Value(hostname),
      emailFromLogin: emailFromLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(emailFromLogin),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      syncFreqInSeconds: syncFreqInSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(syncFreqInSeconds),
      syncPeriod: syncPeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(syncPeriod),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
    );
  }

  User copyWith(
          {int localId,
          int serverId,
          String hostname,
          String emailFromLogin,
          String token,
          int syncFreqInSeconds,
          String syncPeriod,
          String language}) =>
      User(
        localId: localId ?? this.localId,
        serverId: serverId ?? this.serverId,
        hostname: hostname ?? this.hostname,
        emailFromLogin: emailFromLogin ?? this.emailFromLogin,
        token: token ?? this.token,
        syncFreqInSeconds: syncFreqInSeconds ?? this.syncFreqInSeconds,
        syncPeriod: syncPeriod ?? this.syncPeriod,
        language: language ?? this.language,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('localId: $localId, ')
          ..write('serverId: $serverId, ')
          ..write('hostname: $hostname, ')
          ..write('emailFromLogin: $emailFromLogin, ')
          ..write('token: $token, ')
          ..write('syncFreqInSeconds: $syncFreqInSeconds, ')
          ..write('syncPeriod: $syncPeriod, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      localId.hashCode,
      $mrjc(
          serverId.hashCode,
          $mrjc(
              hostname.hashCode,
              $mrjc(
                  emailFromLogin.hashCode,
                  $mrjc(
                      token.hashCode,
                      $mrjc(syncFreqInSeconds.hashCode,
                          $mrjc(syncPeriod.hashCode, language.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.localId == this.localId &&
          other.serverId == this.serverId &&
          other.hostname == this.hostname &&
          other.emailFromLogin == this.emailFromLogin &&
          other.token == this.token &&
          other.syncFreqInSeconds == this.syncFreqInSeconds &&
          other.syncPeriod == this.syncPeriod &&
          other.language == this.language);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> localId;
  final Value<int> serverId;
  final Value<String> hostname;
  final Value<String> emailFromLogin;
  final Value<String> token;
  final Value<int> syncFreqInSeconds;
  final Value<String> syncPeriod;
  final Value<String> language;
  const UsersCompanion({
    this.localId = const Value.absent(),
    this.serverId = const Value.absent(),
    this.hostname = const Value.absent(),
    this.emailFromLogin = const Value.absent(),
    this.token = const Value.absent(),
    this.syncFreqInSeconds = const Value.absent(),
    this.syncPeriod = const Value.absent(),
    this.language = const Value.absent(),
  });
  UsersCompanion.insert({
    this.localId = const Value.absent(),
    @required int serverId,
    @required String hostname,
    @required String emailFromLogin,
    @required String token,
    this.syncFreqInSeconds = const Value.absent(),
    this.syncPeriod = const Value.absent(),
    this.language = const Value.absent(),
  })  : serverId = Value(serverId),
        hostname = Value(hostname),
        emailFromLogin = Value(emailFromLogin),
        token = Value(token);
  UsersCompanion copyWith(
      {Value<int> localId,
      Value<int> serverId,
      Value<String> hostname,
      Value<String> emailFromLogin,
      Value<String> token,
      Value<int> syncFreqInSeconds,
      Value<String> syncPeriod,
      Value<String> language}) {
    return UsersCompanion(
      localId: localId ?? this.localId,
      serverId: serverId ?? this.serverId,
      hostname: hostname ?? this.hostname,
      emailFromLogin: emailFromLogin ?? this.emailFromLogin,
      token: token ?? this.token,
      syncFreqInSeconds: syncFreqInSeconds ?? this.syncFreqInSeconds,
      syncPeriod: syncPeriod ?? this.syncPeriod,
      language: language ?? this.language,
    );
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedIntColumn _localId;
  @override
  GeneratedIntColumn get localId => _localId ??= _constructLocalId();
  GeneratedIntColumn _constructLocalId() {
    return GeneratedIntColumn('local_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  GeneratedIntColumn _serverId;
  @override
  GeneratedIntColumn get serverId => _serverId ??= _constructServerId();
  GeneratedIntColumn _constructServerId() {
    return GeneratedIntColumn(
      'server_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hostnameMeta = const VerificationMeta('hostname');
  GeneratedTextColumn _hostname;
  @override
  GeneratedTextColumn get hostname => _hostname ??= _constructHostname();
  GeneratedTextColumn _constructHostname() {
    return GeneratedTextColumn(
      'hostname',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailFromLoginMeta =
      const VerificationMeta('emailFromLogin');
  GeneratedTextColumn _emailFromLogin;
  @override
  GeneratedTextColumn get emailFromLogin =>
      _emailFromLogin ??= _constructEmailFromLogin();
  GeneratedTextColumn _constructEmailFromLogin() {
    return GeneratedTextColumn(
      'email_from_login',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  GeneratedTextColumn _token;
  @override
  GeneratedTextColumn get token => _token ??= _constructToken();
  GeneratedTextColumn _constructToken() {
    return GeneratedTextColumn(
      'token',
      $tableName,
      false,
    );
  }

  final VerificationMeta _syncFreqInSecondsMeta =
      const VerificationMeta('syncFreqInSeconds');
  GeneratedIntColumn _syncFreqInSeconds;
  @override
  GeneratedIntColumn get syncFreqInSeconds =>
      _syncFreqInSeconds ??= _constructSyncFreqInSeconds();
  GeneratedIntColumn _constructSyncFreqInSeconds() {
    return GeneratedIntColumn('sync_freq_in_seconds', $tableName, true,
        defaultValue: Constant(300));
  }

  final VerificationMeta _syncPeriodMeta = const VerificationMeta('syncPeriod');
  GeneratedTextColumn _syncPeriod;
  @override
  GeneratedTextColumn get syncPeriod => _syncPeriod ??= _constructSyncPeriod();
  GeneratedTextColumn _constructSyncPeriod() {
    return GeneratedTextColumn(
      'sync_period',
      $tableName,
      true,
    );
  }

  final VerificationMeta _languageMeta = const VerificationMeta('language');
  GeneratedTextColumn _language;
  @override
  GeneratedTextColumn get language => _language ??= _constructLanguage();
  GeneratedTextColumn _constructLanguage() {
    return GeneratedTextColumn(
      'language',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        localId,
        serverId,
        hostname,
        emailFromLogin,
        token,
        syncFreqInSeconds,
        syncPeriod,
        language
      ];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(UsersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    }
    if (d.serverId.present) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableValue(d.serverId.value, _serverIdMeta));
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (d.hostname.present) {
      context.handle(_hostnameMeta,
          hostname.isAcceptableValue(d.hostname.value, _hostnameMeta));
    } else if (isInserting) {
      context.missing(_hostnameMeta);
    }
    if (d.emailFromLogin.present) {
      context.handle(
          _emailFromLoginMeta,
          emailFromLogin.isAcceptableValue(
              d.emailFromLogin.value, _emailFromLoginMeta));
    } else if (isInserting) {
      context.missing(_emailFromLoginMeta);
    }
    if (d.token.present) {
      context.handle(
          _tokenMeta, token.isAcceptableValue(d.token.value, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (d.syncFreqInSeconds.present) {
      context.handle(
          _syncFreqInSecondsMeta,
          syncFreqInSeconds.isAcceptableValue(
              d.syncFreqInSeconds.value, _syncFreqInSecondsMeta));
    }
    if (d.syncPeriod.present) {
      context.handle(_syncPeriodMeta,
          syncPeriod.isAcceptableValue(d.syncPeriod.value, _syncPeriodMeta));
    }
    if (d.language.present) {
      context.handle(_languageMeta,
          language.isAcceptableValue(d.language.value, _languageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsersCompanion d) {
    final map = <String, Variable>{};
    if (d.localId.present) {
      map['local_id'] = Variable<int, IntType>(d.localId.value);
    }
    if (d.serverId.present) {
      map['server_id'] = Variable<int, IntType>(d.serverId.value);
    }
    if (d.hostname.present) {
      map['hostname'] = Variable<String, StringType>(d.hostname.value);
    }
    if (d.emailFromLogin.present) {
      map['email_from_login'] =
          Variable<String, StringType>(d.emailFromLogin.value);
    }
    if (d.token.present) {
      map['token'] = Variable<String, StringType>(d.token.value);
    }
    if (d.syncFreqInSeconds.present) {
      map['sync_freq_in_seconds'] =
          Variable<int, IntType>(d.syncFreqInSeconds.value);
    }
    if (d.syncPeriod.present) {
      map['sync_period'] = Variable<String, StringType>(d.syncPeriod.value);
    }
    if (d.language.present) {
      map['language'] = Variable<String, StringType>(d.language.value);
    }
    return map;
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int localId;
  final int userLocalId;
  final int entityId;
  final int idUser;
  final String uuid;
  final String parentUuid;
  final String moduleName;
  final bool useToAuthorize;
  final String email;
  final String friendlyName;
  final bool useSignature;
  final String signature;
  final int serverId;
  final String foldersOrderInJson;
  final bool useThreading;
  final bool saveRepliesToCurrFolder;
  final int accountId;
  final bool allowFilters;
  final bool allowForward;
  final bool allowAutoResponder;
  Account(
      {@required this.localId,
      @required this.userLocalId,
      @required this.entityId,
      @required this.idUser,
      @required this.uuid,
      @required this.parentUuid,
      @required this.moduleName,
      @required this.useToAuthorize,
      @required this.email,
      @required this.friendlyName,
      @required this.useSignature,
      @required this.signature,
      @required this.serverId,
      @required this.foldersOrderInJson,
      @required this.useThreading,
      @required this.saveRepliesToCurrFolder,
      @required this.accountId,
      @required this.allowFilters,
      @required this.allowForward,
      @required this.allowAutoResponder});
  factory Account.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Account(
      localId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      userLocalId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id']),
      entityId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}entity_id']),
      idUser:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      parentUuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_uuid']),
      moduleName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}module_name']),
      useToAuthorize: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}use_to_authorize']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      friendlyName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}friendly_name']),
      useSignature: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}use_signature']),
      signature: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}signature']),
      serverId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}server_id']),
      foldersOrderInJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}folders_order_in_json']),
      useThreading: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}use_threading']),
      saveRepliesToCurrFolder: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}save_replies_to_curr_folder']),
      accountId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}account_id']),
      allowFilters: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}allow_filters']),
      allowForward: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}allow_forward']),
      allowAutoResponder: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}allow_auto_responder']),
    );
  }
  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Account(
      localId: serializer.fromJson<int>(json['localId']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      entityId: serializer.fromJson<int>(json['entityId']),
      idUser: serializer.fromJson<int>(json['idUser']),
      uuid: serializer.fromJson<String>(json['uuid']),
      parentUuid: serializer.fromJson<String>(json['parentUuid']),
      moduleName: serializer.fromJson<String>(json['moduleName']),
      useToAuthorize: serializer.fromJson<bool>(json['useToAuthorize']),
      email: serializer.fromJson<String>(json['email']),
      friendlyName: serializer.fromJson<String>(json['friendlyName']),
      useSignature: serializer.fromJson<bool>(json['useSignature']),
      signature: serializer.fromJson<String>(json['signature']),
      serverId: serializer.fromJson<int>(json['serverId']),
      foldersOrderInJson:
          serializer.fromJson<String>(json['foldersOrderInJson']),
      useThreading: serializer.fromJson<bool>(json['useThreading']),
      saveRepliesToCurrFolder:
          serializer.fromJson<bool>(json['saveRepliesToCurrFolder']),
      accountId: serializer.fromJson<int>(json['accountId']),
      allowFilters: serializer.fromJson<bool>(json['allowFilters']),
      allowForward: serializer.fromJson<bool>(json['allowForward']),
      allowAutoResponder: serializer.fromJson<bool>(json['allowAutoResponder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'entityId': serializer.toJson<int>(entityId),
      'idUser': serializer.toJson<int>(idUser),
      'uuid': serializer.toJson<String>(uuid),
      'parentUuid': serializer.toJson<String>(parentUuid),
      'moduleName': serializer.toJson<String>(moduleName),
      'useToAuthorize': serializer.toJson<bool>(useToAuthorize),
      'email': serializer.toJson<String>(email),
      'friendlyName': serializer.toJson<String>(friendlyName),
      'useSignature': serializer.toJson<bool>(useSignature),
      'signature': serializer.toJson<String>(signature),
      'serverId': serializer.toJson<int>(serverId),
      'foldersOrderInJson': serializer.toJson<String>(foldersOrderInJson),
      'useThreading': serializer.toJson<bool>(useThreading),
      'saveRepliesToCurrFolder':
          serializer.toJson<bool>(saveRepliesToCurrFolder),
      'accountId': serializer.toJson<int>(accountId),
      'allowFilters': serializer.toJson<bool>(allowFilters),
      'allowForward': serializer.toJson<bool>(allowForward),
      'allowAutoResponder': serializer.toJson<bool>(allowAutoResponder),
    };
  }

  @override
  AccountsCompanion createCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      userLocalId: userLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(userLocalId),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      parentUuid: parentUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(parentUuid),
      moduleName: moduleName == null && nullToAbsent
          ? const Value.absent()
          : Value(moduleName),
      useToAuthorize: useToAuthorize == null && nullToAbsent
          ? const Value.absent()
          : Value(useToAuthorize),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      friendlyName: friendlyName == null && nullToAbsent
          ? const Value.absent()
          : Value(friendlyName),
      useSignature: useSignature == null && nullToAbsent
          ? const Value.absent()
          : Value(useSignature),
      signature: signature == null && nullToAbsent
          ? const Value.absent()
          : Value(signature),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      foldersOrderInJson: foldersOrderInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(foldersOrderInJson),
      useThreading: useThreading == null && nullToAbsent
          ? const Value.absent()
          : Value(useThreading),
      saveRepliesToCurrFolder: saveRepliesToCurrFolder == null && nullToAbsent
          ? const Value.absent()
          : Value(saveRepliesToCurrFolder),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      allowFilters: allowFilters == null && nullToAbsent
          ? const Value.absent()
          : Value(allowFilters),
      allowForward: allowForward == null && nullToAbsent
          ? const Value.absent()
          : Value(allowForward),
      allowAutoResponder: allowAutoResponder == null && nullToAbsent
          ? const Value.absent()
          : Value(allowAutoResponder),
    );
  }

  Account copyWith(
          {int localId,
          int userLocalId,
          int entityId,
          int idUser,
          String uuid,
          String parentUuid,
          String moduleName,
          bool useToAuthorize,
          String email,
          String friendlyName,
          bool useSignature,
          String signature,
          int serverId,
          String foldersOrderInJson,
          bool useThreading,
          bool saveRepliesToCurrFolder,
          int accountId,
          bool allowFilters,
          bool allowForward,
          bool allowAutoResponder}) =>
      Account(
        localId: localId ?? this.localId,
        userLocalId: userLocalId ?? this.userLocalId,
        entityId: entityId ?? this.entityId,
        idUser: idUser ?? this.idUser,
        uuid: uuid ?? this.uuid,
        parentUuid: parentUuid ?? this.parentUuid,
        moduleName: moduleName ?? this.moduleName,
        useToAuthorize: useToAuthorize ?? this.useToAuthorize,
        email: email ?? this.email,
        friendlyName: friendlyName ?? this.friendlyName,
        useSignature: useSignature ?? this.useSignature,
        signature: signature ?? this.signature,
        serverId: serverId ?? this.serverId,
        foldersOrderInJson: foldersOrderInJson ?? this.foldersOrderInJson,
        useThreading: useThreading ?? this.useThreading,
        saveRepliesToCurrFolder:
            saveRepliesToCurrFolder ?? this.saveRepliesToCurrFolder,
        accountId: accountId ?? this.accountId,
        allowFilters: allowFilters ?? this.allowFilters,
        allowForward: allowForward ?? this.allowForward,
        allowAutoResponder: allowAutoResponder ?? this.allowAutoResponder,
      );
  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('localId: $localId, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('entityId: $entityId, ')
          ..write('idUser: $idUser, ')
          ..write('uuid: $uuid, ')
          ..write('parentUuid: $parentUuid, ')
          ..write('moduleName: $moduleName, ')
          ..write('useToAuthorize: $useToAuthorize, ')
          ..write('email: $email, ')
          ..write('friendlyName: $friendlyName, ')
          ..write('useSignature: $useSignature, ')
          ..write('signature: $signature, ')
          ..write('serverId: $serverId, ')
          ..write('foldersOrderInJson: $foldersOrderInJson, ')
          ..write('useThreading: $useThreading, ')
          ..write('saveRepliesToCurrFolder: $saveRepliesToCurrFolder, ')
          ..write('accountId: $accountId, ')
          ..write('allowFilters: $allowFilters, ')
          ..write('allowForward: $allowForward, ')
          ..write('allowAutoResponder: $allowAutoResponder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      localId.hashCode,
      $mrjc(
          userLocalId.hashCode,
          $mrjc(
              entityId.hashCode,
              $mrjc(
                  idUser.hashCode,
                  $mrjc(
                      uuid.hashCode,
                      $mrjc(
                          parentUuid.hashCode,
                          $mrjc(
                              moduleName.hashCode,
                              $mrjc(
                                  useToAuthorize.hashCode,
                                  $mrjc(
                                      email.hashCode,
                                      $mrjc(
                                          friendlyName.hashCode,
                                          $mrjc(
                                              useSignature.hashCode,
                                              $mrjc(
                                                  signature.hashCode,
                                                  $mrjc(
                                                      serverId.hashCode,
                                                      $mrjc(
                                                          foldersOrderInJson
                                                              .hashCode,
                                                          $mrjc(
                                                              useThreading
                                                                  .hashCode,
                                                              $mrjc(
                                                                  saveRepliesToCurrFolder
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      accountId
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          allowFilters
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              allowForward.hashCode,
                                                                              allowAutoResponder.hashCode))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Account &&
          other.localId == this.localId &&
          other.userLocalId == this.userLocalId &&
          other.entityId == this.entityId &&
          other.idUser == this.idUser &&
          other.uuid == this.uuid &&
          other.parentUuid == this.parentUuid &&
          other.moduleName == this.moduleName &&
          other.useToAuthorize == this.useToAuthorize &&
          other.email == this.email &&
          other.friendlyName == this.friendlyName &&
          other.useSignature == this.useSignature &&
          other.signature == this.signature &&
          other.serverId == this.serverId &&
          other.foldersOrderInJson == this.foldersOrderInJson &&
          other.useThreading == this.useThreading &&
          other.saveRepliesToCurrFolder == this.saveRepliesToCurrFolder &&
          other.accountId == this.accountId &&
          other.allowFilters == this.allowFilters &&
          other.allowForward == this.allowForward &&
          other.allowAutoResponder == this.allowAutoResponder);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> localId;
  final Value<int> userLocalId;
  final Value<int> entityId;
  final Value<int> idUser;
  final Value<String> uuid;
  final Value<String> parentUuid;
  final Value<String> moduleName;
  final Value<bool> useToAuthorize;
  final Value<String> email;
  final Value<String> friendlyName;
  final Value<bool> useSignature;
  final Value<String> signature;
  final Value<int> serverId;
  final Value<String> foldersOrderInJson;
  final Value<bool> useThreading;
  final Value<bool> saveRepliesToCurrFolder;
  final Value<int> accountId;
  final Value<bool> allowFilters;
  final Value<bool> allowForward;
  final Value<bool> allowAutoResponder;
  const AccountsCompanion({
    this.localId = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.entityId = const Value.absent(),
    this.idUser = const Value.absent(),
    this.uuid = const Value.absent(),
    this.parentUuid = const Value.absent(),
    this.moduleName = const Value.absent(),
    this.useToAuthorize = const Value.absent(),
    this.email = const Value.absent(),
    this.friendlyName = const Value.absent(),
    this.useSignature = const Value.absent(),
    this.signature = const Value.absent(),
    this.serverId = const Value.absent(),
    this.foldersOrderInJson = const Value.absent(),
    this.useThreading = const Value.absent(),
    this.saveRepliesToCurrFolder = const Value.absent(),
    this.accountId = const Value.absent(),
    this.allowFilters = const Value.absent(),
    this.allowForward = const Value.absent(),
    this.allowAutoResponder = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.localId = const Value.absent(),
    @required int userLocalId,
    @required int entityId,
    @required int idUser,
    @required String uuid,
    @required String parentUuid,
    @required String moduleName,
    @required bool useToAuthorize,
    @required String email,
    @required String friendlyName,
    @required bool useSignature,
    @required String signature,
    @required int serverId,
    @required String foldersOrderInJson,
    @required bool useThreading,
    @required bool saveRepliesToCurrFolder,
    @required int accountId,
    @required bool allowFilters,
    @required bool allowForward,
    @required bool allowAutoResponder,
  })  : userLocalId = Value(userLocalId),
        entityId = Value(entityId),
        idUser = Value(idUser),
        uuid = Value(uuid),
        parentUuid = Value(parentUuid),
        moduleName = Value(moduleName),
        useToAuthorize = Value(useToAuthorize),
        email = Value(email),
        friendlyName = Value(friendlyName),
        useSignature = Value(useSignature),
        signature = Value(signature),
        serverId = Value(serverId),
        foldersOrderInJson = Value(foldersOrderInJson),
        useThreading = Value(useThreading),
        saveRepliesToCurrFolder = Value(saveRepliesToCurrFolder),
        accountId = Value(accountId),
        allowFilters = Value(allowFilters),
        allowForward = Value(allowForward),
        allowAutoResponder = Value(allowAutoResponder);
  AccountsCompanion copyWith(
      {Value<int> localId,
      Value<int> userLocalId,
      Value<int> entityId,
      Value<int> idUser,
      Value<String> uuid,
      Value<String> parentUuid,
      Value<String> moduleName,
      Value<bool> useToAuthorize,
      Value<String> email,
      Value<String> friendlyName,
      Value<bool> useSignature,
      Value<String> signature,
      Value<int> serverId,
      Value<String> foldersOrderInJson,
      Value<bool> useThreading,
      Value<bool> saveRepliesToCurrFolder,
      Value<int> accountId,
      Value<bool> allowFilters,
      Value<bool> allowForward,
      Value<bool> allowAutoResponder}) {
    return AccountsCompanion(
      localId: localId ?? this.localId,
      userLocalId: userLocalId ?? this.userLocalId,
      entityId: entityId ?? this.entityId,
      idUser: idUser ?? this.idUser,
      uuid: uuid ?? this.uuid,
      parentUuid: parentUuid ?? this.parentUuid,
      moduleName: moduleName ?? this.moduleName,
      useToAuthorize: useToAuthorize ?? this.useToAuthorize,
      email: email ?? this.email,
      friendlyName: friendlyName ?? this.friendlyName,
      useSignature: useSignature ?? this.useSignature,
      signature: signature ?? this.signature,
      serverId: serverId ?? this.serverId,
      foldersOrderInJson: foldersOrderInJson ?? this.foldersOrderInJson,
      useThreading: useThreading ?? this.useThreading,
      saveRepliesToCurrFolder:
          saveRepliesToCurrFolder ?? this.saveRepliesToCurrFolder,
      accountId: accountId ?? this.accountId,
      allowFilters: allowFilters ?? this.allowFilters,
      allowForward: allowForward ?? this.allowForward,
      allowAutoResponder: allowAutoResponder ?? this.allowAutoResponder,
    );
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  final GeneratedDatabase _db;
  final String _alias;
  $AccountsTable(this._db, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedIntColumn _localId;
  @override
  GeneratedIntColumn get localId => _localId ??= _constructLocalId();
  GeneratedIntColumn _constructLocalId() {
    return GeneratedIntColumn('local_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  GeneratedIntColumn _userLocalId;
  @override
  GeneratedIntColumn get userLocalId =>
      _userLocalId ??= _constructUserLocalId();
  GeneratedIntColumn _constructUserLocalId() {
    return GeneratedIntColumn(
      'user_local_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _entityIdMeta = const VerificationMeta('entityId');
  GeneratedIntColumn _entityId;
  @override
  GeneratedIntColumn get entityId => _entityId ??= _constructEntityId();
  GeneratedIntColumn _constructEntityId() {
    return GeneratedIntColumn(
      'entity_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  GeneratedIntColumn _idUser;
  @override
  GeneratedIntColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedIntColumn _constructIdUser() {
    return GeneratedIntColumn(
      'id_user',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  @override
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn(
      'uuid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _parentUuidMeta = const VerificationMeta('parentUuid');
  GeneratedTextColumn _parentUuid;
  @override
  GeneratedTextColumn get parentUuid => _parentUuid ??= _constructParentUuid();
  GeneratedTextColumn _constructParentUuid() {
    return GeneratedTextColumn(
      'parent_uuid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _moduleNameMeta = const VerificationMeta('moduleName');
  GeneratedTextColumn _moduleName;
  @override
  GeneratedTextColumn get moduleName => _moduleName ??= _constructModuleName();
  GeneratedTextColumn _constructModuleName() {
    return GeneratedTextColumn(
      'module_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _useToAuthorizeMeta =
      const VerificationMeta('useToAuthorize');
  GeneratedBoolColumn _useToAuthorize;
  @override
  GeneratedBoolColumn get useToAuthorize =>
      _useToAuthorize ??= _constructUseToAuthorize();
  GeneratedBoolColumn _constructUseToAuthorize() {
    return GeneratedBoolColumn(
      'use_to_authorize',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _friendlyNameMeta =
      const VerificationMeta('friendlyName');
  GeneratedTextColumn _friendlyName;
  @override
  GeneratedTextColumn get friendlyName =>
      _friendlyName ??= _constructFriendlyName();
  GeneratedTextColumn _constructFriendlyName() {
    return GeneratedTextColumn(
      'friendly_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _useSignatureMeta =
      const VerificationMeta('useSignature');
  GeneratedBoolColumn _useSignature;
  @override
  GeneratedBoolColumn get useSignature =>
      _useSignature ??= _constructUseSignature();
  GeneratedBoolColumn _constructUseSignature() {
    return GeneratedBoolColumn(
      'use_signature',
      $tableName,
      false,
    );
  }

  final VerificationMeta _signatureMeta = const VerificationMeta('signature');
  GeneratedTextColumn _signature;
  @override
  GeneratedTextColumn get signature => _signature ??= _constructSignature();
  GeneratedTextColumn _constructSignature() {
    return GeneratedTextColumn(
      'signature',
      $tableName,
      false,
    );
  }

  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  GeneratedIntColumn _serverId;
  @override
  GeneratedIntColumn get serverId => _serverId ??= _constructServerId();
  GeneratedIntColumn _constructServerId() {
    return GeneratedIntColumn(
      'server_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _foldersOrderInJsonMeta =
      const VerificationMeta('foldersOrderInJson');
  GeneratedTextColumn _foldersOrderInJson;
  @override
  GeneratedTextColumn get foldersOrderInJson =>
      _foldersOrderInJson ??= _constructFoldersOrderInJson();
  GeneratedTextColumn _constructFoldersOrderInJson() {
    return GeneratedTextColumn(
      'folders_order_in_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _useThreadingMeta =
      const VerificationMeta('useThreading');
  GeneratedBoolColumn _useThreading;
  @override
  GeneratedBoolColumn get useThreading =>
      _useThreading ??= _constructUseThreading();
  GeneratedBoolColumn _constructUseThreading() {
    return GeneratedBoolColumn(
      'use_threading',
      $tableName,
      false,
    );
  }

  final VerificationMeta _saveRepliesToCurrFolderMeta =
      const VerificationMeta('saveRepliesToCurrFolder');
  GeneratedBoolColumn _saveRepliesToCurrFolder;
  @override
  GeneratedBoolColumn get saveRepliesToCurrFolder =>
      _saveRepliesToCurrFolder ??= _constructSaveRepliesToCurrFolder();
  GeneratedBoolColumn _constructSaveRepliesToCurrFolder() {
    return GeneratedBoolColumn(
      'save_replies_to_curr_folder',
      $tableName,
      false,
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

  final VerificationMeta _allowFiltersMeta =
      const VerificationMeta('allowFilters');
  GeneratedBoolColumn _allowFilters;
  @override
  GeneratedBoolColumn get allowFilters =>
      _allowFilters ??= _constructAllowFilters();
  GeneratedBoolColumn _constructAllowFilters() {
    return GeneratedBoolColumn(
      'allow_filters',
      $tableName,
      false,
    );
  }

  final VerificationMeta _allowForwardMeta =
      const VerificationMeta('allowForward');
  GeneratedBoolColumn _allowForward;
  @override
  GeneratedBoolColumn get allowForward =>
      _allowForward ??= _constructAllowForward();
  GeneratedBoolColumn _constructAllowForward() {
    return GeneratedBoolColumn(
      'allow_forward',
      $tableName,
      false,
    );
  }

  final VerificationMeta _allowAutoResponderMeta =
      const VerificationMeta('allowAutoResponder');
  GeneratedBoolColumn _allowAutoResponder;
  @override
  GeneratedBoolColumn get allowAutoResponder =>
      _allowAutoResponder ??= _constructAllowAutoResponder();
  GeneratedBoolColumn _constructAllowAutoResponder() {
    return GeneratedBoolColumn(
      'allow_auto_responder',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        localId,
        userLocalId,
        entityId,
        idUser,
        uuid,
        parentUuid,
        moduleName,
        useToAuthorize,
        email,
        friendlyName,
        useSignature,
        signature,
        serverId,
        foldersOrderInJson,
        useThreading,
        saveRepliesToCurrFolder,
        accountId,
        allowFilters,
        allowForward,
        allowAutoResponder
      ];
  @override
  $AccountsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'accounts';
  @override
  final String actualTableName = 'accounts';
  @override
  VerificationContext validateIntegrity(AccountsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    }
    if (d.userLocalId.present) {
      context.handle(_userLocalIdMeta,
          userLocalId.isAcceptableValue(d.userLocalId.value, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (d.entityId.present) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableValue(d.entityId.value, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (d.idUser.present) {
      context.handle(
          _idUserMeta, idUser.isAcceptableValue(d.idUser.value, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (d.uuid.present) {
      context.handle(
          _uuidMeta, uuid.isAcceptableValue(d.uuid.value, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (d.parentUuid.present) {
      context.handle(_parentUuidMeta,
          parentUuid.isAcceptableValue(d.parentUuid.value, _parentUuidMeta));
    } else if (isInserting) {
      context.missing(_parentUuidMeta);
    }
    if (d.moduleName.present) {
      context.handle(_moduleNameMeta,
          moduleName.isAcceptableValue(d.moduleName.value, _moduleNameMeta));
    } else if (isInserting) {
      context.missing(_moduleNameMeta);
    }
    if (d.useToAuthorize.present) {
      context.handle(
          _useToAuthorizeMeta,
          useToAuthorize.isAcceptableValue(
              d.useToAuthorize.value, _useToAuthorizeMeta));
    } else if (isInserting) {
      context.missing(_useToAuthorizeMeta);
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (d.friendlyName.present) {
      context.handle(
          _friendlyNameMeta,
          friendlyName.isAcceptableValue(
              d.friendlyName.value, _friendlyNameMeta));
    } else if (isInserting) {
      context.missing(_friendlyNameMeta);
    }
    if (d.useSignature.present) {
      context.handle(
          _useSignatureMeta,
          useSignature.isAcceptableValue(
              d.useSignature.value, _useSignatureMeta));
    } else if (isInserting) {
      context.missing(_useSignatureMeta);
    }
    if (d.signature.present) {
      context.handle(_signatureMeta,
          signature.isAcceptableValue(d.signature.value, _signatureMeta));
    } else if (isInserting) {
      context.missing(_signatureMeta);
    }
    if (d.serverId.present) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableValue(d.serverId.value, _serverIdMeta));
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (d.foldersOrderInJson.present) {
      context.handle(
          _foldersOrderInJsonMeta,
          foldersOrderInJson.isAcceptableValue(
              d.foldersOrderInJson.value, _foldersOrderInJsonMeta));
    } else if (isInserting) {
      context.missing(_foldersOrderInJsonMeta);
    }
    if (d.useThreading.present) {
      context.handle(
          _useThreadingMeta,
          useThreading.isAcceptableValue(
              d.useThreading.value, _useThreadingMeta));
    } else if (isInserting) {
      context.missing(_useThreadingMeta);
    }
    if (d.saveRepliesToCurrFolder.present) {
      context.handle(
          _saveRepliesToCurrFolderMeta,
          saveRepliesToCurrFolder.isAcceptableValue(
              d.saveRepliesToCurrFolder.value, _saveRepliesToCurrFolderMeta));
    } else if (isInserting) {
      context.missing(_saveRepliesToCurrFolderMeta);
    }
    if (d.accountId.present) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableValue(d.accountId.value, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (d.allowFilters.present) {
      context.handle(
          _allowFiltersMeta,
          allowFilters.isAcceptableValue(
              d.allowFilters.value, _allowFiltersMeta));
    } else if (isInserting) {
      context.missing(_allowFiltersMeta);
    }
    if (d.allowForward.present) {
      context.handle(
          _allowForwardMeta,
          allowForward.isAcceptableValue(
              d.allowForward.value, _allowForwardMeta));
    } else if (isInserting) {
      context.missing(_allowForwardMeta);
    }
    if (d.allowAutoResponder.present) {
      context.handle(
          _allowAutoResponderMeta,
          allowAutoResponder.isAcceptableValue(
              d.allowAutoResponder.value, _allowAutoResponderMeta));
    } else if (isInserting) {
      context.missing(_allowAutoResponderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Account map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Account.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AccountsCompanion d) {
    final map = <String, Variable>{};
    if (d.localId.present) {
      map['local_id'] = Variable<int, IntType>(d.localId.value);
    }
    if (d.userLocalId.present) {
      map['user_local_id'] = Variable<int, IntType>(d.userLocalId.value);
    }
    if (d.entityId.present) {
      map['entity_id'] = Variable<int, IntType>(d.entityId.value);
    }
    if (d.idUser.present) {
      map['id_user'] = Variable<int, IntType>(d.idUser.value);
    }
    if (d.uuid.present) {
      map['uuid'] = Variable<String, StringType>(d.uuid.value);
    }
    if (d.parentUuid.present) {
      map['parent_uuid'] = Variable<String, StringType>(d.parentUuid.value);
    }
    if (d.moduleName.present) {
      map['module_name'] = Variable<String, StringType>(d.moduleName.value);
    }
    if (d.useToAuthorize.present) {
      map['use_to_authorize'] =
          Variable<bool, BoolType>(d.useToAuthorize.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    if (d.friendlyName.present) {
      map['friendly_name'] = Variable<String, StringType>(d.friendlyName.value);
    }
    if (d.useSignature.present) {
      map['use_signature'] = Variable<bool, BoolType>(d.useSignature.value);
    }
    if (d.signature.present) {
      map['signature'] = Variable<String, StringType>(d.signature.value);
    }
    if (d.serverId.present) {
      map['server_id'] = Variable<int, IntType>(d.serverId.value);
    }
    if (d.foldersOrderInJson.present) {
      map['folders_order_in_json'] =
          Variable<String, StringType>(d.foldersOrderInJson.value);
    }
    if (d.useThreading.present) {
      map['use_threading'] = Variable<bool, BoolType>(d.useThreading.value);
    }
    if (d.saveRepliesToCurrFolder.present) {
      map['save_replies_to_curr_folder'] =
          Variable<bool, BoolType>(d.saveRepliesToCurrFolder.value);
    }
    if (d.accountId.present) {
      map['account_id'] = Variable<int, IntType>(d.accountId.value);
    }
    if (d.allowFilters.present) {
      map['allow_filters'] = Variable<bool, BoolType>(d.allowFilters.value);
    }
    if (d.allowForward.present) {
      map['allow_forward'] = Variable<bool, BoolType>(d.allowForward.value);
    }
    if (d.allowAutoResponder.present) {
      map['allow_auto_responder'] =
          Variable<bool, BoolType>(d.allowAutoResponder.value);
    }
    return map;
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(_db, alias);
  }
}

class ContactsTable extends DataClass implements Insertable<ContactsTable> {
  final int localId;
  final String uuidPlusStorage;
  final String uuid;
  final int userLocalId;
  final int entityId;
  final String parentUuid;
  final String eTag;
  final int idUser;
  final int idTenant;
  final String storage;
  final String fullName;
  final bool useFriendlyName;
  final int primaryEmail;
  final int primaryPhone;
  final int primaryAddress;
  final String viewEmail;
  final String title;
  final String firstName;
  final String lastName;
  final String nickName;
  final String skype;
  final String facebook;
  final String personalEmail;
  final String personalAddress;
  final String personalCity;
  final String personalState;
  final String personalZip;
  final String personalCountry;
  final String personalWeb;
  final String personalFax;
  final String personalPhone;
  final String personalMobile;
  final String businessEmail;
  final String businessCompany;
  final String businessAddress;
  final String businessCity;
  final String businessState;
  final String businessZip;
  final String businessCountry;
  final String businessJobTitle;
  final String businessDepartment;
  final String businessOffice;
  final String businessPhone;
  final String businessFax;
  final String businessWeb;
  final String otherEmail;
  final String notes;
  final int birthDay;
  final int birthMonth;
  final int birthYear;
  final bool auto;
  final int frequency;
  final String dateModified;
  final String davContactsUid;
  final String davContactsVCardUid;
  final List<String> groupUUIDs;
  ContactsTable(
      {@required this.localId,
      @required this.uuidPlusStorage,
      @required this.uuid,
      @required this.userLocalId,
      this.entityId,
      this.parentUuid,
      @required this.eTag,
      @required this.idUser,
      this.idTenant,
      @required this.storage,
      @required this.fullName,
      this.useFriendlyName,
      @required this.primaryEmail,
      @required this.primaryPhone,
      @required this.primaryAddress,
      @required this.viewEmail,
      @required this.title,
      @required this.firstName,
      @required this.lastName,
      @required this.nickName,
      @required this.skype,
      @required this.facebook,
      @required this.personalEmail,
      @required this.personalAddress,
      @required this.personalCity,
      @required this.personalState,
      @required this.personalZip,
      @required this.personalCountry,
      @required this.personalWeb,
      @required this.personalFax,
      @required this.personalPhone,
      @required this.personalMobile,
      @required this.businessEmail,
      @required this.businessCompany,
      @required this.businessAddress,
      @required this.businessCity,
      @required this.businessState,
      @required this.businessZip,
      @required this.businessCountry,
      @required this.businessJobTitle,
      @required this.businessDepartment,
      @required this.businessOffice,
      @required this.businessPhone,
      @required this.businessFax,
      @required this.businessWeb,
      @required this.otherEmail,
      @required this.notes,
      @required this.birthDay,
      @required this.birthMonth,
      @required this.birthYear,
      this.auto,
      @required this.frequency,
      this.dateModified,
      this.davContactsUid,
      this.davContactsVCardUid,
      @required this.groupUUIDs});
  factory ContactsTable.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ContactsTable(
      localId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      uuidPlusStorage: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}uuid_plus_storage']),
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      userLocalId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id']),
      entityId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}entity_id']),
      parentUuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_uuid']),
      eTag: stringType.mapFromDatabaseResponse(data['${effectivePrefix}e_tag']),
      idUser:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      idTenant:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_tenant']),
      storage:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}storage']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      useFriendlyName: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}use_friendly_name']),
      primaryEmail: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}primary_email']),
      primaryPhone: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}primary_phone']),
      primaryAddress: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}primary_address']),
      viewEmail: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}view_email']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      nickName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}nick_name']),
      skype:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}skype']),
      facebook: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}facebook']),
      personalEmail: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_email']),
      personalAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_address']),
      personalCity: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_city']),
      personalState: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_state']),
      personalZip: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_zip']),
      personalCountry: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_country']),
      personalWeb: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_web']),
      personalFax: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_fax']),
      personalPhone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_phone']),
      personalMobile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_mobile']),
      businessEmail: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_email']),
      businessCompany: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_company']),
      businessAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_address']),
      businessCity: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_city']),
      businessState: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_state']),
      businessZip: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_zip']),
      businessCountry: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_country']),
      businessJobTitle: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}business_job_title']),
      businessDepartment: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}business_department']),
      businessOffice: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_office']),
      businessPhone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_phone']),
      businessFax: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_fax']),
      businessWeb: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_web']),
      otherEmail: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}other_email']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      birthDay:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}birth_day']),
      birthMonth: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}birth_month']),
      birthYear:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}birth_year']),
      auto: boolType.mapFromDatabaseResponse(data['${effectivePrefix}auto']),
      frequency:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}frequency']),
      dateModified: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_modified']),
      davContactsUid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}dav_contacts_uid']),
      davContactsVCardUid: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}dav_contacts_v_card_uid']),
      groupUUIDs: $ContactsTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}group_u_u_i_ds'])),
    );
  }
  factory ContactsTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ContactsTable(
      localId: serializer.fromJson<int>(json['localId']),
      uuidPlusStorage: serializer.fromJson<String>(json['uuidPlusStorage']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      entityId: serializer.fromJson<int>(json['entityId']),
      parentUuid: serializer.fromJson<String>(json['parentUuid']),
      eTag: serializer.fromJson<String>(json['eTag']),
      idUser: serializer.fromJson<int>(json['idUser']),
      idTenant: serializer.fromJson<int>(json['idTenant']),
      storage: serializer.fromJson<String>(json['storage']),
      fullName: serializer.fromJson<String>(json['fullName']),
      useFriendlyName: serializer.fromJson<bool>(json['useFriendlyName']),
      primaryEmail: serializer.fromJson<int>(json['primaryEmail']),
      primaryPhone: serializer.fromJson<int>(json['primaryPhone']),
      primaryAddress: serializer.fromJson<int>(json['primaryAddress']),
      viewEmail: serializer.fromJson<String>(json['viewEmail']),
      title: serializer.fromJson<String>(json['title']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      nickName: serializer.fromJson<String>(json['nickName']),
      skype: serializer.fromJson<String>(json['skype']),
      facebook: serializer.fromJson<String>(json['facebook']),
      personalEmail: serializer.fromJson<String>(json['personalEmail']),
      personalAddress: serializer.fromJson<String>(json['personalAddress']),
      personalCity: serializer.fromJson<String>(json['personalCity']),
      personalState: serializer.fromJson<String>(json['personalState']),
      personalZip: serializer.fromJson<String>(json['personalZip']),
      personalCountry: serializer.fromJson<String>(json['personalCountry']),
      personalWeb: serializer.fromJson<String>(json['personalWeb']),
      personalFax: serializer.fromJson<String>(json['personalFax']),
      personalPhone: serializer.fromJson<String>(json['personalPhone']),
      personalMobile: serializer.fromJson<String>(json['personalMobile']),
      businessEmail: serializer.fromJson<String>(json['businessEmail']),
      businessCompany: serializer.fromJson<String>(json['businessCompany']),
      businessAddress: serializer.fromJson<String>(json['businessAddress']),
      businessCity: serializer.fromJson<String>(json['businessCity']),
      businessState: serializer.fromJson<String>(json['businessState']),
      businessZip: serializer.fromJson<String>(json['businessZip']),
      businessCountry: serializer.fromJson<String>(json['businessCountry']),
      businessJobTitle: serializer.fromJson<String>(json['businessJobTitle']),
      businessDepartment:
          serializer.fromJson<String>(json['businessDepartment']),
      businessOffice: serializer.fromJson<String>(json['businessOffice']),
      businessPhone: serializer.fromJson<String>(json['businessPhone']),
      businessFax: serializer.fromJson<String>(json['businessFax']),
      businessWeb: serializer.fromJson<String>(json['businessWeb']),
      otherEmail: serializer.fromJson<String>(json['otherEmail']),
      notes: serializer.fromJson<String>(json['notes']),
      birthDay: serializer.fromJson<int>(json['birthDay']),
      birthMonth: serializer.fromJson<int>(json['birthMonth']),
      birthYear: serializer.fromJson<int>(json['birthYear']),
      auto: serializer.fromJson<bool>(json['auto']),
      frequency: serializer.fromJson<int>(json['frequency']),
      dateModified: serializer.fromJson<String>(json['dateModified']),
      davContactsUid: serializer.fromJson<String>(json['davContactsUid']),
      davContactsVCardUid:
          serializer.fromJson<String>(json['davContactsVCardUid']),
      groupUUIDs: serializer.fromJson<List<String>>(json['groupUUIDs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'uuidPlusStorage': serializer.toJson<String>(uuidPlusStorage),
      'uuid': serializer.toJson<String>(uuid),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'entityId': serializer.toJson<int>(entityId),
      'parentUuid': serializer.toJson<String>(parentUuid),
      'eTag': serializer.toJson<String>(eTag),
      'idUser': serializer.toJson<int>(idUser),
      'idTenant': serializer.toJson<int>(idTenant),
      'storage': serializer.toJson<String>(storage),
      'fullName': serializer.toJson<String>(fullName),
      'useFriendlyName': serializer.toJson<bool>(useFriendlyName),
      'primaryEmail': serializer.toJson<int>(primaryEmail),
      'primaryPhone': serializer.toJson<int>(primaryPhone),
      'primaryAddress': serializer.toJson<int>(primaryAddress),
      'viewEmail': serializer.toJson<String>(viewEmail),
      'title': serializer.toJson<String>(title),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'nickName': serializer.toJson<String>(nickName),
      'skype': serializer.toJson<String>(skype),
      'facebook': serializer.toJson<String>(facebook),
      'personalEmail': serializer.toJson<String>(personalEmail),
      'personalAddress': serializer.toJson<String>(personalAddress),
      'personalCity': serializer.toJson<String>(personalCity),
      'personalState': serializer.toJson<String>(personalState),
      'personalZip': serializer.toJson<String>(personalZip),
      'personalCountry': serializer.toJson<String>(personalCountry),
      'personalWeb': serializer.toJson<String>(personalWeb),
      'personalFax': serializer.toJson<String>(personalFax),
      'personalPhone': serializer.toJson<String>(personalPhone),
      'personalMobile': serializer.toJson<String>(personalMobile),
      'businessEmail': serializer.toJson<String>(businessEmail),
      'businessCompany': serializer.toJson<String>(businessCompany),
      'businessAddress': serializer.toJson<String>(businessAddress),
      'businessCity': serializer.toJson<String>(businessCity),
      'businessState': serializer.toJson<String>(businessState),
      'businessZip': serializer.toJson<String>(businessZip),
      'businessCountry': serializer.toJson<String>(businessCountry),
      'businessJobTitle': serializer.toJson<String>(businessJobTitle),
      'businessDepartment': serializer.toJson<String>(businessDepartment),
      'businessOffice': serializer.toJson<String>(businessOffice),
      'businessPhone': serializer.toJson<String>(businessPhone),
      'businessFax': serializer.toJson<String>(businessFax),
      'businessWeb': serializer.toJson<String>(businessWeb),
      'otherEmail': serializer.toJson<String>(otherEmail),
      'notes': serializer.toJson<String>(notes),
      'birthDay': serializer.toJson<int>(birthDay),
      'birthMonth': serializer.toJson<int>(birthMonth),
      'birthYear': serializer.toJson<int>(birthYear),
      'auto': serializer.toJson<bool>(auto),
      'frequency': serializer.toJson<int>(frequency),
      'dateModified': serializer.toJson<String>(dateModified),
      'davContactsUid': serializer.toJson<String>(davContactsUid),
      'davContactsVCardUid': serializer.toJson<String>(davContactsVCardUid),
      'groupUUIDs': serializer.toJson<List<String>>(groupUUIDs),
    };
  }

  @override
  ContactsCompanion createCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      uuidPlusStorage: uuidPlusStorage == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPlusStorage),
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      userLocalId: userLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(userLocalId),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      parentUuid: parentUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(parentUuid),
      eTag: eTag == null && nullToAbsent ? const Value.absent() : Value(eTag),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      idTenant: idTenant == null && nullToAbsent
          ? const Value.absent()
          : Value(idTenant),
      storage: storage == null && nullToAbsent
          ? const Value.absent()
          : Value(storage),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      useFriendlyName: useFriendlyName == null && nullToAbsent
          ? const Value.absent()
          : Value(useFriendlyName),
      primaryEmail: primaryEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryEmail),
      primaryPhone: primaryPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryPhone),
      primaryAddress: primaryAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryAddress),
      viewEmail: viewEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(viewEmail),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      nickName: nickName == null && nullToAbsent
          ? const Value.absent()
          : Value(nickName),
      skype:
          skype == null && nullToAbsent ? const Value.absent() : Value(skype),
      facebook: facebook == null && nullToAbsent
          ? const Value.absent()
          : Value(facebook),
      personalEmail: personalEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(personalEmail),
      personalAddress: personalAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(personalAddress),
      personalCity: personalCity == null && nullToAbsent
          ? const Value.absent()
          : Value(personalCity),
      personalState: personalState == null && nullToAbsent
          ? const Value.absent()
          : Value(personalState),
      personalZip: personalZip == null && nullToAbsent
          ? const Value.absent()
          : Value(personalZip),
      personalCountry: personalCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(personalCountry),
      personalWeb: personalWeb == null && nullToAbsent
          ? const Value.absent()
          : Value(personalWeb),
      personalFax: personalFax == null && nullToAbsent
          ? const Value.absent()
          : Value(personalFax),
      personalPhone: personalPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(personalPhone),
      personalMobile: personalMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(personalMobile),
      businessEmail: businessEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(businessEmail),
      businessCompany: businessCompany == null && nullToAbsent
          ? const Value.absent()
          : Value(businessCompany),
      businessAddress: businessAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(businessAddress),
      businessCity: businessCity == null && nullToAbsent
          ? const Value.absent()
          : Value(businessCity),
      businessState: businessState == null && nullToAbsent
          ? const Value.absent()
          : Value(businessState),
      businessZip: businessZip == null && nullToAbsent
          ? const Value.absent()
          : Value(businessZip),
      businessCountry: businessCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(businessCountry),
      businessJobTitle: businessJobTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(businessJobTitle),
      businessDepartment: businessDepartment == null && nullToAbsent
          ? const Value.absent()
          : Value(businessDepartment),
      businessOffice: businessOffice == null && nullToAbsent
          ? const Value.absent()
          : Value(businessOffice),
      businessPhone: businessPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(businessPhone),
      businessFax: businessFax == null && nullToAbsent
          ? const Value.absent()
          : Value(businessFax),
      businessWeb: businessWeb == null && nullToAbsent
          ? const Value.absent()
          : Value(businessWeb),
      otherEmail: otherEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(otherEmail),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      birthDay: birthDay == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDay),
      birthMonth: birthMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(birthMonth),
      birthYear: birthYear == null && nullToAbsent
          ? const Value.absent()
          : Value(birthYear),
      auto: auto == null && nullToAbsent ? const Value.absent() : Value(auto),
      frequency: frequency == null && nullToAbsent
          ? const Value.absent()
          : Value(frequency),
      dateModified: dateModified == null && nullToAbsent
          ? const Value.absent()
          : Value(dateModified),
      davContactsUid: davContactsUid == null && nullToAbsent
          ? const Value.absent()
          : Value(davContactsUid),
      davContactsVCardUid: davContactsVCardUid == null && nullToAbsent
          ? const Value.absent()
          : Value(davContactsVCardUid),
      groupUUIDs: groupUUIDs == null && nullToAbsent
          ? const Value.absent()
          : Value(groupUUIDs),
    );
  }

  ContactsTable copyWith(
          {int localId,
          String uuidPlusStorage,
          String uuid,
          int userLocalId,
          int entityId,
          String parentUuid,
          String eTag,
          int idUser,
          int idTenant,
          String storage,
          String fullName,
          bool useFriendlyName,
          int primaryEmail,
          int primaryPhone,
          int primaryAddress,
          String viewEmail,
          String title,
          String firstName,
          String lastName,
          String nickName,
          String skype,
          String facebook,
          String personalEmail,
          String personalAddress,
          String personalCity,
          String personalState,
          String personalZip,
          String personalCountry,
          String personalWeb,
          String personalFax,
          String personalPhone,
          String personalMobile,
          String businessEmail,
          String businessCompany,
          String businessAddress,
          String businessCity,
          String businessState,
          String businessZip,
          String businessCountry,
          String businessJobTitle,
          String businessDepartment,
          String businessOffice,
          String businessPhone,
          String businessFax,
          String businessWeb,
          String otherEmail,
          String notes,
          int birthDay,
          int birthMonth,
          int birthYear,
          bool auto,
          int frequency,
          String dateModified,
          String davContactsUid,
          String davContactsVCardUid,
          List<String> groupUUIDs}) =>
      ContactsTable(
        localId: localId ?? this.localId,
        uuidPlusStorage: uuidPlusStorage ?? this.uuidPlusStorage,
        uuid: uuid ?? this.uuid,
        userLocalId: userLocalId ?? this.userLocalId,
        entityId: entityId ?? this.entityId,
        parentUuid: parentUuid ?? this.parentUuid,
        eTag: eTag ?? this.eTag,
        idUser: idUser ?? this.idUser,
        idTenant: idTenant ?? this.idTenant,
        storage: storage ?? this.storage,
        fullName: fullName ?? this.fullName,
        useFriendlyName: useFriendlyName ?? this.useFriendlyName,
        primaryEmail: primaryEmail ?? this.primaryEmail,
        primaryPhone: primaryPhone ?? this.primaryPhone,
        primaryAddress: primaryAddress ?? this.primaryAddress,
        viewEmail: viewEmail ?? this.viewEmail,
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        nickName: nickName ?? this.nickName,
        skype: skype ?? this.skype,
        facebook: facebook ?? this.facebook,
        personalEmail: personalEmail ?? this.personalEmail,
        personalAddress: personalAddress ?? this.personalAddress,
        personalCity: personalCity ?? this.personalCity,
        personalState: personalState ?? this.personalState,
        personalZip: personalZip ?? this.personalZip,
        personalCountry: personalCountry ?? this.personalCountry,
        personalWeb: personalWeb ?? this.personalWeb,
        personalFax: personalFax ?? this.personalFax,
        personalPhone: personalPhone ?? this.personalPhone,
        personalMobile: personalMobile ?? this.personalMobile,
        businessEmail: businessEmail ?? this.businessEmail,
        businessCompany: businessCompany ?? this.businessCompany,
        businessAddress: businessAddress ?? this.businessAddress,
        businessCity: businessCity ?? this.businessCity,
        businessState: businessState ?? this.businessState,
        businessZip: businessZip ?? this.businessZip,
        businessCountry: businessCountry ?? this.businessCountry,
        businessJobTitle: businessJobTitle ?? this.businessJobTitle,
        businessDepartment: businessDepartment ?? this.businessDepartment,
        businessOffice: businessOffice ?? this.businessOffice,
        businessPhone: businessPhone ?? this.businessPhone,
        businessFax: businessFax ?? this.businessFax,
        businessWeb: businessWeb ?? this.businessWeb,
        otherEmail: otherEmail ?? this.otherEmail,
        notes: notes ?? this.notes,
        birthDay: birthDay ?? this.birthDay,
        birthMonth: birthMonth ?? this.birthMonth,
        birthYear: birthYear ?? this.birthYear,
        auto: auto ?? this.auto,
        frequency: frequency ?? this.frequency,
        dateModified: dateModified ?? this.dateModified,
        davContactsUid: davContactsUid ?? this.davContactsUid,
        davContactsVCardUid: davContactsVCardUid ?? this.davContactsVCardUid,
        groupUUIDs: groupUUIDs ?? this.groupUUIDs,
      );
  @override
  String toString() {
    return (StringBuffer('ContactsTable(')
          ..write('localId: $localId, ')
          ..write('uuidPlusStorage: $uuidPlusStorage, ')
          ..write('uuid: $uuid, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('entityId: $entityId, ')
          ..write('parentUuid: $parentUuid, ')
          ..write('eTag: $eTag, ')
          ..write('idUser: $idUser, ')
          ..write('idTenant: $idTenant, ')
          ..write('storage: $storage, ')
          ..write('fullName: $fullName, ')
          ..write('useFriendlyName: $useFriendlyName, ')
          ..write('primaryEmail: $primaryEmail, ')
          ..write('primaryPhone: $primaryPhone, ')
          ..write('primaryAddress: $primaryAddress, ')
          ..write('viewEmail: $viewEmail, ')
          ..write('title: $title, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('nickName: $nickName, ')
          ..write('skype: $skype, ')
          ..write('facebook: $facebook, ')
          ..write('personalEmail: $personalEmail, ')
          ..write('personalAddress: $personalAddress, ')
          ..write('personalCity: $personalCity, ')
          ..write('personalState: $personalState, ')
          ..write('personalZip: $personalZip, ')
          ..write('personalCountry: $personalCountry, ')
          ..write('personalWeb: $personalWeb, ')
          ..write('personalFax: $personalFax, ')
          ..write('personalPhone: $personalPhone, ')
          ..write('personalMobile: $personalMobile, ')
          ..write('businessEmail: $businessEmail, ')
          ..write('businessCompany: $businessCompany, ')
          ..write('businessAddress: $businessAddress, ')
          ..write('businessCity: $businessCity, ')
          ..write('businessState: $businessState, ')
          ..write('businessZip: $businessZip, ')
          ..write('businessCountry: $businessCountry, ')
          ..write('businessJobTitle: $businessJobTitle, ')
          ..write('businessDepartment: $businessDepartment, ')
          ..write('businessOffice: $businessOffice, ')
          ..write('businessPhone: $businessPhone, ')
          ..write('businessFax: $businessFax, ')
          ..write('businessWeb: $businessWeb, ')
          ..write('otherEmail: $otherEmail, ')
          ..write('notes: $notes, ')
          ..write('birthDay: $birthDay, ')
          ..write('birthMonth: $birthMonth, ')
          ..write('birthYear: $birthYear, ')
          ..write('auto: $auto, ')
          ..write('frequency: $frequency, ')
          ..write('dateModified: $dateModified, ')
          ..write('davContactsUid: $davContactsUid, ')
          ..write('davContactsVCardUid: $davContactsVCardUid, ')
          ..write('groupUUIDs: $groupUUIDs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      localId.hashCode,
      $mrjc(
          uuidPlusStorage.hashCode,
          $mrjc(
              uuid.hashCode,
              $mrjc(
                  userLocalId.hashCode,
                  $mrjc(
                      entityId.hashCode,
                      $mrjc(
                          parentUuid.hashCode,
                          $mrjc(
                              eTag.hashCode,
                              $mrjc(
                                  idUser.hashCode,
                                  $mrjc(
                                      idTenant.hashCode,
                                      $mrjc(
                                          storage.hashCode,
                                          $mrjc(
                                              fullName.hashCode,
                                              $mrjc(
                                                  useFriendlyName.hashCode,
                                                  $mrjc(
                                                      primaryEmail.hashCode,
                                                      $mrjc(
                                                          primaryPhone.hashCode,
                                                          $mrjc(
                                                              primaryAddress
                                                                  .hashCode,
                                                              $mrjc(
                                                                  viewEmail
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      title
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          firstName
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              lastName.hashCode,
                                                                              $mrjc(nickName.hashCode, $mrjc(skype.hashCode, $mrjc(facebook.hashCode, $mrjc(personalEmail.hashCode, $mrjc(personalAddress.hashCode, $mrjc(personalCity.hashCode, $mrjc(personalState.hashCode, $mrjc(personalZip.hashCode, $mrjc(personalCountry.hashCode, $mrjc(personalWeb.hashCode, $mrjc(personalFax.hashCode, $mrjc(personalPhone.hashCode, $mrjc(personalMobile.hashCode, $mrjc(businessEmail.hashCode, $mrjc(businessCompany.hashCode, $mrjc(businessAddress.hashCode, $mrjc(businessCity.hashCode, $mrjc(businessState.hashCode, $mrjc(businessZip.hashCode, $mrjc(businessCountry.hashCode, $mrjc(businessJobTitle.hashCode, $mrjc(businessDepartment.hashCode, $mrjc(businessOffice.hashCode, $mrjc(businessPhone.hashCode, $mrjc(businessFax.hashCode, $mrjc(businessWeb.hashCode, $mrjc(otherEmail.hashCode, $mrjc(notes.hashCode, $mrjc(birthDay.hashCode, $mrjc(birthMonth.hashCode, $mrjc(birthYear.hashCode, $mrjc(auto.hashCode, $mrjc(frequency.hashCode, $mrjc(dateModified.hashCode, $mrjc(davContactsUid.hashCode, $mrjc(davContactsVCardUid.hashCode, groupUUIDs.hashCode))))))))))))))))))))))))))))))))))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ContactsTable &&
          other.localId == this.localId &&
          other.uuidPlusStorage == this.uuidPlusStorage &&
          other.uuid == this.uuid &&
          other.userLocalId == this.userLocalId &&
          other.entityId == this.entityId &&
          other.parentUuid == this.parentUuid &&
          other.eTag == this.eTag &&
          other.idUser == this.idUser &&
          other.idTenant == this.idTenant &&
          other.storage == this.storage &&
          other.fullName == this.fullName &&
          other.useFriendlyName == this.useFriendlyName &&
          other.primaryEmail == this.primaryEmail &&
          other.primaryPhone == this.primaryPhone &&
          other.primaryAddress == this.primaryAddress &&
          other.viewEmail == this.viewEmail &&
          other.title == this.title &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.nickName == this.nickName &&
          other.skype == this.skype &&
          other.facebook == this.facebook &&
          other.personalEmail == this.personalEmail &&
          other.personalAddress == this.personalAddress &&
          other.personalCity == this.personalCity &&
          other.personalState == this.personalState &&
          other.personalZip == this.personalZip &&
          other.personalCountry == this.personalCountry &&
          other.personalWeb == this.personalWeb &&
          other.personalFax == this.personalFax &&
          other.personalPhone == this.personalPhone &&
          other.personalMobile == this.personalMobile &&
          other.businessEmail == this.businessEmail &&
          other.businessCompany == this.businessCompany &&
          other.businessAddress == this.businessAddress &&
          other.businessCity == this.businessCity &&
          other.businessState == this.businessState &&
          other.businessZip == this.businessZip &&
          other.businessCountry == this.businessCountry &&
          other.businessJobTitle == this.businessJobTitle &&
          other.businessDepartment == this.businessDepartment &&
          other.businessOffice == this.businessOffice &&
          other.businessPhone == this.businessPhone &&
          other.businessFax == this.businessFax &&
          other.businessWeb == this.businessWeb &&
          other.otherEmail == this.otherEmail &&
          other.notes == this.notes &&
          other.birthDay == this.birthDay &&
          other.birthMonth == this.birthMonth &&
          other.birthYear == this.birthYear &&
          other.auto == this.auto &&
          other.frequency == this.frequency &&
          other.dateModified == this.dateModified &&
          other.davContactsUid == this.davContactsUid &&
          other.davContactsVCardUid == this.davContactsVCardUid &&
          other.groupUUIDs == this.groupUUIDs);
}

class ContactsCompanion extends UpdateCompanion<ContactsTable> {
  final Value<int> localId;
  final Value<String> uuidPlusStorage;
  final Value<String> uuid;
  final Value<int> userLocalId;
  final Value<int> entityId;
  final Value<String> parentUuid;
  final Value<String> eTag;
  final Value<int> idUser;
  final Value<int> idTenant;
  final Value<String> storage;
  final Value<String> fullName;
  final Value<bool> useFriendlyName;
  final Value<int> primaryEmail;
  final Value<int> primaryPhone;
  final Value<int> primaryAddress;
  final Value<String> viewEmail;
  final Value<String> title;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> nickName;
  final Value<String> skype;
  final Value<String> facebook;
  final Value<String> personalEmail;
  final Value<String> personalAddress;
  final Value<String> personalCity;
  final Value<String> personalState;
  final Value<String> personalZip;
  final Value<String> personalCountry;
  final Value<String> personalWeb;
  final Value<String> personalFax;
  final Value<String> personalPhone;
  final Value<String> personalMobile;
  final Value<String> businessEmail;
  final Value<String> businessCompany;
  final Value<String> businessAddress;
  final Value<String> businessCity;
  final Value<String> businessState;
  final Value<String> businessZip;
  final Value<String> businessCountry;
  final Value<String> businessJobTitle;
  final Value<String> businessDepartment;
  final Value<String> businessOffice;
  final Value<String> businessPhone;
  final Value<String> businessFax;
  final Value<String> businessWeb;
  final Value<String> otherEmail;
  final Value<String> notes;
  final Value<int> birthDay;
  final Value<int> birthMonth;
  final Value<int> birthYear;
  final Value<bool> auto;
  final Value<int> frequency;
  final Value<String> dateModified;
  final Value<String> davContactsUid;
  final Value<String> davContactsVCardUid;
  final Value<List<String>> groupUUIDs;
  const ContactsCompanion({
    this.localId = const Value.absent(),
    this.uuidPlusStorage = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.entityId = const Value.absent(),
    this.parentUuid = const Value.absent(),
    this.eTag = const Value.absent(),
    this.idUser = const Value.absent(),
    this.idTenant = const Value.absent(),
    this.storage = const Value.absent(),
    this.fullName = const Value.absent(),
    this.useFriendlyName = const Value.absent(),
    this.primaryEmail = const Value.absent(),
    this.primaryPhone = const Value.absent(),
    this.primaryAddress = const Value.absent(),
    this.viewEmail = const Value.absent(),
    this.title = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.nickName = const Value.absent(),
    this.skype = const Value.absent(),
    this.facebook = const Value.absent(),
    this.personalEmail = const Value.absent(),
    this.personalAddress = const Value.absent(),
    this.personalCity = const Value.absent(),
    this.personalState = const Value.absent(),
    this.personalZip = const Value.absent(),
    this.personalCountry = const Value.absent(),
    this.personalWeb = const Value.absent(),
    this.personalFax = const Value.absent(),
    this.personalPhone = const Value.absent(),
    this.personalMobile = const Value.absent(),
    this.businessEmail = const Value.absent(),
    this.businessCompany = const Value.absent(),
    this.businessAddress = const Value.absent(),
    this.businessCity = const Value.absent(),
    this.businessState = const Value.absent(),
    this.businessZip = const Value.absent(),
    this.businessCountry = const Value.absent(),
    this.businessJobTitle = const Value.absent(),
    this.businessDepartment = const Value.absent(),
    this.businessOffice = const Value.absent(),
    this.businessPhone = const Value.absent(),
    this.businessFax = const Value.absent(),
    this.businessWeb = const Value.absent(),
    this.otherEmail = const Value.absent(),
    this.notes = const Value.absent(),
    this.birthDay = const Value.absent(),
    this.birthMonth = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.auto = const Value.absent(),
    this.frequency = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.davContactsUid = const Value.absent(),
    this.davContactsVCardUid = const Value.absent(),
    this.groupUUIDs = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.localId = const Value.absent(),
    @required String uuidPlusStorage,
    @required String uuid,
    @required int userLocalId,
    this.entityId = const Value.absent(),
    this.parentUuid = const Value.absent(),
    @required String eTag,
    @required int idUser,
    this.idTenant = const Value.absent(),
    @required String storage,
    @required String fullName,
    this.useFriendlyName = const Value.absent(),
    @required int primaryEmail,
    @required int primaryPhone,
    @required int primaryAddress,
    @required String viewEmail,
    @required String title,
    @required String firstName,
    @required String lastName,
    @required String nickName,
    @required String skype,
    @required String facebook,
    @required String personalEmail,
    @required String personalAddress,
    @required String personalCity,
    @required String personalState,
    @required String personalZip,
    @required String personalCountry,
    @required String personalWeb,
    @required String personalFax,
    @required String personalPhone,
    @required String personalMobile,
    @required String businessEmail,
    @required String businessCompany,
    @required String businessAddress,
    @required String businessCity,
    @required String businessState,
    @required String businessZip,
    @required String businessCountry,
    @required String businessJobTitle,
    @required String businessDepartment,
    @required String businessOffice,
    @required String businessPhone,
    @required String businessFax,
    @required String businessWeb,
    @required String otherEmail,
    @required String notes,
    @required int birthDay,
    @required int birthMonth,
    @required int birthYear,
    this.auto = const Value.absent(),
    this.frequency = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.davContactsUid = const Value.absent(),
    this.davContactsVCardUid = const Value.absent(),
    @required List<String> groupUUIDs,
  })  : uuidPlusStorage = Value(uuidPlusStorage),
        uuid = Value(uuid),
        userLocalId = Value(userLocalId),
        eTag = Value(eTag),
        idUser = Value(idUser),
        storage = Value(storage),
        fullName = Value(fullName),
        primaryEmail = Value(primaryEmail),
        primaryPhone = Value(primaryPhone),
        primaryAddress = Value(primaryAddress),
        viewEmail = Value(viewEmail),
        title = Value(title),
        firstName = Value(firstName),
        lastName = Value(lastName),
        nickName = Value(nickName),
        skype = Value(skype),
        facebook = Value(facebook),
        personalEmail = Value(personalEmail),
        personalAddress = Value(personalAddress),
        personalCity = Value(personalCity),
        personalState = Value(personalState),
        personalZip = Value(personalZip),
        personalCountry = Value(personalCountry),
        personalWeb = Value(personalWeb),
        personalFax = Value(personalFax),
        personalPhone = Value(personalPhone),
        personalMobile = Value(personalMobile),
        businessEmail = Value(businessEmail),
        businessCompany = Value(businessCompany),
        businessAddress = Value(businessAddress),
        businessCity = Value(businessCity),
        businessState = Value(businessState),
        businessZip = Value(businessZip),
        businessCountry = Value(businessCountry),
        businessJobTitle = Value(businessJobTitle),
        businessDepartment = Value(businessDepartment),
        businessOffice = Value(businessOffice),
        businessPhone = Value(businessPhone),
        businessFax = Value(businessFax),
        businessWeb = Value(businessWeb),
        otherEmail = Value(otherEmail),
        notes = Value(notes),
        birthDay = Value(birthDay),
        birthMonth = Value(birthMonth),
        birthYear = Value(birthYear),
        groupUUIDs = Value(groupUUIDs);
  ContactsCompanion copyWith(
      {Value<int> localId,
      Value<String> uuidPlusStorage,
      Value<String> uuid,
      Value<int> userLocalId,
      Value<int> entityId,
      Value<String> parentUuid,
      Value<String> eTag,
      Value<int> idUser,
      Value<int> idTenant,
      Value<String> storage,
      Value<String> fullName,
      Value<bool> useFriendlyName,
      Value<int> primaryEmail,
      Value<int> primaryPhone,
      Value<int> primaryAddress,
      Value<String> viewEmail,
      Value<String> title,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> nickName,
      Value<String> skype,
      Value<String> facebook,
      Value<String> personalEmail,
      Value<String> personalAddress,
      Value<String> personalCity,
      Value<String> personalState,
      Value<String> personalZip,
      Value<String> personalCountry,
      Value<String> personalWeb,
      Value<String> personalFax,
      Value<String> personalPhone,
      Value<String> personalMobile,
      Value<String> businessEmail,
      Value<String> businessCompany,
      Value<String> businessAddress,
      Value<String> businessCity,
      Value<String> businessState,
      Value<String> businessZip,
      Value<String> businessCountry,
      Value<String> businessJobTitle,
      Value<String> businessDepartment,
      Value<String> businessOffice,
      Value<String> businessPhone,
      Value<String> businessFax,
      Value<String> businessWeb,
      Value<String> otherEmail,
      Value<String> notes,
      Value<int> birthDay,
      Value<int> birthMonth,
      Value<int> birthYear,
      Value<bool> auto,
      Value<int> frequency,
      Value<String> dateModified,
      Value<String> davContactsUid,
      Value<String> davContactsVCardUid,
      Value<List<String>> groupUUIDs}) {
    return ContactsCompanion(
      localId: localId ?? this.localId,
      uuidPlusStorage: uuidPlusStorage ?? this.uuidPlusStorage,
      uuid: uuid ?? this.uuid,
      userLocalId: userLocalId ?? this.userLocalId,
      entityId: entityId ?? this.entityId,
      parentUuid: parentUuid ?? this.parentUuid,
      eTag: eTag ?? this.eTag,
      idUser: idUser ?? this.idUser,
      idTenant: idTenant ?? this.idTenant,
      storage: storage ?? this.storage,
      fullName: fullName ?? this.fullName,
      useFriendlyName: useFriendlyName ?? this.useFriendlyName,
      primaryEmail: primaryEmail ?? this.primaryEmail,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      viewEmail: viewEmail ?? this.viewEmail,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickName: nickName ?? this.nickName,
      skype: skype ?? this.skype,
      facebook: facebook ?? this.facebook,
      personalEmail: personalEmail ?? this.personalEmail,
      personalAddress: personalAddress ?? this.personalAddress,
      personalCity: personalCity ?? this.personalCity,
      personalState: personalState ?? this.personalState,
      personalZip: personalZip ?? this.personalZip,
      personalCountry: personalCountry ?? this.personalCountry,
      personalWeb: personalWeb ?? this.personalWeb,
      personalFax: personalFax ?? this.personalFax,
      personalPhone: personalPhone ?? this.personalPhone,
      personalMobile: personalMobile ?? this.personalMobile,
      businessEmail: businessEmail ?? this.businessEmail,
      businessCompany: businessCompany ?? this.businessCompany,
      businessAddress: businessAddress ?? this.businessAddress,
      businessCity: businessCity ?? this.businessCity,
      businessState: businessState ?? this.businessState,
      businessZip: businessZip ?? this.businessZip,
      businessCountry: businessCountry ?? this.businessCountry,
      businessJobTitle: businessJobTitle ?? this.businessJobTitle,
      businessDepartment: businessDepartment ?? this.businessDepartment,
      businessOffice: businessOffice ?? this.businessOffice,
      businessPhone: businessPhone ?? this.businessPhone,
      businessFax: businessFax ?? this.businessFax,
      businessWeb: businessWeb ?? this.businessWeb,
      otherEmail: otherEmail ?? this.otherEmail,
      notes: notes ?? this.notes,
      birthDay: birthDay ?? this.birthDay,
      birthMonth: birthMonth ?? this.birthMonth,
      birthYear: birthYear ?? this.birthYear,
      auto: auto ?? this.auto,
      frequency: frequency ?? this.frequency,
      dateModified: dateModified ?? this.dateModified,
      davContactsUid: davContactsUid ?? this.davContactsUid,
      davContactsVCardUid: davContactsVCardUid ?? this.davContactsVCardUid,
      groupUUIDs: groupUUIDs ?? this.groupUUIDs,
    );
  }
}

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactsTable> {
  final GeneratedDatabase _db;
  final String _alias;
  $ContactsTable(this._db, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedIntColumn _localId;
  @override
  GeneratedIntColumn get localId => _localId ??= _constructLocalId();
  GeneratedIntColumn _constructLocalId() {
    return GeneratedIntColumn('local_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _uuidPlusStorageMeta =
      const VerificationMeta('uuidPlusStorage');
  GeneratedTextColumn _uuidPlusStorage;
  @override
  GeneratedTextColumn get uuidPlusStorage =>
      _uuidPlusStorage ??= _constructUuidPlusStorage();
  GeneratedTextColumn _constructUuidPlusStorage() {
    return GeneratedTextColumn(
      'uuid_plus_storage',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  @override
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn(
      'uuid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  GeneratedIntColumn _userLocalId;
  @override
  GeneratedIntColumn get userLocalId =>
      _userLocalId ??= _constructUserLocalId();
  GeneratedIntColumn _constructUserLocalId() {
    return GeneratedIntColumn(
      'user_local_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _entityIdMeta = const VerificationMeta('entityId');
  GeneratedIntColumn _entityId;
  @override
  GeneratedIntColumn get entityId => _entityId ??= _constructEntityId();
  GeneratedIntColumn _constructEntityId() {
    return GeneratedIntColumn(
      'entity_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _parentUuidMeta = const VerificationMeta('parentUuid');
  GeneratedTextColumn _parentUuid;
  @override
  GeneratedTextColumn get parentUuid => _parentUuid ??= _constructParentUuid();
  GeneratedTextColumn _constructParentUuid() {
    return GeneratedTextColumn(
      'parent_uuid',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eTagMeta = const VerificationMeta('eTag');
  GeneratedTextColumn _eTag;
  @override
  GeneratedTextColumn get eTag => _eTag ??= _constructETag();
  GeneratedTextColumn _constructETag() {
    return GeneratedTextColumn(
      'e_tag',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  GeneratedIntColumn _idUser;
  @override
  GeneratedIntColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedIntColumn _constructIdUser() {
    return GeneratedIntColumn(
      'id_user',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idTenantMeta = const VerificationMeta('idTenant');
  GeneratedIntColumn _idTenant;
  @override
  GeneratedIntColumn get idTenant => _idTenant ??= _constructIdTenant();
  GeneratedIntColumn _constructIdTenant() {
    return GeneratedIntColumn(
      'id_tenant',
      $tableName,
      true,
    );
  }

  final VerificationMeta _storageMeta = const VerificationMeta('storage');
  GeneratedTextColumn _storage;
  @override
  GeneratedTextColumn get storage => _storage ??= _constructStorage();
  GeneratedTextColumn _constructStorage() {
    return GeneratedTextColumn(
      'storage',
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

  final VerificationMeta _useFriendlyNameMeta =
      const VerificationMeta('useFriendlyName');
  GeneratedBoolColumn _useFriendlyName;
  @override
  GeneratedBoolColumn get useFriendlyName =>
      _useFriendlyName ??= _constructUseFriendlyName();
  GeneratedBoolColumn _constructUseFriendlyName() {
    return GeneratedBoolColumn(
      'use_friendly_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _primaryEmailMeta =
      const VerificationMeta('primaryEmail');
  GeneratedIntColumn _primaryEmail;
  @override
  GeneratedIntColumn get primaryEmail =>
      _primaryEmail ??= _constructPrimaryEmail();
  GeneratedIntColumn _constructPrimaryEmail() {
    return GeneratedIntColumn(
      'primary_email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _primaryPhoneMeta =
      const VerificationMeta('primaryPhone');
  GeneratedIntColumn _primaryPhone;
  @override
  GeneratedIntColumn get primaryPhone =>
      _primaryPhone ??= _constructPrimaryPhone();
  GeneratedIntColumn _constructPrimaryPhone() {
    return GeneratedIntColumn(
      'primary_phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _primaryAddressMeta =
      const VerificationMeta('primaryAddress');
  GeneratedIntColumn _primaryAddress;
  @override
  GeneratedIntColumn get primaryAddress =>
      _primaryAddress ??= _constructPrimaryAddress();
  GeneratedIntColumn _constructPrimaryAddress() {
    return GeneratedIntColumn(
      'primary_address',
      $tableName,
      false,
    );
  }

  final VerificationMeta _viewEmailMeta = const VerificationMeta('viewEmail');
  GeneratedTextColumn _viewEmail;
  @override
  GeneratedTextColumn get viewEmail => _viewEmail ??= _constructViewEmail();
  GeneratedTextColumn _constructViewEmail() {
    return GeneratedTextColumn(
      'view_email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  GeneratedTextColumn _firstName;
  @override
  GeneratedTextColumn get firstName => _firstName ??= _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  GeneratedTextColumn _lastName;
  @override
  GeneratedTextColumn get lastName => _lastName ??= _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nickNameMeta = const VerificationMeta('nickName');
  GeneratedTextColumn _nickName;
  @override
  GeneratedTextColumn get nickName => _nickName ??= _constructNickName();
  GeneratedTextColumn _constructNickName() {
    return GeneratedTextColumn(
      'nick_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _skypeMeta = const VerificationMeta('skype');
  GeneratedTextColumn _skype;
  @override
  GeneratedTextColumn get skype => _skype ??= _constructSkype();
  GeneratedTextColumn _constructSkype() {
    return GeneratedTextColumn(
      'skype',
      $tableName,
      false,
    );
  }

  final VerificationMeta _facebookMeta = const VerificationMeta('facebook');
  GeneratedTextColumn _facebook;
  @override
  GeneratedTextColumn get facebook => _facebook ??= _constructFacebook();
  GeneratedTextColumn _constructFacebook() {
    return GeneratedTextColumn(
      'facebook',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalEmailMeta =
      const VerificationMeta('personalEmail');
  GeneratedTextColumn _personalEmail;
  @override
  GeneratedTextColumn get personalEmail =>
      _personalEmail ??= _constructPersonalEmail();
  GeneratedTextColumn _constructPersonalEmail() {
    return GeneratedTextColumn(
      'personal_email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalAddressMeta =
      const VerificationMeta('personalAddress');
  GeneratedTextColumn _personalAddress;
  @override
  GeneratedTextColumn get personalAddress =>
      _personalAddress ??= _constructPersonalAddress();
  GeneratedTextColumn _constructPersonalAddress() {
    return GeneratedTextColumn(
      'personal_address',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalCityMeta =
      const VerificationMeta('personalCity');
  GeneratedTextColumn _personalCity;
  @override
  GeneratedTextColumn get personalCity =>
      _personalCity ??= _constructPersonalCity();
  GeneratedTextColumn _constructPersonalCity() {
    return GeneratedTextColumn(
      'personal_city',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalStateMeta =
      const VerificationMeta('personalState');
  GeneratedTextColumn _personalState;
  @override
  GeneratedTextColumn get personalState =>
      _personalState ??= _constructPersonalState();
  GeneratedTextColumn _constructPersonalState() {
    return GeneratedTextColumn(
      'personal_state',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalZipMeta =
      const VerificationMeta('personalZip');
  GeneratedTextColumn _personalZip;
  @override
  GeneratedTextColumn get personalZip =>
      _personalZip ??= _constructPersonalZip();
  GeneratedTextColumn _constructPersonalZip() {
    return GeneratedTextColumn(
      'personal_zip',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalCountryMeta =
      const VerificationMeta('personalCountry');
  GeneratedTextColumn _personalCountry;
  @override
  GeneratedTextColumn get personalCountry =>
      _personalCountry ??= _constructPersonalCountry();
  GeneratedTextColumn _constructPersonalCountry() {
    return GeneratedTextColumn(
      'personal_country',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalWebMeta =
      const VerificationMeta('personalWeb');
  GeneratedTextColumn _personalWeb;
  @override
  GeneratedTextColumn get personalWeb =>
      _personalWeb ??= _constructPersonalWeb();
  GeneratedTextColumn _constructPersonalWeb() {
    return GeneratedTextColumn(
      'personal_web',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalFaxMeta =
      const VerificationMeta('personalFax');
  GeneratedTextColumn _personalFax;
  @override
  GeneratedTextColumn get personalFax =>
      _personalFax ??= _constructPersonalFax();
  GeneratedTextColumn _constructPersonalFax() {
    return GeneratedTextColumn(
      'personal_fax',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalPhoneMeta =
      const VerificationMeta('personalPhone');
  GeneratedTextColumn _personalPhone;
  @override
  GeneratedTextColumn get personalPhone =>
      _personalPhone ??= _constructPersonalPhone();
  GeneratedTextColumn _constructPersonalPhone() {
    return GeneratedTextColumn(
      'personal_phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personalMobileMeta =
      const VerificationMeta('personalMobile');
  GeneratedTextColumn _personalMobile;
  @override
  GeneratedTextColumn get personalMobile =>
      _personalMobile ??= _constructPersonalMobile();
  GeneratedTextColumn _constructPersonalMobile() {
    return GeneratedTextColumn(
      'personal_mobile',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessEmailMeta =
      const VerificationMeta('businessEmail');
  GeneratedTextColumn _businessEmail;
  @override
  GeneratedTextColumn get businessEmail =>
      _businessEmail ??= _constructBusinessEmail();
  GeneratedTextColumn _constructBusinessEmail() {
    return GeneratedTextColumn(
      'business_email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessCompanyMeta =
      const VerificationMeta('businessCompany');
  GeneratedTextColumn _businessCompany;
  @override
  GeneratedTextColumn get businessCompany =>
      _businessCompany ??= _constructBusinessCompany();
  GeneratedTextColumn _constructBusinessCompany() {
    return GeneratedTextColumn(
      'business_company',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessAddressMeta =
      const VerificationMeta('businessAddress');
  GeneratedTextColumn _businessAddress;
  @override
  GeneratedTextColumn get businessAddress =>
      _businessAddress ??= _constructBusinessAddress();
  GeneratedTextColumn _constructBusinessAddress() {
    return GeneratedTextColumn(
      'business_address',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessCityMeta =
      const VerificationMeta('businessCity');
  GeneratedTextColumn _businessCity;
  @override
  GeneratedTextColumn get businessCity =>
      _businessCity ??= _constructBusinessCity();
  GeneratedTextColumn _constructBusinessCity() {
    return GeneratedTextColumn(
      'business_city',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessStateMeta =
      const VerificationMeta('businessState');
  GeneratedTextColumn _businessState;
  @override
  GeneratedTextColumn get businessState =>
      _businessState ??= _constructBusinessState();
  GeneratedTextColumn _constructBusinessState() {
    return GeneratedTextColumn(
      'business_state',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessZipMeta =
      const VerificationMeta('businessZip');
  GeneratedTextColumn _businessZip;
  @override
  GeneratedTextColumn get businessZip =>
      _businessZip ??= _constructBusinessZip();
  GeneratedTextColumn _constructBusinessZip() {
    return GeneratedTextColumn(
      'business_zip',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessCountryMeta =
      const VerificationMeta('businessCountry');
  GeneratedTextColumn _businessCountry;
  @override
  GeneratedTextColumn get businessCountry =>
      _businessCountry ??= _constructBusinessCountry();
  GeneratedTextColumn _constructBusinessCountry() {
    return GeneratedTextColumn(
      'business_country',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessJobTitleMeta =
      const VerificationMeta('businessJobTitle');
  GeneratedTextColumn _businessJobTitle;
  @override
  GeneratedTextColumn get businessJobTitle =>
      _businessJobTitle ??= _constructBusinessJobTitle();
  GeneratedTextColumn _constructBusinessJobTitle() {
    return GeneratedTextColumn(
      'business_job_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessDepartmentMeta =
      const VerificationMeta('businessDepartment');
  GeneratedTextColumn _businessDepartment;
  @override
  GeneratedTextColumn get businessDepartment =>
      _businessDepartment ??= _constructBusinessDepartment();
  GeneratedTextColumn _constructBusinessDepartment() {
    return GeneratedTextColumn(
      'business_department',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessOfficeMeta =
      const VerificationMeta('businessOffice');
  GeneratedTextColumn _businessOffice;
  @override
  GeneratedTextColumn get businessOffice =>
      _businessOffice ??= _constructBusinessOffice();
  GeneratedTextColumn _constructBusinessOffice() {
    return GeneratedTextColumn(
      'business_office',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessPhoneMeta =
      const VerificationMeta('businessPhone');
  GeneratedTextColumn _businessPhone;
  @override
  GeneratedTextColumn get businessPhone =>
      _businessPhone ??= _constructBusinessPhone();
  GeneratedTextColumn _constructBusinessPhone() {
    return GeneratedTextColumn(
      'business_phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessFaxMeta =
      const VerificationMeta('businessFax');
  GeneratedTextColumn _businessFax;
  @override
  GeneratedTextColumn get businessFax =>
      _businessFax ??= _constructBusinessFax();
  GeneratedTextColumn _constructBusinessFax() {
    return GeneratedTextColumn(
      'business_fax',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessWebMeta =
      const VerificationMeta('businessWeb');
  GeneratedTextColumn _businessWeb;
  @override
  GeneratedTextColumn get businessWeb =>
      _businessWeb ??= _constructBusinessWeb();
  GeneratedTextColumn _constructBusinessWeb() {
    return GeneratedTextColumn(
      'business_web',
      $tableName,
      false,
    );
  }

  final VerificationMeta _otherEmailMeta = const VerificationMeta('otherEmail');
  GeneratedTextColumn _otherEmail;
  @override
  GeneratedTextColumn get otherEmail => _otherEmail ??= _constructOtherEmail();
  GeneratedTextColumn _constructOtherEmail() {
    return GeneratedTextColumn(
      'other_email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      false,
    );
  }

  final VerificationMeta _birthDayMeta = const VerificationMeta('birthDay');
  GeneratedIntColumn _birthDay;
  @override
  GeneratedIntColumn get birthDay => _birthDay ??= _constructBirthDay();
  GeneratedIntColumn _constructBirthDay() {
    return GeneratedIntColumn(
      'birth_day',
      $tableName,
      false,
    );
  }

  final VerificationMeta _birthMonthMeta = const VerificationMeta('birthMonth');
  GeneratedIntColumn _birthMonth;
  @override
  GeneratedIntColumn get birthMonth => _birthMonth ??= _constructBirthMonth();
  GeneratedIntColumn _constructBirthMonth() {
    return GeneratedIntColumn(
      'birth_month',
      $tableName,
      false,
    );
  }

  final VerificationMeta _birthYearMeta = const VerificationMeta('birthYear');
  GeneratedIntColumn _birthYear;
  @override
  GeneratedIntColumn get birthYear => _birthYear ??= _constructBirthYear();
  GeneratedIntColumn _constructBirthYear() {
    return GeneratedIntColumn(
      'birth_year',
      $tableName,
      false,
    );
  }

  final VerificationMeta _autoMeta = const VerificationMeta('auto');
  GeneratedBoolColumn _auto;
  @override
  GeneratedBoolColumn get auto => _auto ??= _constructAuto();
  GeneratedBoolColumn _constructAuto() {
    return GeneratedBoolColumn(
      'auto',
      $tableName,
      true,
    );
  }

  final VerificationMeta _frequencyMeta = const VerificationMeta('frequency');
  GeneratedIntColumn _frequency;
  @override
  GeneratedIntColumn get frequency => _frequency ??= _constructFrequency();
  GeneratedIntColumn _constructFrequency() {
    return GeneratedIntColumn('frequency', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _dateModifiedMeta =
      const VerificationMeta('dateModified');
  GeneratedTextColumn _dateModified;
  @override
  GeneratedTextColumn get dateModified =>
      _dateModified ??= _constructDateModified();
  GeneratedTextColumn _constructDateModified() {
    return GeneratedTextColumn(
      'date_modified',
      $tableName,
      true,
    );
  }

  final VerificationMeta _davContactsUidMeta =
      const VerificationMeta('davContactsUid');
  GeneratedTextColumn _davContactsUid;
  @override
  GeneratedTextColumn get davContactsUid =>
      _davContactsUid ??= _constructDavContactsUid();
  GeneratedTextColumn _constructDavContactsUid() {
    return GeneratedTextColumn(
      'dav_contacts_uid',
      $tableName,
      true,
    );
  }

  final VerificationMeta _davContactsVCardUidMeta =
      const VerificationMeta('davContactsVCardUid');
  GeneratedTextColumn _davContactsVCardUid;
  @override
  GeneratedTextColumn get davContactsVCardUid =>
      _davContactsVCardUid ??= _constructDavContactsVCardUid();
  GeneratedTextColumn _constructDavContactsVCardUid() {
    return GeneratedTextColumn(
      'dav_contacts_v_card_uid',
      $tableName,
      true,
    );
  }

  final VerificationMeta _groupUUIDsMeta = const VerificationMeta('groupUUIDs');
  GeneratedTextColumn _groupUUIDs;
  @override
  GeneratedTextColumn get groupUUIDs => _groupUUIDs ??= _constructGroupUUIDs();
  GeneratedTextColumn _constructGroupUUIDs() {
    return GeneratedTextColumn(
      'group_u_u_i_ds',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        localId,
        uuidPlusStorage,
        uuid,
        userLocalId,
        entityId,
        parentUuid,
        eTag,
        idUser,
        idTenant,
        storage,
        fullName,
        useFriendlyName,
        primaryEmail,
        primaryPhone,
        primaryAddress,
        viewEmail,
        title,
        firstName,
        lastName,
        nickName,
        skype,
        facebook,
        personalEmail,
        personalAddress,
        personalCity,
        personalState,
        personalZip,
        personalCountry,
        personalWeb,
        personalFax,
        personalPhone,
        personalMobile,
        businessEmail,
        businessCompany,
        businessAddress,
        businessCity,
        businessState,
        businessZip,
        businessCountry,
        businessJobTitle,
        businessDepartment,
        businessOffice,
        businessPhone,
        businessFax,
        businessWeb,
        otherEmail,
        notes,
        birthDay,
        birthMonth,
        birthYear,
        auto,
        frequency,
        dateModified,
        davContactsUid,
        davContactsVCardUid,
        groupUUIDs
      ];
  @override
  $ContactsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'contacts';
  @override
  final String actualTableName = 'contacts';
  @override
  VerificationContext validateIntegrity(ContactsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    }
    if (d.uuidPlusStorage.present) {
      context.handle(
          _uuidPlusStorageMeta,
          uuidPlusStorage.isAcceptableValue(
              d.uuidPlusStorage.value, _uuidPlusStorageMeta));
    } else if (isInserting) {
      context.missing(_uuidPlusStorageMeta);
    }
    if (d.uuid.present) {
      context.handle(
          _uuidMeta, uuid.isAcceptableValue(d.uuid.value, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (d.userLocalId.present) {
      context.handle(_userLocalIdMeta,
          userLocalId.isAcceptableValue(d.userLocalId.value, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (d.entityId.present) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableValue(d.entityId.value, _entityIdMeta));
    }
    if (d.parentUuid.present) {
      context.handle(_parentUuidMeta,
          parentUuid.isAcceptableValue(d.parentUuid.value, _parentUuidMeta));
    }
    if (d.eTag.present) {
      context.handle(
          _eTagMeta, eTag.isAcceptableValue(d.eTag.value, _eTagMeta));
    } else if (isInserting) {
      context.missing(_eTagMeta);
    }
    if (d.idUser.present) {
      context.handle(
          _idUserMeta, idUser.isAcceptableValue(d.idUser.value, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (d.idTenant.present) {
      context.handle(_idTenantMeta,
          idTenant.isAcceptableValue(d.idTenant.value, _idTenantMeta));
    }
    if (d.storage.present) {
      context.handle(_storageMeta,
          storage.isAcceptableValue(d.storage.value, _storageMeta));
    } else if (isInserting) {
      context.missing(_storageMeta);
    }
    if (d.fullName.present) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableValue(d.fullName.value, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (d.useFriendlyName.present) {
      context.handle(
          _useFriendlyNameMeta,
          useFriendlyName.isAcceptableValue(
              d.useFriendlyName.value, _useFriendlyNameMeta));
    }
    if (d.primaryEmail.present) {
      context.handle(
          _primaryEmailMeta,
          primaryEmail.isAcceptableValue(
              d.primaryEmail.value, _primaryEmailMeta));
    } else if (isInserting) {
      context.missing(_primaryEmailMeta);
    }
    if (d.primaryPhone.present) {
      context.handle(
          _primaryPhoneMeta,
          primaryPhone.isAcceptableValue(
              d.primaryPhone.value, _primaryPhoneMeta));
    } else if (isInserting) {
      context.missing(_primaryPhoneMeta);
    }
    if (d.primaryAddress.present) {
      context.handle(
          _primaryAddressMeta,
          primaryAddress.isAcceptableValue(
              d.primaryAddress.value, _primaryAddressMeta));
    } else if (isInserting) {
      context.missing(_primaryAddressMeta);
    }
    if (d.viewEmail.present) {
      context.handle(_viewEmailMeta,
          viewEmail.isAcceptableValue(d.viewEmail.value, _viewEmailMeta));
    } else if (isInserting) {
      context.missing(_viewEmailMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (d.firstName.present) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableValue(d.firstName.value, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (d.lastName.present) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableValue(d.lastName.value, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (d.nickName.present) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableValue(d.nickName.value, _nickNameMeta));
    } else if (isInserting) {
      context.missing(_nickNameMeta);
    }
    if (d.skype.present) {
      context.handle(
          _skypeMeta, skype.isAcceptableValue(d.skype.value, _skypeMeta));
    } else if (isInserting) {
      context.missing(_skypeMeta);
    }
    if (d.facebook.present) {
      context.handle(_facebookMeta,
          facebook.isAcceptableValue(d.facebook.value, _facebookMeta));
    } else if (isInserting) {
      context.missing(_facebookMeta);
    }
    if (d.personalEmail.present) {
      context.handle(
          _personalEmailMeta,
          personalEmail.isAcceptableValue(
              d.personalEmail.value, _personalEmailMeta));
    } else if (isInserting) {
      context.missing(_personalEmailMeta);
    }
    if (d.personalAddress.present) {
      context.handle(
          _personalAddressMeta,
          personalAddress.isAcceptableValue(
              d.personalAddress.value, _personalAddressMeta));
    } else if (isInserting) {
      context.missing(_personalAddressMeta);
    }
    if (d.personalCity.present) {
      context.handle(
          _personalCityMeta,
          personalCity.isAcceptableValue(
              d.personalCity.value, _personalCityMeta));
    } else if (isInserting) {
      context.missing(_personalCityMeta);
    }
    if (d.personalState.present) {
      context.handle(
          _personalStateMeta,
          personalState.isAcceptableValue(
              d.personalState.value, _personalStateMeta));
    } else if (isInserting) {
      context.missing(_personalStateMeta);
    }
    if (d.personalZip.present) {
      context.handle(_personalZipMeta,
          personalZip.isAcceptableValue(d.personalZip.value, _personalZipMeta));
    } else if (isInserting) {
      context.missing(_personalZipMeta);
    }
    if (d.personalCountry.present) {
      context.handle(
          _personalCountryMeta,
          personalCountry.isAcceptableValue(
              d.personalCountry.value, _personalCountryMeta));
    } else if (isInserting) {
      context.missing(_personalCountryMeta);
    }
    if (d.personalWeb.present) {
      context.handle(_personalWebMeta,
          personalWeb.isAcceptableValue(d.personalWeb.value, _personalWebMeta));
    } else if (isInserting) {
      context.missing(_personalWebMeta);
    }
    if (d.personalFax.present) {
      context.handle(_personalFaxMeta,
          personalFax.isAcceptableValue(d.personalFax.value, _personalFaxMeta));
    } else if (isInserting) {
      context.missing(_personalFaxMeta);
    }
    if (d.personalPhone.present) {
      context.handle(
          _personalPhoneMeta,
          personalPhone.isAcceptableValue(
              d.personalPhone.value, _personalPhoneMeta));
    } else if (isInserting) {
      context.missing(_personalPhoneMeta);
    }
    if (d.personalMobile.present) {
      context.handle(
          _personalMobileMeta,
          personalMobile.isAcceptableValue(
              d.personalMobile.value, _personalMobileMeta));
    } else if (isInserting) {
      context.missing(_personalMobileMeta);
    }
    if (d.businessEmail.present) {
      context.handle(
          _businessEmailMeta,
          businessEmail.isAcceptableValue(
              d.businessEmail.value, _businessEmailMeta));
    } else if (isInserting) {
      context.missing(_businessEmailMeta);
    }
    if (d.businessCompany.present) {
      context.handle(
          _businessCompanyMeta,
          businessCompany.isAcceptableValue(
              d.businessCompany.value, _businessCompanyMeta));
    } else if (isInserting) {
      context.missing(_businessCompanyMeta);
    }
    if (d.businessAddress.present) {
      context.handle(
          _businessAddressMeta,
          businessAddress.isAcceptableValue(
              d.businessAddress.value, _businessAddressMeta));
    } else if (isInserting) {
      context.missing(_businessAddressMeta);
    }
    if (d.businessCity.present) {
      context.handle(
          _businessCityMeta,
          businessCity.isAcceptableValue(
              d.businessCity.value, _businessCityMeta));
    } else if (isInserting) {
      context.missing(_businessCityMeta);
    }
    if (d.businessState.present) {
      context.handle(
          _businessStateMeta,
          businessState.isAcceptableValue(
              d.businessState.value, _businessStateMeta));
    } else if (isInserting) {
      context.missing(_businessStateMeta);
    }
    if (d.businessZip.present) {
      context.handle(_businessZipMeta,
          businessZip.isAcceptableValue(d.businessZip.value, _businessZipMeta));
    } else if (isInserting) {
      context.missing(_businessZipMeta);
    }
    if (d.businessCountry.present) {
      context.handle(
          _businessCountryMeta,
          businessCountry.isAcceptableValue(
              d.businessCountry.value, _businessCountryMeta));
    } else if (isInserting) {
      context.missing(_businessCountryMeta);
    }
    if (d.businessJobTitle.present) {
      context.handle(
          _businessJobTitleMeta,
          businessJobTitle.isAcceptableValue(
              d.businessJobTitle.value, _businessJobTitleMeta));
    } else if (isInserting) {
      context.missing(_businessJobTitleMeta);
    }
    if (d.businessDepartment.present) {
      context.handle(
          _businessDepartmentMeta,
          businessDepartment.isAcceptableValue(
              d.businessDepartment.value, _businessDepartmentMeta));
    } else if (isInserting) {
      context.missing(_businessDepartmentMeta);
    }
    if (d.businessOffice.present) {
      context.handle(
          _businessOfficeMeta,
          businessOffice.isAcceptableValue(
              d.businessOffice.value, _businessOfficeMeta));
    } else if (isInserting) {
      context.missing(_businessOfficeMeta);
    }
    if (d.businessPhone.present) {
      context.handle(
          _businessPhoneMeta,
          businessPhone.isAcceptableValue(
              d.businessPhone.value, _businessPhoneMeta));
    } else if (isInserting) {
      context.missing(_businessPhoneMeta);
    }
    if (d.businessFax.present) {
      context.handle(_businessFaxMeta,
          businessFax.isAcceptableValue(d.businessFax.value, _businessFaxMeta));
    } else if (isInserting) {
      context.missing(_businessFaxMeta);
    }
    if (d.businessWeb.present) {
      context.handle(_businessWebMeta,
          businessWeb.isAcceptableValue(d.businessWeb.value, _businessWebMeta));
    } else if (isInserting) {
      context.missing(_businessWebMeta);
    }
    if (d.otherEmail.present) {
      context.handle(_otherEmailMeta,
          otherEmail.isAcceptableValue(d.otherEmail.value, _otherEmailMeta));
    } else if (isInserting) {
      context.missing(_otherEmailMeta);
    }
    if (d.notes.present) {
      context.handle(
          _notesMeta, notes.isAcceptableValue(d.notes.value, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (d.birthDay.present) {
      context.handle(_birthDayMeta,
          birthDay.isAcceptableValue(d.birthDay.value, _birthDayMeta));
    } else if (isInserting) {
      context.missing(_birthDayMeta);
    }
    if (d.birthMonth.present) {
      context.handle(_birthMonthMeta,
          birthMonth.isAcceptableValue(d.birthMonth.value, _birthMonthMeta));
    } else if (isInserting) {
      context.missing(_birthMonthMeta);
    }
    if (d.birthYear.present) {
      context.handle(_birthYearMeta,
          birthYear.isAcceptableValue(d.birthYear.value, _birthYearMeta));
    } else if (isInserting) {
      context.missing(_birthYearMeta);
    }
    if (d.auto.present) {
      context.handle(
          _autoMeta, auto.isAcceptableValue(d.auto.value, _autoMeta));
    }
    if (d.frequency.present) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableValue(d.frequency.value, _frequencyMeta));
    }
    if (d.dateModified.present) {
      context.handle(
          _dateModifiedMeta,
          dateModified.isAcceptableValue(
              d.dateModified.value, _dateModifiedMeta));
    }
    if (d.davContactsUid.present) {
      context.handle(
          _davContactsUidMeta,
          davContactsUid.isAcceptableValue(
              d.davContactsUid.value, _davContactsUidMeta));
    }
    if (d.davContactsVCardUid.present) {
      context.handle(
          _davContactsVCardUidMeta,
          davContactsVCardUid.isAcceptableValue(
              d.davContactsVCardUid.value, _davContactsVCardUidMeta));
    }
    context.handle(_groupUUIDsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  ContactsTable map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ContactsTable.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ContactsCompanion d) {
    final map = <String, Variable>{};
    if (d.localId.present) {
      map['local_id'] = Variable<int, IntType>(d.localId.value);
    }
    if (d.uuidPlusStorage.present) {
      map['uuid_plus_storage'] =
          Variable<String, StringType>(d.uuidPlusStorage.value);
    }
    if (d.uuid.present) {
      map['uuid'] = Variable<String, StringType>(d.uuid.value);
    }
    if (d.userLocalId.present) {
      map['user_local_id'] = Variable<int, IntType>(d.userLocalId.value);
    }
    if (d.entityId.present) {
      map['entity_id'] = Variable<int, IntType>(d.entityId.value);
    }
    if (d.parentUuid.present) {
      map['parent_uuid'] = Variable<String, StringType>(d.parentUuid.value);
    }
    if (d.eTag.present) {
      map['e_tag'] = Variable<String, StringType>(d.eTag.value);
    }
    if (d.idUser.present) {
      map['id_user'] = Variable<int, IntType>(d.idUser.value);
    }
    if (d.idTenant.present) {
      map['id_tenant'] = Variable<int, IntType>(d.idTenant.value);
    }
    if (d.storage.present) {
      map['storage'] = Variable<String, StringType>(d.storage.value);
    }
    if (d.fullName.present) {
      map['full_name'] = Variable<String, StringType>(d.fullName.value);
    }
    if (d.useFriendlyName.present) {
      map['use_friendly_name'] =
          Variable<bool, BoolType>(d.useFriendlyName.value);
    }
    if (d.primaryEmail.present) {
      map['primary_email'] = Variable<int, IntType>(d.primaryEmail.value);
    }
    if (d.primaryPhone.present) {
      map['primary_phone'] = Variable<int, IntType>(d.primaryPhone.value);
    }
    if (d.primaryAddress.present) {
      map['primary_address'] = Variable<int, IntType>(d.primaryAddress.value);
    }
    if (d.viewEmail.present) {
      map['view_email'] = Variable<String, StringType>(d.viewEmail.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.firstName.present) {
      map['first_name'] = Variable<String, StringType>(d.firstName.value);
    }
    if (d.lastName.present) {
      map['last_name'] = Variable<String, StringType>(d.lastName.value);
    }
    if (d.nickName.present) {
      map['nick_name'] = Variable<String, StringType>(d.nickName.value);
    }
    if (d.skype.present) {
      map['skype'] = Variable<String, StringType>(d.skype.value);
    }
    if (d.facebook.present) {
      map['facebook'] = Variable<String, StringType>(d.facebook.value);
    }
    if (d.personalEmail.present) {
      map['personal_email'] =
          Variable<String, StringType>(d.personalEmail.value);
    }
    if (d.personalAddress.present) {
      map['personal_address'] =
          Variable<String, StringType>(d.personalAddress.value);
    }
    if (d.personalCity.present) {
      map['personal_city'] = Variable<String, StringType>(d.personalCity.value);
    }
    if (d.personalState.present) {
      map['personal_state'] =
          Variable<String, StringType>(d.personalState.value);
    }
    if (d.personalZip.present) {
      map['personal_zip'] = Variable<String, StringType>(d.personalZip.value);
    }
    if (d.personalCountry.present) {
      map['personal_country'] =
          Variable<String, StringType>(d.personalCountry.value);
    }
    if (d.personalWeb.present) {
      map['personal_web'] = Variable<String, StringType>(d.personalWeb.value);
    }
    if (d.personalFax.present) {
      map['personal_fax'] = Variable<String, StringType>(d.personalFax.value);
    }
    if (d.personalPhone.present) {
      map['personal_phone'] =
          Variable<String, StringType>(d.personalPhone.value);
    }
    if (d.personalMobile.present) {
      map['personal_mobile'] =
          Variable<String, StringType>(d.personalMobile.value);
    }
    if (d.businessEmail.present) {
      map['business_email'] =
          Variable<String, StringType>(d.businessEmail.value);
    }
    if (d.businessCompany.present) {
      map['business_company'] =
          Variable<String, StringType>(d.businessCompany.value);
    }
    if (d.businessAddress.present) {
      map['business_address'] =
          Variable<String, StringType>(d.businessAddress.value);
    }
    if (d.businessCity.present) {
      map['business_city'] = Variable<String, StringType>(d.businessCity.value);
    }
    if (d.businessState.present) {
      map['business_state'] =
          Variable<String, StringType>(d.businessState.value);
    }
    if (d.businessZip.present) {
      map['business_zip'] = Variable<String, StringType>(d.businessZip.value);
    }
    if (d.businessCountry.present) {
      map['business_country'] =
          Variable<String, StringType>(d.businessCountry.value);
    }
    if (d.businessJobTitle.present) {
      map['business_job_title'] =
          Variable<String, StringType>(d.businessJobTitle.value);
    }
    if (d.businessDepartment.present) {
      map['business_department'] =
          Variable<String, StringType>(d.businessDepartment.value);
    }
    if (d.businessOffice.present) {
      map['business_office'] =
          Variable<String, StringType>(d.businessOffice.value);
    }
    if (d.businessPhone.present) {
      map['business_phone'] =
          Variable<String, StringType>(d.businessPhone.value);
    }
    if (d.businessFax.present) {
      map['business_fax'] = Variable<String, StringType>(d.businessFax.value);
    }
    if (d.businessWeb.present) {
      map['business_web'] = Variable<String, StringType>(d.businessWeb.value);
    }
    if (d.otherEmail.present) {
      map['other_email'] = Variable<String, StringType>(d.otherEmail.value);
    }
    if (d.notes.present) {
      map['notes'] = Variable<String, StringType>(d.notes.value);
    }
    if (d.birthDay.present) {
      map['birth_day'] = Variable<int, IntType>(d.birthDay.value);
    }
    if (d.birthMonth.present) {
      map['birth_month'] = Variable<int, IntType>(d.birthMonth.value);
    }
    if (d.birthYear.present) {
      map['birth_year'] = Variable<int, IntType>(d.birthYear.value);
    }
    if (d.auto.present) {
      map['auto'] = Variable<bool, BoolType>(d.auto.value);
    }
    if (d.frequency.present) {
      map['frequency'] = Variable<int, IntType>(d.frequency.value);
    }
    if (d.dateModified.present) {
      map['date_modified'] = Variable<String, StringType>(d.dateModified.value);
    }
    if (d.davContactsUid.present) {
      map['dav_contacts_uid'] =
          Variable<String, StringType>(d.davContactsUid.value);
    }
    if (d.davContactsVCardUid.present) {
      map['dav_contacts_v_card_uid'] =
          Variable<String, StringType>(d.davContactsVCardUid.value);
    }
    if (d.groupUUIDs.present) {
      final converter = $ContactsTable.$converter0;
      map['group_u_u_i_ds'] =
          Variable<String, StringType>(converter.mapToSql(d.groupUUIDs.value));
    }
    return map;
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(_db, alias);
  }

  static TypeConverter<List<String>, String> $converter0 =
      const ListStringConverter();
}

class ContactsGroupsTable extends DataClass
    implements Insertable<ContactsGroupsTable> {
  final String uuid;
  final int userLocalId;
  final int idUser;
  final String city;
  final String company;
  final String country;
  final String email;
  final String fax;
  final bool isOrganization;
  final String name;
  final String parentUUID;
  final String phone;
  final String state;
  final String street;
  final String web;
  final String zip;
  ContactsGroupsTable(
      {@required this.uuid,
      @required this.userLocalId,
      @required this.idUser,
      @required this.city,
      @required this.company,
      @required this.country,
      @required this.email,
      @required this.fax,
      @required this.isOrganization,
      @required this.name,
      @required this.parentUUID,
      @required this.phone,
      @required this.state,
      @required this.street,
      @required this.web,
      @required this.zip});
  factory ContactsGroupsTable.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ContactsGroupsTable(
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      userLocalId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id']),
      idUser:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      city: stringType.mapFromDatabaseResponse(data['${effectivePrefix}city']),
      company:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}company']),
      country:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}country']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      fax: stringType.mapFromDatabaseResponse(data['${effectivePrefix}fax']),
      isOrganization: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_organization']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      parentUUID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_u_u_i_d']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      state:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}state']),
      street:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}street']),
      web: stringType.mapFromDatabaseResponse(data['${effectivePrefix}web']),
      zip: stringType.mapFromDatabaseResponse(data['${effectivePrefix}zip']),
    );
  }
  factory ContactsGroupsTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ContactsGroupsTable(
      uuid: serializer.fromJson<String>(json['uuid']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      idUser: serializer.fromJson<int>(json['idUser']),
      city: serializer.fromJson<String>(json['city']),
      company: serializer.fromJson<String>(json['company']),
      country: serializer.fromJson<String>(json['country']),
      email: serializer.fromJson<String>(json['email']),
      fax: serializer.fromJson<String>(json['fax']),
      isOrganization: serializer.fromJson<bool>(json['isOrganization']),
      name: serializer.fromJson<String>(json['name']),
      parentUUID: serializer.fromJson<String>(json['parentUUID']),
      phone: serializer.fromJson<String>(json['phone']),
      state: serializer.fromJson<String>(json['state']),
      street: serializer.fromJson<String>(json['street']),
      web: serializer.fromJson<String>(json['web']),
      zip: serializer.fromJson<String>(json['zip']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'idUser': serializer.toJson<int>(idUser),
      'city': serializer.toJson<String>(city),
      'company': serializer.toJson<String>(company),
      'country': serializer.toJson<String>(country),
      'email': serializer.toJson<String>(email),
      'fax': serializer.toJson<String>(fax),
      'isOrganization': serializer.toJson<bool>(isOrganization),
      'name': serializer.toJson<String>(name),
      'parentUUID': serializer.toJson<String>(parentUUID),
      'phone': serializer.toJson<String>(phone),
      'state': serializer.toJson<String>(state),
      'street': serializer.toJson<String>(street),
      'web': serializer.toJson<String>(web),
      'zip': serializer.toJson<String>(zip),
    };
  }

  @override
  ContactsGroupsCompanion createCompanion(bool nullToAbsent) {
    return ContactsGroupsCompanion(
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      userLocalId: userLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(userLocalId),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      company: company == null && nullToAbsent
          ? const Value.absent()
          : Value(company),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      fax: fax == null && nullToAbsent ? const Value.absent() : Value(fax),
      isOrganization: isOrganization == null && nullToAbsent
          ? const Value.absent()
          : Value(isOrganization),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      parentUUID: parentUUID == null && nullToAbsent
          ? const Value.absent()
          : Value(parentUUID),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      street:
          street == null && nullToAbsent ? const Value.absent() : Value(street),
      web: web == null && nullToAbsent ? const Value.absent() : Value(web),
      zip: zip == null && nullToAbsent ? const Value.absent() : Value(zip),
    );
  }

  ContactsGroupsTable copyWith(
          {String uuid,
          int userLocalId,
          int idUser,
          String city,
          String company,
          String country,
          String email,
          String fax,
          bool isOrganization,
          String name,
          String parentUUID,
          String phone,
          String state,
          String street,
          String web,
          String zip}) =>
      ContactsGroupsTable(
        uuid: uuid ?? this.uuid,
        userLocalId: userLocalId ?? this.userLocalId,
        idUser: idUser ?? this.idUser,
        city: city ?? this.city,
        company: company ?? this.company,
        country: country ?? this.country,
        email: email ?? this.email,
        fax: fax ?? this.fax,
        isOrganization: isOrganization ?? this.isOrganization,
        name: name ?? this.name,
        parentUUID: parentUUID ?? this.parentUUID,
        phone: phone ?? this.phone,
        state: state ?? this.state,
        street: street ?? this.street,
        web: web ?? this.web,
        zip: zip ?? this.zip,
      );
  @override
  String toString() {
    return (StringBuffer('ContactsGroupsTable(')
          ..write('uuid: $uuid, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('idUser: $idUser, ')
          ..write('city: $city, ')
          ..write('company: $company, ')
          ..write('country: $country, ')
          ..write('email: $email, ')
          ..write('fax: $fax, ')
          ..write('isOrganization: $isOrganization, ')
          ..write('name: $name, ')
          ..write('parentUUID: $parentUUID, ')
          ..write('phone: $phone, ')
          ..write('state: $state, ')
          ..write('street: $street, ')
          ..write('web: $web, ')
          ..write('zip: $zip')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      uuid.hashCode,
      $mrjc(
          userLocalId.hashCode,
          $mrjc(
              idUser.hashCode,
              $mrjc(
                  city.hashCode,
                  $mrjc(
                      company.hashCode,
                      $mrjc(
                          country.hashCode,
                          $mrjc(
                              email.hashCode,
                              $mrjc(
                                  fax.hashCode,
                                  $mrjc(
                                      isOrganization.hashCode,
                                      $mrjc(
                                          name.hashCode,
                                          $mrjc(
                                              parentUUID.hashCode,
                                              $mrjc(
                                                  phone.hashCode,
                                                  $mrjc(
                                                      state.hashCode,
                                                      $mrjc(
                                                          street.hashCode,
                                                          $mrjc(web.hashCode,
                                                              zip.hashCode))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ContactsGroupsTable &&
          other.uuid == this.uuid &&
          other.userLocalId == this.userLocalId &&
          other.idUser == this.idUser &&
          other.city == this.city &&
          other.company == this.company &&
          other.country == this.country &&
          other.email == this.email &&
          other.fax == this.fax &&
          other.isOrganization == this.isOrganization &&
          other.name == this.name &&
          other.parentUUID == this.parentUUID &&
          other.phone == this.phone &&
          other.state == this.state &&
          other.street == this.street &&
          other.web == this.web &&
          other.zip == this.zip);
}

class ContactsGroupsCompanion extends UpdateCompanion<ContactsGroupsTable> {
  final Value<String> uuid;
  final Value<int> userLocalId;
  final Value<int> idUser;
  final Value<String> city;
  final Value<String> company;
  final Value<String> country;
  final Value<String> email;
  final Value<String> fax;
  final Value<bool> isOrganization;
  final Value<String> name;
  final Value<String> parentUUID;
  final Value<String> phone;
  final Value<String> state;
  final Value<String> street;
  final Value<String> web;
  final Value<String> zip;
  const ContactsGroupsCompanion({
    this.uuid = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.idUser = const Value.absent(),
    this.city = const Value.absent(),
    this.company = const Value.absent(),
    this.country = const Value.absent(),
    this.email = const Value.absent(),
    this.fax = const Value.absent(),
    this.isOrganization = const Value.absent(),
    this.name = const Value.absent(),
    this.parentUUID = const Value.absent(),
    this.phone = const Value.absent(),
    this.state = const Value.absent(),
    this.street = const Value.absent(),
    this.web = const Value.absent(),
    this.zip = const Value.absent(),
  });
  ContactsGroupsCompanion.insert({
    @required String uuid,
    @required int userLocalId,
    @required int idUser,
    @required String city,
    @required String company,
    @required String country,
    @required String email,
    @required String fax,
    @required bool isOrganization,
    @required String name,
    @required String parentUUID,
    @required String phone,
    @required String state,
    @required String street,
    @required String web,
    @required String zip,
  })  : uuid = Value(uuid),
        userLocalId = Value(userLocalId),
        idUser = Value(idUser),
        city = Value(city),
        company = Value(company),
        country = Value(country),
        email = Value(email),
        fax = Value(fax),
        isOrganization = Value(isOrganization),
        name = Value(name),
        parentUUID = Value(parentUUID),
        phone = Value(phone),
        state = Value(state),
        street = Value(street),
        web = Value(web),
        zip = Value(zip);
  ContactsGroupsCompanion copyWith(
      {Value<String> uuid,
      Value<int> userLocalId,
      Value<int> idUser,
      Value<String> city,
      Value<String> company,
      Value<String> country,
      Value<String> email,
      Value<String> fax,
      Value<bool> isOrganization,
      Value<String> name,
      Value<String> parentUUID,
      Value<String> phone,
      Value<String> state,
      Value<String> street,
      Value<String> web,
      Value<String> zip}) {
    return ContactsGroupsCompanion(
      uuid: uuid ?? this.uuid,
      userLocalId: userLocalId ?? this.userLocalId,
      idUser: idUser ?? this.idUser,
      city: city ?? this.city,
      company: company ?? this.company,
      country: country ?? this.country,
      email: email ?? this.email,
      fax: fax ?? this.fax,
      isOrganization: isOrganization ?? this.isOrganization,
      name: name ?? this.name,
      parentUUID: parentUUID ?? this.parentUUID,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      street: street ?? this.street,
      web: web ?? this.web,
      zip: zip ?? this.zip,
    );
  }
}

class $ContactsGroupsTable extends ContactsGroups
    with TableInfo<$ContactsGroupsTable, ContactsGroupsTable> {
  final GeneratedDatabase _db;
  final String _alias;
  $ContactsGroupsTable(this._db, [this._alias]);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  @override
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn('uuid', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  GeneratedIntColumn _userLocalId;
  @override
  GeneratedIntColumn get userLocalId =>
      _userLocalId ??= _constructUserLocalId();
  GeneratedIntColumn _constructUserLocalId() {
    return GeneratedIntColumn(
      'user_local_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  GeneratedIntColumn _idUser;
  @override
  GeneratedIntColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedIntColumn _constructIdUser() {
    return GeneratedIntColumn(
      'id_user',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedTextColumn _city;
  @override
  GeneratedTextColumn get city => _city ??= _constructCity();
  GeneratedTextColumn _constructCity() {
    return GeneratedTextColumn(
      'city',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyMeta = const VerificationMeta('company');
  GeneratedTextColumn _company;
  @override
  GeneratedTextColumn get company => _company ??= _constructCompany();
  GeneratedTextColumn _constructCompany() {
    return GeneratedTextColumn(
      'company',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countryMeta = const VerificationMeta('country');
  GeneratedTextColumn _country;
  @override
  GeneratedTextColumn get country => _country ??= _constructCountry();
  GeneratedTextColumn _constructCountry() {
    return GeneratedTextColumn(
      'country',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _faxMeta = const VerificationMeta('fax');
  GeneratedTextColumn _fax;
  @override
  GeneratedTextColumn get fax => _fax ??= _constructFax();
  GeneratedTextColumn _constructFax() {
    return GeneratedTextColumn(
      'fax',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isOrganizationMeta =
      const VerificationMeta('isOrganization');
  GeneratedBoolColumn _isOrganization;
  @override
  GeneratedBoolColumn get isOrganization =>
      _isOrganization ??= _constructIsOrganization();
  GeneratedBoolColumn _constructIsOrganization() {
    return GeneratedBoolColumn(
      'is_organization',
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

  final VerificationMeta _parentUUIDMeta = const VerificationMeta('parentUUID');
  GeneratedTextColumn _parentUUID;
  @override
  GeneratedTextColumn get parentUUID => _parentUUID ??= _constructParentUUID();
  GeneratedTextColumn _constructParentUUID() {
    return GeneratedTextColumn(
      'parent_u_u_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  GeneratedTextColumn _phone;
  @override
  GeneratedTextColumn get phone => _phone ??= _constructPhone();
  GeneratedTextColumn _constructPhone() {
    return GeneratedTextColumn(
      'phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _stateMeta = const VerificationMeta('state');
  GeneratedTextColumn _state;
  @override
  GeneratedTextColumn get state => _state ??= _constructState();
  GeneratedTextColumn _constructState() {
    return GeneratedTextColumn(
      'state',
      $tableName,
      false,
    );
  }

  final VerificationMeta _streetMeta = const VerificationMeta('street');
  GeneratedTextColumn _street;
  @override
  GeneratedTextColumn get street => _street ??= _constructStreet();
  GeneratedTextColumn _constructStreet() {
    return GeneratedTextColumn(
      'street',
      $tableName,
      false,
    );
  }

  final VerificationMeta _webMeta = const VerificationMeta('web');
  GeneratedTextColumn _web;
  @override
  GeneratedTextColumn get web => _web ??= _constructWeb();
  GeneratedTextColumn _constructWeb() {
    return GeneratedTextColumn(
      'web',
      $tableName,
      false,
    );
  }

  final VerificationMeta _zipMeta = const VerificationMeta('zip');
  GeneratedTextColumn _zip;
  @override
  GeneratedTextColumn get zip => _zip ??= _constructZip();
  GeneratedTextColumn _constructZip() {
    return GeneratedTextColumn(
      'zip',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        userLocalId,
        idUser,
        city,
        company,
        country,
        email,
        fax,
        isOrganization,
        name,
        parentUUID,
        phone,
        state,
        street,
        web,
        zip
      ];
  @override
  $ContactsGroupsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'contacts_groups';
  @override
  final String actualTableName = 'contacts_groups';
  @override
  VerificationContext validateIntegrity(ContactsGroupsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.uuid.present) {
      context.handle(
          _uuidMeta, uuid.isAcceptableValue(d.uuid.value, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (d.userLocalId.present) {
      context.handle(_userLocalIdMeta,
          userLocalId.isAcceptableValue(d.userLocalId.value, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (d.idUser.present) {
      context.handle(
          _idUserMeta, idUser.isAcceptableValue(d.idUser.value, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (d.city.present) {
      context.handle(
          _cityMeta, city.isAcceptableValue(d.city.value, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (d.company.present) {
      context.handle(_companyMeta,
          company.isAcceptableValue(d.company.value, _companyMeta));
    } else if (isInserting) {
      context.missing(_companyMeta);
    }
    if (d.country.present) {
      context.handle(_countryMeta,
          country.isAcceptableValue(d.country.value, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (d.fax.present) {
      context.handle(_faxMeta, fax.isAcceptableValue(d.fax.value, _faxMeta));
    } else if (isInserting) {
      context.missing(_faxMeta);
    }
    if (d.isOrganization.present) {
      context.handle(
          _isOrganizationMeta,
          isOrganization.isAcceptableValue(
              d.isOrganization.value, _isOrganizationMeta));
    } else if (isInserting) {
      context.missing(_isOrganizationMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.parentUUID.present) {
      context.handle(_parentUUIDMeta,
          parentUUID.isAcceptableValue(d.parentUUID.value, _parentUUIDMeta));
    } else if (isInserting) {
      context.missing(_parentUUIDMeta);
    }
    if (d.phone.present) {
      context.handle(
          _phoneMeta, phone.isAcceptableValue(d.phone.value, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (d.state.present) {
      context.handle(
          _stateMeta, state.isAcceptableValue(d.state.value, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (d.street.present) {
      context.handle(
          _streetMeta, street.isAcceptableValue(d.street.value, _streetMeta));
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (d.web.present) {
      context.handle(_webMeta, web.isAcceptableValue(d.web.value, _webMeta));
    } else if (isInserting) {
      context.missing(_webMeta);
    }
    if (d.zip.present) {
      context.handle(_zipMeta, zip.isAcceptableValue(d.zip.value, _zipMeta));
    } else if (isInserting) {
      context.missing(_zipMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ContactsGroupsTable map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ContactsGroupsTable.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ContactsGroupsCompanion d) {
    final map = <String, Variable>{};
    if (d.uuid.present) {
      map['uuid'] = Variable<String, StringType>(d.uuid.value);
    }
    if (d.userLocalId.present) {
      map['user_local_id'] = Variable<int, IntType>(d.userLocalId.value);
    }
    if (d.idUser.present) {
      map['id_user'] = Variable<int, IntType>(d.idUser.value);
    }
    if (d.city.present) {
      map['city'] = Variable<String, StringType>(d.city.value);
    }
    if (d.company.present) {
      map['company'] = Variable<String, StringType>(d.company.value);
    }
    if (d.country.present) {
      map['country'] = Variable<String, StringType>(d.country.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    if (d.fax.present) {
      map['fax'] = Variable<String, StringType>(d.fax.value);
    }
    if (d.isOrganization.present) {
      map['is_organization'] = Variable<bool, BoolType>(d.isOrganization.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.parentUUID.present) {
      map['parent_u_u_i_d'] = Variable<String, StringType>(d.parentUUID.value);
    }
    if (d.phone.present) {
      map['phone'] = Variable<String, StringType>(d.phone.value);
    }
    if (d.state.present) {
      map['state'] = Variable<String, StringType>(d.state.value);
    }
    if (d.street.present) {
      map['street'] = Variable<String, StringType>(d.street.value);
    }
    if (d.web.present) {
      map['web'] = Variable<String, StringType>(d.web.value);
    }
    if (d.zip.present) {
      map['zip'] = Variable<String, StringType>(d.zip.value);
    }
    return map;
  }

  @override
  $ContactsGroupsTable createAlias(String alias) {
    return $ContactsGroupsTable(_db, alias);
  }
}

class ContactsStoragesTable extends DataClass
    implements Insertable<ContactsStoragesTable> {
  final int sqliteId;
  final int userLocalId;
  final int idUser;
  final String serverId;
  final String uniqueName;
  final String name;
  final int cTag;
  final bool display;
  final List<ContactInfoItem> contactsInfo;
  ContactsStoragesTable(
      {@required this.sqliteId,
      @required this.userLocalId,
      @required this.idUser,
      @required this.serverId,
      @required this.uniqueName,
      @required this.name,
      @required this.cTag,
      @required this.display,
      this.contactsInfo});
  factory ContactsStoragesTable.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ContactsStoragesTable(
      sqliteId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sqlite_id']),
      userLocalId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id']),
      idUser:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      serverId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}server_id']),
      uniqueName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}unique_name']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      cTag: intType.mapFromDatabaseResponse(data['${effectivePrefix}c_tag']),
      display:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}display']),
      contactsInfo: $ContactsStoragesTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}contacts_info'])),
    );
  }
  factory ContactsStoragesTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ContactsStoragesTable(
      sqliteId: serializer.fromJson<int>(json['sqliteId']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      idUser: serializer.fromJson<int>(json['idUser']),
      serverId: serializer.fromJson<String>(json['serverId']),
      uniqueName: serializer.fromJson<String>(json['uniqueName']),
      name: serializer.fromJson<String>(json['name']),
      cTag: serializer.fromJson<int>(json['cTag']),
      display: serializer.fromJson<bool>(json['display']),
      contactsInfo:
          serializer.fromJson<List<ContactInfoItem>>(json['contactsInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sqliteId': serializer.toJson<int>(sqliteId),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'idUser': serializer.toJson<int>(idUser),
      'serverId': serializer.toJson<String>(serverId),
      'uniqueName': serializer.toJson<String>(uniqueName),
      'name': serializer.toJson<String>(name),
      'cTag': serializer.toJson<int>(cTag),
      'display': serializer.toJson<bool>(display),
      'contactsInfo': serializer.toJson<List<ContactInfoItem>>(contactsInfo),
    };
  }

  @override
  ContactsStoragesCompanion createCompanion(bool nullToAbsent) {
    return ContactsStoragesCompanion(
      sqliteId: sqliteId == null && nullToAbsent
          ? const Value.absent()
          : Value(sqliteId),
      userLocalId: userLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(userLocalId),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      uniqueName: uniqueName == null && nullToAbsent
          ? const Value.absent()
          : Value(uniqueName),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      cTag: cTag == null && nullToAbsent ? const Value.absent() : Value(cTag),
      display: display == null && nullToAbsent
          ? const Value.absent()
          : Value(display),
      contactsInfo: contactsInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(contactsInfo),
    );
  }

  ContactsStoragesTable copyWith(
          {int sqliteId,
          int userLocalId,
          int idUser,
          String serverId,
          String uniqueName,
          String name,
          int cTag,
          bool display,
          List<ContactInfoItem> contactsInfo}) =>
      ContactsStoragesTable(
        sqliteId: sqliteId ?? this.sqliteId,
        userLocalId: userLocalId ?? this.userLocalId,
        idUser: idUser ?? this.idUser,
        serverId: serverId ?? this.serverId,
        uniqueName: uniqueName ?? this.uniqueName,
        name: name ?? this.name,
        cTag: cTag ?? this.cTag,
        display: display ?? this.display,
        contactsInfo: contactsInfo ?? this.contactsInfo,
      );
  @override
  String toString() {
    return (StringBuffer('ContactsStoragesTable(')
          ..write('sqliteId: $sqliteId, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('idUser: $idUser, ')
          ..write('serverId: $serverId, ')
          ..write('uniqueName: $uniqueName, ')
          ..write('name: $name, ')
          ..write('cTag: $cTag, ')
          ..write('display: $display, ')
          ..write('contactsInfo: $contactsInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      sqliteId.hashCode,
      $mrjc(
          userLocalId.hashCode,
          $mrjc(
              idUser.hashCode,
              $mrjc(
                  serverId.hashCode,
                  $mrjc(
                      uniqueName.hashCode,
                      $mrjc(
                          name.hashCode,
                          $mrjc(
                              cTag.hashCode,
                              $mrjc(display.hashCode,
                                  contactsInfo.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ContactsStoragesTable &&
          other.sqliteId == this.sqliteId &&
          other.userLocalId == this.userLocalId &&
          other.idUser == this.idUser &&
          other.serverId == this.serverId &&
          other.uniqueName == this.uniqueName &&
          other.name == this.name &&
          other.cTag == this.cTag &&
          other.display == this.display &&
          other.contactsInfo == this.contactsInfo);
}

class ContactsStoragesCompanion extends UpdateCompanion<ContactsStoragesTable> {
  final Value<int> sqliteId;
  final Value<int> userLocalId;
  final Value<int> idUser;
  final Value<String> serverId;
  final Value<String> uniqueName;
  final Value<String> name;
  final Value<int> cTag;
  final Value<bool> display;
  final Value<List<ContactInfoItem>> contactsInfo;
  const ContactsStoragesCompanion({
    this.sqliteId = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.idUser = const Value.absent(),
    this.serverId = const Value.absent(),
    this.uniqueName = const Value.absent(),
    this.name = const Value.absent(),
    this.cTag = const Value.absent(),
    this.display = const Value.absent(),
    this.contactsInfo = const Value.absent(),
  });
  ContactsStoragesCompanion.insert({
    this.sqliteId = const Value.absent(),
    @required int userLocalId,
    @required int idUser,
    @required String serverId,
    @required String uniqueName,
    @required String name,
    @required int cTag,
    @required bool display,
    this.contactsInfo = const Value.absent(),
  })  : userLocalId = Value(userLocalId),
        idUser = Value(idUser),
        serverId = Value(serverId),
        uniqueName = Value(uniqueName),
        name = Value(name),
        cTag = Value(cTag),
        display = Value(display);
  ContactsStoragesCompanion copyWith(
      {Value<int> sqliteId,
      Value<int> userLocalId,
      Value<int> idUser,
      Value<String> serverId,
      Value<String> uniqueName,
      Value<String> name,
      Value<int> cTag,
      Value<bool> display,
      Value<List<ContactInfoItem>> contactsInfo}) {
    return ContactsStoragesCompanion(
      sqliteId: sqliteId ?? this.sqliteId,
      userLocalId: userLocalId ?? this.userLocalId,
      idUser: idUser ?? this.idUser,
      serverId: serverId ?? this.serverId,
      uniqueName: uniqueName ?? this.uniqueName,
      name: name ?? this.name,
      cTag: cTag ?? this.cTag,
      display: display ?? this.display,
      contactsInfo: contactsInfo ?? this.contactsInfo,
    );
  }
}

class $ContactsStoragesTable extends ContactsStorages
    with TableInfo<$ContactsStoragesTable, ContactsStoragesTable> {
  final GeneratedDatabase _db;
  final String _alias;
  $ContactsStoragesTable(this._db, [this._alias]);
  final VerificationMeta _sqliteIdMeta = const VerificationMeta('sqliteId');
  GeneratedIntColumn _sqliteId;
  @override
  GeneratedIntColumn get sqliteId => _sqliteId ??= _constructSqliteId();
  GeneratedIntColumn _constructSqliteId() {
    return GeneratedIntColumn('sqlite_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  GeneratedIntColumn _userLocalId;
  @override
  GeneratedIntColumn get userLocalId =>
      _userLocalId ??= _constructUserLocalId();
  GeneratedIntColumn _constructUserLocalId() {
    return GeneratedIntColumn(
      'user_local_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  GeneratedIntColumn _idUser;
  @override
  GeneratedIntColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedIntColumn _constructIdUser() {
    return GeneratedIntColumn(
      'id_user',
      $tableName,
      false,
    );
  }

  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  GeneratedTextColumn _serverId;
  @override
  GeneratedTextColumn get serverId => _serverId ??= _constructServerId();
  GeneratedTextColumn _constructServerId() {
    return GeneratedTextColumn(
      'server_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uniqueNameMeta = const VerificationMeta('uniqueName');
  GeneratedTextColumn _uniqueName;
  @override
  GeneratedTextColumn get uniqueName => _uniqueName ??= _constructUniqueName();
  GeneratedTextColumn _constructUniqueName() {
    return GeneratedTextColumn('unique_name', $tableName, false,
        $customConstraints: 'UNIQUE');
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

  final VerificationMeta _cTagMeta = const VerificationMeta('cTag');
  GeneratedIntColumn _cTag;
  @override
  GeneratedIntColumn get cTag => _cTag ??= _constructCTag();
  GeneratedIntColumn _constructCTag() {
    return GeneratedIntColumn(
      'c_tag',
      $tableName,
      false,
    );
  }

  final VerificationMeta _displayMeta = const VerificationMeta('display');
  GeneratedBoolColumn _display;
  @override
  GeneratedBoolColumn get display => _display ??= _constructDisplay();
  GeneratedBoolColumn _constructDisplay() {
    return GeneratedBoolColumn(
      'display',
      $tableName,
      false,
    );
  }

  final VerificationMeta _contactsInfoMeta =
      const VerificationMeta('contactsInfo');
  GeneratedTextColumn _contactsInfo;
  @override
  GeneratedTextColumn get contactsInfo =>
      _contactsInfo ??= _constructContactsInfo();
  GeneratedTextColumn _constructContactsInfo() {
    return GeneratedTextColumn(
      'contacts_info',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        sqliteId,
        userLocalId,
        idUser,
        serverId,
        uniqueName,
        name,
        cTag,
        display,
        contactsInfo
      ];
  @override
  $ContactsStoragesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'contacts_storages';
  @override
  final String actualTableName = 'contacts_storages';
  @override
  VerificationContext validateIntegrity(ContactsStoragesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.sqliteId.present) {
      context.handle(_sqliteIdMeta,
          sqliteId.isAcceptableValue(d.sqliteId.value, _sqliteIdMeta));
    }
    if (d.userLocalId.present) {
      context.handle(_userLocalIdMeta,
          userLocalId.isAcceptableValue(d.userLocalId.value, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (d.idUser.present) {
      context.handle(
          _idUserMeta, idUser.isAcceptableValue(d.idUser.value, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (d.serverId.present) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableValue(d.serverId.value, _serverIdMeta));
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (d.uniqueName.present) {
      context.handle(_uniqueNameMeta,
          uniqueName.isAcceptableValue(d.uniqueName.value, _uniqueNameMeta));
    } else if (isInserting) {
      context.missing(_uniqueNameMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.cTag.present) {
      context.handle(
          _cTagMeta, cTag.isAcceptableValue(d.cTag.value, _cTagMeta));
    } else if (isInserting) {
      context.missing(_cTagMeta);
    }
    if (d.display.present) {
      context.handle(_displayMeta,
          display.isAcceptableValue(d.display.value, _displayMeta));
    } else if (isInserting) {
      context.missing(_displayMeta);
    }
    context.handle(_contactsInfoMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sqliteId};
  @override
  ContactsStoragesTable map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ContactsStoragesTable.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ContactsStoragesCompanion d) {
    final map = <String, Variable>{};
    if (d.sqliteId.present) {
      map['sqlite_id'] = Variable<int, IntType>(d.sqliteId.value);
    }
    if (d.userLocalId.present) {
      map['user_local_id'] = Variable<int, IntType>(d.userLocalId.value);
    }
    if (d.idUser.present) {
      map['id_user'] = Variable<int, IntType>(d.idUser.value);
    }
    if (d.serverId.present) {
      map['server_id'] = Variable<String, StringType>(d.serverId.value);
    }
    if (d.uniqueName.present) {
      map['unique_name'] = Variable<String, StringType>(d.uniqueName.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.cTag.present) {
      map['c_tag'] = Variable<int, IntType>(d.cTag.value);
    }
    if (d.display.present) {
      map['display'] = Variable<bool, BoolType>(d.display.value);
    }
    if (d.contactsInfo.present) {
      final converter = $ContactsStoragesTable.$converter0;
      map['contacts_info'] = Variable<String, StringType>(
          converter.mapToSql(d.contactsInfo.value));
    }
    return map;
  }

  @override
  $ContactsStoragesTable createAlias(String alias) {
    return $ContactsStoragesTable(_db, alias);
  }

  static TypeConverter<List<ContactInfoItem>, String> $converter0 =
      const ContactsInfoConverter();
}

class LocalPgpKey extends DataClass implements Insertable<LocalPgpKey> {
  final String id;
  final String name;
  final String mail;
  final bool isPrivate;
  final int length;
  LocalPgpKey(
      {@required this.id,
      this.name,
      @required this.mail,
      @required this.isPrivate,
      this.length});
  factory LocalPgpKey.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final intType = db.typeSystem.forDartType<int>();
    return LocalPgpKey(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      mail: stringType.mapFromDatabaseResponse(data['${effectivePrefix}mail']),
      isPrivate: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_private']),
      length: intType.mapFromDatabaseResponse(data['${effectivePrefix}length']),
    );
  }
  factory LocalPgpKey.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalPgpKey(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mail: serializer.fromJson<String>(json['mail']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      length: serializer.fromJson<int>(json['length']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'mail': serializer.toJson<String>(mail),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'length': serializer.toJson<int>(length),
    };
  }

  @override
  PgpKeyModelCompanion createCompanion(bool nullToAbsent) {
    return PgpKeyModelCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      mail: mail == null && nullToAbsent ? const Value.absent() : Value(mail),
      isPrivate: isPrivate == null && nullToAbsent
          ? const Value.absent()
          : Value(isPrivate),
      length:
          length == null && nullToAbsent ? const Value.absent() : Value(length),
    );
  }

  LocalPgpKey copyWith(
          {String id, String name, String mail, bool isPrivate, int length}) =>
      LocalPgpKey(
        id: id ?? this.id,
        name: name ?? this.name,
        mail: mail ?? this.mail,
        isPrivate: isPrivate ?? this.isPrivate,
        length: length ?? this.length,
      );
  @override
  String toString() {
    return (StringBuffer('LocalPgpKey(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mail: $mail, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('length: $length')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(name.hashCode,
          $mrjc(mail.hashCode, $mrjc(isPrivate.hashCode, length.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is LocalPgpKey &&
          other.id == this.id &&
          other.name == this.name &&
          other.mail == this.mail &&
          other.isPrivate == this.isPrivate &&
          other.length == this.length);
}

class PgpKeyModelCompanion extends UpdateCompanion<LocalPgpKey> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> mail;
  final Value<bool> isPrivate;
  final Value<int> length;
  const PgpKeyModelCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mail = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.length = const Value.absent(),
  });
  PgpKeyModelCompanion.insert({
    @required String id,
    this.name = const Value.absent(),
    @required String mail,
    @required bool isPrivate,
    this.length = const Value.absent(),
  })  : id = Value(id),
        mail = Value(mail),
        isPrivate = Value(isPrivate);
  PgpKeyModelCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> mail,
      Value<bool> isPrivate,
      Value<int> length}) {
    return PgpKeyModelCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mail: mail ?? this.mail,
      isPrivate: isPrivate ?? this.isPrivate,
      length: length ?? this.length,
    );
  }
}

class $PgpKeyModelTable extends PgpKeyModel
    with TableInfo<$PgpKeyModelTable, LocalPgpKey> {
  final GeneratedDatabase _db;
  final String _alias;
  $PgpKeyModelTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
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
      true,
    );
  }

  final VerificationMeta _mailMeta = const VerificationMeta('mail');
  GeneratedTextColumn _mail;
  @override
  GeneratedTextColumn get mail => _mail ??= _constructMail();
  GeneratedTextColumn _constructMail() {
    return GeneratedTextColumn(
      'mail',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isPrivateMeta = const VerificationMeta('isPrivate');
  GeneratedBoolColumn _isPrivate;
  @override
  GeneratedBoolColumn get isPrivate => _isPrivate ??= _constructIsPrivate();
  GeneratedBoolColumn _constructIsPrivate() {
    return GeneratedBoolColumn(
      'is_private',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lengthMeta = const VerificationMeta('length');
  GeneratedIntColumn _length;
  @override
  GeneratedIntColumn get length => _length ??= _constructLength();
  GeneratedIntColumn _constructLength() {
    return GeneratedIntColumn(
      'length',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, mail, isPrivate, length];
  @override
  $PgpKeyModelTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'pgp_key_model';
  @override
  final String actualTableName = 'pgp_key_model';
  @override
  VerificationContext validateIntegrity(PgpKeyModelCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.mail.present) {
      context.handle(
          _mailMeta, mail.isAcceptableValue(d.mail.value, _mailMeta));
    } else if (isInserting) {
      context.missing(_mailMeta);
    }
    if (d.isPrivate.present) {
      context.handle(_isPrivateMeta,
          isPrivate.isAcceptableValue(d.isPrivate.value, _isPrivateMeta));
    } else if (isInserting) {
      context.missing(_isPrivateMeta);
    }
    if (d.length.present) {
      context.handle(
          _lengthMeta, length.isAcceptableValue(d.length.value, _lengthMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPgpKey map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return LocalPgpKey.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PgpKeyModelCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.mail.present) {
      map['mail'] = Variable<String, StringType>(d.mail.value);
    }
    if (d.isPrivate.present) {
      map['is_private'] = Variable<bool, BoolType>(d.isPrivate.value);
    }
    if (d.length.present) {
      map['length'] = Variable<int, IntType>(d.length.value);
    }
    return map;
  }

  @override
  $PgpKeyModelTable createAlias(String alias) {
    return $PgpKeyModelTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MailTable _mail;
  $MailTable get mail => _mail ??= $MailTable(this);
  $FoldersTable _folders;
  $FoldersTable get folders => _folders ??= $FoldersTable(this);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $AccountsTable _accounts;
  $AccountsTable get accounts => _accounts ??= $AccountsTable(this);
  $ContactsTable _contacts;
  $ContactsTable get contacts => _contacts ??= $ContactsTable(this);
  $ContactsGroupsTable _contactsGroups;
  $ContactsGroupsTable get contactsGroups =>
      _contactsGroups ??= $ContactsGroupsTable(this);
  $ContactsStoragesTable _contactsStorages;
  $ContactsStoragesTable get contactsStorages =>
      _contactsStorages ??= $ContactsStoragesTable(this);
  $PgpKeyModelTable _pgpKeyModel;
  $PgpKeyModelTable get pgpKeyModel => _pgpKeyModel ??= $PgpKeyModelTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        mail,
        folders,
        users,
        accounts,
        contacts,
        contactsGroups,
        contactsStorages,
        pgpKeyModel
      ];
}
