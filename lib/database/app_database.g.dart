// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Message extends DataClass implements Insertable<Message> {
  final int localId;
  final int uid;
  final int parentUid;
  final String messageId;
  final String folder;
  final String flagsInJson;
  final String threadInJson;
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
  final String replyTo;
  final bool hasAttachments;
  final bool hasVcardAttachment;
  final bool hasIcalAttachment;
  final int importance;
  final String draftInfo;
  final int sensitivity;
  final String downloadAsEmlUrl;
  final String hash;
  final String headers;
  final String inReplyTo;
  final String references;
  final String readingConfirmationAddressee;
  final String htmlRaw;
  final String html;
  final String plain;
  final String plainRaw;
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
      this.parentUid,
      @required this.messageId,
      @required this.folder,
      @required this.flagsInJson,
      this.threadInJson,
      @required this.subject,
      @required this.size,
      @required this.textSize,
      @required this.truncated,
      @required this.internalTimeStampInUTC,
      @required this.receivedOrDateTimeStampInUTC,
      @required this.timeStampInUTC,
      @required this.toInJson,
      this.fromInJson,
      @required this.fromToDisplay,
      this.ccInJson,
      this.bccInJson,
      this.senderInJson,
      this.replyTo,
      @required this.hasAttachments,
      @required this.hasVcardAttachment,
      @required this.hasIcalAttachment,
      @required this.importance,
      this.draftInfo,
      @required this.sensitivity,
      @required this.downloadAsEmlUrl,
      @required this.hash,
      @required this.headers,
      @required this.inReplyTo,
      @required this.references,
      @required this.readingConfirmationAddressee,
      this.htmlRaw,
      this.html,
      @required this.plain,
      @required this.plainRaw,
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
      parentUid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_uid']),
      messageId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}message_id']),
      folder:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}folder']),
      flagsInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}flags_in_json']),
      threadInJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}thread_in_json']),
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
      replyTo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}reply_to']),
      hasAttachments: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}has_attachments']),
      hasVcardAttachment: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}has_vcard_attachment']),
      hasIcalAttachment: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}has_ical_attachment']),
      importance:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}importance']),
      draftInfo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}draft_info']),
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
      htmlRaw: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}html_raw']),
      html: stringType.mapFromDatabaseResponse(data['${effectivePrefix}html']),
      plain:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}plain']),
      plainRaw: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}plain_raw']),
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Message(
      localId: serializer.fromJson<int>(json['localId']),
      uid: serializer.fromJson<int>(json['uid']),
      parentUid: serializer.fromJson<int>(json['parentUid']),
      messageId: serializer.fromJson<String>(json['messageId']),
      folder: serializer.fromJson<String>(json['folder']),
      flagsInJson: serializer.fromJson<String>(json['flagsInJson']),
      threadInJson: serializer.fromJson<String>(json['threadInJson']),
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
      replyTo: serializer.fromJson<String>(json['replyTo']),
      hasAttachments: serializer.fromJson<bool>(json['hasAttachments']),
      hasVcardAttachment: serializer.fromJson<bool>(json['hasVcardAttachment']),
      hasIcalAttachment: serializer.fromJson<bool>(json['hasIcalAttachment']),
      importance: serializer.fromJson<int>(json['importance']),
      draftInfo: serializer.fromJson<String>(json['draftInfo']),
      sensitivity: serializer.fromJson<int>(json['sensitivity']),
      downloadAsEmlUrl: serializer.fromJson<String>(json['downloadAsEmlUrl']),
      hash: serializer.fromJson<String>(json['hash']),
      headers: serializer.fromJson<String>(json['headers']),
      inReplyTo: serializer.fromJson<String>(json['inReplyTo']),
      references: serializer.fromJson<String>(json['references']),
      readingConfirmationAddressee:
          serializer.fromJson<String>(json['readingConfirmationAddressee']),
      htmlRaw: serializer.fromJson<String>(json['htmlRaw']),
      html: serializer.fromJson<String>(json['html']),
      plain: serializer.fromJson<String>(json['plain']),
      plainRaw: serializer.fromJson<String>(json['plainRaw']),
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
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'localId': serializer.toJson<int>(localId),
      'uid': serializer.toJson<int>(uid),
      'parentUid': serializer.toJson<int>(parentUid),
      'messageId': serializer.toJson<String>(messageId),
      'folder': serializer.toJson<String>(folder),
      'flagsInJson': serializer.toJson<String>(flagsInJson),
      'threadInJson': serializer.toJson<String>(threadInJson),
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
      'replyTo': serializer.toJson<String>(replyTo),
      'hasAttachments': serializer.toJson<bool>(hasAttachments),
      'hasVcardAttachment': serializer.toJson<bool>(hasVcardAttachment),
      'hasIcalAttachment': serializer.toJson<bool>(hasIcalAttachment),
      'importance': serializer.toJson<int>(importance),
      'draftInfo': serializer.toJson<String>(draftInfo),
      'sensitivity': serializer.toJson<int>(sensitivity),
      'downloadAsEmlUrl': serializer.toJson<String>(downloadAsEmlUrl),
      'hash': serializer.toJson<String>(hash),
      'headers': serializer.toJson<String>(headers),
      'inReplyTo': serializer.toJson<String>(inReplyTo),
      'references': serializer.toJson<String>(references),
      'readingConfirmationAddressee':
          serializer.toJson<String>(readingConfirmationAddressee),
      'htmlRaw': serializer.toJson<String>(htmlRaw),
      'html': serializer.toJson<String>(html),
      'plain': serializer.toJson<String>(plain),
      'plainRaw': serializer.toJson<String>(plainRaw),
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
  T createCompanion<T extends UpdateCompanion<Message>>(bool nullToAbsent) {
    return MailCompanion(
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      uid: uid == null && nullToAbsent ? const Value.absent() : Value(uid),
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
      threadInJson: threadInJson == null && nullToAbsent
          ? const Value.absent()
          : Value(threadInJson),
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
      replyTo: replyTo == null && nullToAbsent
          ? const Value.absent()
          : Value(replyTo),
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
      draftInfo: draftInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(draftInfo),
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
      htmlRaw: htmlRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(htmlRaw),
      html: html == null && nullToAbsent ? const Value.absent() : Value(html),
      plain:
          plain == null && nullToAbsent ? const Value.absent() : Value(plain),
      plainRaw: plainRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(plainRaw),
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
    ) as T;
  }

  Message copyWith(
          {int localId,
          int uid,
          int parentUid,
          String messageId,
          String folder,
          String flagsInJson,
          String threadInJson,
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
          String replyTo,
          bool hasAttachments,
          bool hasVcardAttachment,
          bool hasIcalAttachment,
          int importance,
          String draftInfo,
          int sensitivity,
          String downloadAsEmlUrl,
          String hash,
          String headers,
          String inReplyTo,
          String references,
          String readingConfirmationAddressee,
          String htmlRaw,
          String html,
          String plain,
          String plainRaw,
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
        parentUid: parentUid ?? this.parentUid,
        messageId: messageId ?? this.messageId,
        folder: folder ?? this.folder,
        flagsInJson: flagsInJson ?? this.flagsInJson,
        threadInJson: threadInJson ?? this.threadInJson,
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
        replyTo: replyTo ?? this.replyTo,
        hasAttachments: hasAttachments ?? this.hasAttachments,
        hasVcardAttachment: hasVcardAttachment ?? this.hasVcardAttachment,
        hasIcalAttachment: hasIcalAttachment ?? this.hasIcalAttachment,
        importance: importance ?? this.importance,
        draftInfo: draftInfo ?? this.draftInfo,
        sensitivity: sensitivity ?? this.sensitivity,
        downloadAsEmlUrl: downloadAsEmlUrl ?? this.downloadAsEmlUrl,
        hash: hash ?? this.hash,
        headers: headers ?? this.headers,
        inReplyTo: inReplyTo ?? this.inReplyTo,
        references: references ?? this.references,
        readingConfirmationAddressee:
            readingConfirmationAddressee ?? this.readingConfirmationAddressee,
        htmlRaw: htmlRaw ?? this.htmlRaw,
        html: html ?? this.html,
        plain: plain ?? this.plain,
        plainRaw: plainRaw ?? this.plainRaw,
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
          ..write('parentUid: $parentUid, ')
          ..write('messageId: $messageId, ')
          ..write('folder: $folder, ')
          ..write('flagsInJson: $flagsInJson, ')
          ..write('threadInJson: $threadInJson, ')
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
          ..write('replyTo: $replyTo, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('hasVcardAttachment: $hasVcardAttachment, ')
          ..write('hasIcalAttachment: $hasIcalAttachment, ')
          ..write('importance: $importance, ')
          ..write('draftInfo: $draftInfo, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('downloadAsEmlUrl: $downloadAsEmlUrl, ')
          ..write('hash: $hash, ')
          ..write('headers: $headers, ')
          ..write('inReplyTo: $inReplyTo, ')
          ..write('references: $references, ')
          ..write(
              'readingConfirmationAddressee: $readingConfirmationAddressee, ')
          ..write('htmlRaw: $htmlRaw, ')
          ..write('html: $html, ')
          ..write('plain: $plain, ')
          ..write('plainRaw: $plainRaw, ')
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
              parentUid.hashCode,
              $mrjc(
                  messageId.hashCode,
                  $mrjc(
                      folder.hashCode,
                      $mrjc(
                          flagsInJson.hashCode,
                          $mrjc(
                              threadInJson.hashCode,
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
                                                              toInJson.hashCode,
                                                              $mrjc(
                                                                  fromInJson
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      fromToDisplay
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          ccInJson
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              bccInJson.hashCode,
                                                                              $mrjc(senderInJson.hashCode, $mrjc(replyTo.hashCode, $mrjc(hasAttachments.hashCode, $mrjc(hasVcardAttachment.hashCode, $mrjc(hasIcalAttachment.hashCode, $mrjc(importance.hashCode, $mrjc(draftInfo.hashCode, $mrjc(sensitivity.hashCode, $mrjc(downloadAsEmlUrl.hashCode, $mrjc(hash.hashCode, $mrjc(headers.hashCode, $mrjc(inReplyTo.hashCode, $mrjc(references.hashCode, $mrjc(readingConfirmationAddressee.hashCode, $mrjc(htmlRaw.hashCode, $mrjc(html.hashCode, $mrjc(plain.hashCode, $mrjc(plainRaw.hashCode, $mrjc(rtl.hashCode, $mrjc(extendInJson.hashCode, $mrjc(safety.hashCode, $mrjc(hasExternals.hashCode, $mrjc(foundedCIDsInJson.hashCode, $mrjc(foundedContentLocationUrlsInJson.hashCode, $mrjc(attachmentsInJson.hashCode, customInJson.hashCode)))))))))))))))))))))))))))))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Message &&
          other.localId == localId &&
          other.uid == uid &&
          other.parentUid == parentUid &&
          other.messageId == messageId &&
          other.folder == folder &&
          other.flagsInJson == flagsInJson &&
          other.threadInJson == threadInJson &&
          other.subject == subject &&
          other.size == size &&
          other.textSize == textSize &&
          other.truncated == truncated &&
          other.internalTimeStampInUTC == internalTimeStampInUTC &&
          other.receivedOrDateTimeStampInUTC == receivedOrDateTimeStampInUTC &&
          other.timeStampInUTC == timeStampInUTC &&
          other.toInJson == toInJson &&
          other.fromInJson == fromInJson &&
          other.fromToDisplay == fromToDisplay &&
          other.ccInJson == ccInJson &&
          other.bccInJson == bccInJson &&
          other.senderInJson == senderInJson &&
          other.replyTo == replyTo &&
          other.hasAttachments == hasAttachments &&
          other.hasVcardAttachment == hasVcardAttachment &&
          other.hasIcalAttachment == hasIcalAttachment &&
          other.importance == importance &&
          other.draftInfo == draftInfo &&
          other.sensitivity == sensitivity &&
          other.downloadAsEmlUrl == downloadAsEmlUrl &&
          other.hash == hash &&
          other.headers == headers &&
          other.inReplyTo == inReplyTo &&
          other.references == references &&
          other.readingConfirmationAddressee == readingConfirmationAddressee &&
          other.htmlRaw == htmlRaw &&
          other.html == html &&
          other.plain == plain &&
          other.plainRaw == plainRaw &&
          other.rtl == rtl &&
          other.extendInJson == extendInJson &&
          other.safety == safety &&
          other.hasExternals == hasExternals &&
          other.foundedCIDsInJson == foundedCIDsInJson &&
          other.foundedContentLocationUrlsInJson ==
              foundedContentLocationUrlsInJson &&
          other.attachmentsInJson == attachmentsInJson &&
          other.customInJson == customInJson);
}

class MailCompanion extends UpdateCompanion<Message> {
  final Value<int> localId;
  final Value<int> uid;
  final Value<int> parentUid;
  final Value<String> messageId;
  final Value<String> folder;
  final Value<String> flagsInJson;
  final Value<String> threadInJson;
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
  final Value<String> replyTo;
  final Value<bool> hasAttachments;
  final Value<bool> hasVcardAttachment;
  final Value<bool> hasIcalAttachment;
  final Value<int> importance;
  final Value<String> draftInfo;
  final Value<int> sensitivity;
  final Value<String> downloadAsEmlUrl;
  final Value<String> hash;
  final Value<String> headers;
  final Value<String> inReplyTo;
  final Value<String> references;
  final Value<String> readingConfirmationAddressee;
  final Value<String> htmlRaw;
  final Value<String> html;
  final Value<String> plain;
  final Value<String> plainRaw;
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
    this.parentUid = const Value.absent(),
    this.messageId = const Value.absent(),
    this.folder = const Value.absent(),
    this.flagsInJson = const Value.absent(),
    this.threadInJson = const Value.absent(),
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
    this.replyTo = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.hasVcardAttachment = const Value.absent(),
    this.hasIcalAttachment = const Value.absent(),
    this.importance = const Value.absent(),
    this.draftInfo = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.downloadAsEmlUrl = const Value.absent(),
    this.hash = const Value.absent(),
    this.headers = const Value.absent(),
    this.inReplyTo = const Value.absent(),
    this.references = const Value.absent(),
    this.readingConfirmationAddressee = const Value.absent(),
    this.htmlRaw = const Value.absent(),
    this.html = const Value.absent(),
    this.plain = const Value.absent(),
    this.plainRaw = const Value.absent(),
    this.rtl = const Value.absent(),
    this.extendInJson = const Value.absent(),
    this.safety = const Value.absent(),
    this.hasExternals = const Value.absent(),
    this.foundedCIDsInJson = const Value.absent(),
    this.foundedContentLocationUrlsInJson = const Value.absent(),
    this.attachmentsInJson = const Value.absent(),
    this.customInJson = const Value.absent(),
  });
  MailCompanion copyWith(
      {Value<int> localId,
      Value<int> uid,
      Value<int> parentUid,
      Value<String> messageId,
      Value<String> folder,
      Value<String> flagsInJson,
      Value<String> threadInJson,
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
      Value<String> replyTo,
      Value<bool> hasAttachments,
      Value<bool> hasVcardAttachment,
      Value<bool> hasIcalAttachment,
      Value<int> importance,
      Value<String> draftInfo,
      Value<int> sensitivity,
      Value<String> downloadAsEmlUrl,
      Value<String> hash,
      Value<String> headers,
      Value<String> inReplyTo,
      Value<String> references,
      Value<String> readingConfirmationAddressee,
      Value<String> htmlRaw,
      Value<String> html,
      Value<String> plain,
      Value<String> plainRaw,
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
      parentUid: parentUid ?? this.parentUid,
      messageId: messageId ?? this.messageId,
      folder: folder ?? this.folder,
      flagsInJson: flagsInJson ?? this.flagsInJson,
      threadInJson: threadInJson ?? this.threadInJson,
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
      replyTo: replyTo ?? this.replyTo,
      hasAttachments: hasAttachments ?? this.hasAttachments,
      hasVcardAttachment: hasVcardAttachment ?? this.hasVcardAttachment,
      hasIcalAttachment: hasIcalAttachment ?? this.hasIcalAttachment,
      importance: importance ?? this.importance,
      draftInfo: draftInfo ?? this.draftInfo,
      sensitivity: sensitivity ?? this.sensitivity,
      downloadAsEmlUrl: downloadAsEmlUrl ?? this.downloadAsEmlUrl,
      hash: hash ?? this.hash,
      headers: headers ?? this.headers,
      inReplyTo: inReplyTo ?? this.inReplyTo,
      references: references ?? this.references,
      readingConfirmationAddressee:
          readingConfirmationAddressee ?? this.readingConfirmationAddressee,
      htmlRaw: htmlRaw ?? this.htmlRaw,
      html: html ?? this.html,
      plain: plain ?? this.plain,
      plainRaw: plainRaw ?? this.plainRaw,
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

  final VerificationMeta _threadInJsonMeta =
      const VerificationMeta('threadInJson');
  GeneratedTextColumn _threadInJson;
  @override
  GeneratedTextColumn get threadInJson =>
      _threadInJson ??= _constructThreadInJson();
  GeneratedTextColumn _constructThreadInJson() {
    return GeneratedTextColumn(
      'thread_in_json',
      $tableName,
      true,
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
      false,
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

  final VerificationMeta _replyToMeta = const VerificationMeta('replyTo');
  GeneratedTextColumn _replyTo;
  @override
  GeneratedTextColumn get replyTo => _replyTo ??= _constructReplyTo();
  GeneratedTextColumn _constructReplyTo() {
    return GeneratedTextColumn(
      'reply_to',
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

  final VerificationMeta _draftInfoMeta = const VerificationMeta('draftInfo');
  GeneratedTextColumn _draftInfo;
  @override
  GeneratedTextColumn get draftInfo => _draftInfo ??= _constructDraftInfo();
  GeneratedTextColumn _constructDraftInfo() {
    return GeneratedTextColumn(
      'draft_info',
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

  final VerificationMeta _htmlRawMeta = const VerificationMeta('htmlRaw');
  GeneratedTextColumn _htmlRaw;
  @override
  GeneratedTextColumn get htmlRaw => _htmlRaw ??= _constructHtmlRaw();
  GeneratedTextColumn _constructHtmlRaw() {
    return GeneratedTextColumn(
      'html_raw',
      $tableName,
      true,
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

  final VerificationMeta _plainRawMeta = const VerificationMeta('plainRaw');
  GeneratedTextColumn _plainRaw;
  @override
  GeneratedTextColumn get plainRaw => _plainRaw ??= _constructPlainRaw();
  GeneratedTextColumn _constructPlainRaw() {
    return GeneratedTextColumn(
      'plain_raw',
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
        parentUid,
        messageId,
        folder,
        flagsInJson,
        threadInJson,
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
        replyTo,
        hasAttachments,
        hasVcardAttachment,
        hasIcalAttachment,
        importance,
        draftInfo,
        sensitivity,
        downloadAsEmlUrl,
        hash,
        headers,
        inReplyTo,
        references,
        readingConfirmationAddressee,
        htmlRaw,
        html,
        plain,
        plainRaw,
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
    } else if (localId.isRequired && isInserting) {
      context.missing(_localIdMeta);
    }
    if (d.uid.present) {
      context.handle(_uidMeta, uid.isAcceptableValue(d.uid.value, _uidMeta));
    } else if (uid.isRequired && isInserting) {
      context.missing(_uidMeta);
    }
    if (d.parentUid.present) {
      context.handle(_parentUidMeta,
          parentUid.isAcceptableValue(d.parentUid.value, _parentUidMeta));
    } else if (parentUid.isRequired && isInserting) {
      context.missing(_parentUidMeta);
    }
    if (d.messageId.present) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableValue(d.messageId.value, _messageIdMeta));
    } else if (messageId.isRequired && isInserting) {
      context.missing(_messageIdMeta);
    }
    if (d.folder.present) {
      context.handle(
          _folderMeta, folder.isAcceptableValue(d.folder.value, _folderMeta));
    } else if (folder.isRequired && isInserting) {
      context.missing(_folderMeta);
    }
    if (d.flagsInJson.present) {
      context.handle(_flagsInJsonMeta,
          flagsInJson.isAcceptableValue(d.flagsInJson.value, _flagsInJsonMeta));
    } else if (flagsInJson.isRequired && isInserting) {
      context.missing(_flagsInJsonMeta);
    }
    if (d.threadInJson.present) {
      context.handle(
          _threadInJsonMeta,
          threadInJson.isAcceptableValue(
              d.threadInJson.value, _threadInJsonMeta));
    } else if (threadInJson.isRequired && isInserting) {
      context.missing(_threadInJsonMeta);
    }
    if (d.subject.present) {
      context.handle(_subjectMeta,
          subject.isAcceptableValue(d.subject.value, _subjectMeta));
    } else if (subject.isRequired && isInserting) {
      context.missing(_subjectMeta);
    }
    if (d.size.present) {
      context.handle(
          _sizeMeta, size.isAcceptableValue(d.size.value, _sizeMeta));
    } else if (size.isRequired && isInserting) {
      context.missing(_sizeMeta);
    }
    if (d.textSize.present) {
      context.handle(_textSizeMeta,
          textSize.isAcceptableValue(d.textSize.value, _textSizeMeta));
    } else if (textSize.isRequired && isInserting) {
      context.missing(_textSizeMeta);
    }
    if (d.truncated.present) {
      context.handle(_truncatedMeta,
          truncated.isAcceptableValue(d.truncated.value, _truncatedMeta));
    } else if (truncated.isRequired && isInserting) {
      context.missing(_truncatedMeta);
    }
    if (d.internalTimeStampInUTC.present) {
      context.handle(
          _internalTimeStampInUTCMeta,
          internalTimeStampInUTC.isAcceptableValue(
              d.internalTimeStampInUTC.value, _internalTimeStampInUTCMeta));
    } else if (internalTimeStampInUTC.isRequired && isInserting) {
      context.missing(_internalTimeStampInUTCMeta);
    }
    if (d.receivedOrDateTimeStampInUTC.present) {
      context.handle(
          _receivedOrDateTimeStampInUTCMeta,
          receivedOrDateTimeStampInUTC.isAcceptableValue(
              d.receivedOrDateTimeStampInUTC.value,
              _receivedOrDateTimeStampInUTCMeta));
    } else if (receivedOrDateTimeStampInUTC.isRequired && isInserting) {
      context.missing(_receivedOrDateTimeStampInUTCMeta);
    }
    if (d.timeStampInUTC.present) {
      context.handle(
          _timeStampInUTCMeta,
          timeStampInUTC.isAcceptableValue(
              d.timeStampInUTC.value, _timeStampInUTCMeta));
    } else if (timeStampInUTC.isRequired && isInserting) {
      context.missing(_timeStampInUTCMeta);
    }
    if (d.toInJson.present) {
      context.handle(_toInJsonMeta,
          toInJson.isAcceptableValue(d.toInJson.value, _toInJsonMeta));
    } else if (toInJson.isRequired && isInserting) {
      context.missing(_toInJsonMeta);
    }
    if (d.fromInJson.present) {
      context.handle(_fromInJsonMeta,
          fromInJson.isAcceptableValue(d.fromInJson.value, _fromInJsonMeta));
    } else if (fromInJson.isRequired && isInserting) {
      context.missing(_fromInJsonMeta);
    }
    if (d.fromToDisplay.present) {
      context.handle(
          _fromToDisplayMeta,
          fromToDisplay.isAcceptableValue(
              d.fromToDisplay.value, _fromToDisplayMeta));
    } else if (fromToDisplay.isRequired && isInserting) {
      context.missing(_fromToDisplayMeta);
    }
    if (d.ccInJson.present) {
      context.handle(_ccInJsonMeta,
          ccInJson.isAcceptableValue(d.ccInJson.value, _ccInJsonMeta));
    } else if (ccInJson.isRequired && isInserting) {
      context.missing(_ccInJsonMeta);
    }
    if (d.bccInJson.present) {
      context.handle(_bccInJsonMeta,
          bccInJson.isAcceptableValue(d.bccInJson.value, _bccInJsonMeta));
    } else if (bccInJson.isRequired && isInserting) {
      context.missing(_bccInJsonMeta);
    }
    if (d.senderInJson.present) {
      context.handle(
          _senderInJsonMeta,
          senderInJson.isAcceptableValue(
              d.senderInJson.value, _senderInJsonMeta));
    } else if (senderInJson.isRequired && isInserting) {
      context.missing(_senderInJsonMeta);
    }
    if (d.replyTo.present) {
      context.handle(_replyToMeta,
          replyTo.isAcceptableValue(d.replyTo.value, _replyToMeta));
    } else if (replyTo.isRequired && isInserting) {
      context.missing(_replyToMeta);
    }
    if (d.hasAttachments.present) {
      context.handle(
          _hasAttachmentsMeta,
          hasAttachments.isAcceptableValue(
              d.hasAttachments.value, _hasAttachmentsMeta));
    } else if (hasAttachments.isRequired && isInserting) {
      context.missing(_hasAttachmentsMeta);
    }
    if (d.hasVcardAttachment.present) {
      context.handle(
          _hasVcardAttachmentMeta,
          hasVcardAttachment.isAcceptableValue(
              d.hasVcardAttachment.value, _hasVcardAttachmentMeta));
    } else if (hasVcardAttachment.isRequired && isInserting) {
      context.missing(_hasVcardAttachmentMeta);
    }
    if (d.hasIcalAttachment.present) {
      context.handle(
          _hasIcalAttachmentMeta,
          hasIcalAttachment.isAcceptableValue(
              d.hasIcalAttachment.value, _hasIcalAttachmentMeta));
    } else if (hasIcalAttachment.isRequired && isInserting) {
      context.missing(_hasIcalAttachmentMeta);
    }
    if (d.importance.present) {
      context.handle(_importanceMeta,
          importance.isAcceptableValue(d.importance.value, _importanceMeta));
    } else if (importance.isRequired && isInserting) {
      context.missing(_importanceMeta);
    }
    if (d.draftInfo.present) {
      context.handle(_draftInfoMeta,
          draftInfo.isAcceptableValue(d.draftInfo.value, _draftInfoMeta));
    } else if (draftInfo.isRequired && isInserting) {
      context.missing(_draftInfoMeta);
    }
    if (d.sensitivity.present) {
      context.handle(_sensitivityMeta,
          sensitivity.isAcceptableValue(d.sensitivity.value, _sensitivityMeta));
    } else if (sensitivity.isRequired && isInserting) {
      context.missing(_sensitivityMeta);
    }
    if (d.downloadAsEmlUrl.present) {
      context.handle(
          _downloadAsEmlUrlMeta,
          downloadAsEmlUrl.isAcceptableValue(
              d.downloadAsEmlUrl.value, _downloadAsEmlUrlMeta));
    } else if (downloadAsEmlUrl.isRequired && isInserting) {
      context.missing(_downloadAsEmlUrlMeta);
    }
    if (d.hash.present) {
      context.handle(
          _hashMeta, hash.isAcceptableValue(d.hash.value, _hashMeta));
    } else if (hash.isRequired && isInserting) {
      context.missing(_hashMeta);
    }
    if (d.headers.present) {
      context.handle(_headersMeta,
          headers.isAcceptableValue(d.headers.value, _headersMeta));
    } else if (headers.isRequired && isInserting) {
      context.missing(_headersMeta);
    }
    if (d.inReplyTo.present) {
      context.handle(_inReplyToMeta,
          inReplyTo.isAcceptableValue(d.inReplyTo.value, _inReplyToMeta));
    } else if (inReplyTo.isRequired && isInserting) {
      context.missing(_inReplyToMeta);
    }
    if (d.references.present) {
      context.handle(_referencesMeta,
          references.isAcceptableValue(d.references.value, _referencesMeta));
    } else if (references.isRequired && isInserting) {
      context.missing(_referencesMeta);
    }
    if (d.readingConfirmationAddressee.present) {
      context.handle(
          _readingConfirmationAddresseeMeta,
          readingConfirmationAddressee.isAcceptableValue(
              d.readingConfirmationAddressee.value,
              _readingConfirmationAddresseeMeta));
    } else if (readingConfirmationAddressee.isRequired && isInserting) {
      context.missing(_readingConfirmationAddresseeMeta);
    }
    if (d.htmlRaw.present) {
      context.handle(_htmlRawMeta,
          htmlRaw.isAcceptableValue(d.htmlRaw.value, _htmlRawMeta));
    } else if (htmlRaw.isRequired && isInserting) {
      context.missing(_htmlRawMeta);
    }
    if (d.html.present) {
      context.handle(
          _htmlMeta, html.isAcceptableValue(d.html.value, _htmlMeta));
    } else if (html.isRequired && isInserting) {
      context.missing(_htmlMeta);
    }
    if (d.plain.present) {
      context.handle(
          _plainMeta, plain.isAcceptableValue(d.plain.value, _plainMeta));
    } else if (plain.isRequired && isInserting) {
      context.missing(_plainMeta);
    }
    if (d.plainRaw.present) {
      context.handle(_plainRawMeta,
          plainRaw.isAcceptableValue(d.plainRaw.value, _plainRawMeta));
    } else if (plainRaw.isRequired && isInserting) {
      context.missing(_plainRawMeta);
    }
    if (d.rtl.present) {
      context.handle(_rtlMeta, rtl.isAcceptableValue(d.rtl.value, _rtlMeta));
    } else if (rtl.isRequired && isInserting) {
      context.missing(_rtlMeta);
    }
    if (d.extendInJson.present) {
      context.handle(
          _extendInJsonMeta,
          extendInJson.isAcceptableValue(
              d.extendInJson.value, _extendInJsonMeta));
    } else if (extendInJson.isRequired && isInserting) {
      context.missing(_extendInJsonMeta);
    }
    if (d.safety.present) {
      context.handle(
          _safetyMeta, safety.isAcceptableValue(d.safety.value, _safetyMeta));
    } else if (safety.isRequired && isInserting) {
      context.missing(_safetyMeta);
    }
    if (d.hasExternals.present) {
      context.handle(
          _hasExternalsMeta,
          hasExternals.isAcceptableValue(
              d.hasExternals.value, _hasExternalsMeta));
    } else if (hasExternals.isRequired && isInserting) {
      context.missing(_hasExternalsMeta);
    }
    if (d.foundedCIDsInJson.present) {
      context.handle(
          _foundedCIDsInJsonMeta,
          foundedCIDsInJson.isAcceptableValue(
              d.foundedCIDsInJson.value, _foundedCIDsInJsonMeta));
    } else if (foundedCIDsInJson.isRequired && isInserting) {
      context.missing(_foundedCIDsInJsonMeta);
    }
    if (d.foundedContentLocationUrlsInJson.present) {
      context.handle(
          _foundedContentLocationUrlsInJsonMeta,
          foundedContentLocationUrlsInJson.isAcceptableValue(
              d.foundedContentLocationUrlsInJson.value,
              _foundedContentLocationUrlsInJsonMeta));
    } else if (foundedContentLocationUrlsInJson.isRequired && isInserting) {
      context.missing(_foundedContentLocationUrlsInJsonMeta);
    }
    if (d.attachmentsInJson.present) {
      context.handle(
          _attachmentsInJsonMeta,
          attachmentsInJson.isAcceptableValue(
              d.attachmentsInJson.value, _attachmentsInJsonMeta));
    } else if (attachmentsInJson.isRequired && isInserting) {
      context.missing(_attachmentsInJsonMeta);
    }
    if (d.customInJson.present) {
      context.handle(
          _customInJsonMeta,
          customInJson.isAcceptableValue(
              d.customInJson.value, _customInJsonMeta));
    } else if (customInJson.isRequired && isInserting) {
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
    if (d.threadInJson.present) {
      map['thread_in_json'] =
          Variable<String, StringType>(d.threadInJson.value);
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
    if (d.replyTo.present) {
      map['reply_to'] = Variable<String, StringType>(d.replyTo.value);
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
    if (d.draftInfo.present) {
      map['draft_info'] = Variable<String, StringType>(d.draftInfo.value);
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
    if (d.htmlRaw.present) {
      map['html_raw'] = Variable<String, StringType>(d.htmlRaw.value);
    }
    if (d.html.present) {
      map['html'] = Variable<String, StringType>(d.html.value);
    }
    if (d.plain.present) {
      map['plain'] = Variable<String, StringType>(d.plain.value);
    }
    if (d.plainRaw.present) {
      map['plain_raw'] = Variable<String, StringType>(d.plainRaw.value);
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
  final int localId;
  final String guid;
  final String parentGuid;
  final int accountId;
  final int type;
  final int folderOrder;
  final int count;
  final int unread;
  final String name;
  final String fullName;
  final String fullNameRaw;
  final String fullNameHash;
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
      {@required this.localId,
      @required this.guid,
      this.parentGuid,
      @required this.accountId,
      @required this.type,
      @required this.folderOrder,
      this.count,
      this.unread,
      @required this.name,
      @required this.fullName,
      @required this.fullNameRaw,
      @required this.fullNameHash,
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
      count: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}messages_count']),
      unread: intType.mapFromDatabaseResponse(data['${effectivePrefix}unread']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      fullNameRaw: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_raw']),
      fullNameHash: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name_hash']),
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return LocalFolder(
      localId: serializer.fromJson<int>(json['localId']),
      guid: serializer.fromJson<String>(json['guid']),
      parentGuid: serializer.fromJson<String>(json['parentGuid']),
      accountId: serializer.fromJson<int>(json['accountId']),
      type: serializer.fromJson<int>(json['type']),
      folderOrder: serializer.fromJson<int>(json['folderOrder']),
      count: serializer.fromJson<int>(json['count']),
      unread: serializer.fromJson<int>(json['unread']),
      name: serializer.fromJson<String>(json['name']),
      fullName: serializer.fromJson<String>(json['fullName']),
      fullNameRaw: serializer.fromJson<String>(json['fullNameRaw']),
      fullNameHash: serializer.fromJson<String>(json['fullNameHash']),
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
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'localId': serializer.toJson<int>(localId),
      'guid': serializer.toJson<String>(guid),
      'parentGuid': serializer.toJson<String>(parentGuid),
      'accountId': serializer.toJson<int>(accountId),
      'type': serializer.toJson<int>(type),
      'folderOrder': serializer.toJson<int>(folderOrder),
      'count': serializer.toJson<int>(count),
      'unread': serializer.toJson<int>(unread),
      'name': serializer.toJson<String>(name),
      'fullName': serializer.toJson<String>(fullName),
      'fullNameRaw': serializer.toJson<String>(fullNameRaw),
      'fullNameHash': serializer.toJson<String>(fullNameHash),
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
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      unread:
          unread == null && nullToAbsent ? const Value.absent() : Value(unread),
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
    ) as T;
  }

  LocalFolder copyWith(
          {int localId,
          String guid,
          String parentGuid,
          int accountId,
          int type,
          int folderOrder,
          int count,
          int unread,
          String name,
          String fullName,
          String fullNameRaw,
          String fullNameHash,
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
        localId: localId ?? this.localId,
        guid: guid ?? this.guid,
        parentGuid: parentGuid ?? this.parentGuid,
        accountId: accountId ?? this.accountId,
        type: type ?? this.type,
        folderOrder: folderOrder ?? this.folderOrder,
        count: count ?? this.count,
        unread: unread ?? this.unread,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
        fullNameRaw: fullNameRaw ?? this.fullNameRaw,
        fullNameHash: fullNameHash ?? this.fullNameHash,
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
          ..write('localId: $localId, ')
          ..write('guid: $guid, ')
          ..write('parentGuid: $parentGuid, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('folderOrder: $folderOrder, ')
          ..write('count: $count, ')
          ..write('unread: $unread, ')
          ..write('name: $name, ')
          ..write('fullName: $fullName, ')
          ..write('fullNameRaw: $fullNameRaw, ')
          ..write('fullNameHash: $fullNameHash, ')
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
                              count.hashCode,
                              $mrjc(
                                  unread.hashCode,
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
                                                          needsInfoUpdate
                                                              .hashCode,
                                                          $mrjc(
                                                              isSystemFolder
                                                                  .hashCode,
                                                              $mrjc(
                                                                  isSubscribed
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      isSelectable
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          folderExists
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              extended.hashCode,
                                                                              $mrjc(alwaysRefresh.hashCode, messagesInfoInJson.hashCode)))))))))))))))))))));
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
          other.count == count &&
          other.unread == unread &&
          other.name == name &&
          other.fullName == fullName &&
          other.fullNameRaw == fullNameRaw &&
          other.fullNameHash == fullNameHash &&
          other.delimiter == delimiter &&
          other.needsInfoUpdate == needsInfoUpdate &&
          other.isSystemFolder == isSystemFolder &&
          other.isSubscribed == isSubscribed &&
          other.isSelectable == isSelectable &&
          other.folderExists == folderExists &&
          other.extended == extended &&
          other.alwaysRefresh == alwaysRefresh &&
          other.messagesInfoInJson == messagesInfoInJson);
}

class FoldersCompanion extends UpdateCompanion<LocalFolder> {
  final Value<int> localId;
  final Value<String> guid;
  final Value<String> parentGuid;
  final Value<int> accountId;
  final Value<int> type;
  final Value<int> folderOrder;
  final Value<int> count;
  final Value<int> unread;
  final Value<String> name;
  final Value<String> fullName;
  final Value<String> fullNameRaw;
  final Value<String> fullNameHash;
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
    this.localId = const Value.absent(),
    this.guid = const Value.absent(),
    this.parentGuid = const Value.absent(),
    this.accountId = const Value.absent(),
    this.type = const Value.absent(),
    this.folderOrder = const Value.absent(),
    this.count = const Value.absent(),
    this.unread = const Value.absent(),
    this.name = const Value.absent(),
    this.fullName = const Value.absent(),
    this.fullNameRaw = const Value.absent(),
    this.fullNameHash = const Value.absent(),
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
  FoldersCompanion copyWith(
      {Value<int> localId,
      Value<String> guid,
      Value<String> parentGuid,
      Value<int> accountId,
      Value<int> type,
      Value<int> folderOrder,
      Value<int> count,
      Value<int> unread,
      Value<String> name,
      Value<String> fullName,
      Value<String> fullNameRaw,
      Value<String> fullNameHash,
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
      localId: localId ?? this.localId,
      guid: guid ?? this.guid,
      parentGuid: parentGuid ?? this.parentGuid,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      folderOrder: folderOrder ?? this.folderOrder,
      count: count ?? this.count,
      unread: unread ?? this.unread,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      fullNameRaw: fullNameRaw ?? this.fullNameRaw,
      fullNameHash: fullNameHash ?? this.fullNameHash,
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

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedIntColumn _count;
  @override
  GeneratedIntColumn get count => _count ??= _constructCount();
  GeneratedIntColumn _constructCount() {
    return GeneratedIntColumn(
      'messages_count',
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
        localId,
        guid,
        parentGuid,
        accountId,
        type,
        folderOrder,
        count,
        unread,
        name,
        fullName,
        fullNameRaw,
        fullNameHash,
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
    if (d.count.present) {
      context.handle(
          _countMeta, count.isAcceptableValue(d.count.value, _countMeta));
    } else if (count.isRequired && isInserting) {
      context.missing(_countMeta);
    }
    if (d.unread.present) {
      context.handle(
          _unreadMeta, unread.isAcceptableValue(d.unread.value, _unreadMeta));
    } else if (unread.isRequired && isInserting) {
      context.missing(_unreadMeta);
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
    if (d.needsInfoUpdate.present) {
      context.handle(
          _needsInfoUpdateMeta,
          needsInfoUpdate.isAcceptableValue(
              d.needsInfoUpdate.value, _needsInfoUpdateMeta));
    } else if (needsInfoUpdate.isRequired && isInserting) {
      context.missing(_needsInfoUpdateMeta);
    }
    if (d.isSystemFolder.present) {
      context.handle(
          _isSystemFolderMeta,
          isSystemFolder.isAcceptableValue(
              d.isSystemFolder.value, _isSystemFolderMeta));
    } else if (isSystemFolder.isRequired && isInserting) {
      context.missing(_isSystemFolderMeta);
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
    if (d.messagesInfoInJson.present) {
      context.handle(
          _messagesInfoInJsonMeta,
          messagesInfoInJson.isAcceptableValue(
              d.messagesInfoInJson.value, _messagesInfoInJsonMeta));
    } else if (messagesInfoInJson.isRequired && isInserting) {
      context.missing(_messagesInfoInJsonMeta);
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
    if (d.count.present) {
      map['messages_count'] = Variable<int, IntType>(d.count.value);
    }
    if (d.unread.present) {
      map['unread'] = Variable<int, IntType>(d.unread.value);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $MailTable _mail;
  $MailTable get mail => _mail ??= $MailTable(this);
  $FoldersTable _folders;
  $FoldersTable get folders => _folders ??= $FoldersTable(this);
  @override
  List<TableInfo> get allTables => [mail, folders];
}
