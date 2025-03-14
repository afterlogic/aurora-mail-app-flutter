// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Message extends DataClass implements Insertable<Message> {
  final int? localId;
  final int uid;
  final int? accountEntityId;
  final int? userLocalId;
  final String? uniqueUidInFolder;
  final int? parentUid;
  final String? messageId;
  final String folder;
  final String flagsInJson;
  final bool? hasThread;
  final String? subject;
  final int? size;
  final int? textSize;
  final bool? truncated;
  final int? internalTimeStampInUTC;
  final int? receivedOrDateTimeStampInUTC;
  final int? timeStampInUTC;
  final String? toToDisplay;
  final String? toInJson;
  final String? fromInJson;
  final String? fromToDisplay;
  final String? ccInJson;
  final String? bccInJson;
  final String? senderInJson;
  final String? replyToInJson;
  final bool? hasAttachments;
  final bool? hasVcardAttachment;
  final bool? hasIcalAttachment;
  final int? importance;
  final String? draftInfoInJson;
  final int? sensitivity;
  final String? downloadAsEmlUrl;
  final String? hash;
  final String? headers;
  final String? inReplyTo;
  final String? references;
  final String? readingConfirmationAddressee;
  final String? htmlBody;
  final String? rawBody;
  final String? bodyForSearch;
  final bool? rtl;
  final String? extendInJson;
  final bool? safety;
  final bool? hasExternals;
  final String? foundedCIDsInJson;
  final String? foundedContentLocationUrlsInJson;
  final String? attachmentsInJson;
  final String? toForSearch;
  final String? fromForSearch;
  final String? ccForSearch;
  final String? bccForSearch;
  final String? attachmentsForSearch;
  final String? customInJson;
  final bool? isHtml;
  final bool? hasBody;
  Message(
      {this.localId,
      required this.uid,
      this.accountEntityId,
      this.userLocalId,
      this.uniqueUidInFolder,
      this.parentUid,
      this.messageId,
      required this.folder,
      required this.flagsInJson,
      this.hasThread,
      this.subject,
      this.size,
      this.textSize,
      this.truncated,
      this.internalTimeStampInUTC,
      this.receivedOrDateTimeStampInUTC,
      this.timeStampInUTC,
      this.toToDisplay,
      this.toInJson,
      this.fromInJson,
      this.fromToDisplay,
      this.ccInJson,
      this.bccInJson,
      this.senderInJson,
      this.replyToInJson,
      this.hasAttachments,
      this.hasVcardAttachment,
      this.hasIcalAttachment,
      this.importance,
      this.draftInfoInJson,
      this.sensitivity,
      this.downloadAsEmlUrl,
      this.hash,
      this.headers,
      this.inReplyTo,
      this.references,
      this.readingConfirmationAddressee,
      this.htmlBody,
      this.rawBody,
      this.bodyForSearch,
      this.rtl,
      this.extendInJson,
      this.safety,
      this.hasExternals,
      this.foundedCIDsInJson,
      this.foundedContentLocationUrlsInJson,
      this.attachmentsInJson,
      this.toForSearch,
      this.fromForSearch,
      this.ccForSearch,
      this.bccForSearch,
      this.attachmentsForSearch,
      this.customInJson,
      this.isHtml,
      this.hasBody});
  factory Message.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Message(
      localId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      uid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uid'])!,
      accountEntityId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_entity_id']),
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id']),
      uniqueUidInFolder: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}unique_uid_in_folder']),
      parentUid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_uid']),
      messageId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}message_id']),
      folder: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}folder'])!,
      flagsInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}flags_in_json'])!,
      hasThread: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}has_thread']),
      subject: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}subject']),
      size: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}size']),
      textSize: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}text_size']),
      truncated: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}truncated']),
      internalTimeStampInUTC: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}internal_time_stamp_in_u_t_c']),
      receivedOrDateTimeStampInUTC: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}received_or_date_time_stamp_in_u_t_c']),
      timeStampInUTC: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}time_stamp_in_u_t_c']),
      toToDisplay: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to_to_display']),
      toInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to_in_json']),
      fromInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_in_json']),
      fromToDisplay: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_to_display']),
      ccInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cc_in_json']),
      bccInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bcc_in_json']),
      senderInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sender_in_json']),
      replyToInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}reply_to_in_json']),
      hasAttachments: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}has_attachments']),
      hasVcardAttachment: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}has_vcard_attachment']),
      hasIcalAttachment: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}has_ical_attachment']),
      importance: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}importance']),
      draftInfoInJson: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}draft_info_in_json']),
      sensitivity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sensitivity']),
      downloadAsEmlUrl: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}download_as_eml_url']),
      hash: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hash']),
      headers: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}headers']),
      inReplyTo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}in_reply_to']),
      references: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}message_references']),
      readingConfirmationAddressee: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}reading_confirmation_addressee']),
      htmlBody: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}html_body']),
      rawBody: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}raw_body']),
      bodyForSearch: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body_for_search']),
      rtl: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}rtl']),
      extendInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}extend_in_json']),
      safety: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}safety']),
      hasExternals: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}has_externals']),
      foundedCIDsInJson: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}founded_c_i_ds_in_json']),
      foundedContentLocationUrlsInJson: const StringType()
          .mapFromDatabaseResponse(
              data['${effectivePrefix}founded_content_location_urls_in_json']),
      attachmentsInJson: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}attachments_in_json']),
      toForSearch: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to_for_search']),
      fromForSearch: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_for_search']),
      ccForSearch: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cc_for_search']),
      bccForSearch: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bcc_for_search']),
      attachmentsForSearch: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}attachments_for_search']),
      customInJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}custom_in_json']),
      isHtml: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_html']),
      hasBody: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}has_body']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || localId != null) {
      map['local_id'] = Variable<int?>(localId);
    }
    map['uid'] = Variable<int>(uid);
    if (!nullToAbsent || accountEntityId != null) {
      map['account_entity_id'] = Variable<int?>(accountEntityId);
    }
    if (!nullToAbsent || userLocalId != null) {
      map['user_local_id'] = Variable<int?>(userLocalId);
    }
    if (!nullToAbsent || uniqueUidInFolder != null) {
      map['unique_uid_in_folder'] = Variable<String?>(uniqueUidInFolder);
    }
    if (!nullToAbsent || parentUid != null) {
      map['parent_uid'] = Variable<int?>(parentUid);
    }
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<String?>(messageId);
    }
    map['folder'] = Variable<String>(folder);
    map['flags_in_json'] = Variable<String>(flagsInJson);
    if (!nullToAbsent || hasThread != null) {
      map['has_thread'] = Variable<bool?>(hasThread);
    }
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String?>(subject);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int?>(size);
    }
    if (!nullToAbsent || textSize != null) {
      map['text_size'] = Variable<int?>(textSize);
    }
    if (!nullToAbsent || truncated != null) {
      map['truncated'] = Variable<bool?>(truncated);
    }
    if (!nullToAbsent || internalTimeStampInUTC != null) {
      map['internal_time_stamp_in_u_t_c'] =
          Variable<int?>(internalTimeStampInUTC);
    }
    if (!nullToAbsent || receivedOrDateTimeStampInUTC != null) {
      map['received_or_date_time_stamp_in_u_t_c'] =
          Variable<int?>(receivedOrDateTimeStampInUTC);
    }
    if (!nullToAbsent || timeStampInUTC != null) {
      map['time_stamp_in_u_t_c'] = Variable<int?>(timeStampInUTC);
    }
    if (!nullToAbsent || toToDisplay != null) {
      map['to_to_display'] = Variable<String?>(toToDisplay);
    }
    if (!nullToAbsent || toInJson != null) {
      map['to_in_json'] = Variable<String?>(toInJson);
    }
    if (!nullToAbsent || fromInJson != null) {
      map['from_in_json'] = Variable<String?>(fromInJson);
    }
    if (!nullToAbsent || fromToDisplay != null) {
      map['from_to_display'] = Variable<String?>(fromToDisplay);
    }
    if (!nullToAbsent || ccInJson != null) {
      map['cc_in_json'] = Variable<String?>(ccInJson);
    }
    if (!nullToAbsent || bccInJson != null) {
      map['bcc_in_json'] = Variable<String?>(bccInJson);
    }
    if (!nullToAbsent || senderInJson != null) {
      map['sender_in_json'] = Variable<String?>(senderInJson);
    }
    if (!nullToAbsent || replyToInJson != null) {
      map['reply_to_in_json'] = Variable<String?>(replyToInJson);
    }
    if (!nullToAbsent || hasAttachments != null) {
      map['has_attachments'] = Variable<bool?>(hasAttachments);
    }
    if (!nullToAbsent || hasVcardAttachment != null) {
      map['has_vcard_attachment'] = Variable<bool?>(hasVcardAttachment);
    }
    if (!nullToAbsent || hasIcalAttachment != null) {
      map['has_ical_attachment'] = Variable<bool?>(hasIcalAttachment);
    }
    if (!nullToAbsent || importance != null) {
      map['importance'] = Variable<int?>(importance);
    }
    if (!nullToAbsent || draftInfoInJson != null) {
      map['draft_info_in_json'] = Variable<String?>(draftInfoInJson);
    }
    if (!nullToAbsent || sensitivity != null) {
      map['sensitivity'] = Variable<int?>(sensitivity);
    }
    if (!nullToAbsent || downloadAsEmlUrl != null) {
      map['download_as_eml_url'] = Variable<String?>(downloadAsEmlUrl);
    }
    if (!nullToAbsent || hash != null) {
      map['hash'] = Variable<String?>(hash);
    }
    if (!nullToAbsent || headers != null) {
      map['headers'] = Variable<String?>(headers);
    }
    if (!nullToAbsent || inReplyTo != null) {
      map['in_reply_to'] = Variable<String?>(inReplyTo);
    }
    if (!nullToAbsent || references != null) {
      map['message_references'] = Variable<String?>(references);
    }
    if (!nullToAbsent || readingConfirmationAddressee != null) {
      map['reading_confirmation_addressee'] =
          Variable<String?>(readingConfirmationAddressee);
    }
    if (!nullToAbsent || htmlBody != null) {
      map['html_body'] = Variable<String?>(htmlBody);
    }
    if (!nullToAbsent || rawBody != null) {
      map['raw_body'] = Variable<String?>(rawBody);
    }
    if (!nullToAbsent || bodyForSearch != null) {
      map['body_for_search'] = Variable<String?>(bodyForSearch);
    }
    if (!nullToAbsent || rtl != null) {
      map['rtl'] = Variable<bool?>(rtl);
    }
    if (!nullToAbsent || extendInJson != null) {
      map['extend_in_json'] = Variable<String?>(extendInJson);
    }
    if (!nullToAbsent || safety != null) {
      map['safety'] = Variable<bool?>(safety);
    }
    if (!nullToAbsent || hasExternals != null) {
      map['has_externals'] = Variable<bool?>(hasExternals);
    }
    if (!nullToAbsent || foundedCIDsInJson != null) {
      map['founded_c_i_ds_in_json'] = Variable<String?>(foundedCIDsInJson);
    }
    if (!nullToAbsent || foundedContentLocationUrlsInJson != null) {
      map['founded_content_location_urls_in_json'] =
          Variable<String?>(foundedContentLocationUrlsInJson);
    }
    if (!nullToAbsent || attachmentsInJson != null) {
      map['attachments_in_json'] = Variable<String?>(attachmentsInJson);
    }
    if (!nullToAbsent || toForSearch != null) {
      map['to_for_search'] = Variable<String?>(toForSearch);
    }
    if (!nullToAbsent || fromForSearch != null) {
      map['from_for_search'] = Variable<String?>(fromForSearch);
    }
    if (!nullToAbsent || ccForSearch != null) {
      map['cc_for_search'] = Variable<String?>(ccForSearch);
    }
    if (!nullToAbsent || bccForSearch != null) {
      map['bcc_for_search'] = Variable<String?>(bccForSearch);
    }
    if (!nullToAbsent || attachmentsForSearch != null) {
      map['attachments_for_search'] = Variable<String?>(attachmentsForSearch);
    }
    if (!nullToAbsent || customInJson != null) {
      map['custom_in_json'] = Variable<String?>(customInJson);
    }
    if (!nullToAbsent || isHtml != null) {
      map['is_html'] = Variable<bool?>(isHtml);
    }
    if (!nullToAbsent || hasBody != null) {
      map['has_body'] = Variable<bool?>(hasBody);
    }
    return map;
  }

  MailCompanion toCompanion(bool nullToAbsent) {
    return MailCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      uid: Value(uid),
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
      folder: Value(folder),
      flagsInJson: Value(flagsInJson),
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
      toToDisplay: toToDisplay == null && nullToAbsent
          ? const Value.absent()
          : Value(toToDisplay),
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
      htmlBody: htmlBody == null && nullToAbsent
          ? const Value.absent()
          : Value(htmlBody),
      rawBody: rawBody == null && nullToAbsent
          ? const Value.absent()
          : Value(rawBody),
      bodyForSearch: bodyForSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyForSearch),
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
      toForSearch: toForSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(toForSearch),
      fromForSearch: fromForSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(fromForSearch),
      ccForSearch: ccForSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(ccForSearch),
      bccForSearch: bccForSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(bccForSearch),
      attachmentsForSearch: attachmentsForSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentsForSearch),
      customInJson: customInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customInJson),
      isHtml:
          isHtml == null && nullToAbsent ? const Value.absent() : Value(isHtml),
      hasBody: hasBody == null && nullToAbsent
          ? const Value.absent()
          : Value(hasBody),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      localId: serializer.fromJson<int?>(json['localId']),
      uid: serializer.fromJson<int>(json['uid']),
      accountEntityId: serializer.fromJson<int?>(json['accountEntityId']),
      userLocalId: serializer.fromJson<int?>(json['userLocalId']),
      uniqueUidInFolder:
          serializer.fromJson<String?>(json['uniqueUidInFolder']),
      parentUid: serializer.fromJson<int?>(json['parentUid']),
      messageId: serializer.fromJson<String?>(json['messageId']),
      folder: serializer.fromJson<String>(json['folder']),
      flagsInJson: serializer.fromJson<String>(json['flagsInJson']),
      hasThread: serializer.fromJson<bool?>(json['hasThread']),
      subject: serializer.fromJson<String?>(json['subject']),
      size: serializer.fromJson<int?>(json['size']),
      textSize: serializer.fromJson<int?>(json['textSize']),
      truncated: serializer.fromJson<bool?>(json['truncated']),
      internalTimeStampInUTC:
          serializer.fromJson<int?>(json['internalTimeStampInUTC']),
      receivedOrDateTimeStampInUTC:
          serializer.fromJson<int?>(json['receivedOrDateTimeStampInUTC']),
      timeStampInUTC: serializer.fromJson<int?>(json['timeStampInUTC']),
      toToDisplay: serializer.fromJson<String?>(json['toToDisplay']),
      toInJson: serializer.fromJson<String?>(json['toInJson']),
      fromInJson: serializer.fromJson<String?>(json['fromInJson']),
      fromToDisplay: serializer.fromJson<String?>(json['fromToDisplay']),
      ccInJson: serializer.fromJson<String?>(json['ccInJson']),
      bccInJson: serializer.fromJson<String?>(json['bccInJson']),
      senderInJson: serializer.fromJson<String?>(json['senderInJson']),
      replyToInJson: serializer.fromJson<String?>(json['replyToInJson']),
      hasAttachments: serializer.fromJson<bool?>(json['hasAttachments']),
      hasVcardAttachment:
          serializer.fromJson<bool?>(json['hasVcardAttachment']),
      hasIcalAttachment: serializer.fromJson<bool?>(json['hasIcalAttachment']),
      importance: serializer.fromJson<int?>(json['importance']),
      draftInfoInJson: serializer.fromJson<String?>(json['draftInfoInJson']),
      sensitivity: serializer.fromJson<int?>(json['sensitivity']),
      downloadAsEmlUrl: serializer.fromJson<String?>(json['downloadAsEmlUrl']),
      hash: serializer.fromJson<String?>(json['hash']),
      headers: serializer.fromJson<String?>(json['headers']),
      inReplyTo: serializer.fromJson<String?>(json['inReplyTo']),
      references: serializer.fromJson<String?>(json['references']),
      readingConfirmationAddressee:
          serializer.fromJson<String?>(json['readingConfirmationAddressee']),
      htmlBody: serializer.fromJson<String?>(json['htmlBody']),
      rawBody: serializer.fromJson<String?>(json['rawBody']),
      bodyForSearch: serializer.fromJson<String?>(json['bodyForSearch']),
      rtl: serializer.fromJson<bool?>(json['rtl']),
      extendInJson: serializer.fromJson<String?>(json['extendInJson']),
      safety: serializer.fromJson<bool?>(json['safety']),
      hasExternals: serializer.fromJson<bool?>(json['hasExternals']),
      foundedCIDsInJson:
          serializer.fromJson<String?>(json['foundedCIDsInJson']),
      foundedContentLocationUrlsInJson: serializer
          .fromJson<String?>(json['foundedContentLocationUrlsInJson']),
      attachmentsInJson:
          serializer.fromJson<String?>(json['attachmentsInJson']),
      toForSearch: serializer.fromJson<String?>(json['toForSearch']),
      fromForSearch: serializer.fromJson<String?>(json['fromForSearch']),
      ccForSearch: serializer.fromJson<String?>(json['ccForSearch']),
      bccForSearch: serializer.fromJson<String?>(json['bccForSearch']),
      attachmentsForSearch:
          serializer.fromJson<String?>(json['attachmentsForSearch']),
      customInJson: serializer.fromJson<String?>(json['customInJson']),
      isHtml: serializer.fromJson<bool?>(json['isHtml']),
      hasBody: serializer.fromJson<bool?>(json['hasBody']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int?>(localId),
      'uid': serializer.toJson<int>(uid),
      'accountEntityId': serializer.toJson<int?>(accountEntityId),
      'userLocalId': serializer.toJson<int?>(userLocalId),
      'uniqueUidInFolder': serializer.toJson<String?>(uniqueUidInFolder),
      'parentUid': serializer.toJson<int?>(parentUid),
      'messageId': serializer.toJson<String?>(messageId),
      'folder': serializer.toJson<String>(folder),
      'flagsInJson': serializer.toJson<String>(flagsInJson),
      'hasThread': serializer.toJson<bool?>(hasThread),
      'subject': serializer.toJson<String?>(subject),
      'size': serializer.toJson<int?>(size),
      'textSize': serializer.toJson<int?>(textSize),
      'truncated': serializer.toJson<bool?>(truncated),
      'internalTimeStampInUTC': serializer.toJson<int?>(internalTimeStampInUTC),
      'receivedOrDateTimeStampInUTC':
          serializer.toJson<int?>(receivedOrDateTimeStampInUTC),
      'timeStampInUTC': serializer.toJson<int?>(timeStampInUTC),
      'toToDisplay': serializer.toJson<String?>(toToDisplay),
      'toInJson': serializer.toJson<String?>(toInJson),
      'fromInJson': serializer.toJson<String?>(fromInJson),
      'fromToDisplay': serializer.toJson<String?>(fromToDisplay),
      'ccInJson': serializer.toJson<String?>(ccInJson),
      'bccInJson': serializer.toJson<String?>(bccInJson),
      'senderInJson': serializer.toJson<String?>(senderInJson),
      'replyToInJson': serializer.toJson<String?>(replyToInJson),
      'hasAttachments': serializer.toJson<bool?>(hasAttachments),
      'hasVcardAttachment': serializer.toJson<bool?>(hasVcardAttachment),
      'hasIcalAttachment': serializer.toJson<bool?>(hasIcalAttachment),
      'importance': serializer.toJson<int?>(importance),
      'draftInfoInJson': serializer.toJson<String?>(draftInfoInJson),
      'sensitivity': serializer.toJson<int?>(sensitivity),
      'downloadAsEmlUrl': serializer.toJson<String?>(downloadAsEmlUrl),
      'hash': serializer.toJson<String?>(hash),
      'headers': serializer.toJson<String?>(headers),
      'inReplyTo': serializer.toJson<String?>(inReplyTo),
      'references': serializer.toJson<String?>(references),
      'readingConfirmationAddressee':
          serializer.toJson<String?>(readingConfirmationAddressee),
      'htmlBody': serializer.toJson<String?>(htmlBody),
      'rawBody': serializer.toJson<String?>(rawBody),
      'bodyForSearch': serializer.toJson<String?>(bodyForSearch),
      'rtl': serializer.toJson<bool?>(rtl),
      'extendInJson': serializer.toJson<String?>(extendInJson),
      'safety': serializer.toJson<bool?>(safety),
      'hasExternals': serializer.toJson<bool?>(hasExternals),
      'foundedCIDsInJson': serializer.toJson<String?>(foundedCIDsInJson),
      'foundedContentLocationUrlsInJson':
          serializer.toJson<String?>(foundedContentLocationUrlsInJson),
      'attachmentsInJson': serializer.toJson<String?>(attachmentsInJson),
      'toForSearch': serializer.toJson<String?>(toForSearch),
      'fromForSearch': serializer.toJson<String?>(fromForSearch),
      'ccForSearch': serializer.toJson<String?>(ccForSearch),
      'bccForSearch': serializer.toJson<String?>(bccForSearch),
      'attachmentsForSearch': serializer.toJson<String?>(attachmentsForSearch),
      'customInJson': serializer.toJson<String?>(customInJson),
      'isHtml': serializer.toJson<bool?>(isHtml),
      'hasBody': serializer.toJson<bool?>(hasBody),
    };
  }

  Message copyWith(
          {int? localId,
          int? uid,
          int? accountEntityId,
          int? userLocalId,
          String? uniqueUidInFolder,
          int? parentUid,
          String? messageId,
          String? folder,
          String? flagsInJson,
          bool? hasThread,
          String? subject,
          int? size,
          int? textSize,
          bool? truncated,
          int? internalTimeStampInUTC,
          int? receivedOrDateTimeStampInUTC,
          int? timeStampInUTC,
          String? toToDisplay,
          String? toInJson,
          String? fromInJson,
          String? fromToDisplay,
          String? ccInJson,
          String? bccInJson,
          String? senderInJson,
          String? replyToInJson,
          bool? hasAttachments,
          bool? hasVcardAttachment,
          bool? hasIcalAttachment,
          int? importance,
          String? draftInfoInJson,
          int? sensitivity,
          String? downloadAsEmlUrl,
          String? hash,
          String? headers,
          String? inReplyTo,
          String? references,
          String? readingConfirmationAddressee,
          String? htmlBody,
          String? rawBody,
          String? bodyForSearch,
          bool? rtl,
          String? extendInJson,
          bool? safety,
          bool? hasExternals,
          String? foundedCIDsInJson,
          String? foundedContentLocationUrlsInJson,
          String? attachmentsInJson,
          String? toForSearch,
          String? fromForSearch,
          String? ccForSearch,
          String? bccForSearch,
          String? attachmentsForSearch,
          String? customInJson,
          bool? isHtml,
          bool? hasBody}) =>
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
        toToDisplay: toToDisplay ?? this.toToDisplay,
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
        htmlBody: htmlBody ?? this.htmlBody,
        rawBody: rawBody ?? this.rawBody,
        bodyForSearch: bodyForSearch ?? this.bodyForSearch,
        rtl: rtl ?? this.rtl,
        extendInJson: extendInJson ?? this.extendInJson,
        safety: safety ?? this.safety,
        hasExternals: hasExternals ?? this.hasExternals,
        foundedCIDsInJson: foundedCIDsInJson ?? this.foundedCIDsInJson,
        foundedContentLocationUrlsInJson: foundedContentLocationUrlsInJson ??
            this.foundedContentLocationUrlsInJson,
        attachmentsInJson: attachmentsInJson ?? this.attachmentsInJson,
        toForSearch: toForSearch ?? this.toForSearch,
        fromForSearch: fromForSearch ?? this.fromForSearch,
        ccForSearch: ccForSearch ?? this.ccForSearch,
        bccForSearch: bccForSearch ?? this.bccForSearch,
        attachmentsForSearch: attachmentsForSearch ?? this.attachmentsForSearch,
        customInJson: customInJson ?? this.customInJson,
        isHtml: isHtml ?? this.isHtml,
        hasBody: hasBody ?? this.hasBody,
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
          ..write('toToDisplay: $toToDisplay, ')
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
          ..write('htmlBody: $htmlBody, ')
          ..write('rawBody: $rawBody, ')
          ..write('bodyForSearch: $bodyForSearch, ')
          ..write('rtl: $rtl, ')
          ..write('extendInJson: $extendInJson, ')
          ..write('safety: $safety, ')
          ..write('hasExternals: $hasExternals, ')
          ..write('foundedCIDsInJson: $foundedCIDsInJson, ')
          ..write(
              'foundedContentLocationUrlsInJson: $foundedContentLocationUrlsInJson, ')
          ..write('attachmentsInJson: $attachmentsInJson, ')
          ..write('toForSearch: $toForSearch, ')
          ..write('fromForSearch: $fromForSearch, ')
          ..write('ccForSearch: $ccForSearch, ')
          ..write('bccForSearch: $bccForSearch, ')
          ..write('attachmentsForSearch: $attachmentsForSearch, ')
          ..write('customInJson: $customInJson, ')
          ..write('isHtml: $isHtml, ')
          ..write('hasBody: $hasBody')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
        toToDisplay,
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
        htmlBody,
        rawBody,
        bodyForSearch,
        rtl,
        extendInJson,
        safety,
        hasExternals,
        foundedCIDsInJson,
        foundedContentLocationUrlsInJson,
        attachmentsInJson,
        toForSearch,
        fromForSearch,
        ccForSearch,
        bccForSearch,
        attachmentsForSearch,
        customInJson,
        isHtml,
        hasBody
      ]);
  @override
  bool operator ==(Object other) =>
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
          other.toToDisplay == this.toToDisplay &&
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
          other.htmlBody == this.htmlBody &&
          other.rawBody == this.rawBody &&
          other.bodyForSearch == this.bodyForSearch &&
          other.rtl == this.rtl &&
          other.extendInJson == this.extendInJson &&
          other.safety == this.safety &&
          other.hasExternals == this.hasExternals &&
          other.foundedCIDsInJson == this.foundedCIDsInJson &&
          other.foundedContentLocationUrlsInJson ==
              this.foundedContentLocationUrlsInJson &&
          other.attachmentsInJson == this.attachmentsInJson &&
          other.toForSearch == this.toForSearch &&
          other.fromForSearch == this.fromForSearch &&
          other.ccForSearch == this.ccForSearch &&
          other.bccForSearch == this.bccForSearch &&
          other.attachmentsForSearch == this.attachmentsForSearch &&
          other.customInJson == this.customInJson &&
          other.isHtml == this.isHtml &&
          other.hasBody == this.hasBody);
}

class MailCompanion extends UpdateCompanion<Message> {
  final Value<int?> localId;
  final Value<int> uid;
  final Value<int?> accountEntityId;
  final Value<int?> userLocalId;
  final Value<String?> uniqueUidInFolder;
  final Value<int?> parentUid;
  final Value<String?> messageId;
  final Value<String> folder;
  final Value<String> flagsInJson;
  final Value<bool?> hasThread;
  final Value<String?> subject;
  final Value<int?> size;
  final Value<int?> textSize;
  final Value<bool?> truncated;
  final Value<int?> internalTimeStampInUTC;
  final Value<int?> receivedOrDateTimeStampInUTC;
  final Value<int?> timeStampInUTC;
  final Value<String?> toToDisplay;
  final Value<String?> toInJson;
  final Value<String?> fromInJson;
  final Value<String?> fromToDisplay;
  final Value<String?> ccInJson;
  final Value<String?> bccInJson;
  final Value<String?> senderInJson;
  final Value<String?> replyToInJson;
  final Value<bool?> hasAttachments;
  final Value<bool?> hasVcardAttachment;
  final Value<bool?> hasIcalAttachment;
  final Value<int?> importance;
  final Value<String?> draftInfoInJson;
  final Value<int?> sensitivity;
  final Value<String?> downloadAsEmlUrl;
  final Value<String?> hash;
  final Value<String?> headers;
  final Value<String?> inReplyTo;
  final Value<String?> references;
  final Value<String?> readingConfirmationAddressee;
  final Value<String?> htmlBody;
  final Value<String?> rawBody;
  final Value<String?> bodyForSearch;
  final Value<bool?> rtl;
  final Value<String?> extendInJson;
  final Value<bool?> safety;
  final Value<bool?> hasExternals;
  final Value<String?> foundedCIDsInJson;
  final Value<String?> foundedContentLocationUrlsInJson;
  final Value<String?> attachmentsInJson;
  final Value<String?> toForSearch;
  final Value<String?> fromForSearch;
  final Value<String?> ccForSearch;
  final Value<String?> bccForSearch;
  final Value<String?> attachmentsForSearch;
  final Value<String?> customInJson;
  final Value<bool?> isHtml;
  final Value<bool?> hasBody;
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
    this.toToDisplay = const Value.absent(),
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
    this.htmlBody = const Value.absent(),
    this.rawBody = const Value.absent(),
    this.bodyForSearch = const Value.absent(),
    this.rtl = const Value.absent(),
    this.extendInJson = const Value.absent(),
    this.safety = const Value.absent(),
    this.hasExternals = const Value.absent(),
    this.foundedCIDsInJson = const Value.absent(),
    this.foundedContentLocationUrlsInJson = const Value.absent(),
    this.attachmentsInJson = const Value.absent(),
    this.toForSearch = const Value.absent(),
    this.fromForSearch = const Value.absent(),
    this.ccForSearch = const Value.absent(),
    this.bccForSearch = const Value.absent(),
    this.attachmentsForSearch = const Value.absent(),
    this.customInJson = const Value.absent(),
    this.isHtml = const Value.absent(),
    this.hasBody = const Value.absent(),
  });
  MailCompanion.insert({
    this.localId = const Value.absent(),
    required int uid,
    this.accountEntityId = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.uniqueUidInFolder = const Value.absent(),
    this.parentUid = const Value.absent(),
    this.messageId = const Value.absent(),
    required String folder,
    required String flagsInJson,
    this.hasThread = const Value.absent(),
    this.subject = const Value.absent(),
    this.size = const Value.absent(),
    this.textSize = const Value.absent(),
    this.truncated = const Value.absent(),
    this.internalTimeStampInUTC = const Value.absent(),
    this.receivedOrDateTimeStampInUTC = const Value.absent(),
    this.timeStampInUTC = const Value.absent(),
    this.toToDisplay = const Value.absent(),
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
    this.htmlBody = const Value.absent(),
    this.rawBody = const Value.absent(),
    this.bodyForSearch = const Value.absent(),
    this.rtl = const Value.absent(),
    this.extendInJson = const Value.absent(),
    this.safety = const Value.absent(),
    this.hasExternals = const Value.absent(),
    this.foundedCIDsInJson = const Value.absent(),
    this.foundedContentLocationUrlsInJson = const Value.absent(),
    this.attachmentsInJson = const Value.absent(),
    this.toForSearch = const Value.absent(),
    this.fromForSearch = const Value.absent(),
    this.ccForSearch = const Value.absent(),
    this.bccForSearch = const Value.absent(),
    this.attachmentsForSearch = const Value.absent(),
    this.customInJson = const Value.absent(),
    this.isHtml = const Value.absent(),
    this.hasBody = const Value.absent(),
  })  : uid = Value(uid),
        folder = Value(folder),
        flagsInJson = Value(flagsInJson);
  static Insertable<Message> custom({
    Expression<int?>? localId,
    Expression<int>? uid,
    Expression<int?>? accountEntityId,
    Expression<int?>? userLocalId,
    Expression<String?>? uniqueUidInFolder,
    Expression<int?>? parentUid,
    Expression<String?>? messageId,
    Expression<String>? folder,
    Expression<String>? flagsInJson,
    Expression<bool?>? hasThread,
    Expression<String?>? subject,
    Expression<int?>? size,
    Expression<int?>? textSize,
    Expression<bool?>? truncated,
    Expression<int?>? internalTimeStampInUTC,
    Expression<int?>? receivedOrDateTimeStampInUTC,
    Expression<int?>? timeStampInUTC,
    Expression<String?>? toToDisplay,
    Expression<String?>? toInJson,
    Expression<String?>? fromInJson,
    Expression<String?>? fromToDisplay,
    Expression<String?>? ccInJson,
    Expression<String?>? bccInJson,
    Expression<String?>? senderInJson,
    Expression<String?>? replyToInJson,
    Expression<bool?>? hasAttachments,
    Expression<bool?>? hasVcardAttachment,
    Expression<bool?>? hasIcalAttachment,
    Expression<int?>? importance,
    Expression<String?>? draftInfoInJson,
    Expression<int?>? sensitivity,
    Expression<String?>? downloadAsEmlUrl,
    Expression<String?>? hash,
    Expression<String?>? headers,
    Expression<String?>? inReplyTo,
    Expression<String?>? references,
    Expression<String?>? readingConfirmationAddressee,
    Expression<String?>? htmlBody,
    Expression<String?>? rawBody,
    Expression<String?>? bodyForSearch,
    Expression<bool?>? rtl,
    Expression<String?>? extendInJson,
    Expression<bool?>? safety,
    Expression<bool?>? hasExternals,
    Expression<String?>? foundedCIDsInJson,
    Expression<String?>? foundedContentLocationUrlsInJson,
    Expression<String?>? attachmentsInJson,
    Expression<String?>? toForSearch,
    Expression<String?>? fromForSearch,
    Expression<String?>? ccForSearch,
    Expression<String?>? bccForSearch,
    Expression<String?>? attachmentsForSearch,
    Expression<String?>? customInJson,
    Expression<bool?>? isHtml,
    Expression<bool?>? hasBody,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (uid != null) 'uid': uid,
      if (accountEntityId != null) 'account_entity_id': accountEntityId,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (uniqueUidInFolder != null) 'unique_uid_in_folder': uniqueUidInFolder,
      if (parentUid != null) 'parent_uid': parentUid,
      if (messageId != null) 'message_id': messageId,
      if (folder != null) 'folder': folder,
      if (flagsInJson != null) 'flags_in_json': flagsInJson,
      if (hasThread != null) 'has_thread': hasThread,
      if (subject != null) 'subject': subject,
      if (size != null) 'size': size,
      if (textSize != null) 'text_size': textSize,
      if (truncated != null) 'truncated': truncated,
      if (internalTimeStampInUTC != null)
        'internal_time_stamp_in_u_t_c': internalTimeStampInUTC,
      if (receivedOrDateTimeStampInUTC != null)
        'received_or_date_time_stamp_in_u_t_c': receivedOrDateTimeStampInUTC,
      if (timeStampInUTC != null) 'time_stamp_in_u_t_c': timeStampInUTC,
      if (toToDisplay != null) 'to_to_display': toToDisplay,
      if (toInJson != null) 'to_in_json': toInJson,
      if (fromInJson != null) 'from_in_json': fromInJson,
      if (fromToDisplay != null) 'from_to_display': fromToDisplay,
      if (ccInJson != null) 'cc_in_json': ccInJson,
      if (bccInJson != null) 'bcc_in_json': bccInJson,
      if (senderInJson != null) 'sender_in_json': senderInJson,
      if (replyToInJson != null) 'reply_to_in_json': replyToInJson,
      if (hasAttachments != null) 'has_attachments': hasAttachments,
      if (hasVcardAttachment != null)
        'has_vcard_attachment': hasVcardAttachment,
      if (hasIcalAttachment != null) 'has_ical_attachment': hasIcalAttachment,
      if (importance != null) 'importance': importance,
      if (draftInfoInJson != null) 'draft_info_in_json': draftInfoInJson,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (downloadAsEmlUrl != null) 'download_as_eml_url': downloadAsEmlUrl,
      if (hash != null) 'hash': hash,
      if (headers != null) 'headers': headers,
      if (inReplyTo != null) 'in_reply_to': inReplyTo,
      if (references != null) 'message_references': references,
      if (readingConfirmationAddressee != null)
        'reading_confirmation_addressee': readingConfirmationAddressee,
      if (htmlBody != null) 'html_body': htmlBody,
      if (rawBody != null) 'raw_body': rawBody,
      if (bodyForSearch != null) 'body_for_search': bodyForSearch,
      if (rtl != null) 'rtl': rtl,
      if (extendInJson != null) 'extend_in_json': extendInJson,
      if (safety != null) 'safety': safety,
      if (hasExternals != null) 'has_externals': hasExternals,
      if (foundedCIDsInJson != null)
        'founded_c_i_ds_in_json': foundedCIDsInJson,
      if (foundedContentLocationUrlsInJson != null)
        'founded_content_location_urls_in_json':
            foundedContentLocationUrlsInJson,
      if (attachmentsInJson != null) 'attachments_in_json': attachmentsInJson,
      if (toForSearch != null) 'to_for_search': toForSearch,
      if (fromForSearch != null) 'from_for_search': fromForSearch,
      if (ccForSearch != null) 'cc_for_search': ccForSearch,
      if (bccForSearch != null) 'bcc_for_search': bccForSearch,
      if (attachmentsForSearch != null)
        'attachments_for_search': attachmentsForSearch,
      if (customInJson != null) 'custom_in_json': customInJson,
      if (isHtml != null) 'is_html': isHtml,
      if (hasBody != null) 'has_body': hasBody,
    });
  }

  MailCompanion copyWith(
      {Value<int?>? localId,
      Value<int>? uid,
      Value<int?>? accountEntityId,
      Value<int?>? userLocalId,
      Value<String?>? uniqueUidInFolder,
      Value<int?>? parentUid,
      Value<String?>? messageId,
      Value<String>? folder,
      Value<String>? flagsInJson,
      Value<bool?>? hasThread,
      Value<String?>? subject,
      Value<int?>? size,
      Value<int?>? textSize,
      Value<bool?>? truncated,
      Value<int?>? internalTimeStampInUTC,
      Value<int?>? receivedOrDateTimeStampInUTC,
      Value<int?>? timeStampInUTC,
      Value<String?>? toToDisplay,
      Value<String?>? toInJson,
      Value<String?>? fromInJson,
      Value<String?>? fromToDisplay,
      Value<String?>? ccInJson,
      Value<String?>? bccInJson,
      Value<String?>? senderInJson,
      Value<String?>? replyToInJson,
      Value<bool?>? hasAttachments,
      Value<bool?>? hasVcardAttachment,
      Value<bool?>? hasIcalAttachment,
      Value<int?>? importance,
      Value<String?>? draftInfoInJson,
      Value<int?>? sensitivity,
      Value<String?>? downloadAsEmlUrl,
      Value<String?>? hash,
      Value<String?>? headers,
      Value<String?>? inReplyTo,
      Value<String?>? references,
      Value<String?>? readingConfirmationAddressee,
      Value<String?>? htmlBody,
      Value<String?>? rawBody,
      Value<String?>? bodyForSearch,
      Value<bool?>? rtl,
      Value<String?>? extendInJson,
      Value<bool?>? safety,
      Value<bool?>? hasExternals,
      Value<String?>? foundedCIDsInJson,
      Value<String?>? foundedContentLocationUrlsInJson,
      Value<String?>? attachmentsInJson,
      Value<String?>? toForSearch,
      Value<String?>? fromForSearch,
      Value<String?>? ccForSearch,
      Value<String?>? bccForSearch,
      Value<String?>? attachmentsForSearch,
      Value<String?>? customInJson,
      Value<bool?>? isHtml,
      Value<bool?>? hasBody}) {
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
      toToDisplay: toToDisplay ?? this.toToDisplay,
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
      htmlBody: htmlBody ?? this.htmlBody,
      rawBody: rawBody ?? this.rawBody,
      bodyForSearch: bodyForSearch ?? this.bodyForSearch,
      rtl: rtl ?? this.rtl,
      extendInJson: extendInJson ?? this.extendInJson,
      safety: safety ?? this.safety,
      hasExternals: hasExternals ?? this.hasExternals,
      foundedCIDsInJson: foundedCIDsInJson ?? this.foundedCIDsInJson,
      foundedContentLocationUrlsInJson: foundedContentLocationUrlsInJson ??
          this.foundedContentLocationUrlsInJson,
      attachmentsInJson: attachmentsInJson ?? this.attachmentsInJson,
      toForSearch: toForSearch ?? this.toForSearch,
      fromForSearch: fromForSearch ?? this.fromForSearch,
      ccForSearch: ccForSearch ?? this.ccForSearch,
      bccForSearch: bccForSearch ?? this.bccForSearch,
      attachmentsForSearch: attachmentsForSearch ?? this.attachmentsForSearch,
      customInJson: customInJson ?? this.customInJson,
      isHtml: isHtml ?? this.isHtml,
      hasBody: hasBody ?? this.hasBody,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int?>(localId.value);
    }
    if (uid.present) {
      map['uid'] = Variable<int>(uid.value);
    }
    if (accountEntityId.present) {
      map['account_entity_id'] = Variable<int?>(accountEntityId.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int?>(userLocalId.value);
    }
    if (uniqueUidInFolder.present) {
      map['unique_uid_in_folder'] = Variable<String?>(uniqueUidInFolder.value);
    }
    if (parentUid.present) {
      map['parent_uid'] = Variable<int?>(parentUid.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String?>(messageId.value);
    }
    if (folder.present) {
      map['folder'] = Variable<String>(folder.value);
    }
    if (flagsInJson.present) {
      map['flags_in_json'] = Variable<String>(flagsInJson.value);
    }
    if (hasThread.present) {
      map['has_thread'] = Variable<bool?>(hasThread.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String?>(subject.value);
    }
    if (size.present) {
      map['size'] = Variable<int?>(size.value);
    }
    if (textSize.present) {
      map['text_size'] = Variable<int?>(textSize.value);
    }
    if (truncated.present) {
      map['truncated'] = Variable<bool?>(truncated.value);
    }
    if (internalTimeStampInUTC.present) {
      map['internal_time_stamp_in_u_t_c'] =
          Variable<int?>(internalTimeStampInUTC.value);
    }
    if (receivedOrDateTimeStampInUTC.present) {
      map['received_or_date_time_stamp_in_u_t_c'] =
          Variable<int?>(receivedOrDateTimeStampInUTC.value);
    }
    if (timeStampInUTC.present) {
      map['time_stamp_in_u_t_c'] = Variable<int?>(timeStampInUTC.value);
    }
    if (toToDisplay.present) {
      map['to_to_display'] = Variable<String?>(toToDisplay.value);
    }
    if (toInJson.present) {
      map['to_in_json'] = Variable<String?>(toInJson.value);
    }
    if (fromInJson.present) {
      map['from_in_json'] = Variable<String?>(fromInJson.value);
    }
    if (fromToDisplay.present) {
      map['from_to_display'] = Variable<String?>(fromToDisplay.value);
    }
    if (ccInJson.present) {
      map['cc_in_json'] = Variable<String?>(ccInJson.value);
    }
    if (bccInJson.present) {
      map['bcc_in_json'] = Variable<String?>(bccInJson.value);
    }
    if (senderInJson.present) {
      map['sender_in_json'] = Variable<String?>(senderInJson.value);
    }
    if (replyToInJson.present) {
      map['reply_to_in_json'] = Variable<String?>(replyToInJson.value);
    }
    if (hasAttachments.present) {
      map['has_attachments'] = Variable<bool?>(hasAttachments.value);
    }
    if (hasVcardAttachment.present) {
      map['has_vcard_attachment'] = Variable<bool?>(hasVcardAttachment.value);
    }
    if (hasIcalAttachment.present) {
      map['has_ical_attachment'] = Variable<bool?>(hasIcalAttachment.value);
    }
    if (importance.present) {
      map['importance'] = Variable<int?>(importance.value);
    }
    if (draftInfoInJson.present) {
      map['draft_info_in_json'] = Variable<String?>(draftInfoInJson.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int?>(sensitivity.value);
    }
    if (downloadAsEmlUrl.present) {
      map['download_as_eml_url'] = Variable<String?>(downloadAsEmlUrl.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String?>(hash.value);
    }
    if (headers.present) {
      map['headers'] = Variable<String?>(headers.value);
    }
    if (inReplyTo.present) {
      map['in_reply_to'] = Variable<String?>(inReplyTo.value);
    }
    if (references.present) {
      map['message_references'] = Variable<String?>(references.value);
    }
    if (readingConfirmationAddressee.present) {
      map['reading_confirmation_addressee'] =
          Variable<String?>(readingConfirmationAddressee.value);
    }
    if (htmlBody.present) {
      map['html_body'] = Variable<String?>(htmlBody.value);
    }
    if (rawBody.present) {
      map['raw_body'] = Variable<String?>(rawBody.value);
    }
    if (bodyForSearch.present) {
      map['body_for_search'] = Variable<String?>(bodyForSearch.value);
    }
    if (rtl.present) {
      map['rtl'] = Variable<bool?>(rtl.value);
    }
    if (extendInJson.present) {
      map['extend_in_json'] = Variable<String?>(extendInJson.value);
    }
    if (safety.present) {
      map['safety'] = Variable<bool?>(safety.value);
    }
    if (hasExternals.present) {
      map['has_externals'] = Variable<bool?>(hasExternals.value);
    }
    if (foundedCIDsInJson.present) {
      map['founded_c_i_ds_in_json'] =
          Variable<String?>(foundedCIDsInJson.value);
    }
    if (foundedContentLocationUrlsInJson.present) {
      map['founded_content_location_urls_in_json'] =
          Variable<String?>(foundedContentLocationUrlsInJson.value);
    }
    if (attachmentsInJson.present) {
      map['attachments_in_json'] = Variable<String?>(attachmentsInJson.value);
    }
    if (toForSearch.present) {
      map['to_for_search'] = Variable<String?>(toForSearch.value);
    }
    if (fromForSearch.present) {
      map['from_for_search'] = Variable<String?>(fromForSearch.value);
    }
    if (ccForSearch.present) {
      map['cc_for_search'] = Variable<String?>(ccForSearch.value);
    }
    if (bccForSearch.present) {
      map['bcc_for_search'] = Variable<String?>(bccForSearch.value);
    }
    if (attachmentsForSearch.present) {
      map['attachments_for_search'] =
          Variable<String?>(attachmentsForSearch.value);
    }
    if (customInJson.present) {
      map['custom_in_json'] = Variable<String?>(customInJson.value);
    }
    if (isHtml.present) {
      map['is_html'] = Variable<bool?>(isHtml.value);
    }
    if (hasBody.present) {
      map['has_body'] = Variable<bool?>(hasBody.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MailCompanion(')
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
          ..write('toToDisplay: $toToDisplay, ')
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
          ..write('htmlBody: $htmlBody, ')
          ..write('rawBody: $rawBody, ')
          ..write('bodyForSearch: $bodyForSearch, ')
          ..write('rtl: $rtl, ')
          ..write('extendInJson: $extendInJson, ')
          ..write('safety: $safety, ')
          ..write('hasExternals: $hasExternals, ')
          ..write('foundedCIDsInJson: $foundedCIDsInJson, ')
          ..write(
              'foundedContentLocationUrlsInJson: $foundedContentLocationUrlsInJson, ')
          ..write('attachmentsInJson: $attachmentsInJson, ')
          ..write('toForSearch: $toForSearch, ')
          ..write('fromForSearch: $fromForSearch, ')
          ..write('ccForSearch: $ccForSearch, ')
          ..write('bccForSearch: $bccForSearch, ')
          ..write('attachmentsForSearch: $attachmentsForSearch, ')
          ..write('customInJson: $customInJson, ')
          ..write('isHtml: $isHtml, ')
          ..write('hasBody: $hasBody')
          ..write(')'))
        .toString();
  }
}

class $MailTable extends Mail with TableInfo<$MailTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MailTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  @override
  late final GeneratedColumn<int?> localId = GeneratedColumn<int?>(
      'local_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<int?> uid = GeneratedColumn<int?>(
      'uid', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _accountEntityIdMeta =
      const VerificationMeta('accountEntityId');
  @override
  late final GeneratedColumn<int?> accountEntityId = GeneratedColumn<int?>(
      'account_entity_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _uniqueUidInFolderMeta =
      const VerificationMeta('uniqueUidInFolder');
  @override
  late final GeneratedColumn<String?> uniqueUidInFolder =
      GeneratedColumn<String?>('unique_uid_in_folder', aliasedName, true,
          type: const StringType(),
          requiredDuringInsert: false,
          $customConstraints: 'UNIQUE');
  final VerificationMeta _parentUidMeta = const VerificationMeta('parentUid');
  @override
  late final GeneratedColumn<int?> parentUid = GeneratedColumn<int?>(
      'parent_uid', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _messageIdMeta = const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<String?> messageId = GeneratedColumn<String?>(
      'message_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<String?> folder = GeneratedColumn<String?>(
      'folder', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _flagsInJsonMeta =
      const VerificationMeta('flagsInJson');
  @override
  late final GeneratedColumn<String?> flagsInJson = GeneratedColumn<String?>(
      'flags_in_json', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _hasThreadMeta = const VerificationMeta('hasThread');
  @override
  late final GeneratedColumn<bool?> hasThread = GeneratedColumn<bool?>(
      'has_thread', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_thread IN (0, 1))');
  final VerificationMeta _subjectMeta = const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String?> subject = GeneratedColumn<String?>(
      'subject', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int?> size = GeneratedColumn<int?>(
      'size', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _textSizeMeta = const VerificationMeta('textSize');
  @override
  late final GeneratedColumn<int?> textSize = GeneratedColumn<int?>(
      'text_size', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _truncatedMeta = const VerificationMeta('truncated');
  @override
  late final GeneratedColumn<bool?> truncated = GeneratedColumn<bool?>(
      'truncated', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (truncated IN (0, 1))');
  final VerificationMeta _internalTimeStampInUTCMeta =
      const VerificationMeta('internalTimeStampInUTC');
  @override
  late final GeneratedColumn<int?> internalTimeStampInUTC =
      GeneratedColumn<int?>('internal_time_stamp_in_u_t_c', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _receivedOrDateTimeStampInUTCMeta =
      const VerificationMeta('receivedOrDateTimeStampInUTC');
  @override
  late final GeneratedColumn<int?> receivedOrDateTimeStampInUTC =
      GeneratedColumn<int?>(
          'received_or_date_time_stamp_in_u_t_c', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _timeStampInUTCMeta =
      const VerificationMeta('timeStampInUTC');
  @override
  late final GeneratedColumn<int?> timeStampInUTC = GeneratedColumn<int?>(
      'time_stamp_in_u_t_c', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _toToDisplayMeta =
      const VerificationMeta('toToDisplay');
  @override
  late final GeneratedColumn<String?> toToDisplay = GeneratedColumn<String?>(
      'to_to_display', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _toInJsonMeta = const VerificationMeta('toInJson');
  @override
  late final GeneratedColumn<String?> toInJson = GeneratedColumn<String?>(
      'to_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _fromInJsonMeta = const VerificationMeta('fromInJson');
  @override
  late final GeneratedColumn<String?> fromInJson = GeneratedColumn<String?>(
      'from_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _fromToDisplayMeta =
      const VerificationMeta('fromToDisplay');
  @override
  late final GeneratedColumn<String?> fromToDisplay = GeneratedColumn<String?>(
      'from_to_display', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _ccInJsonMeta = const VerificationMeta('ccInJson');
  @override
  late final GeneratedColumn<String?> ccInJson = GeneratedColumn<String?>(
      'cc_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _bccInJsonMeta = const VerificationMeta('bccInJson');
  @override
  late final GeneratedColumn<String?> bccInJson = GeneratedColumn<String?>(
      'bcc_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _senderInJsonMeta =
      const VerificationMeta('senderInJson');
  @override
  late final GeneratedColumn<String?> senderInJson = GeneratedColumn<String?>(
      'sender_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _replyToInJsonMeta =
      const VerificationMeta('replyToInJson');
  @override
  late final GeneratedColumn<String?> replyToInJson = GeneratedColumn<String?>(
      'reply_to_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _hasAttachmentsMeta =
      const VerificationMeta('hasAttachments');
  @override
  late final GeneratedColumn<bool?> hasAttachments = GeneratedColumn<bool?>(
      'has_attachments', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_attachments IN (0, 1))');
  final VerificationMeta _hasVcardAttachmentMeta =
      const VerificationMeta('hasVcardAttachment');
  @override
  late final GeneratedColumn<bool?> hasVcardAttachment = GeneratedColumn<bool?>(
      'has_vcard_attachment', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_vcard_attachment IN (0, 1))');
  final VerificationMeta _hasIcalAttachmentMeta =
      const VerificationMeta('hasIcalAttachment');
  @override
  late final GeneratedColumn<bool?> hasIcalAttachment = GeneratedColumn<bool?>(
      'has_ical_attachment', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_ical_attachment IN (0, 1))');
  final VerificationMeta _importanceMeta = const VerificationMeta('importance');
  @override
  late final GeneratedColumn<int?> importance = GeneratedColumn<int?>(
      'importance', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _draftInfoInJsonMeta =
      const VerificationMeta('draftInfoInJson');
  @override
  late final GeneratedColumn<String?> draftInfoInJson =
      GeneratedColumn<String?>('draft_info_in_json', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _sensitivityMeta =
      const VerificationMeta('sensitivity');
  @override
  late final GeneratedColumn<int?> sensitivity = GeneratedColumn<int?>(
      'sensitivity', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _downloadAsEmlUrlMeta =
      const VerificationMeta('downloadAsEmlUrl');
  @override
  late final GeneratedColumn<String?> downloadAsEmlUrl =
      GeneratedColumn<String?>('download_as_eml_url', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String?> hash = GeneratedColumn<String?>(
      'hash', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _headersMeta = const VerificationMeta('headers');
  @override
  late final GeneratedColumn<String?> headers = GeneratedColumn<String?>(
      'headers', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _inReplyToMeta = const VerificationMeta('inReplyTo');
  @override
  late final GeneratedColumn<String?> inReplyTo = GeneratedColumn<String?>(
      'in_reply_to', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _referencesMeta = const VerificationMeta('references');
  @override
  late final GeneratedColumn<String?> references = GeneratedColumn<String?>(
      'message_references', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _readingConfirmationAddresseeMeta =
      const VerificationMeta('readingConfirmationAddressee');
  @override
  late final GeneratedColumn<String?> readingConfirmationAddressee =
      GeneratedColumn<String?>(
          'reading_confirmation_addressee', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _htmlBodyMeta = const VerificationMeta('htmlBody');
  @override
  late final GeneratedColumn<String?> htmlBody = GeneratedColumn<String?>(
      'html_body', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _rawBodyMeta = const VerificationMeta('rawBody');
  @override
  late final GeneratedColumn<String?> rawBody = GeneratedColumn<String?>(
      'raw_body', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _bodyForSearchMeta =
      const VerificationMeta('bodyForSearch');
  @override
  late final GeneratedColumn<String?> bodyForSearch = GeneratedColumn<String?>(
      'body_for_search', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _rtlMeta = const VerificationMeta('rtl');
  @override
  late final GeneratedColumn<bool?> rtl = GeneratedColumn<bool?>(
      'rtl', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (rtl IN (0, 1))');
  final VerificationMeta _extendInJsonMeta =
      const VerificationMeta('extendInJson');
  @override
  late final GeneratedColumn<String?> extendInJson = GeneratedColumn<String?>(
      'extend_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _safetyMeta = const VerificationMeta('safety');
  @override
  late final GeneratedColumn<bool?> safety = GeneratedColumn<bool?>(
      'safety', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (safety IN (0, 1))');
  final VerificationMeta _hasExternalsMeta =
      const VerificationMeta('hasExternals');
  @override
  late final GeneratedColumn<bool?> hasExternals = GeneratedColumn<bool?>(
      'has_externals', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_externals IN (0, 1))');
  final VerificationMeta _foundedCIDsInJsonMeta =
      const VerificationMeta('foundedCIDsInJson');
  @override
  late final GeneratedColumn<String?> foundedCIDsInJson =
      GeneratedColumn<String?>('founded_c_i_ds_in_json', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _foundedContentLocationUrlsInJsonMeta =
      const VerificationMeta('foundedContentLocationUrlsInJson');
  @override
  late final GeneratedColumn<String?> foundedContentLocationUrlsInJson =
      GeneratedColumn<String?>(
          'founded_content_location_urls_in_json', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _attachmentsInJsonMeta =
      const VerificationMeta('attachmentsInJson');
  @override
  late final GeneratedColumn<String?> attachmentsInJson =
      GeneratedColumn<String?>('attachments_in_json', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _toForSearchMeta =
      const VerificationMeta('toForSearch');
  @override
  late final GeneratedColumn<String?> toForSearch = GeneratedColumn<String?>(
      'to_for_search', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _fromForSearchMeta =
      const VerificationMeta('fromForSearch');
  @override
  late final GeneratedColumn<String?> fromForSearch = GeneratedColumn<String?>(
      'from_for_search', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _ccForSearchMeta =
      const VerificationMeta('ccForSearch');
  @override
  late final GeneratedColumn<String?> ccForSearch = GeneratedColumn<String?>(
      'cc_for_search', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _bccForSearchMeta =
      const VerificationMeta('bccForSearch');
  @override
  late final GeneratedColumn<String?> bccForSearch = GeneratedColumn<String?>(
      'bcc_for_search', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _attachmentsForSearchMeta =
      const VerificationMeta('attachmentsForSearch');
  @override
  late final GeneratedColumn<String?> attachmentsForSearch =
      GeneratedColumn<String?>('attachments_for_search', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _customInJsonMeta =
      const VerificationMeta('customInJson');
  @override
  late final GeneratedColumn<String?> customInJson = GeneratedColumn<String?>(
      'custom_in_json', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _isHtmlMeta = const VerificationMeta('isHtml');
  @override
  late final GeneratedColumn<bool?> isHtml = GeneratedColumn<bool?>(
      'is_html', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_html IN (0, 1))');
  final VerificationMeta _hasBodyMeta = const VerificationMeta('hasBody');
  @override
  late final GeneratedColumn<bool?> hasBody = GeneratedColumn<bool?>(
      'has_body', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_body IN (0, 1))');
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
        toToDisplay,
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
        htmlBody,
        rawBody,
        bodyForSearch,
        rtl,
        extendInJson,
        safety,
        hasExternals,
        foundedCIDsInJson,
        foundedContentLocationUrlsInJson,
        attachmentsInJson,
        toForSearch,
        fromForSearch,
        ccForSearch,
        bccForSearch,
        attachmentsForSearch,
        customInJson,
        isHtml,
        hasBody
      ];
  @override
  String get aliasedName => _alias ?? 'mail';
  @override
  String get actualTableName => 'mail';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('account_entity_id')) {
      context.handle(
          _accountEntityIdMeta,
          accountEntityId.isAcceptableOrUnknown(
              data['account_entity_id']!, _accountEntityIdMeta));
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    }
    if (data.containsKey('unique_uid_in_folder')) {
      context.handle(
          _uniqueUidInFolderMeta,
          uniqueUidInFolder.isAcceptableOrUnknown(
              data['unique_uid_in_folder']!, _uniqueUidInFolderMeta));
    }
    if (data.containsKey('parent_uid')) {
      context.handle(_parentUidMeta,
          parentUid.isAcceptableOrUnknown(data['parent_uid']!, _parentUidMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    }
    if (data.containsKey('folder')) {
      context.handle(_folderMeta,
          folder.isAcceptableOrUnknown(data['folder']!, _folderMeta));
    } else if (isInserting) {
      context.missing(_folderMeta);
    }
    if (data.containsKey('flags_in_json')) {
      context.handle(
          _flagsInJsonMeta,
          flagsInJson.isAcceptableOrUnknown(
              data['flags_in_json']!, _flagsInJsonMeta));
    } else if (isInserting) {
      context.missing(_flagsInJsonMeta);
    }
    if (data.containsKey('has_thread')) {
      context.handle(_hasThreadMeta,
          hasThread.isAcceptableOrUnknown(data['has_thread']!, _hasThreadMeta));
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('text_size')) {
      context.handle(_textSizeMeta,
          textSize.isAcceptableOrUnknown(data['text_size']!, _textSizeMeta));
    }
    if (data.containsKey('truncated')) {
      context.handle(_truncatedMeta,
          truncated.isAcceptableOrUnknown(data['truncated']!, _truncatedMeta));
    }
    if (data.containsKey('internal_time_stamp_in_u_t_c')) {
      context.handle(
          _internalTimeStampInUTCMeta,
          internalTimeStampInUTC.isAcceptableOrUnknown(
              data['internal_time_stamp_in_u_t_c']!,
              _internalTimeStampInUTCMeta));
    }
    if (data.containsKey('received_or_date_time_stamp_in_u_t_c')) {
      context.handle(
          _receivedOrDateTimeStampInUTCMeta,
          receivedOrDateTimeStampInUTC.isAcceptableOrUnknown(
              data['received_or_date_time_stamp_in_u_t_c']!,
              _receivedOrDateTimeStampInUTCMeta));
    }
    if (data.containsKey('time_stamp_in_u_t_c')) {
      context.handle(
          _timeStampInUTCMeta,
          timeStampInUTC.isAcceptableOrUnknown(
              data['time_stamp_in_u_t_c']!, _timeStampInUTCMeta));
    }
    if (data.containsKey('to_to_display')) {
      context.handle(
          _toToDisplayMeta,
          toToDisplay.isAcceptableOrUnknown(
              data['to_to_display']!, _toToDisplayMeta));
    }
    if (data.containsKey('to_in_json')) {
      context.handle(_toInJsonMeta,
          toInJson.isAcceptableOrUnknown(data['to_in_json']!, _toInJsonMeta));
    }
    if (data.containsKey('from_in_json')) {
      context.handle(
          _fromInJsonMeta,
          fromInJson.isAcceptableOrUnknown(
              data['from_in_json']!, _fromInJsonMeta));
    }
    if (data.containsKey('from_to_display')) {
      context.handle(
          _fromToDisplayMeta,
          fromToDisplay.isAcceptableOrUnknown(
              data['from_to_display']!, _fromToDisplayMeta));
    }
    if (data.containsKey('cc_in_json')) {
      context.handle(_ccInJsonMeta,
          ccInJson.isAcceptableOrUnknown(data['cc_in_json']!, _ccInJsonMeta));
    }
    if (data.containsKey('bcc_in_json')) {
      context.handle(
          _bccInJsonMeta,
          bccInJson.isAcceptableOrUnknown(
              data['bcc_in_json']!, _bccInJsonMeta));
    }
    if (data.containsKey('sender_in_json')) {
      context.handle(
          _senderInJsonMeta,
          senderInJson.isAcceptableOrUnknown(
              data['sender_in_json']!, _senderInJsonMeta));
    }
    if (data.containsKey('reply_to_in_json')) {
      context.handle(
          _replyToInJsonMeta,
          replyToInJson.isAcceptableOrUnknown(
              data['reply_to_in_json']!, _replyToInJsonMeta));
    }
    if (data.containsKey('has_attachments')) {
      context.handle(
          _hasAttachmentsMeta,
          hasAttachments.isAcceptableOrUnknown(
              data['has_attachments']!, _hasAttachmentsMeta));
    }
    if (data.containsKey('has_vcard_attachment')) {
      context.handle(
          _hasVcardAttachmentMeta,
          hasVcardAttachment.isAcceptableOrUnknown(
              data['has_vcard_attachment']!, _hasVcardAttachmentMeta));
    }
    if (data.containsKey('has_ical_attachment')) {
      context.handle(
          _hasIcalAttachmentMeta,
          hasIcalAttachment.isAcceptableOrUnknown(
              data['has_ical_attachment']!, _hasIcalAttachmentMeta));
    }
    if (data.containsKey('importance')) {
      context.handle(
          _importanceMeta,
          importance.isAcceptableOrUnknown(
              data['importance']!, _importanceMeta));
    }
    if (data.containsKey('draft_info_in_json')) {
      context.handle(
          _draftInfoInJsonMeta,
          draftInfoInJson.isAcceptableOrUnknown(
              data['draft_info_in_json']!, _draftInfoInJsonMeta));
    }
    if (data.containsKey('sensitivity')) {
      context.handle(
          _sensitivityMeta,
          sensitivity.isAcceptableOrUnknown(
              data['sensitivity']!, _sensitivityMeta));
    }
    if (data.containsKey('download_as_eml_url')) {
      context.handle(
          _downloadAsEmlUrlMeta,
          downloadAsEmlUrl.isAcceptableOrUnknown(
              data['download_as_eml_url']!, _downloadAsEmlUrlMeta));
    }
    if (data.containsKey('hash')) {
      context.handle(
          _hashMeta, hash.isAcceptableOrUnknown(data['hash']!, _hashMeta));
    }
    if (data.containsKey('headers')) {
      context.handle(_headersMeta,
          headers.isAcceptableOrUnknown(data['headers']!, _headersMeta));
    }
    if (data.containsKey('in_reply_to')) {
      context.handle(
          _inReplyToMeta,
          inReplyTo.isAcceptableOrUnknown(
              data['in_reply_to']!, _inReplyToMeta));
    }
    if (data.containsKey('message_references')) {
      context.handle(
          _referencesMeta,
          references.isAcceptableOrUnknown(
              data['message_references']!, _referencesMeta));
    }
    if (data.containsKey('reading_confirmation_addressee')) {
      context.handle(
          _readingConfirmationAddresseeMeta,
          readingConfirmationAddressee.isAcceptableOrUnknown(
              data['reading_confirmation_addressee']!,
              _readingConfirmationAddresseeMeta));
    }
    if (data.containsKey('html_body')) {
      context.handle(_htmlBodyMeta,
          htmlBody.isAcceptableOrUnknown(data['html_body']!, _htmlBodyMeta));
    }
    if (data.containsKey('raw_body')) {
      context.handle(_rawBodyMeta,
          rawBody.isAcceptableOrUnknown(data['raw_body']!, _rawBodyMeta));
    }
    if (data.containsKey('body_for_search')) {
      context.handle(
          _bodyForSearchMeta,
          bodyForSearch.isAcceptableOrUnknown(
              data['body_for_search']!, _bodyForSearchMeta));
    }
    if (data.containsKey('rtl')) {
      context.handle(
          _rtlMeta, rtl.isAcceptableOrUnknown(data['rtl']!, _rtlMeta));
    }
    if (data.containsKey('extend_in_json')) {
      context.handle(
          _extendInJsonMeta,
          extendInJson.isAcceptableOrUnknown(
              data['extend_in_json']!, _extendInJsonMeta));
    }
    if (data.containsKey('safety')) {
      context.handle(_safetyMeta,
          safety.isAcceptableOrUnknown(data['safety']!, _safetyMeta));
    }
    if (data.containsKey('has_externals')) {
      context.handle(
          _hasExternalsMeta,
          hasExternals.isAcceptableOrUnknown(
              data['has_externals']!, _hasExternalsMeta));
    }
    if (data.containsKey('founded_c_i_ds_in_json')) {
      context.handle(
          _foundedCIDsInJsonMeta,
          foundedCIDsInJson.isAcceptableOrUnknown(
              data['founded_c_i_ds_in_json']!, _foundedCIDsInJsonMeta));
    }
    if (data.containsKey('founded_content_location_urls_in_json')) {
      context.handle(
          _foundedContentLocationUrlsInJsonMeta,
          foundedContentLocationUrlsInJson.isAcceptableOrUnknown(
              data['founded_content_location_urls_in_json']!,
              _foundedContentLocationUrlsInJsonMeta));
    }
    if (data.containsKey('attachments_in_json')) {
      context.handle(
          _attachmentsInJsonMeta,
          attachmentsInJson.isAcceptableOrUnknown(
              data['attachments_in_json']!, _attachmentsInJsonMeta));
    }
    if (data.containsKey('to_for_search')) {
      context.handle(
          _toForSearchMeta,
          toForSearch.isAcceptableOrUnknown(
              data['to_for_search']!, _toForSearchMeta));
    }
    if (data.containsKey('from_for_search')) {
      context.handle(
          _fromForSearchMeta,
          fromForSearch.isAcceptableOrUnknown(
              data['from_for_search']!, _fromForSearchMeta));
    }
    if (data.containsKey('cc_for_search')) {
      context.handle(
          _ccForSearchMeta,
          ccForSearch.isAcceptableOrUnknown(
              data['cc_for_search']!, _ccForSearchMeta));
    }
    if (data.containsKey('bcc_for_search')) {
      context.handle(
          _bccForSearchMeta,
          bccForSearch.isAcceptableOrUnknown(
              data['bcc_for_search']!, _bccForSearchMeta));
    }
    if (data.containsKey('attachments_for_search')) {
      context.handle(
          _attachmentsForSearchMeta,
          attachmentsForSearch.isAcceptableOrUnknown(
              data['attachments_for_search']!, _attachmentsForSearchMeta));
    }
    if (data.containsKey('custom_in_json')) {
      context.handle(
          _customInJsonMeta,
          customInJson.isAcceptableOrUnknown(
              data['custom_in_json']!, _customInJsonMeta));
    }
    if (data.containsKey('is_html')) {
      context.handle(_isHtmlMeta,
          isHtml.isAcceptableOrUnknown(data['is_html']!, _isHtmlMeta));
    }
    if (data.containsKey('has_body')) {
      context.handle(_hasBodyMeta,
          hasBody.isAcceptableOrUnknown(data['has_body']!, _hasBodyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Message.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MailTable createAlias(String alias) {
    return $MailTable(attachedDatabase, alias);
  }
}

class CalendarDb extends DataClass implements Insertable<CalendarDb> {
  final String id;
  final String url;
  final String serverUrl;
  final String exportHash;
  final String pubHash;
  final String color;
  final String? description;
  final int userLocalId;
  final String name;
  final String owner;
  final bool isDefault;
  final bool shared;
  final bool sharedToAll;
  final int sharedToAllAccess;
  final int access;
  final List<String>? shares;
  final bool isPublic;
  final bool isSubscribed;
  final String source;
  final String syncToken;
  CalendarDb(
      {required this.id,
      required this.url,
      required this.serverUrl,
      required this.exportHash,
      required this.pubHash,
      required this.color,
      this.description,
      required this.userLocalId,
      required this.name,
      required this.owner,
      required this.isDefault,
      required this.shared,
      required this.sharedToAll,
      required this.sharedToAllAccess,
      required this.access,
      this.shares,
      required this.isPublic,
      required this.isSubscribed,
      required this.source,
      required this.syncToken});
  factory CalendarDb.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CalendarDb(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      serverUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}server_url'])!,
      exportHash: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}export_hash'])!,
      pubHash: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pub_hash'])!,
      color: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      owner: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner'])!,
      isDefault: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_default'])!,
      shared: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}shared'])!,
      sharedToAll: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}shared_to_all'])!,
      sharedToAllAccess: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}shared_to_all_access'])!,
      access: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}access'])!,
      shares: $CalendarTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}shares'])),
      isPublic: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_public'])!,
      isSubscribed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_subscribed'])!,
      source: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}source'])!,
      syncToken: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_token'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['url'] = Variable<String>(url);
    map['server_url'] = Variable<String>(serverUrl);
    map['export_hash'] = Variable<String>(exportHash);
    map['pub_hash'] = Variable<String>(pubHash);
    map['color'] = Variable<String>(color);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    map['user_local_id'] = Variable<int>(userLocalId);
    map['name'] = Variable<String>(name);
    map['owner'] = Variable<String>(owner);
    map['is_default'] = Variable<bool>(isDefault);
    map['shared'] = Variable<bool>(shared);
    map['shared_to_all'] = Variable<bool>(sharedToAll);
    map['shared_to_all_access'] = Variable<int>(sharedToAllAccess);
    map['access'] = Variable<int>(access);
    if (!nullToAbsent || shares != null) {
      final converter = $CalendarTableTable.$converter0;
      map['shares'] = Variable<String?>(converter.mapToSql(shares));
    }
    map['is_public'] = Variable<bool>(isPublic);
    map['is_subscribed'] = Variable<bool>(isSubscribed);
    map['source'] = Variable<String>(source);
    map['sync_token'] = Variable<String>(syncToken);
    return map;
  }

  CalendarTableCompanion toCompanion(bool nullToAbsent) {
    return CalendarTableCompanion(
      id: Value(id),
      url: Value(url),
      serverUrl: Value(serverUrl),
      exportHash: Value(exportHash),
      pubHash: Value(pubHash),
      color: Value(color),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      userLocalId: Value(userLocalId),
      name: Value(name),
      owner: Value(owner),
      isDefault: Value(isDefault),
      shared: Value(shared),
      sharedToAll: Value(sharedToAll),
      sharedToAllAccess: Value(sharedToAllAccess),
      access: Value(access),
      shares:
          shares == null && nullToAbsent ? const Value.absent() : Value(shares),
      isPublic: Value(isPublic),
      isSubscribed: Value(isSubscribed),
      source: Value(source),
      syncToken: Value(syncToken),
    );
  }

  factory CalendarDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarDb(
      id: serializer.fromJson<String>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      serverUrl: serializer.fromJson<String>(json['serverUrl']),
      exportHash: serializer.fromJson<String>(json['exportHash']),
      pubHash: serializer.fromJson<String>(json['pubHash']),
      color: serializer.fromJson<String>(json['color']),
      description: serializer.fromJson<String?>(json['description']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      name: serializer.fromJson<String>(json['name']),
      owner: serializer.fromJson<String>(json['owner']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      shared: serializer.fromJson<bool>(json['shared']),
      sharedToAll: serializer.fromJson<bool>(json['sharedToAll']),
      sharedToAllAccess: serializer.fromJson<int>(json['sharedToAllAccess']),
      access: serializer.fromJson<int>(json['access']),
      shares: serializer.fromJson<List<String>?>(json['shares']),
      isPublic: serializer.fromJson<bool>(json['isPublic']),
      isSubscribed: serializer.fromJson<bool>(json['isSubscribed']),
      source: serializer.fromJson<String>(json['source']),
      syncToken: serializer.fromJson<String>(json['syncToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'url': serializer.toJson<String>(url),
      'serverUrl': serializer.toJson<String>(serverUrl),
      'exportHash': serializer.toJson<String>(exportHash),
      'pubHash': serializer.toJson<String>(pubHash),
      'color': serializer.toJson<String>(color),
      'description': serializer.toJson<String?>(description),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'name': serializer.toJson<String>(name),
      'owner': serializer.toJson<String>(owner),
      'isDefault': serializer.toJson<bool>(isDefault),
      'shared': serializer.toJson<bool>(shared),
      'sharedToAll': serializer.toJson<bool>(sharedToAll),
      'sharedToAllAccess': serializer.toJson<int>(sharedToAllAccess),
      'access': serializer.toJson<int>(access),
      'shares': serializer.toJson<List<String>?>(shares),
      'isPublic': serializer.toJson<bool>(isPublic),
      'isSubscribed': serializer.toJson<bool>(isSubscribed),
      'source': serializer.toJson<String>(source),
      'syncToken': serializer.toJson<String>(syncToken),
    };
  }

  CalendarDb copyWith(
          {String? id,
          String? url,
          String? serverUrl,
          String? exportHash,
          String? pubHash,
          String? color,
          String? description,
          int? userLocalId,
          String? name,
          String? owner,
          bool? isDefault,
          bool? shared,
          bool? sharedToAll,
          int? sharedToAllAccess,
          int? access,
          List<String>? shares,
          bool? isPublic,
          bool? isSubscribed,
          String? source,
          String? syncToken}) =>
      CalendarDb(
        id: id ?? this.id,
        url: url ?? this.url,
        serverUrl: serverUrl ?? this.serverUrl,
        exportHash: exportHash ?? this.exportHash,
        pubHash: pubHash ?? this.pubHash,
        color: color ?? this.color,
        description: description ?? this.description,
        userLocalId: userLocalId ?? this.userLocalId,
        name: name ?? this.name,
        owner: owner ?? this.owner,
        isDefault: isDefault ?? this.isDefault,
        shared: shared ?? this.shared,
        sharedToAll: sharedToAll ?? this.sharedToAll,
        sharedToAllAccess: sharedToAllAccess ?? this.sharedToAllAccess,
        access: access ?? this.access,
        shares: shares ?? this.shares,
        isPublic: isPublic ?? this.isPublic,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        source: source ?? this.source,
        syncToken: syncToken ?? this.syncToken,
      );
  @override
  String toString() {
    return (StringBuffer('CalendarDb(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('exportHash: $exportHash, ')
          ..write('pubHash: $pubHash, ')
          ..write('color: $color, ')
          ..write('description: $description, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('name: $name, ')
          ..write('owner: $owner, ')
          ..write('isDefault: $isDefault, ')
          ..write('shared: $shared, ')
          ..write('sharedToAll: $sharedToAll, ')
          ..write('sharedToAllAccess: $sharedToAllAccess, ')
          ..write('access: $access, ')
          ..write('shares: $shares, ')
          ..write('isPublic: $isPublic, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('source: $source, ')
          ..write('syncToken: $syncToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      url,
      serverUrl,
      exportHash,
      pubHash,
      color,
      description,
      userLocalId,
      name,
      owner,
      isDefault,
      shared,
      sharedToAll,
      sharedToAllAccess,
      access,
      shares,
      isPublic,
      isSubscribed,
      source,
      syncToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarDb &&
          other.id == this.id &&
          other.url == this.url &&
          other.serverUrl == this.serverUrl &&
          other.exportHash == this.exportHash &&
          other.pubHash == this.pubHash &&
          other.color == this.color &&
          other.description == this.description &&
          other.userLocalId == this.userLocalId &&
          other.name == this.name &&
          other.owner == this.owner &&
          other.isDefault == this.isDefault &&
          other.shared == this.shared &&
          other.sharedToAll == this.sharedToAll &&
          other.sharedToAllAccess == this.sharedToAllAccess &&
          other.access == this.access &&
          other.shares == this.shares &&
          other.isPublic == this.isPublic &&
          other.isSubscribed == this.isSubscribed &&
          other.source == this.source &&
          other.syncToken == this.syncToken);
}

class CalendarTableCompanion extends UpdateCompanion<CalendarDb> {
  final Value<String> id;
  final Value<String> url;
  final Value<String> serverUrl;
  final Value<String> exportHash;
  final Value<String> pubHash;
  final Value<String> color;
  final Value<String?> description;
  final Value<int> userLocalId;
  final Value<String> name;
  final Value<String> owner;
  final Value<bool> isDefault;
  final Value<bool> shared;
  final Value<bool> sharedToAll;
  final Value<int> sharedToAllAccess;
  final Value<int> access;
  final Value<List<String>?> shares;
  final Value<bool> isPublic;
  final Value<bool> isSubscribed;
  final Value<String> source;
  final Value<String> syncToken;
  const CalendarTableCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.serverUrl = const Value.absent(),
    this.exportHash = const Value.absent(),
    this.pubHash = const Value.absent(),
    this.color = const Value.absent(),
    this.description = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.name = const Value.absent(),
    this.owner = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.shared = const Value.absent(),
    this.sharedToAll = const Value.absent(),
    this.sharedToAllAccess = const Value.absent(),
    this.access = const Value.absent(),
    this.shares = const Value.absent(),
    this.isPublic = const Value.absent(),
    this.isSubscribed = const Value.absent(),
    this.source = const Value.absent(),
    this.syncToken = const Value.absent(),
  });
  CalendarTableCompanion.insert({
    required String id,
    required String url,
    required String serverUrl,
    required String exportHash,
    required String pubHash,
    required String color,
    this.description = const Value.absent(),
    required int userLocalId,
    required String name,
    required String owner,
    required bool isDefault,
    required bool shared,
    required bool sharedToAll,
    required int sharedToAllAccess,
    required int access,
    this.shares = const Value.absent(),
    required bool isPublic,
    required bool isSubscribed,
    required String source,
    required String syncToken,
  })  : id = Value(id),
        url = Value(url),
        serverUrl = Value(serverUrl),
        exportHash = Value(exportHash),
        pubHash = Value(pubHash),
        color = Value(color),
        userLocalId = Value(userLocalId),
        name = Value(name),
        owner = Value(owner),
        isDefault = Value(isDefault),
        shared = Value(shared),
        sharedToAll = Value(sharedToAll),
        sharedToAllAccess = Value(sharedToAllAccess),
        access = Value(access),
        isPublic = Value(isPublic),
        isSubscribed = Value(isSubscribed),
        source = Value(source),
        syncToken = Value(syncToken);
  static Insertable<CalendarDb> custom({
    Expression<String>? id,
    Expression<String>? url,
    Expression<String>? serverUrl,
    Expression<String>? exportHash,
    Expression<String>? pubHash,
    Expression<String>? color,
    Expression<String?>? description,
    Expression<int>? userLocalId,
    Expression<String>? name,
    Expression<String>? owner,
    Expression<bool>? isDefault,
    Expression<bool>? shared,
    Expression<bool>? sharedToAll,
    Expression<int>? sharedToAllAccess,
    Expression<int>? access,
    Expression<List<String>?>? shares,
    Expression<bool>? isPublic,
    Expression<bool>? isSubscribed,
    Expression<String>? source,
    Expression<String>? syncToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (serverUrl != null) 'server_url': serverUrl,
      if (exportHash != null) 'export_hash': exportHash,
      if (pubHash != null) 'pub_hash': pubHash,
      if (color != null) 'color': color,
      if (description != null) 'description': description,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (name != null) 'name': name,
      if (owner != null) 'owner': owner,
      if (isDefault != null) 'is_default': isDefault,
      if (shared != null) 'shared': shared,
      if (sharedToAll != null) 'shared_to_all': sharedToAll,
      if (sharedToAllAccess != null) 'shared_to_all_access': sharedToAllAccess,
      if (access != null) 'access': access,
      if (shares != null) 'shares': shares,
      if (isPublic != null) 'is_public': isPublic,
      if (isSubscribed != null) 'is_subscribed': isSubscribed,
      if (source != null) 'source': source,
      if (syncToken != null) 'sync_token': syncToken,
    });
  }

  CalendarTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? url,
      Value<String>? serverUrl,
      Value<String>? exportHash,
      Value<String>? pubHash,
      Value<String>? color,
      Value<String?>? description,
      Value<int>? userLocalId,
      Value<String>? name,
      Value<String>? owner,
      Value<bool>? isDefault,
      Value<bool>? shared,
      Value<bool>? sharedToAll,
      Value<int>? sharedToAllAccess,
      Value<int>? access,
      Value<List<String>?>? shares,
      Value<bool>? isPublic,
      Value<bool>? isSubscribed,
      Value<String>? source,
      Value<String>? syncToken}) {
    return CalendarTableCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      serverUrl: serverUrl ?? this.serverUrl,
      exportHash: exportHash ?? this.exportHash,
      pubHash: pubHash ?? this.pubHash,
      color: color ?? this.color,
      description: description ?? this.description,
      userLocalId: userLocalId ?? this.userLocalId,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      isDefault: isDefault ?? this.isDefault,
      shared: shared ?? this.shared,
      sharedToAll: sharedToAll ?? this.sharedToAll,
      sharedToAllAccess: sharedToAllAccess ?? this.sharedToAllAccess,
      access: access ?? this.access,
      shares: shares ?? this.shares,
      isPublic: isPublic ?? this.isPublic,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      source: source ?? this.source,
      syncToken: syncToken ?? this.syncToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (serverUrl.present) {
      map['server_url'] = Variable<String>(serverUrl.value);
    }
    if (exportHash.present) {
      map['export_hash'] = Variable<String>(exportHash.value);
    }
    if (pubHash.present) {
      map['pub_hash'] = Variable<String>(pubHash.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int>(userLocalId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (shared.present) {
      map['shared'] = Variable<bool>(shared.value);
    }
    if (sharedToAll.present) {
      map['shared_to_all'] = Variable<bool>(sharedToAll.value);
    }
    if (sharedToAllAccess.present) {
      map['shared_to_all_access'] = Variable<int>(sharedToAllAccess.value);
    }
    if (access.present) {
      map['access'] = Variable<int>(access.value);
    }
    if (shares.present) {
      final converter = $CalendarTableTable.$converter0;
      map['shares'] = Variable<String?>(converter.mapToSql(shares.value));
    }
    if (isPublic.present) {
      map['is_public'] = Variable<bool>(isPublic.value);
    }
    if (isSubscribed.present) {
      map['is_subscribed'] = Variable<bool>(isSubscribed.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (syncToken.present) {
      map['sync_token'] = Variable<String>(syncToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarTableCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('exportHash: $exportHash, ')
          ..write('pubHash: $pubHash, ')
          ..write('color: $color, ')
          ..write('description: $description, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('name: $name, ')
          ..write('owner: $owner, ')
          ..write('isDefault: $isDefault, ')
          ..write('shared: $shared, ')
          ..write('sharedToAll: $sharedToAll, ')
          ..write('sharedToAllAccess: $sharedToAllAccess, ')
          ..write('access: $access, ')
          ..write('shares: $shares, ')
          ..write('isPublic: $isPublic, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('source: $source, ')
          ..write('syncToken: $syncToken')
          ..write(')'))
        .toString();
  }
}

class $CalendarTableTable extends CalendarTable
    with TableInfo<$CalendarTableTable, CalendarDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _serverUrlMeta = const VerificationMeta('serverUrl');
  @override
  late final GeneratedColumn<String?> serverUrl = GeneratedColumn<String?>(
      'server_url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _exportHashMeta = const VerificationMeta('exportHash');
  @override
  late final GeneratedColumn<String?> exportHash = GeneratedColumn<String?>(
      'export_hash', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pubHashMeta = const VerificationMeta('pubHash');
  @override
  late final GeneratedColumn<String?> pubHash = GeneratedColumn<String?>(
      'pub_hash', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String?> color = GeneratedColumn<String?>(
      'color', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String?> owner = GeneratedColumn<String?>(
      'owner', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isDefaultMeta = const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool?> isDefault = GeneratedColumn<bool?>(
      'is_default', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_default IN (0, 1))');
  final VerificationMeta _sharedMeta = const VerificationMeta('shared');
  @override
  late final GeneratedColumn<bool?> shared = GeneratedColumn<bool?>(
      'shared', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (shared IN (0, 1))');
  final VerificationMeta _sharedToAllMeta =
      const VerificationMeta('sharedToAll');
  @override
  late final GeneratedColumn<bool?> sharedToAll = GeneratedColumn<bool?>(
      'shared_to_all', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (shared_to_all IN (0, 1))');
  final VerificationMeta _sharedToAllAccessMeta =
      const VerificationMeta('sharedToAllAccess');
  @override
  late final GeneratedColumn<int?> sharedToAllAccess = GeneratedColumn<int?>(
      'shared_to_all_access', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _accessMeta = const VerificationMeta('access');
  @override
  late final GeneratedColumn<int?> access = GeneratedColumn<int?>(
      'access', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String?> shares =
      GeneratedColumn<String?>('shares', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<List<String>>($CalendarTableTable.$converter0);
  final VerificationMeta _isPublicMeta = const VerificationMeta('isPublic');
  @override
  late final GeneratedColumn<bool?> isPublic = GeneratedColumn<bool?>(
      'is_public', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_public IN (0, 1))');
  final VerificationMeta _isSubscribedMeta =
      const VerificationMeta('isSubscribed');
  @override
  late final GeneratedColumn<bool?> isSubscribed = GeneratedColumn<bool?>(
      'is_subscribed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_subscribed IN (0, 1))');
  final VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String?> source = GeneratedColumn<String?>(
      'source', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _syncTokenMeta = const VerificationMeta('syncToken');
  @override
  late final GeneratedColumn<String?> syncToken = GeneratedColumn<String?>(
      'sync_token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        url,
        serverUrl,
        exportHash,
        pubHash,
        color,
        description,
        userLocalId,
        name,
        owner,
        isDefault,
        shared,
        sharedToAll,
        sharedToAllAccess,
        access,
        shares,
        isPublic,
        isSubscribed,
        source,
        syncToken
      ];
  @override
  String get aliasedName => _alias ?? 'calendar_table';
  @override
  String get actualTableName => 'calendar_table';
  @override
  VerificationContext validateIntegrity(Insertable<CalendarDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('server_url')) {
      context.handle(_serverUrlMeta,
          serverUrl.isAcceptableOrUnknown(data['server_url']!, _serverUrlMeta));
    } else if (isInserting) {
      context.missing(_serverUrlMeta);
    }
    if (data.containsKey('export_hash')) {
      context.handle(
          _exportHashMeta,
          exportHash.isAcceptableOrUnknown(
              data['export_hash']!, _exportHashMeta));
    } else if (isInserting) {
      context.missing(_exportHashMeta);
    }
    if (data.containsKey('pub_hash')) {
      context.handle(_pubHashMeta,
          pubHash.isAcceptableOrUnknown(data['pub_hash']!, _pubHashMeta));
    } else if (isInserting) {
      context.missing(_pubHashMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    } else if (isInserting) {
      context.missing(_ownerMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    } else if (isInserting) {
      context.missing(_isDefaultMeta);
    }
    if (data.containsKey('shared')) {
      context.handle(_sharedMeta,
          shared.isAcceptableOrUnknown(data['shared']!, _sharedMeta));
    } else if (isInserting) {
      context.missing(_sharedMeta);
    }
    if (data.containsKey('shared_to_all')) {
      context.handle(
          _sharedToAllMeta,
          sharedToAll.isAcceptableOrUnknown(
              data['shared_to_all']!, _sharedToAllMeta));
    } else if (isInserting) {
      context.missing(_sharedToAllMeta);
    }
    if (data.containsKey('shared_to_all_access')) {
      context.handle(
          _sharedToAllAccessMeta,
          sharedToAllAccess.isAcceptableOrUnknown(
              data['shared_to_all_access']!, _sharedToAllAccessMeta));
    } else if (isInserting) {
      context.missing(_sharedToAllAccessMeta);
    }
    if (data.containsKey('access')) {
      context.handle(_accessMeta,
          access.isAcceptableOrUnknown(data['access']!, _accessMeta));
    } else if (isInserting) {
      context.missing(_accessMeta);
    }
    context.handle(_sharesMeta, const VerificationResult.success());
    if (data.containsKey('is_public')) {
      context.handle(_isPublicMeta,
          isPublic.isAcceptableOrUnknown(data['is_public']!, _isPublicMeta));
    } else if (isInserting) {
      context.missing(_isPublicMeta);
    }
    if (data.containsKey('is_subscribed')) {
      context.handle(
          _isSubscribedMeta,
          isSubscribed.isAcceptableOrUnknown(
              data['is_subscribed']!, _isSubscribedMeta));
    } else if (isInserting) {
      context.missing(_isSubscribedMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('sync_token')) {
      context.handle(_syncTokenMeta,
          syncToken.isAcceptableOrUnknown(data['sync_token']!, _syncTokenMeta));
    } else if (isInserting) {
      context.missing(_syncTokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, userLocalId};
  @override
  CalendarDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CalendarDb.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CalendarTableTable createAlias(String alias) {
    return $CalendarTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converter0 =
      const ListStringConverter();
}

class ActivityDb extends DataClass implements Insertable<ActivityDb> {
  final ActivityType? type;
  final String? organizer;
  final bool? appointment;
  final int? appointmentAccess;
  final String calendarId;
  final int userLocalId;
  final String uid;
  final String? subject;
  final String? description;
  final String? location;
  final DateTime? startTS;
  final DateTime? endTS;
  final bool? allDay;
  final String? owner;
  final bool? modified;
  final int? recurrenceId;
  final int? lastModified;
  final String? remindersString;
  final bool? status;
  final bool? withDate;
  final bool? isPrivate;
  final UpdateStatus updateStatus;
  final bool synced;
  final bool onceLoaded;
  final RecurrenceMode? recurrenceMode;
  final EveryWeekFrequency? recurrenceWeeklyFrequency;
  final DateTime? recurrenceUntilDate;
  final String? recurrenceWeekDaysString;
  final List<String>? attendees;
  ActivityDb(
      {this.type,
      this.organizer,
      this.appointment,
      this.appointmentAccess,
      required this.calendarId,
      required this.userLocalId,
      required this.uid,
      this.subject,
      this.description,
      this.location,
      this.startTS,
      this.endTS,
      this.allDay,
      this.owner,
      this.modified,
      this.recurrenceId,
      this.lastModified,
      this.remindersString,
      this.status,
      this.withDate,
      this.isPrivate,
      required this.updateStatus,
      required this.synced,
      required this.onceLoaded,
      this.recurrenceMode,
      this.recurrenceWeeklyFrequency,
      this.recurrenceUntilDate,
      this.recurrenceWeekDaysString,
      this.attendees});
  factory ActivityDb.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ActivityDb(
      type: $ActivityTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      organizer: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}organizer']),
      appointment: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}appointment']),
      appointmentAccess: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}appointment_access']),
      calendarId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}calendar_id'])!,
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id'])!,
      uid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uid'])!,
      subject: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}subject']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      location: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      startTS: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}start_t_s']),
      endTS: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}end_t_s']),
      allDay: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}all_day']),
      owner: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner']),
      modified: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}modified']),
      recurrenceId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}recurrence_id']),
      lastModified: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_modified']),
      remindersString: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}reminders_string']),
      status: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status']),
      withDate: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}with_date']),
      isPrivate: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_private']),
      updateStatus: $ActivityTableTable.$converter1.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}update_status']))!,
      synced: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}synced'])!,
      onceLoaded: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}once_loaded'])!,
      recurrenceMode: $ActivityTableTable.$converter2.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}recurrence_mode'])),
      recurrenceWeeklyFrequency: $ActivityTableTable.$converter3.mapToDart(
          const IntType().mapFromDatabaseResponse(
              data['${effectivePrefix}recurrence_weekly_frequency'])),
      recurrenceUntilDate: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}recurrence_until_date']),
      recurrenceWeekDaysString: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}recurrence_week_days_string']),
      attendees: $ActivityTableTable.$converter4.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attendees'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || type != null) {
      final converter = $ActivityTableTable.$converter0;
      map['type'] = Variable<int?>(converter.mapToSql(type));
    }
    if (!nullToAbsent || organizer != null) {
      map['organizer'] = Variable<String?>(organizer);
    }
    if (!nullToAbsent || appointment != null) {
      map['appointment'] = Variable<bool?>(appointment);
    }
    if (!nullToAbsent || appointmentAccess != null) {
      map['appointment_access'] = Variable<int?>(appointmentAccess);
    }
    map['calendar_id'] = Variable<String>(calendarId);
    map['user_local_id'] = Variable<int>(userLocalId);
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String?>(subject);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String?>(location);
    }
    if (!nullToAbsent || startTS != null) {
      map['start_t_s'] = Variable<DateTime?>(startTS);
    }
    if (!nullToAbsent || endTS != null) {
      map['end_t_s'] = Variable<DateTime?>(endTS);
    }
    if (!nullToAbsent || allDay != null) {
      map['all_day'] = Variable<bool?>(allDay);
    }
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<String?>(owner);
    }
    if (!nullToAbsent || modified != null) {
      map['modified'] = Variable<bool?>(modified);
    }
    if (!nullToAbsent || recurrenceId != null) {
      map['recurrence_id'] = Variable<int?>(recurrenceId);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<int?>(lastModified);
    }
    if (!nullToAbsent || remindersString != null) {
      map['reminders_string'] = Variable<String?>(remindersString);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<bool?>(status);
    }
    if (!nullToAbsent || withDate != null) {
      map['with_date'] = Variable<bool?>(withDate);
    }
    if (!nullToAbsent || isPrivate != null) {
      map['is_private'] = Variable<bool?>(isPrivate);
    }
    {
      final converter = $ActivityTableTable.$converter1;
      map['update_status'] = Variable<int>(converter.mapToSql(updateStatus)!);
    }
    map['synced'] = Variable<bool>(synced);
    map['once_loaded'] = Variable<bool>(onceLoaded);
    if (!nullToAbsent || recurrenceMode != null) {
      final converter = $ActivityTableTable.$converter2;
      map['recurrence_mode'] =
          Variable<int?>(converter.mapToSql(recurrenceMode));
    }
    if (!nullToAbsent || recurrenceWeeklyFrequency != null) {
      final converter = $ActivityTableTable.$converter3;
      map['recurrence_weekly_frequency'] =
          Variable<int?>(converter.mapToSql(recurrenceWeeklyFrequency));
    }
    if (!nullToAbsent || recurrenceUntilDate != null) {
      map['recurrence_until_date'] = Variable<DateTime?>(recurrenceUntilDate);
    }
    if (!nullToAbsent || recurrenceWeekDaysString != null) {
      map['recurrence_week_days_string'] =
          Variable<String?>(recurrenceWeekDaysString);
    }
    if (!nullToAbsent || attendees != null) {
      final converter = $ActivityTableTable.$converter4;
      map['attendees'] = Variable<String?>(converter.mapToSql(attendees));
    }
    return map;
  }

  ActivityTableCompanion toCompanion(bool nullToAbsent) {
    return ActivityTableCompanion(
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      organizer: organizer == null && nullToAbsent
          ? const Value.absent()
          : Value(organizer),
      appointment: appointment == null && nullToAbsent
          ? const Value.absent()
          : Value(appointment),
      appointmentAccess: appointmentAccess == null && nullToAbsent
          ? const Value.absent()
          : Value(appointmentAccess),
      calendarId: Value(calendarId),
      userLocalId: Value(userLocalId),
      uid: Value(uid),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      startTS: startTS == null && nullToAbsent
          ? const Value.absent()
          : Value(startTS),
      endTS:
          endTS == null && nullToAbsent ? const Value.absent() : Value(endTS),
      allDay:
          allDay == null && nullToAbsent ? const Value.absent() : Value(allDay),
      owner:
          owner == null && nullToAbsent ? const Value.absent() : Value(owner),
      modified: modified == null && nullToAbsent
          ? const Value.absent()
          : Value(modified),
      recurrenceId: recurrenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceId),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
      remindersString: remindersString == null && nullToAbsent
          ? const Value.absent()
          : Value(remindersString),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      withDate: withDate == null && nullToAbsent
          ? const Value.absent()
          : Value(withDate),
      isPrivate: isPrivate == null && nullToAbsent
          ? const Value.absent()
          : Value(isPrivate),
      updateStatus: Value(updateStatus),
      synced: Value(synced),
      onceLoaded: Value(onceLoaded),
      recurrenceMode: recurrenceMode == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceMode),
      recurrenceWeeklyFrequency:
          recurrenceWeeklyFrequency == null && nullToAbsent
              ? const Value.absent()
              : Value(recurrenceWeeklyFrequency),
      recurrenceUntilDate: recurrenceUntilDate == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceUntilDate),
      recurrenceWeekDaysString: recurrenceWeekDaysString == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceWeekDaysString),
      attendees: attendees == null && nullToAbsent
          ? const Value.absent()
          : Value(attendees),
    );
  }

  factory ActivityDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityDb(
      type: serializer.fromJson<ActivityType?>(json['type']),
      organizer: serializer.fromJson<String?>(json['organizer']),
      appointment: serializer.fromJson<bool?>(json['appointment']),
      appointmentAccess: serializer.fromJson<int?>(json['appointmentAccess']),
      calendarId: serializer.fromJson<String>(json['calendarId']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      uid: serializer.fromJson<String>(json['uid']),
      subject: serializer.fromJson<String?>(json['subject']),
      description: serializer.fromJson<String?>(json['description']),
      location: serializer.fromJson<String?>(json['location']),
      startTS: serializer.fromJson<DateTime?>(json['startTS']),
      endTS: serializer.fromJson<DateTime?>(json['endTS']),
      allDay: serializer.fromJson<bool?>(json['allDay']),
      owner: serializer.fromJson<String?>(json['owner']),
      modified: serializer.fromJson<bool?>(json['modified']),
      recurrenceId: serializer.fromJson<int?>(json['recurrenceId']),
      lastModified: serializer.fromJson<int?>(json['lastModified']),
      remindersString: serializer.fromJson<String?>(json['remindersString']),
      status: serializer.fromJson<bool?>(json['status']),
      withDate: serializer.fromJson<bool?>(json['withDate']),
      isPrivate: serializer.fromJson<bool?>(json['isPrivate']),
      updateStatus: serializer.fromJson<UpdateStatus>(json['updateStatus']),
      synced: serializer.fromJson<bool>(json['synced']),
      onceLoaded: serializer.fromJson<bool>(json['onceLoaded']),
      recurrenceMode:
          serializer.fromJson<RecurrenceMode?>(json['recurrenceMode']),
      recurrenceWeeklyFrequency: serializer
          .fromJson<EveryWeekFrequency?>(json['recurrenceWeeklyFrequency']),
      recurrenceUntilDate:
          serializer.fromJson<DateTime?>(json['recurrenceUntilDate']),
      recurrenceWeekDaysString:
          serializer.fromJson<String?>(json['recurrenceWeekDaysString']),
      attendees: serializer.fromJson<List<String>?>(json['attendees']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<ActivityType?>(type),
      'organizer': serializer.toJson<String?>(organizer),
      'appointment': serializer.toJson<bool?>(appointment),
      'appointmentAccess': serializer.toJson<int?>(appointmentAccess),
      'calendarId': serializer.toJson<String>(calendarId),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'uid': serializer.toJson<String>(uid),
      'subject': serializer.toJson<String?>(subject),
      'description': serializer.toJson<String?>(description),
      'location': serializer.toJson<String?>(location),
      'startTS': serializer.toJson<DateTime?>(startTS),
      'endTS': serializer.toJson<DateTime?>(endTS),
      'allDay': serializer.toJson<bool?>(allDay),
      'owner': serializer.toJson<String?>(owner),
      'modified': serializer.toJson<bool?>(modified),
      'recurrenceId': serializer.toJson<int?>(recurrenceId),
      'lastModified': serializer.toJson<int?>(lastModified),
      'remindersString': serializer.toJson<String?>(remindersString),
      'status': serializer.toJson<bool?>(status),
      'withDate': serializer.toJson<bool?>(withDate),
      'isPrivate': serializer.toJson<bool?>(isPrivate),
      'updateStatus': serializer.toJson<UpdateStatus>(updateStatus),
      'synced': serializer.toJson<bool>(synced),
      'onceLoaded': serializer.toJson<bool>(onceLoaded),
      'recurrenceMode': serializer.toJson<RecurrenceMode?>(recurrenceMode),
      'recurrenceWeeklyFrequency':
          serializer.toJson<EveryWeekFrequency?>(recurrenceWeeklyFrequency),
      'recurrenceUntilDate': serializer.toJson<DateTime?>(recurrenceUntilDate),
      'recurrenceWeekDaysString':
          serializer.toJson<String?>(recurrenceWeekDaysString),
      'attendees': serializer.toJson<List<String>?>(attendees),
    };
  }

  ActivityDb copyWith(
          {ActivityType? type,
          String? organizer,
          bool? appointment,
          int? appointmentAccess,
          String? calendarId,
          int? userLocalId,
          String? uid,
          String? subject,
          String? description,
          String? location,
          DateTime? startTS,
          DateTime? endTS,
          bool? allDay,
          String? owner,
          bool? modified,
          int? recurrenceId,
          int? lastModified,
          String? remindersString,
          bool? status,
          bool? withDate,
          bool? isPrivate,
          UpdateStatus? updateStatus,
          bool? synced,
          bool? onceLoaded,
          RecurrenceMode? recurrenceMode,
          EveryWeekFrequency? recurrenceWeeklyFrequency,
          DateTime? recurrenceUntilDate,
          String? recurrenceWeekDaysString,
          List<String>? attendees}) =>
      ActivityDb(
        type: type ?? this.type,
        organizer: organizer ?? this.organizer,
        appointment: appointment ?? this.appointment,
        appointmentAccess: appointmentAccess ?? this.appointmentAccess,
        calendarId: calendarId ?? this.calendarId,
        userLocalId: userLocalId ?? this.userLocalId,
        uid: uid ?? this.uid,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        location: location ?? this.location,
        startTS: startTS ?? this.startTS,
        endTS: endTS ?? this.endTS,
        allDay: allDay ?? this.allDay,
        owner: owner ?? this.owner,
        modified: modified ?? this.modified,
        recurrenceId: recurrenceId ?? this.recurrenceId,
        lastModified: lastModified ?? this.lastModified,
        remindersString: remindersString ?? this.remindersString,
        status: status ?? this.status,
        withDate: withDate ?? this.withDate,
        isPrivate: isPrivate ?? this.isPrivate,
        updateStatus: updateStatus ?? this.updateStatus,
        synced: synced ?? this.synced,
        onceLoaded: onceLoaded ?? this.onceLoaded,
        recurrenceMode: recurrenceMode ?? this.recurrenceMode,
        recurrenceWeeklyFrequency:
            recurrenceWeeklyFrequency ?? this.recurrenceWeeklyFrequency,
        recurrenceUntilDate: recurrenceUntilDate ?? this.recurrenceUntilDate,
        recurrenceWeekDaysString:
            recurrenceWeekDaysString ?? this.recurrenceWeekDaysString,
        attendees: attendees ?? this.attendees,
      );
  @override
  String toString() {
    return (StringBuffer('ActivityDb(')
          ..write('type: $type, ')
          ..write('organizer: $organizer, ')
          ..write('appointment: $appointment, ')
          ..write('appointmentAccess: $appointmentAccess, ')
          ..write('calendarId: $calendarId, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('uid: $uid, ')
          ..write('subject: $subject, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('startTS: $startTS, ')
          ..write('endTS: $endTS, ')
          ..write('allDay: $allDay, ')
          ..write('owner: $owner, ')
          ..write('modified: $modified, ')
          ..write('recurrenceId: $recurrenceId, ')
          ..write('lastModified: $lastModified, ')
          ..write('remindersString: $remindersString, ')
          ..write('status: $status, ')
          ..write('withDate: $withDate, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('updateStatus: $updateStatus, ')
          ..write('synced: $synced, ')
          ..write('onceLoaded: $onceLoaded, ')
          ..write('recurrenceMode: $recurrenceMode, ')
          ..write('recurrenceWeeklyFrequency: $recurrenceWeeklyFrequency, ')
          ..write('recurrenceUntilDate: $recurrenceUntilDate, ')
          ..write('recurrenceWeekDaysString: $recurrenceWeekDaysString, ')
          ..write('attendees: $attendees')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        type,
        organizer,
        appointment,
        appointmentAccess,
        calendarId,
        userLocalId,
        uid,
        subject,
        description,
        location,
        startTS,
        endTS,
        allDay,
        owner,
        modified,
        recurrenceId,
        lastModified,
        remindersString,
        status,
        withDate,
        isPrivate,
        updateStatus,
        synced,
        onceLoaded,
        recurrenceMode,
        recurrenceWeeklyFrequency,
        recurrenceUntilDate,
        recurrenceWeekDaysString,
        attendees
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityDb &&
          other.type == this.type &&
          other.organizer == this.organizer &&
          other.appointment == this.appointment &&
          other.appointmentAccess == this.appointmentAccess &&
          other.calendarId == this.calendarId &&
          other.userLocalId == this.userLocalId &&
          other.uid == this.uid &&
          other.subject == this.subject &&
          other.description == this.description &&
          other.location == this.location &&
          other.startTS == this.startTS &&
          other.endTS == this.endTS &&
          other.allDay == this.allDay &&
          other.owner == this.owner &&
          other.modified == this.modified &&
          other.recurrenceId == this.recurrenceId &&
          other.lastModified == this.lastModified &&
          other.remindersString == this.remindersString &&
          other.status == this.status &&
          other.withDate == this.withDate &&
          other.isPrivate == this.isPrivate &&
          other.updateStatus == this.updateStatus &&
          other.synced == this.synced &&
          other.onceLoaded == this.onceLoaded &&
          other.recurrenceMode == this.recurrenceMode &&
          other.recurrenceWeeklyFrequency == this.recurrenceWeeklyFrequency &&
          other.recurrenceUntilDate == this.recurrenceUntilDate &&
          other.recurrenceWeekDaysString == this.recurrenceWeekDaysString &&
          other.attendees == this.attendees);
}

class ActivityTableCompanion extends UpdateCompanion<ActivityDb> {
  final Value<ActivityType?> type;
  final Value<String?> organizer;
  final Value<bool?> appointment;
  final Value<int?> appointmentAccess;
  final Value<String> calendarId;
  final Value<int> userLocalId;
  final Value<String> uid;
  final Value<String?> subject;
  final Value<String?> description;
  final Value<String?> location;
  final Value<DateTime?> startTS;
  final Value<DateTime?> endTS;
  final Value<bool?> allDay;
  final Value<String?> owner;
  final Value<bool?> modified;
  final Value<int?> recurrenceId;
  final Value<int?> lastModified;
  final Value<String?> remindersString;
  final Value<bool?> status;
  final Value<bool?> withDate;
  final Value<bool?> isPrivate;
  final Value<UpdateStatus> updateStatus;
  final Value<bool> synced;
  final Value<bool> onceLoaded;
  final Value<RecurrenceMode?> recurrenceMode;
  final Value<EveryWeekFrequency?> recurrenceWeeklyFrequency;
  final Value<DateTime?> recurrenceUntilDate;
  final Value<String?> recurrenceWeekDaysString;
  final Value<List<String>?> attendees;
  const ActivityTableCompanion({
    this.type = const Value.absent(),
    this.organizer = const Value.absent(),
    this.appointment = const Value.absent(),
    this.appointmentAccess = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.uid = const Value.absent(),
    this.subject = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.startTS = const Value.absent(),
    this.endTS = const Value.absent(),
    this.allDay = const Value.absent(),
    this.owner = const Value.absent(),
    this.modified = const Value.absent(),
    this.recurrenceId = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.remindersString = const Value.absent(),
    this.status = const Value.absent(),
    this.withDate = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.updateStatus = const Value.absent(),
    this.synced = const Value.absent(),
    this.onceLoaded = const Value.absent(),
    this.recurrenceMode = const Value.absent(),
    this.recurrenceWeeklyFrequency = const Value.absent(),
    this.recurrenceUntilDate = const Value.absent(),
    this.recurrenceWeekDaysString = const Value.absent(),
    this.attendees = const Value.absent(),
  });
  ActivityTableCompanion.insert({
    this.type = const Value.absent(),
    this.organizer = const Value.absent(),
    this.appointment = const Value.absent(),
    this.appointmentAccess = const Value.absent(),
    required String calendarId,
    required int userLocalId,
    required String uid,
    this.subject = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.startTS = const Value.absent(),
    this.endTS = const Value.absent(),
    this.allDay = const Value.absent(),
    this.owner = const Value.absent(),
    this.modified = const Value.absent(),
    this.recurrenceId = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.remindersString = const Value.absent(),
    this.status = const Value.absent(),
    this.withDate = const Value.absent(),
    this.isPrivate = const Value.absent(),
    required UpdateStatus updateStatus,
    required bool synced,
    required bool onceLoaded,
    this.recurrenceMode = const Value.absent(),
    this.recurrenceWeeklyFrequency = const Value.absent(),
    this.recurrenceUntilDate = const Value.absent(),
    this.recurrenceWeekDaysString = const Value.absent(),
    this.attendees = const Value.absent(),
  })  : calendarId = Value(calendarId),
        userLocalId = Value(userLocalId),
        uid = Value(uid),
        updateStatus = Value(updateStatus),
        synced = Value(synced),
        onceLoaded = Value(onceLoaded);
  static Insertable<ActivityDb> custom({
    Expression<ActivityType?>? type,
    Expression<String?>? organizer,
    Expression<bool?>? appointment,
    Expression<int?>? appointmentAccess,
    Expression<String>? calendarId,
    Expression<int>? userLocalId,
    Expression<String>? uid,
    Expression<String?>? subject,
    Expression<String?>? description,
    Expression<String?>? location,
    Expression<DateTime?>? startTS,
    Expression<DateTime?>? endTS,
    Expression<bool?>? allDay,
    Expression<String?>? owner,
    Expression<bool?>? modified,
    Expression<int?>? recurrenceId,
    Expression<int?>? lastModified,
    Expression<String?>? remindersString,
    Expression<bool?>? status,
    Expression<bool?>? withDate,
    Expression<bool?>? isPrivate,
    Expression<UpdateStatus>? updateStatus,
    Expression<bool>? synced,
    Expression<bool>? onceLoaded,
    Expression<RecurrenceMode?>? recurrenceMode,
    Expression<EveryWeekFrequency?>? recurrenceWeeklyFrequency,
    Expression<DateTime?>? recurrenceUntilDate,
    Expression<String?>? recurrenceWeekDaysString,
    Expression<List<String>?>? attendees,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (organizer != null) 'organizer': organizer,
      if (appointment != null) 'appointment': appointment,
      if (appointmentAccess != null) 'appointment_access': appointmentAccess,
      if (calendarId != null) 'calendar_id': calendarId,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (uid != null) 'uid': uid,
      if (subject != null) 'subject': subject,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (startTS != null) 'start_t_s': startTS,
      if (endTS != null) 'end_t_s': endTS,
      if (allDay != null) 'all_day': allDay,
      if (owner != null) 'owner': owner,
      if (modified != null) 'modified': modified,
      if (recurrenceId != null) 'recurrence_id': recurrenceId,
      if (lastModified != null) 'last_modified': lastModified,
      if (remindersString != null) 'reminders_string': remindersString,
      if (status != null) 'status': status,
      if (withDate != null) 'with_date': withDate,
      if (isPrivate != null) 'is_private': isPrivate,
      if (updateStatus != null) 'update_status': updateStatus,
      if (synced != null) 'synced': synced,
      if (onceLoaded != null) 'once_loaded': onceLoaded,
      if (recurrenceMode != null) 'recurrence_mode': recurrenceMode,
      if (recurrenceWeeklyFrequency != null)
        'recurrence_weekly_frequency': recurrenceWeeklyFrequency,
      if (recurrenceUntilDate != null)
        'recurrence_until_date': recurrenceUntilDate,
      if (recurrenceWeekDaysString != null)
        'recurrence_week_days_string': recurrenceWeekDaysString,
      if (attendees != null) 'attendees': attendees,
    });
  }

  ActivityTableCompanion copyWith(
      {Value<ActivityType?>? type,
      Value<String?>? organizer,
      Value<bool?>? appointment,
      Value<int?>? appointmentAccess,
      Value<String>? calendarId,
      Value<int>? userLocalId,
      Value<String>? uid,
      Value<String?>? subject,
      Value<String?>? description,
      Value<String?>? location,
      Value<DateTime?>? startTS,
      Value<DateTime?>? endTS,
      Value<bool?>? allDay,
      Value<String?>? owner,
      Value<bool?>? modified,
      Value<int?>? recurrenceId,
      Value<int?>? lastModified,
      Value<String?>? remindersString,
      Value<bool?>? status,
      Value<bool?>? withDate,
      Value<bool?>? isPrivate,
      Value<UpdateStatus>? updateStatus,
      Value<bool>? synced,
      Value<bool>? onceLoaded,
      Value<RecurrenceMode?>? recurrenceMode,
      Value<EveryWeekFrequency?>? recurrenceWeeklyFrequency,
      Value<DateTime?>? recurrenceUntilDate,
      Value<String?>? recurrenceWeekDaysString,
      Value<List<String>?>? attendees}) {
    return ActivityTableCompanion(
      type: type ?? this.type,
      organizer: organizer ?? this.organizer,
      appointment: appointment ?? this.appointment,
      appointmentAccess: appointmentAccess ?? this.appointmentAccess,
      calendarId: calendarId ?? this.calendarId,
      userLocalId: userLocalId ?? this.userLocalId,
      uid: uid ?? this.uid,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      location: location ?? this.location,
      startTS: startTS ?? this.startTS,
      endTS: endTS ?? this.endTS,
      allDay: allDay ?? this.allDay,
      owner: owner ?? this.owner,
      modified: modified ?? this.modified,
      recurrenceId: recurrenceId ?? this.recurrenceId,
      lastModified: lastModified ?? this.lastModified,
      remindersString: remindersString ?? this.remindersString,
      status: status ?? this.status,
      withDate: withDate ?? this.withDate,
      isPrivate: isPrivate ?? this.isPrivate,
      updateStatus: updateStatus ?? this.updateStatus,
      synced: synced ?? this.synced,
      onceLoaded: onceLoaded ?? this.onceLoaded,
      recurrenceMode: recurrenceMode ?? this.recurrenceMode,
      recurrenceWeeklyFrequency:
          recurrenceWeeklyFrequency ?? this.recurrenceWeeklyFrequency,
      recurrenceUntilDate: recurrenceUntilDate ?? this.recurrenceUntilDate,
      recurrenceWeekDaysString:
          recurrenceWeekDaysString ?? this.recurrenceWeekDaysString,
      attendees: attendees ?? this.attendees,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      final converter = $ActivityTableTable.$converter0;
      map['type'] = Variable<int?>(converter.mapToSql(type.value));
    }
    if (organizer.present) {
      map['organizer'] = Variable<String?>(organizer.value);
    }
    if (appointment.present) {
      map['appointment'] = Variable<bool?>(appointment.value);
    }
    if (appointmentAccess.present) {
      map['appointment_access'] = Variable<int?>(appointmentAccess.value);
    }
    if (calendarId.present) {
      map['calendar_id'] = Variable<String>(calendarId.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int>(userLocalId.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String?>(subject.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (location.present) {
      map['location'] = Variable<String?>(location.value);
    }
    if (startTS.present) {
      map['start_t_s'] = Variable<DateTime?>(startTS.value);
    }
    if (endTS.present) {
      map['end_t_s'] = Variable<DateTime?>(endTS.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool?>(allDay.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String?>(owner.value);
    }
    if (modified.present) {
      map['modified'] = Variable<bool?>(modified.value);
    }
    if (recurrenceId.present) {
      map['recurrence_id'] = Variable<int?>(recurrenceId.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<int?>(lastModified.value);
    }
    if (remindersString.present) {
      map['reminders_string'] = Variable<String?>(remindersString.value);
    }
    if (status.present) {
      map['status'] = Variable<bool?>(status.value);
    }
    if (withDate.present) {
      map['with_date'] = Variable<bool?>(withDate.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool?>(isPrivate.value);
    }
    if (updateStatus.present) {
      final converter = $ActivityTableTable.$converter1;
      map['update_status'] =
          Variable<int>(converter.mapToSql(updateStatus.value)!);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (onceLoaded.present) {
      map['once_loaded'] = Variable<bool>(onceLoaded.value);
    }
    if (recurrenceMode.present) {
      final converter = $ActivityTableTable.$converter2;
      map['recurrence_mode'] =
          Variable<int?>(converter.mapToSql(recurrenceMode.value));
    }
    if (recurrenceWeeklyFrequency.present) {
      final converter = $ActivityTableTable.$converter3;
      map['recurrence_weekly_frequency'] =
          Variable<int?>(converter.mapToSql(recurrenceWeeklyFrequency.value));
    }
    if (recurrenceUntilDate.present) {
      map['recurrence_until_date'] =
          Variable<DateTime?>(recurrenceUntilDate.value);
    }
    if (recurrenceWeekDaysString.present) {
      map['recurrence_week_days_string'] =
          Variable<String?>(recurrenceWeekDaysString.value);
    }
    if (attendees.present) {
      final converter = $ActivityTableTable.$converter4;
      map['attendees'] = Variable<String?>(converter.mapToSql(attendees.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityTableCompanion(')
          ..write('type: $type, ')
          ..write('organizer: $organizer, ')
          ..write('appointment: $appointment, ')
          ..write('appointmentAccess: $appointmentAccess, ')
          ..write('calendarId: $calendarId, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('uid: $uid, ')
          ..write('subject: $subject, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('startTS: $startTS, ')
          ..write('endTS: $endTS, ')
          ..write('allDay: $allDay, ')
          ..write('owner: $owner, ')
          ..write('modified: $modified, ')
          ..write('recurrenceId: $recurrenceId, ')
          ..write('lastModified: $lastModified, ')
          ..write('remindersString: $remindersString, ')
          ..write('status: $status, ')
          ..write('withDate: $withDate, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('updateStatus: $updateStatus, ')
          ..write('synced: $synced, ')
          ..write('onceLoaded: $onceLoaded, ')
          ..write('recurrenceMode: $recurrenceMode, ')
          ..write('recurrenceWeeklyFrequency: $recurrenceWeeklyFrequency, ')
          ..write('recurrenceUntilDate: $recurrenceUntilDate, ')
          ..write('recurrenceWeekDaysString: $recurrenceWeekDaysString, ')
          ..write('attendees: $attendees')
          ..write(')'))
        .toString();
  }
}

class $ActivityTableTable extends ActivityTable
    with TableInfo<$ActivityTableTable, ActivityDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ActivityType?, int?> type =
      GeneratedColumn<int?>('type', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<ActivityType?>($ActivityTableTable.$converter0);
  final VerificationMeta _organizerMeta = const VerificationMeta('organizer');
  @override
  late final GeneratedColumn<String?> organizer = GeneratedColumn<String?>(
      'organizer', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _appointmentMeta =
      const VerificationMeta('appointment');
  @override
  late final GeneratedColumn<bool?> appointment = GeneratedColumn<bool?>(
      'appointment', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (appointment IN (0, 1))');
  final VerificationMeta _appointmentAccessMeta =
      const VerificationMeta('appointmentAccess');
  @override
  late final GeneratedColumn<int?> appointmentAccess = GeneratedColumn<int?>(
      'appointment_access', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _calendarIdMeta = const VerificationMeta('calendarId');
  @override
  late final GeneratedColumn<String?> calendarId = GeneratedColumn<String?>(
      'calendar_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String?> uid = GeneratedColumn<String?>(
      'uid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _subjectMeta = const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String?> subject = GeneratedColumn<String?>(
      'subject', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _locationMeta = const VerificationMeta('location');
  @override
  late final GeneratedColumn<String?> location = GeneratedColumn<String?>(
      'location', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _startTSMeta = const VerificationMeta('startTS');
  @override
  late final GeneratedColumn<DateTime?> startTS = GeneratedColumn<DateTime?>(
      'start_t_s', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _endTSMeta = const VerificationMeta('endTS');
  @override
  late final GeneratedColumn<DateTime?> endTS = GeneratedColumn<DateTime?>(
      'end_t_s', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool?> allDay = GeneratedColumn<bool?>(
      'all_day', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (all_day IN (0, 1))');
  final VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String?> owner = GeneratedColumn<String?>(
      'owner', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _modifiedMeta = const VerificationMeta('modified');
  @override
  late final GeneratedColumn<bool?> modified = GeneratedColumn<bool?>(
      'modified', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (modified IN (0, 1))');
  final VerificationMeta _recurrenceIdMeta =
      const VerificationMeta('recurrenceId');
  @override
  late final GeneratedColumn<int?> recurrenceId = GeneratedColumn<int?>(
      'recurrence_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<int?> lastModified = GeneratedColumn<int?>(
      'last_modified', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _remindersStringMeta =
      const VerificationMeta('remindersString');
  @override
  late final GeneratedColumn<String?> remindersString =
      GeneratedColumn<String?>('reminders_string', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<bool?> status = GeneratedColumn<bool?>(
      'status', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (status IN (0, 1))');
  final VerificationMeta _withDateMeta = const VerificationMeta('withDate');
  @override
  late final GeneratedColumn<bool?> withDate = GeneratedColumn<bool?>(
      'with_date', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (with_date IN (0, 1))');
  final VerificationMeta _isPrivateMeta = const VerificationMeta('isPrivate');
  @override
  late final GeneratedColumn<bool?> isPrivate = GeneratedColumn<bool?>(
      'is_private', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_private IN (0, 1))');
  final VerificationMeta _updateStatusMeta =
      const VerificationMeta('updateStatus');
  @override
  late final GeneratedColumnWithTypeConverter<UpdateStatus, int?> updateStatus =
      GeneratedColumn<int?>('update_status', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<UpdateStatus>($ActivityTableTable.$converter1);
  final VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool?> synced = GeneratedColumn<bool?>(
      'synced', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (synced IN (0, 1))');
  final VerificationMeta _onceLoadedMeta = const VerificationMeta('onceLoaded');
  @override
  late final GeneratedColumn<bool?> onceLoaded = GeneratedColumn<bool?>(
      'once_loaded', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (once_loaded IN (0, 1))');
  final VerificationMeta _recurrenceModeMeta =
      const VerificationMeta('recurrenceMode');
  @override
  late final GeneratedColumnWithTypeConverter<RecurrenceMode?, int?>
      recurrenceMode = GeneratedColumn<int?>(
              'recurrence_mode', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<RecurrenceMode?>($ActivityTableTable.$converter2);
  final VerificationMeta _recurrenceWeeklyFrequencyMeta =
      const VerificationMeta('recurrenceWeeklyFrequency');
  @override
  late final GeneratedColumnWithTypeConverter<EveryWeekFrequency?, int?>
      recurrenceWeeklyFrequency = GeneratedColumn<int?>(
              'recurrence_weekly_frequency', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<EveryWeekFrequency?>($ActivityTableTable.$converter3);
  final VerificationMeta _recurrenceUntilDateMeta =
      const VerificationMeta('recurrenceUntilDate');
  @override
  late final GeneratedColumn<DateTime?> recurrenceUntilDate =
      GeneratedColumn<DateTime?>('recurrence_until_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _recurrenceWeekDaysStringMeta =
      const VerificationMeta('recurrenceWeekDaysString');
  @override
  late final GeneratedColumn<String?> recurrenceWeekDaysString =
      GeneratedColumn<String?>('recurrence_week_days_string', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _attendeesMeta = const VerificationMeta('attendees');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String?> attendees =
      GeneratedColumn<String?>('attendees', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<List<String>>($ActivityTableTable.$converter4);
  @override
  List<GeneratedColumn> get $columns => [
        type,
        organizer,
        appointment,
        appointmentAccess,
        calendarId,
        userLocalId,
        uid,
        subject,
        description,
        location,
        startTS,
        endTS,
        allDay,
        owner,
        modified,
        recurrenceId,
        lastModified,
        remindersString,
        status,
        withDate,
        isPrivate,
        updateStatus,
        synced,
        onceLoaded,
        recurrenceMode,
        recurrenceWeeklyFrequency,
        recurrenceUntilDate,
        recurrenceWeekDaysString,
        attendees
      ];
  @override
  String get aliasedName => _alias ?? 'activity_table';
  @override
  String get actualTableName => 'activity_table';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('organizer')) {
      context.handle(_organizerMeta,
          organizer.isAcceptableOrUnknown(data['organizer']!, _organizerMeta));
    }
    if (data.containsKey('appointment')) {
      context.handle(
          _appointmentMeta,
          appointment.isAcceptableOrUnknown(
              data['appointment']!, _appointmentMeta));
    }
    if (data.containsKey('appointment_access')) {
      context.handle(
          _appointmentAccessMeta,
          appointmentAccess.isAcceptableOrUnknown(
              data['appointment_access']!, _appointmentAccessMeta));
    }
    if (data.containsKey('calendar_id')) {
      context.handle(
          _calendarIdMeta,
          calendarId.isAcceptableOrUnknown(
              data['calendar_id']!, _calendarIdMeta));
    } else if (isInserting) {
      context.missing(_calendarIdMeta);
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('start_t_s')) {
      context.handle(_startTSMeta,
          startTS.isAcceptableOrUnknown(data['start_t_s']!, _startTSMeta));
    }
    if (data.containsKey('end_t_s')) {
      context.handle(_endTSMeta,
          endTS.isAcceptableOrUnknown(data['end_t_s']!, _endTSMeta));
    }
    if (data.containsKey('all_day')) {
      context.handle(_allDayMeta,
          allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta));
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    }
    if (data.containsKey('modified')) {
      context.handle(_modifiedMeta,
          modified.isAcceptableOrUnknown(data['modified']!, _modifiedMeta));
    }
    if (data.containsKey('recurrence_id')) {
      context.handle(
          _recurrenceIdMeta,
          recurrenceId.isAcceptableOrUnknown(
              data['recurrence_id']!, _recurrenceIdMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    if (data.containsKey('reminders_string')) {
      context.handle(
          _remindersStringMeta,
          remindersString.isAcceptableOrUnknown(
              data['reminders_string']!, _remindersStringMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('with_date')) {
      context.handle(_withDateMeta,
          withDate.isAcceptableOrUnknown(data['with_date']!, _withDateMeta));
    }
    if (data.containsKey('is_private')) {
      context.handle(_isPrivateMeta,
          isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta));
    }
    context.handle(_updateStatusMeta, const VerificationResult.success());
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    } else if (isInserting) {
      context.missing(_syncedMeta);
    }
    if (data.containsKey('once_loaded')) {
      context.handle(
          _onceLoadedMeta,
          onceLoaded.isAcceptableOrUnknown(
              data['once_loaded']!, _onceLoadedMeta));
    } else if (isInserting) {
      context.missing(_onceLoadedMeta);
    }
    context.handle(_recurrenceModeMeta, const VerificationResult.success());
    context.handle(
        _recurrenceWeeklyFrequencyMeta, const VerificationResult.success());
    if (data.containsKey('recurrence_until_date')) {
      context.handle(
          _recurrenceUntilDateMeta,
          recurrenceUntilDate.isAcceptableOrUnknown(
              data['recurrence_until_date']!, _recurrenceUntilDateMeta));
    }
    if (data.containsKey('recurrence_week_days_string')) {
      context.handle(
          _recurrenceWeekDaysStringMeta,
          recurrenceWeekDaysString.isAcceptableOrUnknown(
              data['recurrence_week_days_string']!,
              _recurrenceWeekDaysStringMeta));
    }
    context.handle(_attendeesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid, userLocalId, calendarId};
  @override
  ActivityDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ActivityDb.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ActivityTableTable createAlias(String alias) {
    return $ActivityTableTable(attachedDatabase, alias);
  }

  static TypeConverter<ActivityType?, int> $converter0 =
      const EnumIndexConverter<ActivityType>(ActivityType.values);
  static TypeConverter<UpdateStatus, int> $converter1 =
      const EnumIndexConverter<UpdateStatus>(UpdateStatus.values);
  static TypeConverter<RecurrenceMode?, int> $converter2 =
      const EnumIndexConverter<RecurrenceMode>(RecurrenceMode.values);
  static TypeConverter<EveryWeekFrequency?, int> $converter3 =
      const EnumIndexConverter<EveryWeekFrequency>(EveryWeekFrequency.values);
  static TypeConverter<List<String>, String> $converter4 =
      const ListStringConverter();
}

class LocalFolder extends DataClass implements Insertable<LocalFolder> {
  final String fullName;
  final int accountLocalId;
  final int userLocalId;
  final String guid;
  final String? parentGuid;
  final int accountId;
  final int type;
  final int folderOrder;
  final int? count;
  final int? unread;
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
  final bool? extended;
  final bool alwaysRefresh;
  final String namespace;
  LocalFolder(
      {required this.fullName,
      required this.accountLocalId,
      required this.userLocalId,
      required this.guid,
      this.parentGuid,
      required this.accountId,
      required this.type,
      required this.folderOrder,
      this.count,
      this.unread,
      required this.name,
      required this.fullNameRaw,
      required this.fullNameHash,
      required this.folderHash,
      required this.delimiter,
      required this.needsInfoUpdate,
      required this.isSystemFolder,
      required this.isSubscribed,
      required this.isSelectable,
      required this.folderExists,
      this.extended,
      required this.alwaysRefresh,
      required this.namespace});
  factory LocalFolder.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalFolder(
      fullName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name'])!,
      accountLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_local_id'])!,
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id'])!,
      guid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}guid'])!,
      parentGuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_guid']),
      accountId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_id'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      folderOrder: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_order'])!,
      count: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}count']),
      unread: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unread']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      fullNameRaw: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_raw'])!,
      fullNameHash: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_hash'])!,
      folderHash: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_hash'])!,
      delimiter: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delimiter'])!,
      needsInfoUpdate: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}needs_info_update'])!,
      isSystemFolder: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_system_folder'])!,
      isSubscribed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_subscribed'])!,
      isSelectable: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_selectable'])!,
      folderExists: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_exists'])!,
      extended: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}extended']),
      alwaysRefresh: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}always_refresh'])!,
      namespace: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}namespace'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['full_name'] = Variable<String>(fullName);
    map['account_local_id'] = Variable<int>(accountLocalId);
    map['user_local_id'] = Variable<int>(userLocalId);
    map['guid'] = Variable<String>(guid);
    if (!nullToAbsent || parentGuid != null) {
      map['parent_guid'] = Variable<String?>(parentGuid);
    }
    map['account_id'] = Variable<int>(accountId);
    map['type'] = Variable<int>(type);
    map['folder_order'] = Variable<int>(folderOrder);
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int?>(count);
    }
    if (!nullToAbsent || unread != null) {
      map['unread'] = Variable<int?>(unread);
    }
    map['name'] = Variable<String>(name);
    map['full_name_raw'] = Variable<String>(fullNameRaw);
    map['full_name_hash'] = Variable<String>(fullNameHash);
    map['folder_hash'] = Variable<String>(folderHash);
    map['delimiter'] = Variable<String>(delimiter);
    map['needs_info_update'] = Variable<bool>(needsInfoUpdate);
    map['is_system_folder'] = Variable<bool>(isSystemFolder);
    map['is_subscribed'] = Variable<bool>(isSubscribed);
    map['is_selectable'] = Variable<bool>(isSelectable);
    map['folder_exists'] = Variable<bool>(folderExists);
    if (!nullToAbsent || extended != null) {
      map['extended'] = Variable<bool?>(extended);
    }
    map['always_refresh'] = Variable<bool>(alwaysRefresh);
    map['namespace'] = Variable<String>(namespace);
    return map;
  }

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      fullName: Value(fullName),
      accountLocalId: Value(accountLocalId),
      userLocalId: Value(userLocalId),
      guid: Value(guid),
      parentGuid: parentGuid == null && nullToAbsent
          ? const Value.absent()
          : Value(parentGuid),
      accountId: Value(accountId),
      type: Value(type),
      folderOrder: Value(folderOrder),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      unread:
          unread == null && nullToAbsent ? const Value.absent() : Value(unread),
      name: Value(name),
      fullNameRaw: Value(fullNameRaw),
      fullNameHash: Value(fullNameHash),
      folderHash: Value(folderHash),
      delimiter: Value(delimiter),
      needsInfoUpdate: Value(needsInfoUpdate),
      isSystemFolder: Value(isSystemFolder),
      isSubscribed: Value(isSubscribed),
      isSelectable: Value(isSelectable),
      folderExists: Value(folderExists),
      extended: extended == null && nullToAbsent
          ? const Value.absent()
          : Value(extended),
      alwaysRefresh: Value(alwaysRefresh),
      namespace: Value(namespace),
    );
  }

  factory LocalFolder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFolder(
      fullName: serializer.fromJson<String>(json['fullName']),
      accountLocalId: serializer.fromJson<int>(json['accountLocalId']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      guid: serializer.fromJson<String>(json['guid']),
      parentGuid: serializer.fromJson<String?>(json['parentGuid']),
      accountId: serializer.fromJson<int>(json['accountId']),
      type: serializer.fromJson<int>(json['type']),
      folderOrder: serializer.fromJson<int>(json['folderOrder']),
      count: serializer.fromJson<int?>(json['count']),
      unread: serializer.fromJson<int?>(json['unread']),
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
      extended: serializer.fromJson<bool?>(json['extended']),
      alwaysRefresh: serializer.fromJson<bool>(json['alwaysRefresh']),
      namespace: serializer.fromJson<String>(json['namespace']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fullName': serializer.toJson<String>(fullName),
      'accountLocalId': serializer.toJson<int>(accountLocalId),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'guid': serializer.toJson<String>(guid),
      'parentGuid': serializer.toJson<String?>(parentGuid),
      'accountId': serializer.toJson<int>(accountId),
      'type': serializer.toJson<int>(type),
      'folderOrder': serializer.toJson<int>(folderOrder),
      'count': serializer.toJson<int?>(count),
      'unread': serializer.toJson<int?>(unread),
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
      'extended': serializer.toJson<bool?>(extended),
      'alwaysRefresh': serializer.toJson<bool>(alwaysRefresh),
      'namespace': serializer.toJson<String>(namespace),
    };
  }

  LocalFolder copyWith(
          {String? fullName,
          int? accountLocalId,
          int? userLocalId,
          String? guid,
          String? parentGuid,
          int? accountId,
          int? type,
          int? folderOrder,
          int? count,
          int? unread,
          String? name,
          String? fullNameRaw,
          String? fullNameHash,
          String? folderHash,
          String? delimiter,
          bool? needsInfoUpdate,
          bool? isSystemFolder,
          bool? isSubscribed,
          bool? isSelectable,
          bool? folderExists,
          bool? extended,
          bool? alwaysRefresh,
          String? namespace}) =>
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
        namespace: namespace ?? this.namespace,
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
          ..write('namespace: $namespace')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
        namespace
      ]);
  @override
  bool operator ==(Object other) =>
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
          other.namespace == this.namespace);
}

class FoldersCompanion extends UpdateCompanion<LocalFolder> {
  final Value<String> fullName;
  final Value<int> accountLocalId;
  final Value<int> userLocalId;
  final Value<String> guid;
  final Value<String?> parentGuid;
  final Value<int> accountId;
  final Value<int> type;
  final Value<int> folderOrder;
  final Value<int?> count;
  final Value<int?> unread;
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
  final Value<bool?> extended;
  final Value<bool> alwaysRefresh;
  final Value<String> namespace;
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
    this.namespace = const Value.absent(),
  });
  FoldersCompanion.insert({
    required String fullName,
    required int accountLocalId,
    required int userLocalId,
    required String guid,
    this.parentGuid = const Value.absent(),
    required int accountId,
    required int type,
    required int folderOrder,
    this.count = const Value.absent(),
    this.unread = const Value.absent(),
    required String name,
    required String fullNameRaw,
    required String fullNameHash,
    required String folderHash,
    required String delimiter,
    required bool needsInfoUpdate,
    required bool isSystemFolder,
    required bool isSubscribed,
    required bool isSelectable,
    required bool folderExists,
    this.extended = const Value.absent(),
    required bool alwaysRefresh,
    required String namespace,
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
        alwaysRefresh = Value(alwaysRefresh),
        namespace = Value(namespace);
  static Insertable<LocalFolder> custom({
    Expression<String>? fullName,
    Expression<int>? accountLocalId,
    Expression<int>? userLocalId,
    Expression<String>? guid,
    Expression<String?>? parentGuid,
    Expression<int>? accountId,
    Expression<int>? type,
    Expression<int>? folderOrder,
    Expression<int?>? count,
    Expression<int?>? unread,
    Expression<String>? name,
    Expression<String>? fullNameRaw,
    Expression<String>? fullNameHash,
    Expression<String>? folderHash,
    Expression<String>? delimiter,
    Expression<bool>? needsInfoUpdate,
    Expression<bool>? isSystemFolder,
    Expression<bool>? isSubscribed,
    Expression<bool>? isSelectable,
    Expression<bool>? folderExists,
    Expression<bool?>? extended,
    Expression<bool>? alwaysRefresh,
    Expression<String>? namespace,
  }) {
    return RawValuesInsertable({
      if (fullName != null) 'full_name': fullName,
      if (accountLocalId != null) 'account_local_id': accountLocalId,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (guid != null) 'guid': guid,
      if (parentGuid != null) 'parent_guid': parentGuid,
      if (accountId != null) 'account_id': accountId,
      if (type != null) 'type': type,
      if (folderOrder != null) 'folder_order': folderOrder,
      if (count != null) 'count': count,
      if (unread != null) 'unread': unread,
      if (name != null) 'name': name,
      if (fullNameRaw != null) 'full_name_raw': fullNameRaw,
      if (fullNameHash != null) 'full_name_hash': fullNameHash,
      if (folderHash != null) 'folder_hash': folderHash,
      if (delimiter != null) 'delimiter': delimiter,
      if (needsInfoUpdate != null) 'needs_info_update': needsInfoUpdate,
      if (isSystemFolder != null) 'is_system_folder': isSystemFolder,
      if (isSubscribed != null) 'is_subscribed': isSubscribed,
      if (isSelectable != null) 'is_selectable': isSelectable,
      if (folderExists != null) 'folder_exists': folderExists,
      if (extended != null) 'extended': extended,
      if (alwaysRefresh != null) 'always_refresh': alwaysRefresh,
      if (namespace != null) 'namespace': namespace,
    });
  }

  FoldersCompanion copyWith(
      {Value<String>? fullName,
      Value<int>? accountLocalId,
      Value<int>? userLocalId,
      Value<String>? guid,
      Value<String?>? parentGuid,
      Value<int>? accountId,
      Value<int>? type,
      Value<int>? folderOrder,
      Value<int?>? count,
      Value<int?>? unread,
      Value<String>? name,
      Value<String>? fullNameRaw,
      Value<String>? fullNameHash,
      Value<String>? folderHash,
      Value<String>? delimiter,
      Value<bool>? needsInfoUpdate,
      Value<bool>? isSystemFolder,
      Value<bool>? isSubscribed,
      Value<bool>? isSelectable,
      Value<bool>? folderExists,
      Value<bool?>? extended,
      Value<bool>? alwaysRefresh,
      Value<String>? namespace}) {
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
      namespace: namespace ?? this.namespace,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (accountLocalId.present) {
      map['account_local_id'] = Variable<int>(accountLocalId.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int>(userLocalId.value);
    }
    if (guid.present) {
      map['guid'] = Variable<String>(guid.value);
    }
    if (parentGuid.present) {
      map['parent_guid'] = Variable<String?>(parentGuid.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (folderOrder.present) {
      map['folder_order'] = Variable<int>(folderOrder.value);
    }
    if (count.present) {
      map['count'] = Variable<int?>(count.value);
    }
    if (unread.present) {
      map['unread'] = Variable<int?>(unread.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (fullNameRaw.present) {
      map['full_name_raw'] = Variable<String>(fullNameRaw.value);
    }
    if (fullNameHash.present) {
      map['full_name_hash'] = Variable<String>(fullNameHash.value);
    }
    if (folderHash.present) {
      map['folder_hash'] = Variable<String>(folderHash.value);
    }
    if (delimiter.present) {
      map['delimiter'] = Variable<String>(delimiter.value);
    }
    if (needsInfoUpdate.present) {
      map['needs_info_update'] = Variable<bool>(needsInfoUpdate.value);
    }
    if (isSystemFolder.present) {
      map['is_system_folder'] = Variable<bool>(isSystemFolder.value);
    }
    if (isSubscribed.present) {
      map['is_subscribed'] = Variable<bool>(isSubscribed.value);
    }
    if (isSelectable.present) {
      map['is_selectable'] = Variable<bool>(isSelectable.value);
    }
    if (folderExists.present) {
      map['folder_exists'] = Variable<bool>(folderExists.value);
    }
    if (extended.present) {
      map['extended'] = Variable<bool?>(extended.value);
    }
    if (alwaysRefresh.present) {
      map['always_refresh'] = Variable<bool>(alwaysRefresh.value);
    }
    if (namespace.present) {
      map['namespace'] = Variable<String>(namespace.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersCompanion(')
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
          ..write('namespace: $namespace')
          ..write(')'))
        .toString();
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, LocalFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoldersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String?> fullName = GeneratedColumn<String?>(
      'full_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _accountLocalIdMeta =
      const VerificationMeta('accountLocalId');
  @override
  late final GeneratedColumn<int?> accountLocalId = GeneratedColumn<int?>(
      'account_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _guidMeta = const VerificationMeta('guid');
  @override
  late final GeneratedColumn<String?> guid = GeneratedColumn<String?>(
      'guid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _parentGuidMeta = const VerificationMeta('parentGuid');
  @override
  late final GeneratedColumn<String?> parentGuid = GeneratedColumn<String?>(
      'parent_guid', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<int?> accountId = GeneratedColumn<int?>(
      'account_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _folderOrderMeta =
      const VerificationMeta('folderOrder');
  @override
  late final GeneratedColumn<int?> folderOrder = GeneratedColumn<int?>(
      'folder_order', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int?> count = GeneratedColumn<int?>(
      'count', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _unreadMeta = const VerificationMeta('unread');
  @override
  late final GeneratedColumn<int?> unread = GeneratedColumn<int?>(
      'unread', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _fullNameRawMeta =
      const VerificationMeta('fullNameRaw');
  @override
  late final GeneratedColumn<String?> fullNameRaw = GeneratedColumn<String?>(
      'full_name_raw', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _fullNameHashMeta =
      const VerificationMeta('fullNameHash');
  @override
  late final GeneratedColumn<String?> fullNameHash = GeneratedColumn<String?>(
      'full_name_hash', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _folderHashMeta = const VerificationMeta('folderHash');
  @override
  late final GeneratedColumn<String?> folderHash = GeneratedColumn<String?>(
      'folder_hash', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _delimiterMeta = const VerificationMeta('delimiter');
  @override
  late final GeneratedColumn<String?> delimiter = GeneratedColumn<String?>(
      'delimiter', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _needsInfoUpdateMeta =
      const VerificationMeta('needsInfoUpdate');
  @override
  late final GeneratedColumn<bool?> needsInfoUpdate = GeneratedColumn<bool?>(
      'needs_info_update', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (needs_info_update IN (0, 1))');
  final VerificationMeta _isSystemFolderMeta =
      const VerificationMeta('isSystemFolder');
  @override
  late final GeneratedColumn<bool?> isSystemFolder = GeneratedColumn<bool?>(
      'is_system_folder', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_system_folder IN (0, 1))');
  final VerificationMeta _isSubscribedMeta =
      const VerificationMeta('isSubscribed');
  @override
  late final GeneratedColumn<bool?> isSubscribed = GeneratedColumn<bool?>(
      'is_subscribed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_subscribed IN (0, 1))');
  final VerificationMeta _isSelectableMeta =
      const VerificationMeta('isSelectable');
  @override
  late final GeneratedColumn<bool?> isSelectable = GeneratedColumn<bool?>(
      'is_selectable', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_selectable IN (0, 1))');
  final VerificationMeta _folderExistsMeta =
      const VerificationMeta('folderExists');
  @override
  late final GeneratedColumn<bool?> folderExists = GeneratedColumn<bool?>(
      'folder_exists', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (folder_exists IN (0, 1))');
  final VerificationMeta _extendedMeta = const VerificationMeta('extended');
  @override
  late final GeneratedColumn<bool?> extended = GeneratedColumn<bool?>(
      'extended', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (extended IN (0, 1))');
  final VerificationMeta _alwaysRefreshMeta =
      const VerificationMeta('alwaysRefresh');
  @override
  late final GeneratedColumn<bool?> alwaysRefresh = GeneratedColumn<bool?>(
      'always_refresh', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (always_refresh IN (0, 1))');
  final VerificationMeta _namespaceMeta = const VerificationMeta('namespace');
  @override
  late final GeneratedColumn<String?> namespace = GeneratedColumn<String?>(
      'namespace', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
        namespace
      ];
  @override
  String get aliasedName => _alias ?? 'folders';
  @override
  String get actualTableName => 'folders';
  @override
  VerificationContext validateIntegrity(Insertable<LocalFolder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('account_local_id')) {
      context.handle(
          _accountLocalIdMeta,
          accountLocalId.isAcceptableOrUnknown(
              data['account_local_id']!, _accountLocalIdMeta));
    } else if (isInserting) {
      context.missing(_accountLocalIdMeta);
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (data.containsKey('guid')) {
      context.handle(
          _guidMeta, guid.isAcceptableOrUnknown(data['guid']!, _guidMeta));
    } else if (isInserting) {
      context.missing(_guidMeta);
    }
    if (data.containsKey('parent_guid')) {
      context.handle(
          _parentGuidMeta,
          parentGuid.isAcceptableOrUnknown(
              data['parent_guid']!, _parentGuidMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('folder_order')) {
      context.handle(
          _folderOrderMeta,
          folderOrder.isAcceptableOrUnknown(
              data['folder_order']!, _folderOrderMeta));
    } else if (isInserting) {
      context.missing(_folderOrderMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    if (data.containsKey('unread')) {
      context.handle(_unreadMeta,
          unread.isAcceptableOrUnknown(data['unread']!, _unreadMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('full_name_raw')) {
      context.handle(
          _fullNameRawMeta,
          fullNameRaw.isAcceptableOrUnknown(
              data['full_name_raw']!, _fullNameRawMeta));
    } else if (isInserting) {
      context.missing(_fullNameRawMeta);
    }
    if (data.containsKey('full_name_hash')) {
      context.handle(
          _fullNameHashMeta,
          fullNameHash.isAcceptableOrUnknown(
              data['full_name_hash']!, _fullNameHashMeta));
    } else if (isInserting) {
      context.missing(_fullNameHashMeta);
    }
    if (data.containsKey('folder_hash')) {
      context.handle(
          _folderHashMeta,
          folderHash.isAcceptableOrUnknown(
              data['folder_hash']!, _folderHashMeta));
    } else if (isInserting) {
      context.missing(_folderHashMeta);
    }
    if (data.containsKey('delimiter')) {
      context.handle(_delimiterMeta,
          delimiter.isAcceptableOrUnknown(data['delimiter']!, _delimiterMeta));
    } else if (isInserting) {
      context.missing(_delimiterMeta);
    }
    if (data.containsKey('needs_info_update')) {
      context.handle(
          _needsInfoUpdateMeta,
          needsInfoUpdate.isAcceptableOrUnknown(
              data['needs_info_update']!, _needsInfoUpdateMeta));
    } else if (isInserting) {
      context.missing(_needsInfoUpdateMeta);
    }
    if (data.containsKey('is_system_folder')) {
      context.handle(
          _isSystemFolderMeta,
          isSystemFolder.isAcceptableOrUnknown(
              data['is_system_folder']!, _isSystemFolderMeta));
    } else if (isInserting) {
      context.missing(_isSystemFolderMeta);
    }
    if (data.containsKey('is_subscribed')) {
      context.handle(
          _isSubscribedMeta,
          isSubscribed.isAcceptableOrUnknown(
              data['is_subscribed']!, _isSubscribedMeta));
    } else if (isInserting) {
      context.missing(_isSubscribedMeta);
    }
    if (data.containsKey('is_selectable')) {
      context.handle(
          _isSelectableMeta,
          isSelectable.isAcceptableOrUnknown(
              data['is_selectable']!, _isSelectableMeta));
    } else if (isInserting) {
      context.missing(_isSelectableMeta);
    }
    if (data.containsKey('folder_exists')) {
      context.handle(
          _folderExistsMeta,
          folderExists.isAcceptableOrUnknown(
              data['folder_exists']!, _folderExistsMeta));
    } else if (isInserting) {
      context.missing(_folderExistsMeta);
    }
    if (data.containsKey('extended')) {
      context.handle(_extendedMeta,
          extended.isAcceptableOrUnknown(data['extended']!, _extendedMeta));
    }
    if (data.containsKey('always_refresh')) {
      context.handle(
          _alwaysRefreshMeta,
          alwaysRefresh.isAcceptableOrUnknown(
              data['always_refresh']!, _alwaysRefreshMeta));
    } else if (isInserting) {
      context.missing(_alwaysRefreshMeta);
    }
    if (data.containsKey('namespace')) {
      context.handle(_namespaceMeta,
          namespace.isAcceptableOrUnknown(data['namespace']!, _namespaceMeta));
    } else if (isInserting) {
      context.missing(_namespaceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {fullName, accountLocalId};
  @override
  LocalFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalFolder.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int? localId;
  final int serverId;
  final String hostname;
  final String emailFromLogin;
  final String token;
  final int? syncFreqInSeconds;
  final String? syncPeriod;
  User(
      {this.localId,
      required this.serverId,
      required this.hostname,
      required this.emailFromLogin,
      required this.token,
      this.syncFreqInSeconds,
      this.syncPeriod});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      localId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      serverId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}server_id'])!,
      hostname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hostname'])!,
      emailFromLogin: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email_from_login'])!,
      token: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token'])!,
      syncFreqInSeconds: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_freq_in_seconds']),
      syncPeriod: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_period']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || localId != null) {
      map['local_id'] = Variable<int?>(localId);
    }
    map['server_id'] = Variable<int>(serverId);
    map['hostname'] = Variable<String>(hostname);
    map['email_from_login'] = Variable<String>(emailFromLogin);
    map['token'] = Variable<String>(token);
    if (!nullToAbsent || syncFreqInSeconds != null) {
      map['sync_freq_in_seconds'] = Variable<int?>(syncFreqInSeconds);
    }
    if (!nullToAbsent || syncPeriod != null) {
      map['sync_period'] = Variable<String?>(syncPeriod);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      serverId: Value(serverId),
      hostname: Value(hostname),
      emailFromLogin: Value(emailFromLogin),
      token: Value(token),
      syncFreqInSeconds: syncFreqInSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(syncFreqInSeconds),
      syncPeriod: syncPeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(syncPeriod),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      localId: serializer.fromJson<int?>(json['localId']),
      serverId: serializer.fromJson<int>(json['serverId']),
      hostname: serializer.fromJson<String>(json['hostname']),
      emailFromLogin: serializer.fromJson<String>(json['emailFromLogin']),
      token: serializer.fromJson<String>(json['token']),
      syncFreqInSeconds: serializer.fromJson<int?>(json['syncFreqInSeconds']),
      syncPeriod: serializer.fromJson<String?>(json['syncPeriod']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int?>(localId),
      'serverId': serializer.toJson<int>(serverId),
      'hostname': serializer.toJson<String>(hostname),
      'emailFromLogin': serializer.toJson<String>(emailFromLogin),
      'token': serializer.toJson<String>(token),
      'syncFreqInSeconds': serializer.toJson<int?>(syncFreqInSeconds),
      'syncPeriod': serializer.toJson<String?>(syncPeriod),
    };
  }

  User copyWith(
          {int? localId,
          int? serverId,
          String? hostname,
          String? emailFromLogin,
          String? token,
          int? syncFreqInSeconds,
          String? syncPeriod}) =>
      User(
        localId: localId ?? this.localId,
        serverId: serverId ?? this.serverId,
        hostname: hostname ?? this.hostname,
        emailFromLogin: emailFromLogin ?? this.emailFromLogin,
        token: token ?? this.token,
        syncFreqInSeconds: syncFreqInSeconds ?? this.syncFreqInSeconds,
        syncPeriod: syncPeriod ?? this.syncPeriod,
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
          ..write('syncPeriod: $syncPeriod')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(localId, serverId, hostname, emailFromLogin,
      token, syncFreqInSeconds, syncPeriod);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.localId == this.localId &&
          other.serverId == this.serverId &&
          other.hostname == this.hostname &&
          other.emailFromLogin == this.emailFromLogin &&
          other.token == this.token &&
          other.syncFreqInSeconds == this.syncFreqInSeconds &&
          other.syncPeriod == this.syncPeriod);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int?> localId;
  final Value<int> serverId;
  final Value<String> hostname;
  final Value<String> emailFromLogin;
  final Value<String> token;
  final Value<int?> syncFreqInSeconds;
  final Value<String?> syncPeriod;
  const UsersCompanion({
    this.localId = const Value.absent(),
    this.serverId = const Value.absent(),
    this.hostname = const Value.absent(),
    this.emailFromLogin = const Value.absent(),
    this.token = const Value.absent(),
    this.syncFreqInSeconds = const Value.absent(),
    this.syncPeriod = const Value.absent(),
  });
  UsersCompanion.insert({
    this.localId = const Value.absent(),
    required int serverId,
    required String hostname,
    required String emailFromLogin,
    required String token,
    this.syncFreqInSeconds = const Value.absent(),
    this.syncPeriod = const Value.absent(),
  })  : serverId = Value(serverId),
        hostname = Value(hostname),
        emailFromLogin = Value(emailFromLogin),
        token = Value(token);
  static Insertable<User> custom({
    Expression<int?>? localId,
    Expression<int>? serverId,
    Expression<String>? hostname,
    Expression<String>? emailFromLogin,
    Expression<String>? token,
    Expression<int?>? syncFreqInSeconds,
    Expression<String?>? syncPeriod,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (serverId != null) 'server_id': serverId,
      if (hostname != null) 'hostname': hostname,
      if (emailFromLogin != null) 'email_from_login': emailFromLogin,
      if (token != null) 'token': token,
      if (syncFreqInSeconds != null) 'sync_freq_in_seconds': syncFreqInSeconds,
      if (syncPeriod != null) 'sync_period': syncPeriod,
    });
  }

  UsersCompanion copyWith(
      {Value<int?>? localId,
      Value<int>? serverId,
      Value<String>? hostname,
      Value<String>? emailFromLogin,
      Value<String>? token,
      Value<int?>? syncFreqInSeconds,
      Value<String?>? syncPeriod}) {
    return UsersCompanion(
      localId: localId ?? this.localId,
      serverId: serverId ?? this.serverId,
      hostname: hostname ?? this.hostname,
      emailFromLogin: emailFromLogin ?? this.emailFromLogin,
      token: token ?? this.token,
      syncFreqInSeconds: syncFreqInSeconds ?? this.syncFreqInSeconds,
      syncPeriod: syncPeriod ?? this.syncPeriod,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int?>(localId.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (hostname.present) {
      map['hostname'] = Variable<String>(hostname.value);
    }
    if (emailFromLogin.present) {
      map['email_from_login'] = Variable<String>(emailFromLogin.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (syncFreqInSeconds.present) {
      map['sync_freq_in_seconds'] = Variable<int?>(syncFreqInSeconds.value);
    }
    if (syncPeriod.present) {
      map['sync_period'] = Variable<String?>(syncPeriod.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('localId: $localId, ')
          ..write('serverId: $serverId, ')
          ..write('hostname: $hostname, ')
          ..write('emailFromLogin: $emailFromLogin, ')
          ..write('token: $token, ')
          ..write('syncFreqInSeconds: $syncFreqInSeconds, ')
          ..write('syncPeriod: $syncPeriod')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  @override
  late final GeneratedColumn<int?> localId = GeneratedColumn<int?>(
      'local_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<int?> serverId = GeneratedColumn<int?>(
      'server_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _hostnameMeta = const VerificationMeta('hostname');
  @override
  late final GeneratedColumn<String?> hostname = GeneratedColumn<String?>(
      'hostname', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailFromLoginMeta =
      const VerificationMeta('emailFromLogin');
  @override
  late final GeneratedColumn<String?> emailFromLogin = GeneratedColumn<String?>(
      'email_from_login', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _syncFreqInSecondsMeta =
      const VerificationMeta('syncFreqInSeconds');
  @override
  late final GeneratedColumn<int?> syncFreqInSeconds = GeneratedColumn<int?>(
      'sync_freq_in_seconds', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(
          !BuildProperty.backgroundSync ? SyncFreq.NEVER_IN_SECONDS : 300));
  final VerificationMeta _syncPeriodMeta = const VerificationMeta('syncPeriod');
  @override
  late final GeneratedColumn<String?> syncPeriod = GeneratedColumn<String?>(
      'sync_period', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        localId,
        serverId,
        hostname,
        emailFromLogin,
        token,
        syncFreqInSeconds,
        syncPeriod
      ];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('hostname')) {
      context.handle(_hostnameMeta,
          hostname.isAcceptableOrUnknown(data['hostname']!, _hostnameMeta));
    } else if (isInserting) {
      context.missing(_hostnameMeta);
    }
    if (data.containsKey('email_from_login')) {
      context.handle(
          _emailFromLoginMeta,
          emailFromLogin.isAcceptableOrUnknown(
              data['email_from_login']!, _emailFromLoginMeta));
    } else if (isInserting) {
      context.missing(_emailFromLoginMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('sync_freq_in_seconds')) {
      context.handle(
          _syncFreqInSecondsMeta,
          syncFreqInSeconds.isAcceptableOrUnknown(
              data['sync_freq_in_seconds']!, _syncFreqInSecondsMeta));
    }
    if (data.containsKey('sync_period')) {
      context.handle(
          _syncPeriodMeta,
          syncPeriod.isAcceptableOrUnknown(
              data['sync_period']!, _syncPeriodMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int? localId;
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
      {this.localId,
      required this.userLocalId,
      required this.entityId,
      required this.idUser,
      required this.uuid,
      required this.parentUuid,
      required this.moduleName,
      required this.useToAuthorize,
      required this.email,
      required this.friendlyName,
      required this.useSignature,
      required this.signature,
      required this.serverId,
      required this.foldersOrderInJson,
      required this.useThreading,
      required this.saveRepliesToCurrFolder,
      required this.accountId,
      required this.allowFilters,
      required this.allowForward,
      required this.allowAutoResponder});
  factory Account.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Account(
      localId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id'])!,
      entityId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}entity_id'])!,
      idUser: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_user'])!,
      uuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uuid'])!,
      parentUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_uuid'])!,
      moduleName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}module_name'])!,
      useToAuthorize: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}use_to_authorize'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      friendlyName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}friendly_name'])!,
      useSignature: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}use_signature'])!,
      signature: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}signature'])!,
      serverId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}server_id'])!,
      foldersOrderInJson: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}folders_order_in_json'])!,
      useThreading: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}use_threading'])!,
      saveRepliesToCurrFolder: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}save_replies_to_curr_folder'])!,
      accountId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_id'])!,
      allowFilters: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}allow_filters'])!,
      allowForward: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}allow_forward'])!,
      allowAutoResponder: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}allow_auto_responder'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || localId != null) {
      map['local_id'] = Variable<int?>(localId);
    }
    map['user_local_id'] = Variable<int>(userLocalId);
    map['entity_id'] = Variable<int>(entityId);
    map['id_user'] = Variable<int>(idUser);
    map['uuid'] = Variable<String>(uuid);
    map['parent_uuid'] = Variable<String>(parentUuid);
    map['module_name'] = Variable<String>(moduleName);
    map['use_to_authorize'] = Variable<bool>(useToAuthorize);
    map['email'] = Variable<String>(email);
    map['friendly_name'] = Variable<String>(friendlyName);
    map['use_signature'] = Variable<bool>(useSignature);
    map['signature'] = Variable<String>(signature);
    map['server_id'] = Variable<int>(serverId);
    map['folders_order_in_json'] = Variable<String>(foldersOrderInJson);
    map['use_threading'] = Variable<bool>(useThreading);
    map['save_replies_to_curr_folder'] =
        Variable<bool>(saveRepliesToCurrFolder);
    map['account_id'] = Variable<int>(accountId);
    map['allow_filters'] = Variable<bool>(allowFilters);
    map['allow_forward'] = Variable<bool>(allowForward);
    map['allow_auto_responder'] = Variable<bool>(allowAutoResponder);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      userLocalId: Value(userLocalId),
      entityId: Value(entityId),
      idUser: Value(idUser),
      uuid: Value(uuid),
      parentUuid: Value(parentUuid),
      moduleName: Value(moduleName),
      useToAuthorize: Value(useToAuthorize),
      email: Value(email),
      friendlyName: Value(friendlyName),
      useSignature: Value(useSignature),
      signature: Value(signature),
      serverId: Value(serverId),
      foldersOrderInJson: Value(foldersOrderInJson),
      useThreading: Value(useThreading),
      saveRepliesToCurrFolder: Value(saveRepliesToCurrFolder),
      accountId: Value(accountId),
      allowFilters: Value(allowFilters),
      allowForward: Value(allowForward),
      allowAutoResponder: Value(allowAutoResponder),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      localId: serializer.fromJson<int?>(json['localId']),
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
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int?>(localId),
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

  Account copyWith(
          {int? localId,
          int? userLocalId,
          int? entityId,
          int? idUser,
          String? uuid,
          String? parentUuid,
          String? moduleName,
          bool? useToAuthorize,
          String? email,
          String? friendlyName,
          bool? useSignature,
          String? signature,
          int? serverId,
          String? foldersOrderInJson,
          bool? useThreading,
          bool? saveRepliesToCurrFolder,
          int? accountId,
          bool? allowFilters,
          bool? allowForward,
          bool? allowAutoResponder}) =>
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
  int get hashCode => Object.hash(
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
      allowAutoResponder);
  @override
  bool operator ==(Object other) =>
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
  final Value<int?> localId;
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
    required int userLocalId,
    required int entityId,
    required int idUser,
    required String uuid,
    required String parentUuid,
    required String moduleName,
    required bool useToAuthorize,
    required String email,
    required String friendlyName,
    required bool useSignature,
    required String signature,
    required int serverId,
    required String foldersOrderInJson,
    required bool useThreading,
    required bool saveRepliesToCurrFolder,
    required int accountId,
    required bool allowFilters,
    required bool allowForward,
    required bool allowAutoResponder,
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
  static Insertable<Account> custom({
    Expression<int?>? localId,
    Expression<int>? userLocalId,
    Expression<int>? entityId,
    Expression<int>? idUser,
    Expression<String>? uuid,
    Expression<String>? parentUuid,
    Expression<String>? moduleName,
    Expression<bool>? useToAuthorize,
    Expression<String>? email,
    Expression<String>? friendlyName,
    Expression<bool>? useSignature,
    Expression<String>? signature,
    Expression<int>? serverId,
    Expression<String>? foldersOrderInJson,
    Expression<bool>? useThreading,
    Expression<bool>? saveRepliesToCurrFolder,
    Expression<int>? accountId,
    Expression<bool>? allowFilters,
    Expression<bool>? allowForward,
    Expression<bool>? allowAutoResponder,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (entityId != null) 'entity_id': entityId,
      if (idUser != null) 'id_user': idUser,
      if (uuid != null) 'uuid': uuid,
      if (parentUuid != null) 'parent_uuid': parentUuid,
      if (moduleName != null) 'module_name': moduleName,
      if (useToAuthorize != null) 'use_to_authorize': useToAuthorize,
      if (email != null) 'email': email,
      if (friendlyName != null) 'friendly_name': friendlyName,
      if (useSignature != null) 'use_signature': useSignature,
      if (signature != null) 'signature': signature,
      if (serverId != null) 'server_id': serverId,
      if (foldersOrderInJson != null)
        'folders_order_in_json': foldersOrderInJson,
      if (useThreading != null) 'use_threading': useThreading,
      if (saveRepliesToCurrFolder != null)
        'save_replies_to_curr_folder': saveRepliesToCurrFolder,
      if (accountId != null) 'account_id': accountId,
      if (allowFilters != null) 'allow_filters': allowFilters,
      if (allowForward != null) 'allow_forward': allowForward,
      if (allowAutoResponder != null)
        'allow_auto_responder': allowAutoResponder,
    });
  }

  AccountsCompanion copyWith(
      {Value<int?>? localId,
      Value<int>? userLocalId,
      Value<int>? entityId,
      Value<int>? idUser,
      Value<String>? uuid,
      Value<String>? parentUuid,
      Value<String>? moduleName,
      Value<bool>? useToAuthorize,
      Value<String>? email,
      Value<String>? friendlyName,
      Value<bool>? useSignature,
      Value<String>? signature,
      Value<int>? serverId,
      Value<String>? foldersOrderInJson,
      Value<bool>? useThreading,
      Value<bool>? saveRepliesToCurrFolder,
      Value<int>? accountId,
      Value<bool>? allowFilters,
      Value<bool>? allowForward,
      Value<bool>? allowAutoResponder}) {
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int?>(localId.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int>(userLocalId.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<int>(idUser.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (parentUuid.present) {
      map['parent_uuid'] = Variable<String>(parentUuid.value);
    }
    if (moduleName.present) {
      map['module_name'] = Variable<String>(moduleName.value);
    }
    if (useToAuthorize.present) {
      map['use_to_authorize'] = Variable<bool>(useToAuthorize.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (friendlyName.present) {
      map['friendly_name'] = Variable<String>(friendlyName.value);
    }
    if (useSignature.present) {
      map['use_signature'] = Variable<bool>(useSignature.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String>(signature.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (foldersOrderInJson.present) {
      map['folders_order_in_json'] = Variable<String>(foldersOrderInJson.value);
    }
    if (useThreading.present) {
      map['use_threading'] = Variable<bool>(useThreading.value);
    }
    if (saveRepliesToCurrFolder.present) {
      map['save_replies_to_curr_folder'] =
          Variable<bool>(saveRepliesToCurrFolder.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (allowFilters.present) {
      map['allow_filters'] = Variable<bool>(allowFilters.value);
    }
    if (allowForward.present) {
      map['allow_forward'] = Variable<bool>(allowForward.value);
    }
    if (allowAutoResponder.present) {
      map['allow_auto_responder'] = Variable<bool>(allowAutoResponder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
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
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  @override
  late final GeneratedColumn<int?> localId = GeneratedColumn<int?>(
      'local_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _entityIdMeta = const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<int?> entityId = GeneratedColumn<int?>(
      'entity_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  @override
  late final GeneratedColumn<int?> idUser = GeneratedColumn<int?>(
      'id_user', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String?> uuid = GeneratedColumn<String?>(
      'uuid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _parentUuidMeta = const VerificationMeta('parentUuid');
  @override
  late final GeneratedColumn<String?> parentUuid = GeneratedColumn<String?>(
      'parent_uuid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _moduleNameMeta = const VerificationMeta('moduleName');
  @override
  late final GeneratedColumn<String?> moduleName = GeneratedColumn<String?>(
      'module_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _useToAuthorizeMeta =
      const VerificationMeta('useToAuthorize');
  @override
  late final GeneratedColumn<bool?> useToAuthorize = GeneratedColumn<bool?>(
      'use_to_authorize', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (use_to_authorize IN (0, 1))');
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _friendlyNameMeta =
      const VerificationMeta('friendlyName');
  @override
  late final GeneratedColumn<String?> friendlyName = GeneratedColumn<String?>(
      'friendly_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _useSignatureMeta =
      const VerificationMeta('useSignature');
  @override
  late final GeneratedColumn<bool?> useSignature = GeneratedColumn<bool?>(
      'use_signature', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (use_signature IN (0, 1))');
  final VerificationMeta _signatureMeta = const VerificationMeta('signature');
  @override
  late final GeneratedColumn<String?> signature = GeneratedColumn<String?>(
      'signature', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<int?> serverId = GeneratedColumn<int?>(
      'server_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _foldersOrderInJsonMeta =
      const VerificationMeta('foldersOrderInJson');
  @override
  late final GeneratedColumn<String?> foldersOrderInJson =
      GeneratedColumn<String?>('folders_order_in_json', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _useThreadingMeta =
      const VerificationMeta('useThreading');
  @override
  late final GeneratedColumn<bool?> useThreading = GeneratedColumn<bool?>(
      'use_threading', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (use_threading IN (0, 1))');
  final VerificationMeta _saveRepliesToCurrFolderMeta =
      const VerificationMeta('saveRepliesToCurrFolder');
  @override
  late final GeneratedColumn<bool?> saveRepliesToCurrFolder =
      GeneratedColumn<bool?>('save_replies_to_curr_folder', aliasedName, false,
          type: const BoolType(),
          requiredDuringInsert: true,
          defaultConstraints: 'CHECK (save_replies_to_curr_folder IN (0, 1))');
  final VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<int?> accountId = GeneratedColumn<int?>(
      'account_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _allowFiltersMeta =
      const VerificationMeta('allowFilters');
  @override
  late final GeneratedColumn<bool?> allowFilters = GeneratedColumn<bool?>(
      'allow_filters', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (allow_filters IN (0, 1))');
  final VerificationMeta _allowForwardMeta =
      const VerificationMeta('allowForward');
  @override
  late final GeneratedColumn<bool?> allowForward = GeneratedColumn<bool?>(
      'allow_forward', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (allow_forward IN (0, 1))');
  final VerificationMeta _allowAutoResponderMeta =
      const VerificationMeta('allowAutoResponder');
  @override
  late final GeneratedColumn<bool?> allowAutoResponder = GeneratedColumn<bool?>(
      'allow_auto_responder', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (allow_auto_responder IN (0, 1))');
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
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user']!, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('parent_uuid')) {
      context.handle(
          _parentUuidMeta,
          parentUuid.isAcceptableOrUnknown(
              data['parent_uuid']!, _parentUuidMeta));
    } else if (isInserting) {
      context.missing(_parentUuidMeta);
    }
    if (data.containsKey('module_name')) {
      context.handle(
          _moduleNameMeta,
          moduleName.isAcceptableOrUnknown(
              data['module_name']!, _moduleNameMeta));
    } else if (isInserting) {
      context.missing(_moduleNameMeta);
    }
    if (data.containsKey('use_to_authorize')) {
      context.handle(
          _useToAuthorizeMeta,
          useToAuthorize.isAcceptableOrUnknown(
              data['use_to_authorize']!, _useToAuthorizeMeta));
    } else if (isInserting) {
      context.missing(_useToAuthorizeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('friendly_name')) {
      context.handle(
          _friendlyNameMeta,
          friendlyName.isAcceptableOrUnknown(
              data['friendly_name']!, _friendlyNameMeta));
    } else if (isInserting) {
      context.missing(_friendlyNameMeta);
    }
    if (data.containsKey('use_signature')) {
      context.handle(
          _useSignatureMeta,
          useSignature.isAcceptableOrUnknown(
              data['use_signature']!, _useSignatureMeta));
    } else if (isInserting) {
      context.missing(_useSignatureMeta);
    }
    if (data.containsKey('signature')) {
      context.handle(_signatureMeta,
          signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta));
    } else if (isInserting) {
      context.missing(_signatureMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('folders_order_in_json')) {
      context.handle(
          _foldersOrderInJsonMeta,
          foldersOrderInJson.isAcceptableOrUnknown(
              data['folders_order_in_json']!, _foldersOrderInJsonMeta));
    } else if (isInserting) {
      context.missing(_foldersOrderInJsonMeta);
    }
    if (data.containsKey('use_threading')) {
      context.handle(
          _useThreadingMeta,
          useThreading.isAcceptableOrUnknown(
              data['use_threading']!, _useThreadingMeta));
    } else if (isInserting) {
      context.missing(_useThreadingMeta);
    }
    if (data.containsKey('save_replies_to_curr_folder')) {
      context.handle(
          _saveRepliesToCurrFolderMeta,
          saveRepliesToCurrFolder.isAcceptableOrUnknown(
              data['save_replies_to_curr_folder']!,
              _saveRepliesToCurrFolderMeta));
    } else if (isInserting) {
      context.missing(_saveRepliesToCurrFolderMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('allow_filters')) {
      context.handle(
          _allowFiltersMeta,
          allowFilters.isAcceptableOrUnknown(
              data['allow_filters']!, _allowFiltersMeta));
    } else if (isInserting) {
      context.missing(_allowFiltersMeta);
    }
    if (data.containsKey('allow_forward')) {
      context.handle(
          _allowForwardMeta,
          allowForward.isAcceptableOrUnknown(
              data['allow_forward']!, _allowForwardMeta));
    } else if (isInserting) {
      context.missing(_allowForwardMeta);
    }
    if (data.containsKey('allow_auto_responder')) {
      context.handle(
          _allowAutoResponderMeta,
          allowAutoResponder.isAcceptableOrUnknown(
              data['allow_auto_responder']!, _allowAutoResponderMeta));
    } else if (isInserting) {
      context.missing(_allowAutoResponderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Account.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class ContactDb extends DataClass implements Insertable<ContactDb> {
  final String uuidPlusStorage;
  final String uuid;
  final int userLocalId;
  final int? entityId;
  final String? parentUuid;
  final String eTag;
  final int idUser;
  final int? idTenant;
  final String storage;
  final String fullName;
  final bool? useFriendlyName;
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
  final bool? auto;
  final int frequency;
  final String? dateModified;
  final String? davContactsUid;
  final String? davContactsVCardUid;
  final String? pgpPublicKey;
  final List<String> groupUUIDs;
  final bool autoSign;
  final bool autoEncrypt;
  ContactDb(
      {required this.uuidPlusStorage,
      required this.uuid,
      required this.userLocalId,
      this.entityId,
      this.parentUuid,
      required this.eTag,
      required this.idUser,
      this.idTenant,
      required this.storage,
      required this.fullName,
      this.useFriendlyName,
      required this.primaryEmail,
      required this.primaryPhone,
      required this.primaryAddress,
      required this.viewEmail,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.nickName,
      required this.skype,
      required this.facebook,
      required this.personalEmail,
      required this.personalAddress,
      required this.personalCity,
      required this.personalState,
      required this.personalZip,
      required this.personalCountry,
      required this.personalWeb,
      required this.personalFax,
      required this.personalPhone,
      required this.personalMobile,
      required this.businessEmail,
      required this.businessCompany,
      required this.businessAddress,
      required this.businessCity,
      required this.businessState,
      required this.businessZip,
      required this.businessCountry,
      required this.businessJobTitle,
      required this.businessDepartment,
      required this.businessOffice,
      required this.businessPhone,
      required this.businessFax,
      required this.businessWeb,
      required this.otherEmail,
      required this.notes,
      required this.birthDay,
      required this.birthMonth,
      required this.birthYear,
      this.auto,
      required this.frequency,
      this.dateModified,
      this.davContactsUid,
      this.davContactsVCardUid,
      this.pgpPublicKey,
      required this.groupUUIDs,
      required this.autoSign,
      required this.autoEncrypt});
  factory ContactDb.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContactDb(
      uuidPlusStorage: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}uuid_plus_storage'])!,
      uuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uuid'])!,
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id'])!,
      entityId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}entity_id']),
      parentUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_uuid']),
      eTag: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}e_tag'])!,
      idUser: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_user'])!,
      idTenant: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_tenant']),
      storage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage'])!,
      fullName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name'])!,
      useFriendlyName: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}use_friendly_name']),
      primaryEmail: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}primary_email'])!,
      primaryPhone: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}primary_phone'])!,
      primaryAddress: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}primary_address'])!,
      viewEmail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}view_email'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      nickName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nick_name'])!,
      skype: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}skype'])!,
      facebook: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}facebook'])!,
      personalEmail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_email'])!,
      personalAddress: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_address'])!,
      personalCity: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_city'])!,
      personalState: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_state'])!,
      personalZip: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_zip'])!,
      personalCountry: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_country'])!,
      personalWeb: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_web'])!,
      personalFax: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_fax'])!,
      personalPhone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_phone'])!,
      personalMobile: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_mobile'])!,
      businessEmail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_email'])!,
      businessCompany: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_company'])!,
      businessAddress: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_address'])!,
      businessCity: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_city'])!,
      businessState: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_state'])!,
      businessZip: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_zip'])!,
      businessCountry: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_country'])!,
      businessJobTitle: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}business_job_title'])!,
      businessDepartment: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}business_department'])!,
      businessOffice: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_office'])!,
      businessPhone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_phone'])!,
      businessFax: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_fax'])!,
      businessWeb: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_web'])!,
      otherEmail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}other_email'])!,
      notes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notes'])!,
      birthDay: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}birth_day'])!,
      birthMonth: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}birth_month'])!,
      birthYear: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}birth_year'])!,
      auto: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}auto']),
      frequency: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}frequency'])!,
      dateModified: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_modified']),
      davContactsUid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dav_contacts_uid']),
      davContactsVCardUid: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}dav_contacts_v_card_uid']),
      pgpPublicKey: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pgp_public_key']),
      groupUUIDs: $ContactsTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}group_u_u_i_ds']))!,
      autoSign: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}auto_sign'])!,
      autoEncrypt: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}auto_encrypt'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid_plus_storage'] = Variable<String>(uuidPlusStorage);
    map['uuid'] = Variable<String>(uuid);
    map['user_local_id'] = Variable<int>(userLocalId);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<int?>(entityId);
    }
    if (!nullToAbsent || parentUuid != null) {
      map['parent_uuid'] = Variable<String?>(parentUuid);
    }
    map['e_tag'] = Variable<String>(eTag);
    map['id_user'] = Variable<int>(idUser);
    if (!nullToAbsent || idTenant != null) {
      map['id_tenant'] = Variable<int?>(idTenant);
    }
    map['storage'] = Variable<String>(storage);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || useFriendlyName != null) {
      map['use_friendly_name'] = Variable<bool?>(useFriendlyName);
    }
    map['primary_email'] = Variable<int>(primaryEmail);
    map['primary_phone'] = Variable<int>(primaryPhone);
    map['primary_address'] = Variable<int>(primaryAddress);
    map['view_email'] = Variable<String>(viewEmail);
    map['title'] = Variable<String>(title);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['nick_name'] = Variable<String>(nickName);
    map['skype'] = Variable<String>(skype);
    map['facebook'] = Variable<String>(facebook);
    map['personal_email'] = Variable<String>(personalEmail);
    map['personal_address'] = Variable<String>(personalAddress);
    map['personal_city'] = Variable<String>(personalCity);
    map['personal_state'] = Variable<String>(personalState);
    map['personal_zip'] = Variable<String>(personalZip);
    map['personal_country'] = Variable<String>(personalCountry);
    map['personal_web'] = Variable<String>(personalWeb);
    map['personal_fax'] = Variable<String>(personalFax);
    map['personal_phone'] = Variable<String>(personalPhone);
    map['personal_mobile'] = Variable<String>(personalMobile);
    map['business_email'] = Variable<String>(businessEmail);
    map['business_company'] = Variable<String>(businessCompany);
    map['business_address'] = Variable<String>(businessAddress);
    map['business_city'] = Variable<String>(businessCity);
    map['business_state'] = Variable<String>(businessState);
    map['business_zip'] = Variable<String>(businessZip);
    map['business_country'] = Variable<String>(businessCountry);
    map['business_job_title'] = Variable<String>(businessJobTitle);
    map['business_department'] = Variable<String>(businessDepartment);
    map['business_office'] = Variable<String>(businessOffice);
    map['business_phone'] = Variable<String>(businessPhone);
    map['business_fax'] = Variable<String>(businessFax);
    map['business_web'] = Variable<String>(businessWeb);
    map['other_email'] = Variable<String>(otherEmail);
    map['notes'] = Variable<String>(notes);
    map['birth_day'] = Variable<int>(birthDay);
    map['birth_month'] = Variable<int>(birthMonth);
    map['birth_year'] = Variable<int>(birthYear);
    if (!nullToAbsent || auto != null) {
      map['auto'] = Variable<bool?>(auto);
    }
    map['frequency'] = Variable<int>(frequency);
    if (!nullToAbsent || dateModified != null) {
      map['date_modified'] = Variable<String?>(dateModified);
    }
    if (!nullToAbsent || davContactsUid != null) {
      map['dav_contacts_uid'] = Variable<String?>(davContactsUid);
    }
    if (!nullToAbsent || davContactsVCardUid != null) {
      map['dav_contacts_v_card_uid'] = Variable<String?>(davContactsVCardUid);
    }
    if (!nullToAbsent || pgpPublicKey != null) {
      map['pgp_public_key'] = Variable<String?>(pgpPublicKey);
    }
    {
      final converter = $ContactsTableTable.$converter0;
      map['group_u_u_i_ds'] = Variable<String>(converter.mapToSql(groupUUIDs)!);
    }
    map['auto_sign'] = Variable<bool>(autoSign);
    map['auto_encrypt'] = Variable<bool>(autoEncrypt);
    return map;
  }

  ContactsTableCompanion toCompanion(bool nullToAbsent) {
    return ContactsTableCompanion(
      uuidPlusStorage: Value(uuidPlusStorage),
      uuid: Value(uuid),
      userLocalId: Value(userLocalId),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      parentUuid: parentUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(parentUuid),
      eTag: Value(eTag),
      idUser: Value(idUser),
      idTenant: idTenant == null && nullToAbsent
          ? const Value.absent()
          : Value(idTenant),
      storage: Value(storage),
      fullName: Value(fullName),
      useFriendlyName: useFriendlyName == null && nullToAbsent
          ? const Value.absent()
          : Value(useFriendlyName),
      primaryEmail: Value(primaryEmail),
      primaryPhone: Value(primaryPhone),
      primaryAddress: Value(primaryAddress),
      viewEmail: Value(viewEmail),
      title: Value(title),
      firstName: Value(firstName),
      lastName: Value(lastName),
      nickName: Value(nickName),
      skype: Value(skype),
      facebook: Value(facebook),
      personalEmail: Value(personalEmail),
      personalAddress: Value(personalAddress),
      personalCity: Value(personalCity),
      personalState: Value(personalState),
      personalZip: Value(personalZip),
      personalCountry: Value(personalCountry),
      personalWeb: Value(personalWeb),
      personalFax: Value(personalFax),
      personalPhone: Value(personalPhone),
      personalMobile: Value(personalMobile),
      businessEmail: Value(businessEmail),
      businessCompany: Value(businessCompany),
      businessAddress: Value(businessAddress),
      businessCity: Value(businessCity),
      businessState: Value(businessState),
      businessZip: Value(businessZip),
      businessCountry: Value(businessCountry),
      businessJobTitle: Value(businessJobTitle),
      businessDepartment: Value(businessDepartment),
      businessOffice: Value(businessOffice),
      businessPhone: Value(businessPhone),
      businessFax: Value(businessFax),
      businessWeb: Value(businessWeb),
      otherEmail: Value(otherEmail),
      notes: Value(notes),
      birthDay: Value(birthDay),
      birthMonth: Value(birthMonth),
      birthYear: Value(birthYear),
      auto: auto == null && nullToAbsent ? const Value.absent() : Value(auto),
      frequency: Value(frequency),
      dateModified: dateModified == null && nullToAbsent
          ? const Value.absent()
          : Value(dateModified),
      davContactsUid: davContactsUid == null && nullToAbsent
          ? const Value.absent()
          : Value(davContactsUid),
      davContactsVCardUid: davContactsVCardUid == null && nullToAbsent
          ? const Value.absent()
          : Value(davContactsVCardUid),
      pgpPublicKey: pgpPublicKey == null && nullToAbsent
          ? const Value.absent()
          : Value(pgpPublicKey),
      groupUUIDs: Value(groupUUIDs),
      autoSign: Value(autoSign),
      autoEncrypt: Value(autoEncrypt),
    );
  }

  factory ContactDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactDb(
      uuidPlusStorage: serializer.fromJson<String>(json['uuidPlusStorage']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      entityId: serializer.fromJson<int?>(json['entityId']),
      parentUuid: serializer.fromJson<String?>(json['parentUuid']),
      eTag: serializer.fromJson<String>(json['eTag']),
      idUser: serializer.fromJson<int>(json['idUser']),
      idTenant: serializer.fromJson<int?>(json['idTenant']),
      storage: serializer.fromJson<String>(json['storage']),
      fullName: serializer.fromJson<String>(json['fullName']),
      useFriendlyName: serializer.fromJson<bool?>(json['useFriendlyName']),
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
      auto: serializer.fromJson<bool?>(json['auto']),
      frequency: serializer.fromJson<int>(json['frequency']),
      dateModified: serializer.fromJson<String?>(json['dateModified']),
      davContactsUid: serializer.fromJson<String?>(json['davContactsUid']),
      davContactsVCardUid:
          serializer.fromJson<String?>(json['davContactsVCardUid']),
      pgpPublicKey: serializer.fromJson<String?>(json['pgpPublicKey']),
      groupUUIDs: serializer.fromJson<List<String>>(json['groupUUIDs']),
      autoSign: serializer.fromJson<bool>(json['autoSign']),
      autoEncrypt: serializer.fromJson<bool>(json['autoEncrypt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuidPlusStorage': serializer.toJson<String>(uuidPlusStorage),
      'uuid': serializer.toJson<String>(uuid),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'entityId': serializer.toJson<int?>(entityId),
      'parentUuid': serializer.toJson<String?>(parentUuid),
      'eTag': serializer.toJson<String>(eTag),
      'idUser': serializer.toJson<int>(idUser),
      'idTenant': serializer.toJson<int?>(idTenant),
      'storage': serializer.toJson<String>(storage),
      'fullName': serializer.toJson<String>(fullName),
      'useFriendlyName': serializer.toJson<bool?>(useFriendlyName),
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
      'auto': serializer.toJson<bool?>(auto),
      'frequency': serializer.toJson<int>(frequency),
      'dateModified': serializer.toJson<String?>(dateModified),
      'davContactsUid': serializer.toJson<String?>(davContactsUid),
      'davContactsVCardUid': serializer.toJson<String?>(davContactsVCardUid),
      'pgpPublicKey': serializer.toJson<String?>(pgpPublicKey),
      'groupUUIDs': serializer.toJson<List<String>>(groupUUIDs),
      'autoSign': serializer.toJson<bool>(autoSign),
      'autoEncrypt': serializer.toJson<bool>(autoEncrypt),
    };
  }

  ContactDb copyWith(
          {String? uuidPlusStorage,
          String? uuid,
          int? userLocalId,
          int? entityId,
          String? parentUuid,
          String? eTag,
          int? idUser,
          int? idTenant,
          String? storage,
          String? fullName,
          bool? useFriendlyName,
          int? primaryEmail,
          int? primaryPhone,
          int? primaryAddress,
          String? viewEmail,
          String? title,
          String? firstName,
          String? lastName,
          String? nickName,
          String? skype,
          String? facebook,
          String? personalEmail,
          String? personalAddress,
          String? personalCity,
          String? personalState,
          String? personalZip,
          String? personalCountry,
          String? personalWeb,
          String? personalFax,
          String? personalPhone,
          String? personalMobile,
          String? businessEmail,
          String? businessCompany,
          String? businessAddress,
          String? businessCity,
          String? businessState,
          String? businessZip,
          String? businessCountry,
          String? businessJobTitle,
          String? businessDepartment,
          String? businessOffice,
          String? businessPhone,
          String? businessFax,
          String? businessWeb,
          String? otherEmail,
          String? notes,
          int? birthDay,
          int? birthMonth,
          int? birthYear,
          bool? auto,
          int? frequency,
          String? dateModified,
          String? davContactsUid,
          String? davContactsVCardUid,
          String? pgpPublicKey,
          List<String>? groupUUIDs,
          bool? autoSign,
          bool? autoEncrypt}) =>
      ContactDb(
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
        pgpPublicKey: pgpPublicKey ?? this.pgpPublicKey,
        groupUUIDs: groupUUIDs ?? this.groupUUIDs,
        autoSign: autoSign ?? this.autoSign,
        autoEncrypt: autoEncrypt ?? this.autoEncrypt,
      );
  @override
  String toString() {
    return (StringBuffer('ContactDb(')
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
          ..write('pgpPublicKey: $pgpPublicKey, ')
          ..write('groupUUIDs: $groupUUIDs, ')
          ..write('autoSign: $autoSign, ')
          ..write('autoEncrypt: $autoEncrypt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
        pgpPublicKey,
        groupUUIDs,
        autoSign,
        autoEncrypt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactDb &&
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
          other.pgpPublicKey == this.pgpPublicKey &&
          other.groupUUIDs == this.groupUUIDs &&
          other.autoSign == this.autoSign &&
          other.autoEncrypt == this.autoEncrypt);
}

class ContactsTableCompanion extends UpdateCompanion<ContactDb> {
  final Value<String> uuidPlusStorage;
  final Value<String> uuid;
  final Value<int> userLocalId;
  final Value<int?> entityId;
  final Value<String?> parentUuid;
  final Value<String> eTag;
  final Value<int> idUser;
  final Value<int?> idTenant;
  final Value<String> storage;
  final Value<String> fullName;
  final Value<bool?> useFriendlyName;
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
  final Value<bool?> auto;
  final Value<int> frequency;
  final Value<String?> dateModified;
  final Value<String?> davContactsUid;
  final Value<String?> davContactsVCardUid;
  final Value<String?> pgpPublicKey;
  final Value<List<String>> groupUUIDs;
  final Value<bool> autoSign;
  final Value<bool> autoEncrypt;
  const ContactsTableCompanion({
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
    this.pgpPublicKey = const Value.absent(),
    this.groupUUIDs = const Value.absent(),
    this.autoSign = const Value.absent(),
    this.autoEncrypt = const Value.absent(),
  });
  ContactsTableCompanion.insert({
    required String uuidPlusStorage,
    required String uuid,
    required int userLocalId,
    this.entityId = const Value.absent(),
    this.parentUuid = const Value.absent(),
    required String eTag,
    required int idUser,
    this.idTenant = const Value.absent(),
    required String storage,
    required String fullName,
    this.useFriendlyName = const Value.absent(),
    required int primaryEmail,
    required int primaryPhone,
    required int primaryAddress,
    required String viewEmail,
    required String title,
    required String firstName,
    required String lastName,
    required String nickName,
    required String skype,
    required String facebook,
    required String personalEmail,
    required String personalAddress,
    required String personalCity,
    required String personalState,
    required String personalZip,
    required String personalCountry,
    required String personalWeb,
    required String personalFax,
    required String personalPhone,
    required String personalMobile,
    required String businessEmail,
    required String businessCompany,
    required String businessAddress,
    required String businessCity,
    required String businessState,
    required String businessZip,
    required String businessCountry,
    required String businessJobTitle,
    required String businessDepartment,
    required String businessOffice,
    required String businessPhone,
    required String businessFax,
    required String businessWeb,
    required String otherEmail,
    required String notes,
    required int birthDay,
    required int birthMonth,
    required int birthYear,
    this.auto = const Value.absent(),
    this.frequency = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.davContactsUid = const Value.absent(),
    this.davContactsVCardUid = const Value.absent(),
    this.pgpPublicKey = const Value.absent(),
    required List<String> groupUUIDs,
    this.autoSign = const Value.absent(),
    this.autoEncrypt = const Value.absent(),
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
  static Insertable<ContactDb> custom({
    Expression<String>? uuidPlusStorage,
    Expression<String>? uuid,
    Expression<int>? userLocalId,
    Expression<int?>? entityId,
    Expression<String?>? parentUuid,
    Expression<String>? eTag,
    Expression<int>? idUser,
    Expression<int?>? idTenant,
    Expression<String>? storage,
    Expression<String>? fullName,
    Expression<bool?>? useFriendlyName,
    Expression<int>? primaryEmail,
    Expression<int>? primaryPhone,
    Expression<int>? primaryAddress,
    Expression<String>? viewEmail,
    Expression<String>? title,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? nickName,
    Expression<String>? skype,
    Expression<String>? facebook,
    Expression<String>? personalEmail,
    Expression<String>? personalAddress,
    Expression<String>? personalCity,
    Expression<String>? personalState,
    Expression<String>? personalZip,
    Expression<String>? personalCountry,
    Expression<String>? personalWeb,
    Expression<String>? personalFax,
    Expression<String>? personalPhone,
    Expression<String>? personalMobile,
    Expression<String>? businessEmail,
    Expression<String>? businessCompany,
    Expression<String>? businessAddress,
    Expression<String>? businessCity,
    Expression<String>? businessState,
    Expression<String>? businessZip,
    Expression<String>? businessCountry,
    Expression<String>? businessJobTitle,
    Expression<String>? businessDepartment,
    Expression<String>? businessOffice,
    Expression<String>? businessPhone,
    Expression<String>? businessFax,
    Expression<String>? businessWeb,
    Expression<String>? otherEmail,
    Expression<String>? notes,
    Expression<int>? birthDay,
    Expression<int>? birthMonth,
    Expression<int>? birthYear,
    Expression<bool?>? auto,
    Expression<int>? frequency,
    Expression<String?>? dateModified,
    Expression<String?>? davContactsUid,
    Expression<String?>? davContactsVCardUid,
    Expression<String?>? pgpPublicKey,
    Expression<List<String>>? groupUUIDs,
    Expression<bool>? autoSign,
    Expression<bool>? autoEncrypt,
  }) {
    return RawValuesInsertable({
      if (uuidPlusStorage != null) 'uuid_plus_storage': uuidPlusStorage,
      if (uuid != null) 'uuid': uuid,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (entityId != null) 'entity_id': entityId,
      if (parentUuid != null) 'parent_uuid': parentUuid,
      if (eTag != null) 'e_tag': eTag,
      if (idUser != null) 'id_user': idUser,
      if (idTenant != null) 'id_tenant': idTenant,
      if (storage != null) 'storage': storage,
      if (fullName != null) 'full_name': fullName,
      if (useFriendlyName != null) 'use_friendly_name': useFriendlyName,
      if (primaryEmail != null) 'primary_email': primaryEmail,
      if (primaryPhone != null) 'primary_phone': primaryPhone,
      if (primaryAddress != null) 'primary_address': primaryAddress,
      if (viewEmail != null) 'view_email': viewEmail,
      if (title != null) 'title': title,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (nickName != null) 'nick_name': nickName,
      if (skype != null) 'skype': skype,
      if (facebook != null) 'facebook': facebook,
      if (personalEmail != null) 'personal_email': personalEmail,
      if (personalAddress != null) 'personal_address': personalAddress,
      if (personalCity != null) 'personal_city': personalCity,
      if (personalState != null) 'personal_state': personalState,
      if (personalZip != null) 'personal_zip': personalZip,
      if (personalCountry != null) 'personal_country': personalCountry,
      if (personalWeb != null) 'personal_web': personalWeb,
      if (personalFax != null) 'personal_fax': personalFax,
      if (personalPhone != null) 'personal_phone': personalPhone,
      if (personalMobile != null) 'personal_mobile': personalMobile,
      if (businessEmail != null) 'business_email': businessEmail,
      if (businessCompany != null) 'business_company': businessCompany,
      if (businessAddress != null) 'business_address': businessAddress,
      if (businessCity != null) 'business_city': businessCity,
      if (businessState != null) 'business_state': businessState,
      if (businessZip != null) 'business_zip': businessZip,
      if (businessCountry != null) 'business_country': businessCountry,
      if (businessJobTitle != null) 'business_job_title': businessJobTitle,
      if (businessDepartment != null) 'business_department': businessDepartment,
      if (businessOffice != null) 'business_office': businessOffice,
      if (businessPhone != null) 'business_phone': businessPhone,
      if (businessFax != null) 'business_fax': businessFax,
      if (businessWeb != null) 'business_web': businessWeb,
      if (otherEmail != null) 'other_email': otherEmail,
      if (notes != null) 'notes': notes,
      if (birthDay != null) 'birth_day': birthDay,
      if (birthMonth != null) 'birth_month': birthMonth,
      if (birthYear != null) 'birth_year': birthYear,
      if (auto != null) 'auto': auto,
      if (frequency != null) 'frequency': frequency,
      if (dateModified != null) 'date_modified': dateModified,
      if (davContactsUid != null) 'dav_contacts_uid': davContactsUid,
      if (davContactsVCardUid != null)
        'dav_contacts_v_card_uid': davContactsVCardUid,
      if (pgpPublicKey != null) 'pgp_public_key': pgpPublicKey,
      if (groupUUIDs != null) 'group_u_u_i_ds': groupUUIDs,
      if (autoSign != null) 'auto_sign': autoSign,
      if (autoEncrypt != null) 'auto_encrypt': autoEncrypt,
    });
  }

  ContactsTableCompanion copyWith(
      {Value<String>? uuidPlusStorage,
      Value<String>? uuid,
      Value<int>? userLocalId,
      Value<int?>? entityId,
      Value<String?>? parentUuid,
      Value<String>? eTag,
      Value<int>? idUser,
      Value<int?>? idTenant,
      Value<String>? storage,
      Value<String>? fullName,
      Value<bool?>? useFriendlyName,
      Value<int>? primaryEmail,
      Value<int>? primaryPhone,
      Value<int>? primaryAddress,
      Value<String>? viewEmail,
      Value<String>? title,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? nickName,
      Value<String>? skype,
      Value<String>? facebook,
      Value<String>? personalEmail,
      Value<String>? personalAddress,
      Value<String>? personalCity,
      Value<String>? personalState,
      Value<String>? personalZip,
      Value<String>? personalCountry,
      Value<String>? personalWeb,
      Value<String>? personalFax,
      Value<String>? personalPhone,
      Value<String>? personalMobile,
      Value<String>? businessEmail,
      Value<String>? businessCompany,
      Value<String>? businessAddress,
      Value<String>? businessCity,
      Value<String>? businessState,
      Value<String>? businessZip,
      Value<String>? businessCountry,
      Value<String>? businessJobTitle,
      Value<String>? businessDepartment,
      Value<String>? businessOffice,
      Value<String>? businessPhone,
      Value<String>? businessFax,
      Value<String>? businessWeb,
      Value<String>? otherEmail,
      Value<String>? notes,
      Value<int>? birthDay,
      Value<int>? birthMonth,
      Value<int>? birthYear,
      Value<bool?>? auto,
      Value<int>? frequency,
      Value<String?>? dateModified,
      Value<String?>? davContactsUid,
      Value<String?>? davContactsVCardUid,
      Value<String?>? pgpPublicKey,
      Value<List<String>>? groupUUIDs,
      Value<bool>? autoSign,
      Value<bool>? autoEncrypt}) {
    return ContactsTableCompanion(
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
      pgpPublicKey: pgpPublicKey ?? this.pgpPublicKey,
      groupUUIDs: groupUUIDs ?? this.groupUUIDs,
      autoSign: autoSign ?? this.autoSign,
      autoEncrypt: autoEncrypt ?? this.autoEncrypt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuidPlusStorage.present) {
      map['uuid_plus_storage'] = Variable<String>(uuidPlusStorage.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int>(userLocalId.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int?>(entityId.value);
    }
    if (parentUuid.present) {
      map['parent_uuid'] = Variable<String?>(parentUuid.value);
    }
    if (eTag.present) {
      map['e_tag'] = Variable<String>(eTag.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<int>(idUser.value);
    }
    if (idTenant.present) {
      map['id_tenant'] = Variable<int?>(idTenant.value);
    }
    if (storage.present) {
      map['storage'] = Variable<String>(storage.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (useFriendlyName.present) {
      map['use_friendly_name'] = Variable<bool?>(useFriendlyName.value);
    }
    if (primaryEmail.present) {
      map['primary_email'] = Variable<int>(primaryEmail.value);
    }
    if (primaryPhone.present) {
      map['primary_phone'] = Variable<int>(primaryPhone.value);
    }
    if (primaryAddress.present) {
      map['primary_address'] = Variable<int>(primaryAddress.value);
    }
    if (viewEmail.present) {
      map['view_email'] = Variable<String>(viewEmail.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (skype.present) {
      map['skype'] = Variable<String>(skype.value);
    }
    if (facebook.present) {
      map['facebook'] = Variable<String>(facebook.value);
    }
    if (personalEmail.present) {
      map['personal_email'] = Variable<String>(personalEmail.value);
    }
    if (personalAddress.present) {
      map['personal_address'] = Variable<String>(personalAddress.value);
    }
    if (personalCity.present) {
      map['personal_city'] = Variable<String>(personalCity.value);
    }
    if (personalState.present) {
      map['personal_state'] = Variable<String>(personalState.value);
    }
    if (personalZip.present) {
      map['personal_zip'] = Variable<String>(personalZip.value);
    }
    if (personalCountry.present) {
      map['personal_country'] = Variable<String>(personalCountry.value);
    }
    if (personalWeb.present) {
      map['personal_web'] = Variable<String>(personalWeb.value);
    }
    if (personalFax.present) {
      map['personal_fax'] = Variable<String>(personalFax.value);
    }
    if (personalPhone.present) {
      map['personal_phone'] = Variable<String>(personalPhone.value);
    }
    if (personalMobile.present) {
      map['personal_mobile'] = Variable<String>(personalMobile.value);
    }
    if (businessEmail.present) {
      map['business_email'] = Variable<String>(businessEmail.value);
    }
    if (businessCompany.present) {
      map['business_company'] = Variable<String>(businessCompany.value);
    }
    if (businessAddress.present) {
      map['business_address'] = Variable<String>(businessAddress.value);
    }
    if (businessCity.present) {
      map['business_city'] = Variable<String>(businessCity.value);
    }
    if (businessState.present) {
      map['business_state'] = Variable<String>(businessState.value);
    }
    if (businessZip.present) {
      map['business_zip'] = Variable<String>(businessZip.value);
    }
    if (businessCountry.present) {
      map['business_country'] = Variable<String>(businessCountry.value);
    }
    if (businessJobTitle.present) {
      map['business_job_title'] = Variable<String>(businessJobTitle.value);
    }
    if (businessDepartment.present) {
      map['business_department'] = Variable<String>(businessDepartment.value);
    }
    if (businessOffice.present) {
      map['business_office'] = Variable<String>(businessOffice.value);
    }
    if (businessPhone.present) {
      map['business_phone'] = Variable<String>(businessPhone.value);
    }
    if (businessFax.present) {
      map['business_fax'] = Variable<String>(businessFax.value);
    }
    if (businessWeb.present) {
      map['business_web'] = Variable<String>(businessWeb.value);
    }
    if (otherEmail.present) {
      map['other_email'] = Variable<String>(otherEmail.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (birthDay.present) {
      map['birth_day'] = Variable<int>(birthDay.value);
    }
    if (birthMonth.present) {
      map['birth_month'] = Variable<int>(birthMonth.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<int>(birthYear.value);
    }
    if (auto.present) {
      map['auto'] = Variable<bool?>(auto.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (dateModified.present) {
      map['date_modified'] = Variable<String?>(dateModified.value);
    }
    if (davContactsUid.present) {
      map['dav_contacts_uid'] = Variable<String?>(davContactsUid.value);
    }
    if (davContactsVCardUid.present) {
      map['dav_contacts_v_card_uid'] =
          Variable<String?>(davContactsVCardUid.value);
    }
    if (pgpPublicKey.present) {
      map['pgp_public_key'] = Variable<String?>(pgpPublicKey.value);
    }
    if (groupUUIDs.present) {
      final converter = $ContactsTableTable.$converter0;
      map['group_u_u_i_ds'] =
          Variable<String>(converter.mapToSql(groupUUIDs.value)!);
    }
    if (autoSign.present) {
      map['auto_sign'] = Variable<bool>(autoSign.value);
    }
    if (autoEncrypt.present) {
      map['auto_encrypt'] = Variable<bool>(autoEncrypt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsTableCompanion(')
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
          ..write('pgpPublicKey: $pgpPublicKey, ')
          ..write('groupUUIDs: $groupUUIDs, ')
          ..write('autoSign: $autoSign, ')
          ..write('autoEncrypt: $autoEncrypt')
          ..write(')'))
        .toString();
  }
}

class $ContactsTableTable extends ContactsTable
    with TableInfo<$ContactsTableTable, ContactDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _uuidPlusStorageMeta =
      const VerificationMeta('uuidPlusStorage');
  @override
  late final GeneratedColumn<String?> uuidPlusStorage =
      GeneratedColumn<String?>('uuid_plus_storage', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String?> uuid = GeneratedColumn<String?>(
      'uuid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _entityIdMeta = const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<int?> entityId = GeneratedColumn<int?>(
      'entity_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _parentUuidMeta = const VerificationMeta('parentUuid');
  @override
  late final GeneratedColumn<String?> parentUuid = GeneratedColumn<String?>(
      'parent_uuid', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _eTagMeta = const VerificationMeta('eTag');
  @override
  late final GeneratedColumn<String?> eTag = GeneratedColumn<String?>(
      'e_tag', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  @override
  late final GeneratedColumn<int?> idUser = GeneratedColumn<int?>(
      'id_user', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _idTenantMeta = const VerificationMeta('idTenant');
  @override
  late final GeneratedColumn<int?> idTenant = GeneratedColumn<int?>(
      'id_tenant', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _storageMeta = const VerificationMeta('storage');
  @override
  late final GeneratedColumn<String?> storage = GeneratedColumn<String?>(
      'storage', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String?> fullName = GeneratedColumn<String?>(
      'full_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _useFriendlyNameMeta =
      const VerificationMeta('useFriendlyName');
  @override
  late final GeneratedColumn<bool?> useFriendlyName = GeneratedColumn<bool?>(
      'use_friendly_name', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (use_friendly_name IN (0, 1))');
  final VerificationMeta _primaryEmailMeta =
      const VerificationMeta('primaryEmail');
  @override
  late final GeneratedColumn<int?> primaryEmail = GeneratedColumn<int?>(
      'primary_email', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _primaryPhoneMeta =
      const VerificationMeta('primaryPhone');
  @override
  late final GeneratedColumn<int?> primaryPhone = GeneratedColumn<int?>(
      'primary_phone', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _primaryAddressMeta =
      const VerificationMeta('primaryAddress');
  @override
  late final GeneratedColumn<int?> primaryAddress = GeneratedColumn<int?>(
      'primary_address', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _viewEmailMeta = const VerificationMeta('viewEmail');
  @override
  late final GeneratedColumn<String?> viewEmail = GeneratedColumn<String?>(
      'view_email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nickNameMeta = const VerificationMeta('nickName');
  @override
  late final GeneratedColumn<String?> nickName = GeneratedColumn<String?>(
      'nick_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _skypeMeta = const VerificationMeta('skype');
  @override
  late final GeneratedColumn<String?> skype = GeneratedColumn<String?>(
      'skype', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _facebookMeta = const VerificationMeta('facebook');
  @override
  late final GeneratedColumn<String?> facebook = GeneratedColumn<String?>(
      'facebook', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalEmailMeta =
      const VerificationMeta('personalEmail');
  @override
  late final GeneratedColumn<String?> personalEmail = GeneratedColumn<String?>(
      'personal_email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalAddressMeta =
      const VerificationMeta('personalAddress');
  @override
  late final GeneratedColumn<String?> personalAddress =
      GeneratedColumn<String?>('personal_address', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalCityMeta =
      const VerificationMeta('personalCity');
  @override
  late final GeneratedColumn<String?> personalCity = GeneratedColumn<String?>(
      'personal_city', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalStateMeta =
      const VerificationMeta('personalState');
  @override
  late final GeneratedColumn<String?> personalState = GeneratedColumn<String?>(
      'personal_state', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalZipMeta =
      const VerificationMeta('personalZip');
  @override
  late final GeneratedColumn<String?> personalZip = GeneratedColumn<String?>(
      'personal_zip', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalCountryMeta =
      const VerificationMeta('personalCountry');
  @override
  late final GeneratedColumn<String?> personalCountry =
      GeneratedColumn<String?>('personal_country', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalWebMeta =
      const VerificationMeta('personalWeb');
  @override
  late final GeneratedColumn<String?> personalWeb = GeneratedColumn<String?>(
      'personal_web', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalFaxMeta =
      const VerificationMeta('personalFax');
  @override
  late final GeneratedColumn<String?> personalFax = GeneratedColumn<String?>(
      'personal_fax', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalPhoneMeta =
      const VerificationMeta('personalPhone');
  @override
  late final GeneratedColumn<String?> personalPhone = GeneratedColumn<String?>(
      'personal_phone', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personalMobileMeta =
      const VerificationMeta('personalMobile');
  @override
  late final GeneratedColumn<String?> personalMobile = GeneratedColumn<String?>(
      'personal_mobile', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessEmailMeta =
      const VerificationMeta('businessEmail');
  @override
  late final GeneratedColumn<String?> businessEmail = GeneratedColumn<String?>(
      'business_email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessCompanyMeta =
      const VerificationMeta('businessCompany');
  @override
  late final GeneratedColumn<String?> businessCompany =
      GeneratedColumn<String?>('business_company', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessAddressMeta =
      const VerificationMeta('businessAddress');
  @override
  late final GeneratedColumn<String?> businessAddress =
      GeneratedColumn<String?>('business_address', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessCityMeta =
      const VerificationMeta('businessCity');
  @override
  late final GeneratedColumn<String?> businessCity = GeneratedColumn<String?>(
      'business_city', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessStateMeta =
      const VerificationMeta('businessState');
  @override
  late final GeneratedColumn<String?> businessState = GeneratedColumn<String?>(
      'business_state', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessZipMeta =
      const VerificationMeta('businessZip');
  @override
  late final GeneratedColumn<String?> businessZip = GeneratedColumn<String?>(
      'business_zip', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessCountryMeta =
      const VerificationMeta('businessCountry');
  @override
  late final GeneratedColumn<String?> businessCountry =
      GeneratedColumn<String?>('business_country', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessJobTitleMeta =
      const VerificationMeta('businessJobTitle');
  @override
  late final GeneratedColumn<String?> businessJobTitle =
      GeneratedColumn<String?>('business_job_title', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessDepartmentMeta =
      const VerificationMeta('businessDepartment');
  @override
  late final GeneratedColumn<String?> businessDepartment =
      GeneratedColumn<String?>('business_department', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessOfficeMeta =
      const VerificationMeta('businessOffice');
  @override
  late final GeneratedColumn<String?> businessOffice = GeneratedColumn<String?>(
      'business_office', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessPhoneMeta =
      const VerificationMeta('businessPhone');
  @override
  late final GeneratedColumn<String?> businessPhone = GeneratedColumn<String?>(
      'business_phone', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessFaxMeta =
      const VerificationMeta('businessFax');
  @override
  late final GeneratedColumn<String?> businessFax = GeneratedColumn<String?>(
      'business_fax', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _businessWebMeta =
      const VerificationMeta('businessWeb');
  @override
  late final GeneratedColumn<String?> businessWeb = GeneratedColumn<String?>(
      'business_web', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _otherEmailMeta = const VerificationMeta('otherEmail');
  @override
  late final GeneratedColumn<String?> otherEmail = GeneratedColumn<String?>(
      'other_email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String?> notes = GeneratedColumn<String?>(
      'notes', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _birthDayMeta = const VerificationMeta('birthDay');
  @override
  late final GeneratedColumn<int?> birthDay = GeneratedColumn<int?>(
      'birth_day', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _birthMonthMeta = const VerificationMeta('birthMonth');
  @override
  late final GeneratedColumn<int?> birthMonth = GeneratedColumn<int?>(
      'birth_month', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _birthYearMeta = const VerificationMeta('birthYear');
  @override
  late final GeneratedColumn<int?> birthYear = GeneratedColumn<int?>(
      'birth_year', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _autoMeta = const VerificationMeta('auto');
  @override
  late final GeneratedColumn<bool?> auto = GeneratedColumn<bool?>(
      'auto', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (auto IN (0, 1))');
  final VerificationMeta _frequencyMeta = const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<int?> frequency = GeneratedColumn<int?>(
      'frequency', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  final VerificationMeta _dateModifiedMeta =
      const VerificationMeta('dateModified');
  @override
  late final GeneratedColumn<String?> dateModified = GeneratedColumn<String?>(
      'date_modified', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _davContactsUidMeta =
      const VerificationMeta('davContactsUid');
  @override
  late final GeneratedColumn<String?> davContactsUid = GeneratedColumn<String?>(
      'dav_contacts_uid', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _davContactsVCardUidMeta =
      const VerificationMeta('davContactsVCardUid');
  @override
  late final GeneratedColumn<String?> davContactsVCardUid =
      GeneratedColumn<String?>('dav_contacts_v_card_uid', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _pgpPublicKeyMeta =
      const VerificationMeta('pgpPublicKey');
  @override
  late final GeneratedColumn<String?> pgpPublicKey = GeneratedColumn<String?>(
      'pgp_public_key', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _groupUUIDsMeta = const VerificationMeta('groupUUIDs');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String?>
      groupUUIDs = GeneratedColumn<String?>(
              'group_u_u_i_ds', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<List<String>>($ContactsTableTable.$converter0);
  final VerificationMeta _autoSignMeta = const VerificationMeta('autoSign');
  @override
  late final GeneratedColumn<bool?> autoSign = GeneratedColumn<bool?>(
      'auto_sign', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (auto_sign IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _autoEncryptMeta =
      const VerificationMeta('autoEncrypt');
  @override
  late final GeneratedColumn<bool?> autoEncrypt = GeneratedColumn<bool?>(
      'auto_encrypt', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (auto_encrypt IN (0, 1))',
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
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
        pgpPublicKey,
        groupUUIDs,
        autoSign,
        autoEncrypt
      ];
  @override
  String get aliasedName => _alias ?? 'contacts_table';
  @override
  String get actualTableName => 'contacts_table';
  @override
  VerificationContext validateIntegrity(Insertable<ContactDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid_plus_storage')) {
      context.handle(
          _uuidPlusStorageMeta,
          uuidPlusStorage.isAcceptableOrUnknown(
              data['uuid_plus_storage']!, _uuidPlusStorageMeta));
    } else if (isInserting) {
      context.missing(_uuidPlusStorageMeta);
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    }
    if (data.containsKey('parent_uuid')) {
      context.handle(
          _parentUuidMeta,
          parentUuid.isAcceptableOrUnknown(
              data['parent_uuid']!, _parentUuidMeta));
    }
    if (data.containsKey('e_tag')) {
      context.handle(
          _eTagMeta, eTag.isAcceptableOrUnknown(data['e_tag']!, _eTagMeta));
    } else if (isInserting) {
      context.missing(_eTagMeta);
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user']!, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('id_tenant')) {
      context.handle(_idTenantMeta,
          idTenant.isAcceptableOrUnknown(data['id_tenant']!, _idTenantMeta));
    }
    if (data.containsKey('storage')) {
      context.handle(_storageMeta,
          storage.isAcceptableOrUnknown(data['storage']!, _storageMeta));
    } else if (isInserting) {
      context.missing(_storageMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('use_friendly_name')) {
      context.handle(
          _useFriendlyNameMeta,
          useFriendlyName.isAcceptableOrUnknown(
              data['use_friendly_name']!, _useFriendlyNameMeta));
    }
    if (data.containsKey('primary_email')) {
      context.handle(
          _primaryEmailMeta,
          primaryEmail.isAcceptableOrUnknown(
              data['primary_email']!, _primaryEmailMeta));
    } else if (isInserting) {
      context.missing(_primaryEmailMeta);
    }
    if (data.containsKey('primary_phone')) {
      context.handle(
          _primaryPhoneMeta,
          primaryPhone.isAcceptableOrUnknown(
              data['primary_phone']!, _primaryPhoneMeta));
    } else if (isInserting) {
      context.missing(_primaryPhoneMeta);
    }
    if (data.containsKey('primary_address')) {
      context.handle(
          _primaryAddressMeta,
          primaryAddress.isAcceptableOrUnknown(
              data['primary_address']!, _primaryAddressMeta));
    } else if (isInserting) {
      context.missing(_primaryAddressMeta);
    }
    if (data.containsKey('view_email')) {
      context.handle(_viewEmailMeta,
          viewEmail.isAcceptableOrUnknown(data['view_email']!, _viewEmailMeta));
    } else if (isInserting) {
      context.missing(_viewEmailMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('nick_name')) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta));
    } else if (isInserting) {
      context.missing(_nickNameMeta);
    }
    if (data.containsKey('skype')) {
      context.handle(
          _skypeMeta, skype.isAcceptableOrUnknown(data['skype']!, _skypeMeta));
    } else if (isInserting) {
      context.missing(_skypeMeta);
    }
    if (data.containsKey('facebook')) {
      context.handle(_facebookMeta,
          facebook.isAcceptableOrUnknown(data['facebook']!, _facebookMeta));
    } else if (isInserting) {
      context.missing(_facebookMeta);
    }
    if (data.containsKey('personal_email')) {
      context.handle(
          _personalEmailMeta,
          personalEmail.isAcceptableOrUnknown(
              data['personal_email']!, _personalEmailMeta));
    } else if (isInserting) {
      context.missing(_personalEmailMeta);
    }
    if (data.containsKey('personal_address')) {
      context.handle(
          _personalAddressMeta,
          personalAddress.isAcceptableOrUnknown(
              data['personal_address']!, _personalAddressMeta));
    } else if (isInserting) {
      context.missing(_personalAddressMeta);
    }
    if (data.containsKey('personal_city')) {
      context.handle(
          _personalCityMeta,
          personalCity.isAcceptableOrUnknown(
              data['personal_city']!, _personalCityMeta));
    } else if (isInserting) {
      context.missing(_personalCityMeta);
    }
    if (data.containsKey('personal_state')) {
      context.handle(
          _personalStateMeta,
          personalState.isAcceptableOrUnknown(
              data['personal_state']!, _personalStateMeta));
    } else if (isInserting) {
      context.missing(_personalStateMeta);
    }
    if (data.containsKey('personal_zip')) {
      context.handle(
          _personalZipMeta,
          personalZip.isAcceptableOrUnknown(
              data['personal_zip']!, _personalZipMeta));
    } else if (isInserting) {
      context.missing(_personalZipMeta);
    }
    if (data.containsKey('personal_country')) {
      context.handle(
          _personalCountryMeta,
          personalCountry.isAcceptableOrUnknown(
              data['personal_country']!, _personalCountryMeta));
    } else if (isInserting) {
      context.missing(_personalCountryMeta);
    }
    if (data.containsKey('personal_web')) {
      context.handle(
          _personalWebMeta,
          personalWeb.isAcceptableOrUnknown(
              data['personal_web']!, _personalWebMeta));
    } else if (isInserting) {
      context.missing(_personalWebMeta);
    }
    if (data.containsKey('personal_fax')) {
      context.handle(
          _personalFaxMeta,
          personalFax.isAcceptableOrUnknown(
              data['personal_fax']!, _personalFaxMeta));
    } else if (isInserting) {
      context.missing(_personalFaxMeta);
    }
    if (data.containsKey('personal_phone')) {
      context.handle(
          _personalPhoneMeta,
          personalPhone.isAcceptableOrUnknown(
              data['personal_phone']!, _personalPhoneMeta));
    } else if (isInserting) {
      context.missing(_personalPhoneMeta);
    }
    if (data.containsKey('personal_mobile')) {
      context.handle(
          _personalMobileMeta,
          personalMobile.isAcceptableOrUnknown(
              data['personal_mobile']!, _personalMobileMeta));
    } else if (isInserting) {
      context.missing(_personalMobileMeta);
    }
    if (data.containsKey('business_email')) {
      context.handle(
          _businessEmailMeta,
          businessEmail.isAcceptableOrUnknown(
              data['business_email']!, _businessEmailMeta));
    } else if (isInserting) {
      context.missing(_businessEmailMeta);
    }
    if (data.containsKey('business_company')) {
      context.handle(
          _businessCompanyMeta,
          businessCompany.isAcceptableOrUnknown(
              data['business_company']!, _businessCompanyMeta));
    } else if (isInserting) {
      context.missing(_businessCompanyMeta);
    }
    if (data.containsKey('business_address')) {
      context.handle(
          _businessAddressMeta,
          businessAddress.isAcceptableOrUnknown(
              data['business_address']!, _businessAddressMeta));
    } else if (isInserting) {
      context.missing(_businessAddressMeta);
    }
    if (data.containsKey('business_city')) {
      context.handle(
          _businessCityMeta,
          businessCity.isAcceptableOrUnknown(
              data['business_city']!, _businessCityMeta));
    } else if (isInserting) {
      context.missing(_businessCityMeta);
    }
    if (data.containsKey('business_state')) {
      context.handle(
          _businessStateMeta,
          businessState.isAcceptableOrUnknown(
              data['business_state']!, _businessStateMeta));
    } else if (isInserting) {
      context.missing(_businessStateMeta);
    }
    if (data.containsKey('business_zip')) {
      context.handle(
          _businessZipMeta,
          businessZip.isAcceptableOrUnknown(
              data['business_zip']!, _businessZipMeta));
    } else if (isInserting) {
      context.missing(_businessZipMeta);
    }
    if (data.containsKey('business_country')) {
      context.handle(
          _businessCountryMeta,
          businessCountry.isAcceptableOrUnknown(
              data['business_country']!, _businessCountryMeta));
    } else if (isInserting) {
      context.missing(_businessCountryMeta);
    }
    if (data.containsKey('business_job_title')) {
      context.handle(
          _businessJobTitleMeta,
          businessJobTitle.isAcceptableOrUnknown(
              data['business_job_title']!, _businessJobTitleMeta));
    } else if (isInserting) {
      context.missing(_businessJobTitleMeta);
    }
    if (data.containsKey('business_department')) {
      context.handle(
          _businessDepartmentMeta,
          businessDepartment.isAcceptableOrUnknown(
              data['business_department']!, _businessDepartmentMeta));
    } else if (isInserting) {
      context.missing(_businessDepartmentMeta);
    }
    if (data.containsKey('business_office')) {
      context.handle(
          _businessOfficeMeta,
          businessOffice.isAcceptableOrUnknown(
              data['business_office']!, _businessOfficeMeta));
    } else if (isInserting) {
      context.missing(_businessOfficeMeta);
    }
    if (data.containsKey('business_phone')) {
      context.handle(
          _businessPhoneMeta,
          businessPhone.isAcceptableOrUnknown(
              data['business_phone']!, _businessPhoneMeta));
    } else if (isInserting) {
      context.missing(_businessPhoneMeta);
    }
    if (data.containsKey('business_fax')) {
      context.handle(
          _businessFaxMeta,
          businessFax.isAcceptableOrUnknown(
              data['business_fax']!, _businessFaxMeta));
    } else if (isInserting) {
      context.missing(_businessFaxMeta);
    }
    if (data.containsKey('business_web')) {
      context.handle(
          _businessWebMeta,
          businessWeb.isAcceptableOrUnknown(
              data['business_web']!, _businessWebMeta));
    } else if (isInserting) {
      context.missing(_businessWebMeta);
    }
    if (data.containsKey('other_email')) {
      context.handle(
          _otherEmailMeta,
          otherEmail.isAcceptableOrUnknown(
              data['other_email']!, _otherEmailMeta));
    } else if (isInserting) {
      context.missing(_otherEmailMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('birth_day')) {
      context.handle(_birthDayMeta,
          birthDay.isAcceptableOrUnknown(data['birth_day']!, _birthDayMeta));
    } else if (isInserting) {
      context.missing(_birthDayMeta);
    }
    if (data.containsKey('birth_month')) {
      context.handle(
          _birthMonthMeta,
          birthMonth.isAcceptableOrUnknown(
              data['birth_month']!, _birthMonthMeta));
    } else if (isInserting) {
      context.missing(_birthMonthMeta);
    }
    if (data.containsKey('birth_year')) {
      context.handle(_birthYearMeta,
          birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta));
    } else if (isInserting) {
      context.missing(_birthYearMeta);
    }
    if (data.containsKey('auto')) {
      context.handle(
          _autoMeta, auto.isAcceptableOrUnknown(data['auto']!, _autoMeta));
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    }
    if (data.containsKey('date_modified')) {
      context.handle(
          _dateModifiedMeta,
          dateModified.isAcceptableOrUnknown(
              data['date_modified']!, _dateModifiedMeta));
    }
    if (data.containsKey('dav_contacts_uid')) {
      context.handle(
          _davContactsUidMeta,
          davContactsUid.isAcceptableOrUnknown(
              data['dav_contacts_uid']!, _davContactsUidMeta));
    }
    if (data.containsKey('dav_contacts_v_card_uid')) {
      context.handle(
          _davContactsVCardUidMeta,
          davContactsVCardUid.isAcceptableOrUnknown(
              data['dav_contacts_v_card_uid']!, _davContactsVCardUidMeta));
    }
    if (data.containsKey('pgp_public_key')) {
      context.handle(
          _pgpPublicKeyMeta,
          pgpPublicKey.isAcceptableOrUnknown(
              data['pgp_public_key']!, _pgpPublicKeyMeta));
    }
    context.handle(_groupUUIDsMeta, const VerificationResult.success());
    if (data.containsKey('auto_sign')) {
      context.handle(_autoSignMeta,
          autoSign.isAcceptableOrUnknown(data['auto_sign']!, _autoSignMeta));
    }
    if (data.containsKey('auto_encrypt')) {
      context.handle(
          _autoEncryptMeta,
          autoEncrypt.isAcceptableOrUnknown(
              data['auto_encrypt']!, _autoEncryptMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityId};
  @override
  ContactDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ContactDb.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTableTable createAlias(String alias) {
    return $ContactsTableTable(attachedDatabase, alias);
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
      {required this.uuid,
      required this.userLocalId,
      required this.idUser,
      required this.city,
      required this.company,
      required this.country,
      required this.email,
      required this.fax,
      required this.isOrganization,
      required this.name,
      required this.parentUUID,
      required this.phone,
      required this.state,
      required this.street,
      required this.web,
      required this.zip});
  factory ContactsGroupsTable.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContactsGroupsTable(
      uuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uuid'])!,
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id'])!,
      idUser: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_user'])!,
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city'])!,
      company: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}company'])!,
      country: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}country'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      fax: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fax'])!,
      isOrganization: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_organization'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      parentUUID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_u_u_i_d'])!,
      phone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone'])!,
      state: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}state'])!,
      street: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street'])!,
      web: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}web'])!,
      zip: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zip'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['user_local_id'] = Variable<int>(userLocalId);
    map['id_user'] = Variable<int>(idUser);
    map['city'] = Variable<String>(city);
    map['company'] = Variable<String>(company);
    map['country'] = Variable<String>(country);
    map['email'] = Variable<String>(email);
    map['fax'] = Variable<String>(fax);
    map['is_organization'] = Variable<bool>(isOrganization);
    map['name'] = Variable<String>(name);
    map['parent_u_u_i_d'] = Variable<String>(parentUUID);
    map['phone'] = Variable<String>(phone);
    map['state'] = Variable<String>(state);
    map['street'] = Variable<String>(street);
    map['web'] = Variable<String>(web);
    map['zip'] = Variable<String>(zip);
    return map;
  }

  ContactsGroupsCompanion toCompanion(bool nullToAbsent) {
    return ContactsGroupsCompanion(
      uuid: Value(uuid),
      userLocalId: Value(userLocalId),
      idUser: Value(idUser),
      city: Value(city),
      company: Value(company),
      country: Value(country),
      email: Value(email),
      fax: Value(fax),
      isOrganization: Value(isOrganization),
      name: Value(name),
      parentUUID: Value(parentUUID),
      phone: Value(phone),
      state: Value(state),
      street: Value(street),
      web: Value(web),
      zip: Value(zip),
    );
  }

  factory ContactsGroupsTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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

  ContactsGroupsTable copyWith(
          {String? uuid,
          int? userLocalId,
          int? idUser,
          String? city,
          String? company,
          String? country,
          String? email,
          String? fax,
          bool? isOrganization,
          String? name,
          String? parentUUID,
          String? phone,
          String? state,
          String? street,
          String? web,
          String? zip}) =>
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
  int get hashCode => Object.hash(
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
      zip);
  @override
  bool operator ==(Object other) =>
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
    required String uuid,
    required int userLocalId,
    required int idUser,
    required String city,
    required String company,
    required String country,
    required String email,
    required String fax,
    required bool isOrganization,
    required String name,
    required String parentUUID,
    required String phone,
    required String state,
    required String street,
    required String web,
    required String zip,
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
  static Insertable<ContactsGroupsTable> custom({
    Expression<String>? uuid,
    Expression<int>? userLocalId,
    Expression<int>? idUser,
    Expression<String>? city,
    Expression<String>? company,
    Expression<String>? country,
    Expression<String>? email,
    Expression<String>? fax,
    Expression<bool>? isOrganization,
    Expression<String>? name,
    Expression<String>? parentUUID,
    Expression<String>? phone,
    Expression<String>? state,
    Expression<String>? street,
    Expression<String>? web,
    Expression<String>? zip,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (idUser != null) 'id_user': idUser,
      if (city != null) 'city': city,
      if (company != null) 'company': company,
      if (country != null) 'country': country,
      if (email != null) 'email': email,
      if (fax != null) 'fax': fax,
      if (isOrganization != null) 'is_organization': isOrganization,
      if (name != null) 'name': name,
      if (parentUUID != null) 'parent_u_u_i_d': parentUUID,
      if (phone != null) 'phone': phone,
      if (state != null) 'state': state,
      if (street != null) 'street': street,
      if (web != null) 'web': web,
      if (zip != null) 'zip': zip,
    });
  }

  ContactsGroupsCompanion copyWith(
      {Value<String>? uuid,
      Value<int>? userLocalId,
      Value<int>? idUser,
      Value<String>? city,
      Value<String>? company,
      Value<String>? country,
      Value<String>? email,
      Value<String>? fax,
      Value<bool>? isOrganization,
      Value<String>? name,
      Value<String>? parentUUID,
      Value<String>? phone,
      Value<String>? state,
      Value<String>? street,
      Value<String>? web,
      Value<String>? zip}) {
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int>(userLocalId.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<int>(idUser.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (fax.present) {
      map['fax'] = Variable<String>(fax.value);
    }
    if (isOrganization.present) {
      map['is_organization'] = Variable<bool>(isOrganization.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentUUID.present) {
      map['parent_u_u_i_d'] = Variable<String>(parentUUID.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (web.present) {
      map['web'] = Variable<String>(web.value);
    }
    if (zip.present) {
      map['zip'] = Variable<String>(zip.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsGroupsCompanion(')
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
}

class $ContactsGroupsTable extends ContactsGroups
    with TableInfo<$ContactsGroupsTable, ContactsGroupsTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String?> uuid = GeneratedColumn<String?>(
      'uuid', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  @override
  late final GeneratedColumn<int?> idUser = GeneratedColumn<int?>(
      'id_user', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _companyMeta = const VerificationMeta('company');
  @override
  late final GeneratedColumn<String?> company = GeneratedColumn<String?>(
      'company', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  @override
  late final GeneratedColumn<String?> country = GeneratedColumn<String?>(
      'country', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _faxMeta = const VerificationMeta('fax');
  @override
  late final GeneratedColumn<String?> fax = GeneratedColumn<String?>(
      'fax', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isOrganizationMeta =
      const VerificationMeta('isOrganization');
  @override
  late final GeneratedColumn<bool?> isOrganization = GeneratedColumn<bool?>(
      'is_organization', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_organization IN (0, 1))');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _parentUUIDMeta = const VerificationMeta('parentUUID');
  @override
  late final GeneratedColumn<String?> parentUUID = GeneratedColumn<String?>(
      'parent_u_u_i_d', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String?> phone = GeneratedColumn<String?>(
      'phone', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String?> state = GeneratedColumn<String?>(
      'state', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String?> street = GeneratedColumn<String?>(
      'street', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _webMeta = const VerificationMeta('web');
  @override
  late final GeneratedColumn<String?> web = GeneratedColumn<String?>(
      'web', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zipMeta = const VerificationMeta('zip');
  @override
  late final GeneratedColumn<String?> zip = GeneratedColumn<String?>(
      'zip', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  String get aliasedName => _alias ?? 'contacts_groups';
  @override
  String get actualTableName => 'contacts_groups';
  @override
  VerificationContext validateIntegrity(
      Insertable<ContactsGroupsTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user']!, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('company')) {
      context.handle(_companyMeta,
          company.isAcceptableOrUnknown(data['company']!, _companyMeta));
    } else if (isInserting) {
      context.missing(_companyMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('fax')) {
      context.handle(
          _faxMeta, fax.isAcceptableOrUnknown(data['fax']!, _faxMeta));
    } else if (isInserting) {
      context.missing(_faxMeta);
    }
    if (data.containsKey('is_organization')) {
      context.handle(
          _isOrganizationMeta,
          isOrganization.isAcceptableOrUnknown(
              data['is_organization']!, _isOrganizationMeta));
    } else if (isInserting) {
      context.missing(_isOrganizationMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_u_u_i_d')) {
      context.handle(
          _parentUUIDMeta,
          parentUUID.isAcceptableOrUnknown(
              data['parent_u_u_i_d']!, _parentUUIDMeta));
    } else if (isInserting) {
      context.missing(_parentUUIDMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (data.containsKey('web')) {
      context.handle(
          _webMeta, web.isAcceptableOrUnknown(data['web']!, _webMeta));
    } else if (isInserting) {
      context.missing(_webMeta);
    }
    if (data.containsKey('zip')) {
      context.handle(
          _zipMeta, zip.isAcceptableOrUnknown(data['zip']!, _zipMeta));
    } else if (isInserting) {
      context.missing(_zipMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ContactsGroupsTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ContactsGroupsTable.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsGroupsTable createAlias(String alias) {
    return $ContactsGroupsTable(attachedDatabase, alias);
  }
}

class ContactsStoragesTable extends DataClass
    implements Insertable<ContactsStoragesTable> {
  final int? sqliteId;
  final int userLocalId;
  final int idUser;
  final String serverId;
  final String uniqueName;
  final String name;
  final int cTag;
  final bool display;
  final String displayName;
  final String? ownerMail;
  final bool? isShared;
  final int? accessCode;
  final List<ContactInfoItem>? contactsInfo;
  ContactsStoragesTable(
      {this.sqliteId,
      required this.userLocalId,
      required this.idUser,
      required this.serverId,
      required this.uniqueName,
      required this.name,
      required this.cTag,
      required this.display,
      required this.displayName,
      this.ownerMail,
      this.isShared,
      this.accessCode,
      this.contactsInfo});
  factory ContactsStoragesTable.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContactsStoragesTable(
      sqliteId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sqlite_id']),
      userLocalId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_local_id'])!,
      idUser: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_user'])!,
      serverId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}server_id'])!,
      uniqueName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unique_name'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      cTag: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}c_tag'])!,
      display: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}display'])!,
      displayName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name'])!,
      ownerMail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_mail']),
      isShared: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_shared']),
      accessCode: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}access_code']),
      contactsInfo: $ContactsStoragesTable.$converter0.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}contacts_info'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || sqliteId != null) {
      map['sqlite_id'] = Variable<int?>(sqliteId);
    }
    map['user_local_id'] = Variable<int>(userLocalId);
    map['id_user'] = Variable<int>(idUser);
    map['server_id'] = Variable<String>(serverId);
    map['unique_name'] = Variable<String>(uniqueName);
    map['name'] = Variable<String>(name);
    map['c_tag'] = Variable<int>(cTag);
    map['display'] = Variable<bool>(display);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || ownerMail != null) {
      map['owner_mail'] = Variable<String?>(ownerMail);
    }
    if (!nullToAbsent || isShared != null) {
      map['is_shared'] = Variable<bool?>(isShared);
    }
    if (!nullToAbsent || accessCode != null) {
      map['access_code'] = Variable<int?>(accessCode);
    }
    if (!nullToAbsent || contactsInfo != null) {
      final converter = $ContactsStoragesTable.$converter0;
      map['contacts_info'] =
          Variable<String?>(converter.mapToSql(contactsInfo));
    }
    return map;
  }

  ContactsStoragesCompanion toCompanion(bool nullToAbsent) {
    return ContactsStoragesCompanion(
      sqliteId: sqliteId == null && nullToAbsent
          ? const Value.absent()
          : Value(sqliteId),
      userLocalId: Value(userLocalId),
      idUser: Value(idUser),
      serverId: Value(serverId),
      uniqueName: Value(uniqueName),
      name: Value(name),
      cTag: Value(cTag),
      display: Value(display),
      displayName: Value(displayName),
      ownerMail: ownerMail == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerMail),
      isShared: isShared == null && nullToAbsent
          ? const Value.absent()
          : Value(isShared),
      accessCode: accessCode == null && nullToAbsent
          ? const Value.absent()
          : Value(accessCode),
      contactsInfo: contactsInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(contactsInfo),
    );
  }

  factory ContactsStoragesTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactsStoragesTable(
      sqliteId: serializer.fromJson<int?>(json['sqliteId']),
      userLocalId: serializer.fromJson<int>(json['userLocalId']),
      idUser: serializer.fromJson<int>(json['idUser']),
      serverId: serializer.fromJson<String>(json['serverId']),
      uniqueName: serializer.fromJson<String>(json['uniqueName']),
      name: serializer.fromJson<String>(json['name']),
      cTag: serializer.fromJson<int>(json['cTag']),
      display: serializer.fromJson<bool>(json['display']),
      displayName: serializer.fromJson<String>(json['displayName']),
      ownerMail: serializer.fromJson<String?>(json['ownerMail']),
      isShared: serializer.fromJson<bool?>(json['isShared']),
      accessCode: serializer.fromJson<int?>(json['accessCode']),
      contactsInfo:
          serializer.fromJson<List<ContactInfoItem>?>(json['contactsInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sqliteId': serializer.toJson<int?>(sqliteId),
      'userLocalId': serializer.toJson<int>(userLocalId),
      'idUser': serializer.toJson<int>(idUser),
      'serverId': serializer.toJson<String>(serverId),
      'uniqueName': serializer.toJson<String>(uniqueName),
      'name': serializer.toJson<String>(name),
      'cTag': serializer.toJson<int>(cTag),
      'display': serializer.toJson<bool>(display),
      'displayName': serializer.toJson<String>(displayName),
      'ownerMail': serializer.toJson<String?>(ownerMail),
      'isShared': serializer.toJson<bool?>(isShared),
      'accessCode': serializer.toJson<int?>(accessCode),
      'contactsInfo': serializer.toJson<List<ContactInfoItem>?>(contactsInfo),
    };
  }

  ContactsStoragesTable copyWith(
          {int? sqliteId,
          int? userLocalId,
          int? idUser,
          String? serverId,
          String? uniqueName,
          String? name,
          int? cTag,
          bool? display,
          String? displayName,
          String? ownerMail,
          bool? isShared,
          int? accessCode,
          List<ContactInfoItem>? contactsInfo}) =>
      ContactsStoragesTable(
        sqliteId: sqliteId ?? this.sqliteId,
        userLocalId: userLocalId ?? this.userLocalId,
        idUser: idUser ?? this.idUser,
        serverId: serverId ?? this.serverId,
        uniqueName: uniqueName ?? this.uniqueName,
        name: name ?? this.name,
        cTag: cTag ?? this.cTag,
        display: display ?? this.display,
        displayName: displayName ?? this.displayName,
        ownerMail: ownerMail ?? this.ownerMail,
        isShared: isShared ?? this.isShared,
        accessCode: accessCode ?? this.accessCode,
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
          ..write('displayName: $displayName, ')
          ..write('ownerMail: $ownerMail, ')
          ..write('isShared: $isShared, ')
          ..write('accessCode: $accessCode, ')
          ..write('contactsInfo: $contactsInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      sqliteId,
      userLocalId,
      idUser,
      serverId,
      uniqueName,
      name,
      cTag,
      display,
      displayName,
      ownerMail,
      isShared,
      accessCode,
      contactsInfo);
  @override
  bool operator ==(Object other) =>
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
          other.displayName == this.displayName &&
          other.ownerMail == this.ownerMail &&
          other.isShared == this.isShared &&
          other.accessCode == this.accessCode &&
          other.contactsInfo == this.contactsInfo);
}

class ContactsStoragesCompanion extends UpdateCompanion<ContactsStoragesTable> {
  final Value<int?> sqliteId;
  final Value<int> userLocalId;
  final Value<int> idUser;
  final Value<String> serverId;
  final Value<String> uniqueName;
  final Value<String> name;
  final Value<int> cTag;
  final Value<bool> display;
  final Value<String> displayName;
  final Value<String?> ownerMail;
  final Value<bool?> isShared;
  final Value<int?> accessCode;
  final Value<List<ContactInfoItem>?> contactsInfo;
  const ContactsStoragesCompanion({
    this.sqliteId = const Value.absent(),
    this.userLocalId = const Value.absent(),
    this.idUser = const Value.absent(),
    this.serverId = const Value.absent(),
    this.uniqueName = const Value.absent(),
    this.name = const Value.absent(),
    this.cTag = const Value.absent(),
    this.display = const Value.absent(),
    this.displayName = const Value.absent(),
    this.ownerMail = const Value.absent(),
    this.isShared = const Value.absent(),
    this.accessCode = const Value.absent(),
    this.contactsInfo = const Value.absent(),
  });
  ContactsStoragesCompanion.insert({
    this.sqliteId = const Value.absent(),
    required int userLocalId,
    required int idUser,
    required String serverId,
    required String uniqueName,
    required String name,
    required int cTag,
    required bool display,
    this.displayName = const Value.absent(),
    this.ownerMail = const Value.absent(),
    this.isShared = const Value.absent(),
    this.accessCode = const Value.absent(),
    this.contactsInfo = const Value.absent(),
  })  : userLocalId = Value(userLocalId),
        idUser = Value(idUser),
        serverId = Value(serverId),
        uniqueName = Value(uniqueName),
        name = Value(name),
        cTag = Value(cTag),
        display = Value(display);
  static Insertable<ContactsStoragesTable> custom({
    Expression<int?>? sqliteId,
    Expression<int>? userLocalId,
    Expression<int>? idUser,
    Expression<String>? serverId,
    Expression<String>? uniqueName,
    Expression<String>? name,
    Expression<int>? cTag,
    Expression<bool>? display,
    Expression<String>? displayName,
    Expression<String?>? ownerMail,
    Expression<bool?>? isShared,
    Expression<int?>? accessCode,
    Expression<List<ContactInfoItem>?>? contactsInfo,
  }) {
    return RawValuesInsertable({
      if (sqliteId != null) 'sqlite_id': sqliteId,
      if (userLocalId != null) 'user_local_id': userLocalId,
      if (idUser != null) 'id_user': idUser,
      if (serverId != null) 'server_id': serverId,
      if (uniqueName != null) 'unique_name': uniqueName,
      if (name != null) 'name': name,
      if (cTag != null) 'c_tag': cTag,
      if (display != null) 'display': display,
      if (displayName != null) 'display_name': displayName,
      if (ownerMail != null) 'owner_mail': ownerMail,
      if (isShared != null) 'is_shared': isShared,
      if (accessCode != null) 'access_code': accessCode,
      if (contactsInfo != null) 'contacts_info': contactsInfo,
    });
  }

  ContactsStoragesCompanion copyWith(
      {Value<int?>? sqliteId,
      Value<int>? userLocalId,
      Value<int>? idUser,
      Value<String>? serverId,
      Value<String>? uniqueName,
      Value<String>? name,
      Value<int>? cTag,
      Value<bool>? display,
      Value<String>? displayName,
      Value<String?>? ownerMail,
      Value<bool?>? isShared,
      Value<int?>? accessCode,
      Value<List<ContactInfoItem>?>? contactsInfo}) {
    return ContactsStoragesCompanion(
      sqliteId: sqliteId ?? this.sqliteId,
      userLocalId: userLocalId ?? this.userLocalId,
      idUser: idUser ?? this.idUser,
      serverId: serverId ?? this.serverId,
      uniqueName: uniqueName ?? this.uniqueName,
      name: name ?? this.name,
      cTag: cTag ?? this.cTag,
      display: display ?? this.display,
      displayName: displayName ?? this.displayName,
      ownerMail: ownerMail ?? this.ownerMail,
      isShared: isShared ?? this.isShared,
      accessCode: accessCode ?? this.accessCode,
      contactsInfo: contactsInfo ?? this.contactsInfo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sqliteId.present) {
      map['sqlite_id'] = Variable<int?>(sqliteId.value);
    }
    if (userLocalId.present) {
      map['user_local_id'] = Variable<int>(userLocalId.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<int>(idUser.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (uniqueName.present) {
      map['unique_name'] = Variable<String>(uniqueName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cTag.present) {
      map['c_tag'] = Variable<int>(cTag.value);
    }
    if (display.present) {
      map['display'] = Variable<bool>(display.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (ownerMail.present) {
      map['owner_mail'] = Variable<String?>(ownerMail.value);
    }
    if (isShared.present) {
      map['is_shared'] = Variable<bool?>(isShared.value);
    }
    if (accessCode.present) {
      map['access_code'] = Variable<int?>(accessCode.value);
    }
    if (contactsInfo.present) {
      final converter = $ContactsStoragesTable.$converter0;
      map['contacts_info'] =
          Variable<String?>(converter.mapToSql(contactsInfo.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsStoragesCompanion(')
          ..write('sqliteId: $sqliteId, ')
          ..write('userLocalId: $userLocalId, ')
          ..write('idUser: $idUser, ')
          ..write('serverId: $serverId, ')
          ..write('uniqueName: $uniqueName, ')
          ..write('name: $name, ')
          ..write('cTag: $cTag, ')
          ..write('display: $display, ')
          ..write('displayName: $displayName, ')
          ..write('ownerMail: $ownerMail, ')
          ..write('isShared: $isShared, ')
          ..write('accessCode: $accessCode, ')
          ..write('contactsInfo: $contactsInfo')
          ..write(')'))
        .toString();
  }
}

class $ContactsStoragesTable extends ContactsStorages
    with TableInfo<$ContactsStoragesTable, ContactsStoragesTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsStoragesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _sqliteIdMeta = const VerificationMeta('sqliteId');
  @override
  late final GeneratedColumn<int?> sqliteId = GeneratedColumn<int?>(
      'sqlite_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userLocalIdMeta =
      const VerificationMeta('userLocalId');
  @override
  late final GeneratedColumn<int?> userLocalId = GeneratedColumn<int?>(
      'user_local_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  @override
  late final GeneratedColumn<int?> idUser = GeneratedColumn<int?>(
      'id_user', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<String?> serverId = GeneratedColumn<String?>(
      'server_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _uniqueNameMeta = const VerificationMeta('uniqueName');
  @override
  late final GeneratedColumn<String?> uniqueName = GeneratedColumn<String?>(
      'unique_name', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _cTagMeta = const VerificationMeta('cTag');
  @override
  late final GeneratedColumn<int?> cTag = GeneratedColumn<int?>(
      'c_tag', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _displayMeta = const VerificationMeta('display');
  @override
  late final GeneratedColumn<bool?> display = GeneratedColumn<bool?>(
      'display', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (display IN (0, 1))');
  final VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String?> displayName = GeneratedColumn<String?>(
      'display_name', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _ownerMailMeta = const VerificationMeta('ownerMail');
  @override
  late final GeneratedColumn<String?> ownerMail = GeneratedColumn<String?>(
      'owner_mail', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _isSharedMeta = const VerificationMeta('isShared');
  @override
  late final GeneratedColumn<bool?> isShared = GeneratedColumn<bool?>(
      'is_shared', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_shared IN (0, 1))');
  final VerificationMeta _accessCodeMeta = const VerificationMeta('accessCode');
  @override
  late final GeneratedColumn<int?> accessCode = GeneratedColumn<int?>(
      'access_code', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _contactsInfoMeta =
      const VerificationMeta('contactsInfo');
  @override
  late final GeneratedColumnWithTypeConverter<List<ContactInfoItem>, String?>
      contactsInfo = GeneratedColumn<String?>(
              'contacts_info', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<List<ContactInfoItem>>(
              $ContactsStoragesTable.$converter0);
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
        displayName,
        ownerMail,
        isShared,
        accessCode,
        contactsInfo
      ];
  @override
  String get aliasedName => _alias ?? 'contacts_storages';
  @override
  String get actualTableName => 'contacts_storages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ContactsStoragesTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sqlite_id')) {
      context.handle(_sqliteIdMeta,
          sqliteId.isAcceptableOrUnknown(data['sqlite_id']!, _sqliteIdMeta));
    }
    if (data.containsKey('user_local_id')) {
      context.handle(
          _userLocalIdMeta,
          userLocalId.isAcceptableOrUnknown(
              data['user_local_id']!, _userLocalIdMeta));
    } else if (isInserting) {
      context.missing(_userLocalIdMeta);
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user']!, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('unique_name')) {
      context.handle(
          _uniqueNameMeta,
          uniqueName.isAcceptableOrUnknown(
              data['unique_name']!, _uniqueNameMeta));
    } else if (isInserting) {
      context.missing(_uniqueNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('c_tag')) {
      context.handle(
          _cTagMeta, cTag.isAcceptableOrUnknown(data['c_tag']!, _cTagMeta));
    } else if (isInserting) {
      context.missing(_cTagMeta);
    }
    if (data.containsKey('display')) {
      context.handle(_displayMeta,
          display.isAcceptableOrUnknown(data['display']!, _displayMeta));
    } else if (isInserting) {
      context.missing(_displayMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('owner_mail')) {
      context.handle(_ownerMailMeta,
          ownerMail.isAcceptableOrUnknown(data['owner_mail']!, _ownerMailMeta));
    }
    if (data.containsKey('is_shared')) {
      context.handle(_isSharedMeta,
          isShared.isAcceptableOrUnknown(data['is_shared']!, _isSharedMeta));
    }
    if (data.containsKey('access_code')) {
      context.handle(
          _accessCodeMeta,
          accessCode.isAcceptableOrUnknown(
              data['access_code']!, _accessCodeMeta));
    }
    context.handle(_contactsInfoMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sqliteId};
  @override
  ContactsStoragesTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ContactsStoragesTable.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsStoragesTable createAlias(String alias) {
    return $ContactsStoragesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<ContactInfoItem>, String> $converter0 =
      const ContactsInfoConverter();
}

class LocalPgpKey extends DataClass implements Insertable<LocalPgpKey> {
  final String id;
  final String? name;
  final String mail;
  final bool isPrivate;
  final int? length;
  final String other;
  LocalPgpKey(
      {required this.id,
      this.name,
      required this.mail,
      required this.isPrivate,
      this.length,
      required this.other});
  factory LocalPgpKey.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalPgpKey(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      mail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mail'])!,
      isPrivate: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_private'])!,
      length: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}length']),
      other: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}other'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    map['mail'] = Variable<String>(mail);
    map['is_private'] = Variable<bool>(isPrivate);
    if (!nullToAbsent || length != null) {
      map['length'] = Variable<int?>(length);
    }
    map['other'] = Variable<String>(other);
    return map;
  }

  PgpKeyModelCompanion toCompanion(bool nullToAbsent) {
    return PgpKeyModelCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      mail: Value(mail),
      isPrivate: Value(isPrivate),
      length:
          length == null && nullToAbsent ? const Value.absent() : Value(length),
      other: Value(other),
    );
  }

  factory LocalPgpKey.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPgpKey(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      mail: serializer.fromJson<String>(json['mail']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      length: serializer.fromJson<int?>(json['length']),
      other: serializer.fromJson<String>(json['other']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'mail': serializer.toJson<String>(mail),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'length': serializer.toJson<int?>(length),
      'other': serializer.toJson<String>(other),
    };
  }

  LocalPgpKey copyWith(
          {String? id,
          String? name,
          String? mail,
          bool? isPrivate,
          int? length,
          String? other}) =>
      LocalPgpKey(
        id: id ?? this.id,
        name: name ?? this.name,
        mail: mail ?? this.mail,
        isPrivate: isPrivate ?? this.isPrivate,
        length: length ?? this.length,
        other: other ?? this.other,
      );
  @override
  String toString() {
    return (StringBuffer('LocalPgpKey(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mail: $mail, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('length: $length, ')
          ..write('other: $other')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, mail, isPrivate, length, other);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPgpKey &&
          other.id == this.id &&
          other.name == this.name &&
          other.mail == this.mail &&
          other.isPrivate == this.isPrivate &&
          other.length == this.length &&
          other.other == this.other);
}

class PgpKeyModelCompanion extends UpdateCompanion<LocalPgpKey> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String> mail;
  final Value<bool> isPrivate;
  final Value<int?> length;
  final Value<String> other;
  const PgpKeyModelCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mail = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.length = const Value.absent(),
    this.other = const Value.absent(),
  });
  PgpKeyModelCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    required String mail,
    required bool isPrivate,
    this.length = const Value.absent(),
    required String other,
  })  : id = Value(id),
        mail = Value(mail),
        isPrivate = Value(isPrivate),
        other = Value(other);
  static Insertable<LocalPgpKey> custom({
    Expression<String>? id,
    Expression<String?>? name,
    Expression<String>? mail,
    Expression<bool>? isPrivate,
    Expression<int?>? length,
    Expression<String>? other,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mail != null) 'mail': mail,
      if (isPrivate != null) 'is_private': isPrivate,
      if (length != null) 'length': length,
      if (other != null) 'other': other,
    });
  }

  PgpKeyModelCompanion copyWith(
      {Value<String>? id,
      Value<String?>? name,
      Value<String>? mail,
      Value<bool>? isPrivate,
      Value<int?>? length,
      Value<String>? other}) {
    return PgpKeyModelCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mail: mail ?? this.mail,
      isPrivate: isPrivate ?? this.isPrivate,
      length: length ?? this.length,
      other: other ?? this.other,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (mail.present) {
      map['mail'] = Variable<String>(mail.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (length.present) {
      map['length'] = Variable<int?>(length.value);
    }
    if (other.present) {
      map['other'] = Variable<String>(other.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PgpKeyModelCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mail: $mail, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('length: $length, ')
          ..write('other: $other')
          ..write(')'))
        .toString();
  }
}

class $PgpKeyModelTable extends PgpKeyModel
    with TableInfo<$PgpKeyModelTable, LocalPgpKey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PgpKeyModelTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _mailMeta = const VerificationMeta('mail');
  @override
  late final GeneratedColumn<String?> mail = GeneratedColumn<String?>(
      'mail', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isPrivateMeta = const VerificationMeta('isPrivate');
  @override
  late final GeneratedColumn<bool?> isPrivate = GeneratedColumn<bool?>(
      'is_private', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_private IN (0, 1))');
  final VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<int?> length = GeneratedColumn<int?>(
      'length', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _otherMeta = const VerificationMeta('other');
  @override
  late final GeneratedColumn<String?> other = GeneratedColumn<String?>(
      'other', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, mail, isPrivate, length, other];
  @override
  String get aliasedName => _alias ?? 'pgp_key_model';
  @override
  String get actualTableName => 'pgp_key_model';
  @override
  VerificationContext validateIntegrity(Insertable<LocalPgpKey> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('mail')) {
      context.handle(
          _mailMeta, mail.isAcceptableOrUnknown(data['mail']!, _mailMeta));
    } else if (isInserting) {
      context.missing(_mailMeta);
    }
    if (data.containsKey('is_private')) {
      context.handle(_isPrivateMeta,
          isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta));
    } else if (isInserting) {
      context.missing(_isPrivateMeta);
    }
    if (data.containsKey('length')) {
      context.handle(_lengthMeta,
          length.isAcceptableOrUnknown(data['length']!, _lengthMeta));
    }
    if (data.containsKey('other')) {
      context.handle(
          _otherMeta, other.isAcceptableOrUnknown(data['other']!, _otherMeta));
    } else if (isInserting) {
      context.missing(_otherMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {other, id};
  @override
  LocalPgpKey map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalPgpKey.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PgpKeyModelTable createAlias(String alias) {
    return $PgpKeyModelTable(attachedDatabase, alias);
  }
}

class AccountIdentity extends DataClass implements Insertable<AccountIdentity> {
  final int entityId;
  final String email;
  final String friendlyName;
  final String signature;
  final int idUser;
  final int idAccount;
  final bool isDefault;
  final bool useSignature;
  AccountIdentity(
      {required this.entityId,
      required this.email,
      required this.friendlyName,
      required this.signature,
      required this.idUser,
      required this.idAccount,
      required this.isDefault,
      required this.useSignature});
  factory AccountIdentity.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AccountIdentity(
      entityId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}entity_id'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      friendlyName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}friendly_name'])!,
      signature: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}signature'])!,
      idUser: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_user'])!,
      idAccount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_account'])!,
      isDefault: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_default'])!,
      useSignature: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}use_signature'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity_id'] = Variable<int>(entityId);
    map['email'] = Variable<String>(email);
    map['friendly_name'] = Variable<String>(friendlyName);
    map['signature'] = Variable<String>(signature);
    map['id_user'] = Variable<int>(idUser);
    map['id_account'] = Variable<int>(idAccount);
    map['is_default'] = Variable<bool>(isDefault);
    map['use_signature'] = Variable<bool>(useSignature);
    return map;
  }

  AccountIdentityTableCompanion toCompanion(bool nullToAbsent) {
    return AccountIdentityTableCompanion(
      entityId: Value(entityId),
      email: Value(email),
      friendlyName: Value(friendlyName),
      signature: Value(signature),
      idUser: Value(idUser),
      idAccount: Value(idAccount),
      isDefault: Value(isDefault),
      useSignature: Value(useSignature),
    );
  }

  factory AccountIdentity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountIdentity(
      entityId: serializer.fromJson<int>(json['entityId']),
      email: serializer.fromJson<String>(json['email']),
      friendlyName: serializer.fromJson<String>(json['friendlyName']),
      signature: serializer.fromJson<String>(json['signature']),
      idUser: serializer.fromJson<int>(json['idUser']),
      idAccount: serializer.fromJson<int>(json['idAccount']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      useSignature: serializer.fromJson<bool>(json['useSignature']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entityId': serializer.toJson<int>(entityId),
      'email': serializer.toJson<String>(email),
      'friendlyName': serializer.toJson<String>(friendlyName),
      'signature': serializer.toJson<String>(signature),
      'idUser': serializer.toJson<int>(idUser),
      'idAccount': serializer.toJson<int>(idAccount),
      'isDefault': serializer.toJson<bool>(isDefault),
      'useSignature': serializer.toJson<bool>(useSignature),
    };
  }

  AccountIdentity copyWith(
          {int? entityId,
          String? email,
          String? friendlyName,
          String? signature,
          int? idUser,
          int? idAccount,
          bool? isDefault,
          bool? useSignature}) =>
      AccountIdentity(
        entityId: entityId ?? this.entityId,
        email: email ?? this.email,
        friendlyName: friendlyName ?? this.friendlyName,
        signature: signature ?? this.signature,
        idUser: idUser ?? this.idUser,
        idAccount: idAccount ?? this.idAccount,
        isDefault: isDefault ?? this.isDefault,
        useSignature: useSignature ?? this.useSignature,
      );
  @override
  String toString() {
    return (StringBuffer('AccountIdentity(')
          ..write('entityId: $entityId, ')
          ..write('email: $email, ')
          ..write('friendlyName: $friendlyName, ')
          ..write('signature: $signature, ')
          ..write('idUser: $idUser, ')
          ..write('idAccount: $idAccount, ')
          ..write('isDefault: $isDefault, ')
          ..write('useSignature: $useSignature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entityId, email, friendlyName, signature,
      idUser, idAccount, isDefault, useSignature);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountIdentity &&
          other.entityId == this.entityId &&
          other.email == this.email &&
          other.friendlyName == this.friendlyName &&
          other.signature == this.signature &&
          other.idUser == this.idUser &&
          other.idAccount == this.idAccount &&
          other.isDefault == this.isDefault &&
          other.useSignature == this.useSignature);
}

class AccountIdentityTableCompanion extends UpdateCompanion<AccountIdentity> {
  final Value<int> entityId;
  final Value<String> email;
  final Value<String> friendlyName;
  final Value<String> signature;
  final Value<int> idUser;
  final Value<int> idAccount;
  final Value<bool> isDefault;
  final Value<bool> useSignature;
  const AccountIdentityTableCompanion({
    this.entityId = const Value.absent(),
    this.email = const Value.absent(),
    this.friendlyName = const Value.absent(),
    this.signature = const Value.absent(),
    this.idUser = const Value.absent(),
    this.idAccount = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.useSignature = const Value.absent(),
  });
  AccountIdentityTableCompanion.insert({
    required int entityId,
    required String email,
    required String friendlyName,
    required String signature,
    required int idUser,
    required int idAccount,
    required bool isDefault,
    required bool useSignature,
  })  : entityId = Value(entityId),
        email = Value(email),
        friendlyName = Value(friendlyName),
        signature = Value(signature),
        idUser = Value(idUser),
        idAccount = Value(idAccount),
        isDefault = Value(isDefault),
        useSignature = Value(useSignature);
  static Insertable<AccountIdentity> custom({
    Expression<int>? entityId,
    Expression<String>? email,
    Expression<String>? friendlyName,
    Expression<String>? signature,
    Expression<int>? idUser,
    Expression<int>? idAccount,
    Expression<bool>? isDefault,
    Expression<bool>? useSignature,
  }) {
    return RawValuesInsertable({
      if (entityId != null) 'entity_id': entityId,
      if (email != null) 'email': email,
      if (friendlyName != null) 'friendly_name': friendlyName,
      if (signature != null) 'signature': signature,
      if (idUser != null) 'id_user': idUser,
      if (idAccount != null) 'id_account': idAccount,
      if (isDefault != null) 'is_default': isDefault,
      if (useSignature != null) 'use_signature': useSignature,
    });
  }

  AccountIdentityTableCompanion copyWith(
      {Value<int>? entityId,
      Value<String>? email,
      Value<String>? friendlyName,
      Value<String>? signature,
      Value<int>? idUser,
      Value<int>? idAccount,
      Value<bool>? isDefault,
      Value<bool>? useSignature}) {
    return AccountIdentityTableCompanion(
      entityId: entityId ?? this.entityId,
      email: email ?? this.email,
      friendlyName: friendlyName ?? this.friendlyName,
      signature: signature ?? this.signature,
      idUser: idUser ?? this.idUser,
      idAccount: idAccount ?? this.idAccount,
      isDefault: isDefault ?? this.isDefault,
      useSignature: useSignature ?? this.useSignature,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (friendlyName.present) {
      map['friendly_name'] = Variable<String>(friendlyName.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String>(signature.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<int>(idUser.value);
    }
    if (idAccount.present) {
      map['id_account'] = Variable<int>(idAccount.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (useSignature.present) {
      map['use_signature'] = Variable<bool>(useSignature.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountIdentityTableCompanion(')
          ..write('entityId: $entityId, ')
          ..write('email: $email, ')
          ..write('friendlyName: $friendlyName, ')
          ..write('signature: $signature, ')
          ..write('idUser: $idUser, ')
          ..write('idAccount: $idAccount, ')
          ..write('isDefault: $isDefault, ')
          ..write('useSignature: $useSignature')
          ..write(')'))
        .toString();
  }
}

class $AccountIdentityTableTable extends AccountIdentityTable
    with TableInfo<$AccountIdentityTableTable, AccountIdentity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountIdentityTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _entityIdMeta = const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<int?> entityId = GeneratedColumn<int?>(
      'entity_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _friendlyNameMeta =
      const VerificationMeta('friendlyName');
  @override
  late final GeneratedColumn<String?> friendlyName = GeneratedColumn<String?>(
      'friendly_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _signatureMeta = const VerificationMeta('signature');
  @override
  late final GeneratedColumn<String?> signature = GeneratedColumn<String?>(
      'signature', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  @override
  late final GeneratedColumn<int?> idUser = GeneratedColumn<int?>(
      'id_user', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _idAccountMeta = const VerificationMeta('idAccount');
  @override
  late final GeneratedColumn<int?> idAccount = GeneratedColumn<int?>(
      'id_account', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isDefaultMeta = const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool?> isDefault = GeneratedColumn<bool?>(
      'is_default', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_default IN (0, 1))');
  final VerificationMeta _useSignatureMeta =
      const VerificationMeta('useSignature');
  @override
  late final GeneratedColumn<bool?> useSignature = GeneratedColumn<bool?>(
      'use_signature', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (use_signature IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        entityId,
        email,
        friendlyName,
        signature,
        idUser,
        idAccount,
        isDefault,
        useSignature
      ];
  @override
  String get aliasedName => _alias ?? 'account_identity_table';
  @override
  String get actualTableName => 'account_identity_table';
  @override
  VerificationContext validateIntegrity(Insertable<AccountIdentity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('friendly_name')) {
      context.handle(
          _friendlyNameMeta,
          friendlyName.isAcceptableOrUnknown(
              data['friendly_name']!, _friendlyNameMeta));
    } else if (isInserting) {
      context.missing(_friendlyNameMeta);
    }
    if (data.containsKey('signature')) {
      context.handle(_signatureMeta,
          signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta));
    } else if (isInserting) {
      context.missing(_signatureMeta);
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user']!, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('id_account')) {
      context.handle(_idAccountMeta,
          idAccount.isAcceptableOrUnknown(data['id_account']!, _idAccountMeta));
    } else if (isInserting) {
      context.missing(_idAccountMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    } else if (isInserting) {
      context.missing(_isDefaultMeta);
    }
    if (data.containsKey('use_signature')) {
      context.handle(
          _useSignatureMeta,
          useSignature.isAcceptableOrUnknown(
              data['use_signature']!, _useSignatureMeta));
    } else if (isInserting) {
      context.missing(_useSignatureMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityId, idUser};
  @override
  AccountIdentity map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AccountIdentity.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AccountIdentityTableTable createAlias(String alias) {
    return $AccountIdentityTableTable(attachedDatabase, alias);
  }
}

class Aliases extends DataClass implements Insertable<Aliases> {
  final int entityId;
  final String email;
  final String friendlyName;
  final String signature;
  final int idUser;
  final int idAccount;
  final bool useSignature;
  Aliases(
      {required this.entityId,
      required this.email,
      required this.friendlyName,
      required this.signature,
      required this.idUser,
      required this.idAccount,
      required this.useSignature});
  factory Aliases.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Aliases(
      entityId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}entity_id'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      friendlyName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}friendly_name'])!,
      signature: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}signature'])!,
      idUser: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_user'])!,
      idAccount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_account'])!,
      useSignature: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}use_signature'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity_id'] = Variable<int>(entityId);
    map['email'] = Variable<String>(email);
    map['friendly_name'] = Variable<String>(friendlyName);
    map['signature'] = Variable<String>(signature);
    map['id_user'] = Variable<int>(idUser);
    map['id_account'] = Variable<int>(idAccount);
    map['use_signature'] = Variable<bool>(useSignature);
    return map;
  }

  AliasesTableCompanion toCompanion(bool nullToAbsent) {
    return AliasesTableCompanion(
      entityId: Value(entityId),
      email: Value(email),
      friendlyName: Value(friendlyName),
      signature: Value(signature),
      idUser: Value(idUser),
      idAccount: Value(idAccount),
      useSignature: Value(useSignature),
    );
  }

  factory Aliases.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Aliases(
      entityId: serializer.fromJson<int>(json['entityId']),
      email: serializer.fromJson<String>(json['email']),
      friendlyName: serializer.fromJson<String>(json['friendlyName']),
      signature: serializer.fromJson<String>(json['signature']),
      idUser: serializer.fromJson<int>(json['idUser']),
      idAccount: serializer.fromJson<int>(json['idAccount']),
      useSignature: serializer.fromJson<bool>(json['useSignature']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entityId': serializer.toJson<int>(entityId),
      'email': serializer.toJson<String>(email),
      'friendlyName': serializer.toJson<String>(friendlyName),
      'signature': serializer.toJson<String>(signature),
      'idUser': serializer.toJson<int>(idUser),
      'idAccount': serializer.toJson<int>(idAccount),
      'useSignature': serializer.toJson<bool>(useSignature),
    };
  }

  Aliases copyWith(
          {int? entityId,
          String? email,
          String? friendlyName,
          String? signature,
          int? idUser,
          int? idAccount,
          bool? useSignature}) =>
      Aliases(
        entityId: entityId ?? this.entityId,
        email: email ?? this.email,
        friendlyName: friendlyName ?? this.friendlyName,
        signature: signature ?? this.signature,
        idUser: idUser ?? this.idUser,
        idAccount: idAccount ?? this.idAccount,
        useSignature: useSignature ?? this.useSignature,
      );
  @override
  String toString() {
    return (StringBuffer('Aliases(')
          ..write('entityId: $entityId, ')
          ..write('email: $email, ')
          ..write('friendlyName: $friendlyName, ')
          ..write('signature: $signature, ')
          ..write('idUser: $idUser, ')
          ..write('idAccount: $idAccount, ')
          ..write('useSignature: $useSignature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entityId, email, friendlyName, signature,
      idUser, idAccount, useSignature);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Aliases &&
          other.entityId == this.entityId &&
          other.email == this.email &&
          other.friendlyName == this.friendlyName &&
          other.signature == this.signature &&
          other.idUser == this.idUser &&
          other.idAccount == this.idAccount &&
          other.useSignature == this.useSignature);
}

class AliasesTableCompanion extends UpdateCompanion<Aliases> {
  final Value<int> entityId;
  final Value<String> email;
  final Value<String> friendlyName;
  final Value<String> signature;
  final Value<int> idUser;
  final Value<int> idAccount;
  final Value<bool> useSignature;
  const AliasesTableCompanion({
    this.entityId = const Value.absent(),
    this.email = const Value.absent(),
    this.friendlyName = const Value.absent(),
    this.signature = const Value.absent(),
    this.idUser = const Value.absent(),
    this.idAccount = const Value.absent(),
    this.useSignature = const Value.absent(),
  });
  AliasesTableCompanion.insert({
    required int entityId,
    required String email,
    required String friendlyName,
    required String signature,
    required int idUser,
    required int idAccount,
    required bool useSignature,
  })  : entityId = Value(entityId),
        email = Value(email),
        friendlyName = Value(friendlyName),
        signature = Value(signature),
        idUser = Value(idUser),
        idAccount = Value(idAccount),
        useSignature = Value(useSignature);
  static Insertable<Aliases> custom({
    Expression<int>? entityId,
    Expression<String>? email,
    Expression<String>? friendlyName,
    Expression<String>? signature,
    Expression<int>? idUser,
    Expression<int>? idAccount,
    Expression<bool>? useSignature,
  }) {
    return RawValuesInsertable({
      if (entityId != null) 'entity_id': entityId,
      if (email != null) 'email': email,
      if (friendlyName != null) 'friendly_name': friendlyName,
      if (signature != null) 'signature': signature,
      if (idUser != null) 'id_user': idUser,
      if (idAccount != null) 'id_account': idAccount,
      if (useSignature != null) 'use_signature': useSignature,
    });
  }

  AliasesTableCompanion copyWith(
      {Value<int>? entityId,
      Value<String>? email,
      Value<String>? friendlyName,
      Value<String>? signature,
      Value<int>? idUser,
      Value<int>? idAccount,
      Value<bool>? useSignature}) {
    return AliasesTableCompanion(
      entityId: entityId ?? this.entityId,
      email: email ?? this.email,
      friendlyName: friendlyName ?? this.friendlyName,
      signature: signature ?? this.signature,
      idUser: idUser ?? this.idUser,
      idAccount: idAccount ?? this.idAccount,
      useSignature: useSignature ?? this.useSignature,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (friendlyName.present) {
      map['friendly_name'] = Variable<String>(friendlyName.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String>(signature.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<int>(idUser.value);
    }
    if (idAccount.present) {
      map['id_account'] = Variable<int>(idAccount.value);
    }
    if (useSignature.present) {
      map['use_signature'] = Variable<bool>(useSignature.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AliasesTableCompanion(')
          ..write('entityId: $entityId, ')
          ..write('email: $email, ')
          ..write('friendlyName: $friendlyName, ')
          ..write('signature: $signature, ')
          ..write('idUser: $idUser, ')
          ..write('idAccount: $idAccount, ')
          ..write('useSignature: $useSignature')
          ..write(')'))
        .toString();
  }
}

class $AliasesTableTable extends AliasesTable
    with TableInfo<$AliasesTableTable, Aliases> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AliasesTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _entityIdMeta = const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<int?> entityId = GeneratedColumn<int?>(
      'entity_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _friendlyNameMeta =
      const VerificationMeta('friendlyName');
  @override
  late final GeneratedColumn<String?> friendlyName = GeneratedColumn<String?>(
      'friendly_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _signatureMeta = const VerificationMeta('signature');
  @override
  late final GeneratedColumn<String?> signature = GeneratedColumn<String?>(
      'signature', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  @override
  late final GeneratedColumn<int?> idUser = GeneratedColumn<int?>(
      'id_user', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _idAccountMeta = const VerificationMeta('idAccount');
  @override
  late final GeneratedColumn<int?> idAccount = GeneratedColumn<int?>(
      'id_account', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _useSignatureMeta =
      const VerificationMeta('useSignature');
  @override
  late final GeneratedColumn<bool?> useSignature = GeneratedColumn<bool?>(
      'use_signature', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (use_signature IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        entityId,
        email,
        friendlyName,
        signature,
        idUser,
        idAccount,
        useSignature
      ];
  @override
  String get aliasedName => _alias ?? 'aliases_table';
  @override
  String get actualTableName => 'aliases_table';
  @override
  VerificationContext validateIntegrity(Insertable<Aliases> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('friendly_name')) {
      context.handle(
          _friendlyNameMeta,
          friendlyName.isAcceptableOrUnknown(
              data['friendly_name']!, _friendlyNameMeta));
    } else if (isInserting) {
      context.missing(_friendlyNameMeta);
    }
    if (data.containsKey('signature')) {
      context.handle(_signatureMeta,
          signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta));
    } else if (isInserting) {
      context.missing(_signatureMeta);
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user']!, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('id_account')) {
      context.handle(_idAccountMeta,
          idAccount.isAcceptableOrUnknown(data['id_account']!, _idAccountMeta));
    } else if (isInserting) {
      context.missing(_idAccountMeta);
    }
    if (data.containsKey('use_signature')) {
      context.handle(
          _useSignatureMeta,
          useSignature.isAcceptableOrUnknown(
              data['use_signature']!, _useSignatureMeta));
    } else if (isInserting) {
      context.missing(_useSignatureMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityId, idUser};
  @override
  Aliases map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Aliases.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AliasesTableTable createAlias(String alias) {
    return $AliasesTableTable(attachedDatabase, alias);
  }
}

class WhiteMail extends DataClass implements Insertable<WhiteMail> {
  final String mail;
  WhiteMail({required this.mail});
  factory WhiteMail.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WhiteMail(
      mail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mail'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mail'] = Variable<String>(mail);
    return map;
  }

  WhiteMailTableCompanion toCompanion(bool nullToAbsent) {
    return WhiteMailTableCompanion(
      mail: Value(mail),
    );
  }

  factory WhiteMail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WhiteMail(
      mail: serializer.fromJson<String>(json['mail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mail': serializer.toJson<String>(mail),
    };
  }

  WhiteMail copyWith({String? mail}) => WhiteMail(
        mail: mail ?? this.mail,
      );
  @override
  String toString() {
    return (StringBuffer('WhiteMail(')
          ..write('mail: $mail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => mail.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is WhiteMail && other.mail == this.mail);
}

class WhiteMailTableCompanion extends UpdateCompanion<WhiteMail> {
  final Value<String> mail;
  const WhiteMailTableCompanion({
    this.mail = const Value.absent(),
  });
  WhiteMailTableCompanion.insert({
    required String mail,
  }) : mail = Value(mail);
  static Insertable<WhiteMail> custom({
    Expression<String>? mail,
  }) {
    return RawValuesInsertable({
      if (mail != null) 'mail': mail,
    });
  }

  WhiteMailTableCompanion copyWith({Value<String>? mail}) {
    return WhiteMailTableCompanion(
      mail: mail ?? this.mail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mail.present) {
      map['mail'] = Variable<String>(mail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WhiteMailTableCompanion(')
          ..write('mail: $mail')
          ..write(')'))
        .toString();
  }
}

class $WhiteMailTableTable extends WhiteMailTable
    with TableInfo<$WhiteMailTableTable, WhiteMail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WhiteMailTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _mailMeta = const VerificationMeta('mail');
  @override
  late final GeneratedColumn<String?> mail = GeneratedColumn<String?>(
      'mail', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [mail];
  @override
  String get aliasedName => _alias ?? 'white_mail_table';
  @override
  String get actualTableName => 'white_mail_table';
  @override
  VerificationContext validateIntegrity(Insertable<WhiteMail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mail')) {
      context.handle(
          _mailMeta, mail.isAcceptableOrUnknown(data['mail']!, _mailMeta));
    } else if (isInserting) {
      context.missing(_mailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mail};
  @override
  WhiteMail map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WhiteMail.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WhiteMailTableTable createAlias(String alias) {
    return $WhiteMailTableTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MailTable mail = $MailTable(this);
  late final $CalendarTableTable calendarTable = $CalendarTableTable(this);
  late final $ActivityTableTable activityTable = $ActivityTableTable(this);
  late final $FoldersTable folders = $FoldersTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $ContactsTableTable contactsTable = $ContactsTableTable(this);
  late final $ContactsGroupsTable contactsGroups = $ContactsGroupsTable(this);
  late final $ContactsStoragesTable contactsStorages =
      $ContactsStoragesTable(this);
  late final $PgpKeyModelTable pgpKeyModel = $PgpKeyModelTable(this);
  late final $AccountIdentityTableTable accountIdentityTable =
      $AccountIdentityTableTable(this);
  late final $AliasesTableTable aliasesTable = $AliasesTableTable(this);
  late final $WhiteMailTableTable whiteMailTable = $WhiteMailTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        mail,
        calendarTable,
        activityTable,
        folders,
        users,
        accounts,
        contactsTable,
        contactsGroups,
        contactsStorages,
        pgpKeyModel,
        accountIdentityTable,
        aliasesTable,
        whiteMailTable
      ];
}
