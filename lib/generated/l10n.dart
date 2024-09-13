// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mail Client`
  String get app_title {
    return Intl.message(
      'Mail Client',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Host`
  String get login_input_host {
    return Intl.message(
      'Host',
      name: 'login_input_host',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get login_input_email {
    return Intl.message(
      'Email',
      name: 'login_input_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_input_password {
    return Intl.message(
      'Password',
      name: 'login_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Log in to continue`
  String get login_to_continue {
    return Intl.message(
      'Log in to continue',
      name: 'login_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `No folders`
  String get folders_empty {
    return Intl.message(
      'No folders',
      name: 'folders_empty',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get folders_inbox {
    return Intl.message(
      'Inbox',
      name: 'folders_inbox',
      desc: '',
      args: [],
    );
  }

  /// `Starred`
  String get folders_starred {
    return Intl.message(
      'Starred',
      name: 'folders_starred',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get folders_sent {
    return Intl.message(
      'Sent',
      name: 'folders_sent',
      desc: '',
      args: [],
    );
  }

  /// `Drafts`
  String get folders_drafts {
    return Intl.message(
      'Drafts',
      name: 'folders_drafts',
      desc: '',
      args: [],
    );
  }

  /// `Spam`
  String get folders_spam {
    return Intl.message(
      'Spam',
      name: 'folders_spam',
      desc: '',
      args: [],
    );
  }

  /// `Trash`
  String get folders_trash {
    return Intl.message(
      'Trash',
      name: 'folders_trash',
      desc: '',
      args: [],
    );
  }

  /// `Reply`
  String get messages_reply {
    return Intl.message(
      'Reply',
      name: 'messages_reply',
      desc: '',
      args: [],
    );
  }

  /// `Reply to all`
  String get messages_reply_all {
    return Intl.message(
      'Reply to all',
      name: 'messages_reply_all',
      desc: '',
      args: [],
    );
  }

  /// `Forward`
  String get messages_forward {
    return Intl.message(
      'Forward',
      name: 'messages_forward',
      desc: '',
      args: [],
    );
  }

  /// `No messages`
  String get messages_empty {
    return Intl.message(
      'No messages',
      name: 'messages_empty',
      desc: '',
      args: [],
    );
  }

  /// `Unread messages:`
  String get messages_filter_unread {
    return Intl.message(
      'Unread messages:',
      name: 'messages_filter_unread',
      desc: '',
      args: [],
    );
  }

  /// `Delete message`
  String get messages_delete_title {
    return Intl.message(
      'Delete message',
      name: 'messages_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete messages`
  String get messages_delete_title_with_count {
    return Intl.message(
      'Delete messages',
      name: 'messages_delete_title_with_count',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {subject}?`
  String messages_delete_desc_with_subject(Object subject) {
    return Intl.message(
      'Are you sure you want to delete $subject?',
      name: 'messages_delete_desc_with_subject',
      desc: '',
      args: [subject],
    );
  }

  /// `Are you sure you want to delete this message?`
  String get messages_delete_desc {
    return Intl.message(
      'Are you sure you want to delete this message?',
      name: 'messages_delete_desc',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete these messages?`
  String get messages_delete_desc_with_count {
    return Intl.message(
      'Are you sure you want to delete these messages?',
      name: 'messages_delete_desc_with_count',
      desc: '',
      args: [],
    );
  }

  /// `Mail`
  String get messages_list_app_bar_mail {
    return Intl.message(
      'Mail',
      name: 'messages_list_app_bar_mail',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get messages_list_app_bar_contacts {
    return Intl.message(
      'Contacts',
      name: 'messages_list_app_bar_contacts',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get messages_list_app_bar_settings {
    return Intl.message(
      'Settings',
      name: 'messages_list_app_bar_settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get messages_list_app_bar_logout {
    return Intl.message(
      'Log out',
      name: 'messages_list_app_bar_logout',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get messages_list_app_bar_search {
    return Intl.message(
      'Search',
      name: 'messages_list_app_bar_search',
      desc: '',
      args: [],
    );
  }

  /// `Loading folders...`
  String get messages_list_app_bar_loading_folders {
    return Intl.message(
      'Loading folders...',
      name: 'messages_list_app_bar_loading_folders',
      desc: '',
      args: [],
    );
  }

  /// `Show details`
  String get messages_show_details {
    return Intl.message(
      'Show details',
      name: 'messages_show_details',
      desc: '',
      args: [],
    );
  }

  /// `Pictures in this message have been blocked for your safety.`
  String get messages_images_security_alert {
    return Intl.message(
      'Pictures in this message have been blocked for your safety.',
      name: 'messages_images_security_alert',
      desc: '',
      args: [],
    );
  }

  /// `Show pictures.`
  String get messages_show_images {
    return Intl.message(
      'Show pictures.',
      name: 'messages_show_images',
      desc: '',
      args: [],
    );
  }

  /// `Always show pictures in messages from this sender.`
  String get messages_always_show_images {
    return Intl.message(
      'Always show pictures in messages from this sender.',
      name: 'messages_always_show_images',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get messages_view_tab_attachments {
    return Intl.message(
      'Attachments',
      name: 'messages_view_tab_attachments',
      desc: '',
      args: [],
    );
  }

  /// `Message body`
  String get messages_view_tab_message_body {
    return Intl.message(
      'Message body',
      name: 'messages_view_tab_message_body',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get messages_to {
    return Intl.message(
      'To',
      name: 'messages_to',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get messages_from {
    return Intl.message(
      'From',
      name: 'messages_from',
      desc: '',
      args: [],
    );
  }

  /// `CC`
  String get messages_cc {
    return Intl.message(
      'CC',
      name: 'messages_cc',
      desc: '',
      args: [],
    );
  }

  /// `BCC`
  String get messages_bcc {
    return Intl.message(
      'BCC',
      name: 'messages_bcc',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get messages_subject {
    return Intl.message(
      'Subject',
      name: 'messages_subject',
      desc: '',
      args: [],
    );
  }

  /// `No subject`
  String get messages_no_subject {
    return Intl.message(
      'No subject',
      name: 'messages_no_subject',
      desc: '',
      args: [],
    );
  }

  /// `To me`
  String get messages_to_me {
    return Intl.message(
      'To me',
      name: 'messages_to_me',
      desc: '',
      args: [],
    );
  }

  /// `No recipients`
  String get messages_no_receivers {
    return Intl.message(
      'No recipients',
      name: 'messages_no_receivers',
      desc: '',
      args: [],
    );
  }

  /// `No sender`
  String get messages_unknown_sender {
    return Intl.message(
      'No sender',
      name: 'messages_unknown_sender',
      desc: '',
      args: [],
    );
  }

  /// `No recipient`
  String get messages_unknown_recipient {
    return Intl.message(
      'No recipient',
      name: 'messages_unknown_recipient',
      desc: '',
      args: [],
    );
  }

  /// `Sending message...`
  String get messages_sending {
    return Intl.message(
      'Sending message...',
      name: 'messages_sending',
      desc: '',
      args: [],
    );
  }

  /// `Message saved in drafts`
  String get messages_saved_in_drafts {
    return Intl.message(
      'Message saved in drafts',
      name: 'messages_saved_in_drafts',
      desc: '',
      args: [],
    );
  }

  /// `No attachments`
  String get messages_attachments_empty {
    return Intl.message(
      'No attachments',
      name: 'messages_attachments_empty',
      desc: '',
      args: [],
    );
  }

  /// `Delete attachment`
  String get messages_attachment_delete {
    return Intl.message(
      'Delete attachment',
      name: 'messages_attachment_delete',
      desc: '',
      args: [],
    );
  }

  /// `Download attachment`
  String get messages_attachment_download {
    return Intl.message(
      'Download attachment',
      name: 'messages_attachment_download',
      desc: '',
      args: [],
    );
  }

  /// `Downloading {fileName}...`
  String messages_attachment_downloading(Object fileName) {
    return Intl.message(
      'Downloading $fileName...',
      name: 'messages_attachment_downloading',
      desc: '',
      args: [fileName],
    );
  }

  /// `Download failed`
  String get messages_attachment_download_failed {
    return Intl.message(
      'Download failed',
      name: 'messages_attachment_download_failed',
      desc: '',
      args: [],
    );
  }

  /// `Cancel download`
  String get messages_attachment_download_cancel {
    return Intl.message(
      'Cancel download',
      name: 'messages_attachment_download_cancel',
      desc: '',
      args: [],
    );
  }

  /// `File downloaded into: {path}`
  String messages_attachment_download_success(Object path) {
    return Intl.message(
      'File downloaded into: $path',
      name: 'messages_attachment_download_success',
      desc: '',
      args: [path],
    );
  }

  /// `Upload attachment`
  String get messages_attachment_upload {
    return Intl.message(
      'Upload attachment',
      name: 'messages_attachment_upload',
      desc: '',
      args: [],
    );
  }

  /// `Uploading {fileName}...`
  String messages_attachment_uploading(Object fileName) {
    return Intl.message(
      'Uploading $fileName...',
      name: 'messages_attachment_uploading',
      desc: '',
      args: [fileName],
    );
  }

  /// `Upload failed`
  String get messages_attachment_upload_failed {
    return Intl.message(
      'Upload failed',
      name: 'messages_attachment_upload_failed',
      desc: '',
      args: [],
    );
  }

  /// `Cancel upload`
  String get messages_attachment_upload_cancel {
    return Intl.message(
      'Cancel upload',
      name: 'messages_attachment_upload_cancel',
      desc: '',
      args: [],
    );
  }

  /// `File uploaded into: {path}`
  String messages_attachment_upload_success(Object path) {
    return Intl.message(
      'File uploaded into: $path',
      name: 'messages_attachment_upload_success',
      desc: '',
      args: [path],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Message text...`
  String get compose_body_placeholder {
    return Intl.message(
      'Message text...',
      name: 'compose_body_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `---- Original Message ----`
  String get compose_forward_body_original_message {
    return Intl.message(
      '---- Original Message ----',
      name: 'compose_forward_body_original_message',
      desc: '',
      args: [],
    );
  }

  /// `From: {emails}`
  String compose_forward_from(Object emails) {
    return Intl.message(
      'From: $emails',
      name: 'compose_forward_from',
      desc: '',
      args: [emails],
    );
  }

  /// `To: {emails}`
  String compose_forward_to(Object emails) {
    return Intl.message(
      'To: $emails',
      name: 'compose_forward_to',
      desc: '',
      args: [emails],
    );
  }

  /// `CC: {emails}`
  String compose_forward_cc(Object emails) {
    return Intl.message(
      'CC: $emails',
      name: 'compose_forward_cc',
      desc: '',
      args: [emails],
    );
  }

  /// `BCC: {emails}`
  String compose_forward_bcc(Object emails) {
    return Intl.message(
      'BCC: $emails',
      name: 'compose_forward_bcc',
      desc: '',
      args: [emails],
    );
  }

  /// `Sent: {date}`
  String compose_forward_sent(Object date) {
    return Intl.message(
      'Sent: $date',
      name: 'compose_forward_sent',
      desc: '',
      args: [date],
    );
  }

  /// `Subject: {subject}`
  String compose_forward_subject(Object subject) {
    return Intl.message(
      'Subject: $subject',
      name: 'compose_forward_subject',
      desc: '',
      args: [subject],
    );
  }

  /// `On {time}, {from} wrote:`
  String compose_reply_body_title(Object time, Object from) {
    return Intl.message(
      'On $time, $from wrote:',
      name: 'compose_reply_body_title',
      desc: '',
      args: [time, from],
    );
  }

  /// `Discard changes`
  String get compose_discard_save_dialog_title {
    return Intl.message(
      'Discard changes',
      name: 'compose_discard_save_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Save changes in drafts?`
  String get compose_discard_save_dialog_description {
    return Intl.message(
      'Save changes in drafts?',
      name: 'compose_discard_save_dialog_description',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `View group`
  String get contacts_list_app_bar_view_group {
    return Intl.message(
      'View group',
      name: 'contacts_list_app_bar_view_group',
      desc: '',
      args: [],
    );
  }

  /// `All contacts`
  String get contacts_list_app_bar_all_contacts {
    return Intl.message(
      'All contacts',
      name: 'contacts_list_app_bar_all_contacts',
      desc: '',
      args: [],
    );
  }

  /// `It's me!`
  String get contacts_list_its_me_flag {
    return Intl.message(
      'It\'s me!',
      name: 'contacts_list_its_me_flag',
      desc: '',
      args: [],
    );
  }

  /// `No contacts`
  String get contacts_empty {
    return Intl.message(
      'No contacts',
      name: 'contacts_empty',
      desc: '',
      args: [],
    );
  }

  /// `No groups`
  String get contacts_groups_empty {
    return Intl.message(
      'No groups',
      name: 'contacts_groups_empty',
      desc: '',
      args: [],
    );
  }

  /// `No email address`
  String get contacts_email_empty {
    return Intl.message(
      'No email address',
      name: 'contacts_email_empty',
      desc: '',
      args: [],
    );
  }

  /// `Storages`
  String get contacts_drawer_section_storages {
    return Intl.message(
      'Storages',
      name: 'contacts_drawer_section_storages',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get contacts_drawer_storage_all {
    return Intl.message(
      'All',
      name: 'contacts_drawer_storage_all',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get contacts_drawer_storage_personal {
    return Intl.message(
      'Personal',
      name: 'contacts_drawer_storage_personal',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get contacts_drawer_storage_team {
    return Intl.message(
      'Team',
      name: 'contacts_drawer_storage_team',
      desc: '',
      args: [],
    );
  }

  /// `Shared with all`
  String get contacts_drawer_storage_shared {
    return Intl.message(
      'Shared with all',
      name: 'contacts_drawer_storage_shared',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get contacts_drawer_section_groups {
    return Intl.message(
      'Groups',
      name: 'contacts_drawer_section_groups',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get contacts_view_app_bar_share {
    return Intl.message(
      'Share',
      name: 'contacts_view_app_bar_share',
      desc: '',
      args: [],
    );
  }

  /// `Unshare`
  String get contacts_view_app_bar_unshare {
    return Intl.message(
      'Unshare',
      name: 'contacts_view_app_bar_unshare',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get contacts_view_app_bar_attach {
    return Intl.message(
      'Send',
      name: 'contacts_view_app_bar_attach',
      desc: '',
      args: [],
    );
  }

  /// `Email to this contact`
  String get contacts_view_app_bar_send_message {
    return Intl.message(
      'Email to this contact',
      name: 'contacts_view_app_bar_send_message',
      desc: '',
      args: [],
    );
  }

  /// `Search messages`
  String get contacts_view_app_bar_search_messages {
    return Intl.message(
      'Search messages',
      name: 'contacts_view_app_bar_search_messages',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get contacts_view_app_bar_edit_contact {
    return Intl.message(
      'Edit',
      name: 'contacts_view_app_bar_edit_contact',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get contacts_view_app_bar_delete_contact {
    return Intl.message(
      'Delete',
      name: 'contacts_view_app_bar_delete_contact',
      desc: '',
      args: [],
    );
  }

  /// `{contact} will soon appear in {storage} storage`
  String contacts_shared_message(Object contact, Object storage) {
    return Intl.message(
      '$contact will soon appear in $storage storage',
      name: 'contacts_shared_message',
      desc: '',
      args: [contact, storage],
    );
  }

  /// `Email to the contacts in this group`
  String get contacts_group_view_app_bar_send_message {
    return Intl.message(
      'Email to the contacts in this group',
      name: 'contacts_group_view_app_bar_send_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete this group`
  String get contacts_group_view_app_bar_delete {
    return Intl.message(
      'Delete this group',
      name: 'contacts_group_view_app_bar_delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit group`
  String get contacts_group_view_app_bar_edit {
    return Intl.message(
      'Edit group',
      name: 'contacts_group_view_app_bar_edit',
      desc: '',
      args: [],
    );
  }

  /// `Show additional fields`
  String get contacts_view_show_additional_fields {
    return Intl.message(
      'Show additional fields',
      name: 'contacts_view_show_additional_fields',
      desc: '',
      args: [],
    );
  }

  /// `Hide additional fields`
  String get contacts_view_hide_additional_fields {
    return Intl.message(
      'Hide additional fields',
      name: 'contacts_view_hide_additional_fields',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get contacts_view_section_home {
    return Intl.message(
      'Home',
      name: 'contacts_view_section_home',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get contacts_view_section_personal {
    return Intl.message(
      'Personal',
      name: 'contacts_view_section_personal',
      desc: '',
      args: [],
    );
  }

  /// `Business`
  String get contacts_view_section_business {
    return Intl.message(
      'Business',
      name: 'contacts_view_section_business',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get contacts_view_section_other_info {
    return Intl.message(
      'Other',
      name: 'contacts_view_section_other_info',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get contacts_view_section_group_name {
    return Intl.message(
      'Group Name',
      name: 'contacts_view_section_group_name',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get contacts_view_section_groups {
    return Intl.message(
      'Groups',
      name: 'contacts_view_section_groups',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get contacts_view_display_name {
    return Intl.message(
      'Display name',
      name: 'contacts_view_display_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get contacts_view_email {
    return Intl.message(
      'Email',
      name: 'contacts_view_email',
      desc: '',
      args: [],
    );
  }

  /// `Personal email`
  String get contacts_view_personal_email {
    return Intl.message(
      'Personal email',
      name: 'contacts_view_personal_email',
      desc: '',
      args: [],
    );
  }

  /// `Business email`
  String get contacts_view_business_email {
    return Intl.message(
      'Business email',
      name: 'contacts_view_business_email',
      desc: '',
      args: [],
    );
  }

  /// `Other email`
  String get contacts_view_other_email {
    return Intl.message(
      'Other email',
      name: 'contacts_view_other_email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get contacts_view_phone {
    return Intl.message(
      'Phone',
      name: 'contacts_view_phone',
      desc: '',
      args: [],
    );
  }

  /// `Personal Phone`
  String get contacts_view_personal_phone {
    return Intl.message(
      'Personal Phone',
      name: 'contacts_view_personal_phone',
      desc: '',
      args: [],
    );
  }

  /// `Business Phone`
  String get contacts_view_business_phone {
    return Intl.message(
      'Business Phone',
      name: 'contacts_view_business_phone',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get contacts_view_mobile {
    return Intl.message(
      'Mobile',
      name: 'contacts_view_mobile',
      desc: '',
      args: [],
    );
  }

  /// `Fax`
  String get contacts_view_fax {
    return Intl.message(
      'Fax',
      name: 'contacts_view_fax',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get contacts_view_address {
    return Intl.message(
      'Address',
      name: 'contacts_view_address',
      desc: '',
      args: [],
    );
  }

  /// `Personal Address`
  String get contacts_view_personal_address {
    return Intl.message(
      'Personal Address',
      name: 'contacts_view_personal_address',
      desc: '',
      args: [],
    );
  }

  /// `Business Address`
  String get contacts_view_business_address {
    return Intl.message(
      'Business Address',
      name: 'contacts_view_business_address',
      desc: '',
      args: [],
    );
  }

  /// `Skype`
  String get contacts_view_skype {
    return Intl.message(
      'Skype',
      name: 'contacts_view_skype',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get contacts_view_facebook {
    return Intl.message(
      'Facebook',
      name: 'contacts_view_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get contacts_view_name {
    return Intl.message(
      'Name',
      name: 'contacts_view_name',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get contacts_view_first_name {
    return Intl.message(
      'First name',
      name: 'contacts_view_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get contacts_view_last_name {
    return Intl.message(
      'Last name',
      name: 'contacts_view_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get contacts_view_nickname {
    return Intl.message(
      'Nickname',
      name: 'contacts_view_nickname',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get contacts_view_street_address {
    return Intl.message(
      'Street',
      name: 'contacts_view_street_address',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get contacts_view_city {
    return Intl.message(
      'City',
      name: 'contacts_view_city',
      desc: '',
      args: [],
    );
  }

  /// `State/Province`
  String get contacts_view_province {
    return Intl.message(
      'State/Province',
      name: 'contacts_view_province',
      desc: '',
      args: [],
    );
  }

  /// `Country/Region`
  String get contacts_view_country {
    return Intl.message(
      'Country/Region',
      name: 'contacts_view_country',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code`
  String get contacts_view_zip {
    return Intl.message(
      'Zip Code',
      name: 'contacts_view_zip',
      desc: '',
      args: [],
    );
  }

  /// `Web Page`
  String get contacts_view_web_page {
    return Intl.message(
      'Web Page',
      name: 'contacts_view_web_page',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get contacts_view_company {
    return Intl.message(
      'Company',
      name: 'contacts_view_company',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get contacts_view_department {
    return Intl.message(
      'Department',
      name: 'contacts_view_department',
      desc: '',
      args: [],
    );
  }

  /// `Job Title`
  String get contacts_view_job_title {
    return Intl.message(
      'Job Title',
      name: 'contacts_view_job_title',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get contacts_view_office {
    return Intl.message(
      'Office',
      name: 'contacts_view_office',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get contacts_view_birthday {
    return Intl.message(
      'Birthday',
      name: 'contacts_view_birthday',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get contacts_view_notes {
    return Intl.message(
      'Notes',
      name: 'contacts_view_notes',
      desc: '',
      args: [],
    );
  }

  /// `Edit contact`
  String get contacts_edit {
    return Intl.message(
      'Edit contact',
      name: 'contacts_edit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel editing contact`
  String get contacts_edit_cancel {
    return Intl.message(
      'Cancel editing contact',
      name: 'contacts_edit_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get contacts_edit_save {
    return Intl.message(
      'Save changes',
      name: 'contacts_edit_save',
      desc: '',
      args: [],
    );
  }

  /// `Save changes?`
  String get save_changes_question {
    return Intl.message(
      'Save changes?',
      name: 'save_changes_question',
      desc: '',
      args: [],
    );
  }

  /// `Add contact`
  String get contacts_add {
    return Intl.message(
      'Add contact',
      name: 'contacts_add',
      desc: '',
      args: [],
    );
  }

  /// `Add group`
  String get contacts_group_add {
    return Intl.message(
      'Add group',
      name: 'contacts_group_add',
      desc: '',
      args: [],
    );
  }

  /// `Add to group`
  String get contacts_group_add_to_group {
    return Intl.message(
      'Add to group',
      name: 'contacts_group_add_to_group',
      desc: '',
      args: [],
    );
  }

  /// `Edit group`
  String get contacts_group_edit {
    return Intl.message(
      'Edit group',
      name: 'contacts_group_edit',
      desc: '',
      args: [],
    );
  }

  /// `This group is a Company`
  String get contacts_group_edit_is_organization {
    return Intl.message(
      'This group is a Company',
      name: 'contacts_group_edit_is_organization',
      desc: '',
      args: [],
    );
  }

  /// `Cancel editing group`
  String get contacts_group_edit_cancel {
    return Intl.message(
      'Cancel editing group',
      name: 'contacts_group_edit_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete contact`
  String get contacts_delete_title {
    return Intl.message(
      'Delete contact',
      name: 'contacts_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `Remove contacts from group`
  String get contacts_remove_from_group {
    return Intl.message(
      'Remove contacts from group',
      name: 'contacts_remove_from_group',
      desc: '',
      args: [],
    );
  }

  /// `Delete contacts`
  String get contacts_delete_title_plural {
    return Intl.message(
      'Delete contacts',
      name: 'contacts_delete_title_plural',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete selected contacts?`
  String get contacts_delete_selected {
    return Intl.message(
      'Are you sure you want to delete selected contacts?',
      name: 'contacts_delete_selected',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove selected contacts from group?`
  String get contacts_remove_selected {
    return Intl.message(
      'Are you sure you want to remove selected contacts from group?',
      name: 'contacts_remove_selected',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {contact}?`
  String contacts_delete_desc_with_name(Object contact) {
    return Intl.message(
      'Are you sure you want to delete $contact?',
      name: 'contacts_delete_desc_with_name',
      desc: '',
      args: [contact],
    );
  }

  /// `Delete group`
  String get contacts_group_delete_title {
    return Intl.message(
      'Delete group',
      name: 'contacts_group_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {group}? The contacts of this group will not be deleted.`
  String contacts_group_delete_desc_with_name(Object group) {
    return Intl.message(
      'Are you sure you want to delete $group? The contacts of this group will not be deleted.',
      name: 'contacts_group_delete_desc_with_name',
      desc: '',
      args: [group],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Common`
  String get settings_common {
    return Intl.message(
      'Common',
      name: 'settings_common',
      desc: '',
      args: [],
    );
  }

  /// `24 hour format`
  String get settings_24_time_format {
    return Intl.message(
      '24 hour format',
      name: 'settings_24_time_format',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language {
    return Intl.message(
      'Language',
      name: 'settings_language',
      desc: '',
      args: [],
    );
  }

  /// `System language`
  String get settings_language_system {
    return Intl.message(
      'System language',
      name: 'settings_language_system',
      desc: '',
      args: [],
    );
  }

  /// `App theme`
  String get settings_dark_theme {
    return Intl.message(
      'App theme',
      name: 'settings_dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `System theme`
  String get settings_dark_theme_system {
    return Intl.message(
      'System theme',
      name: 'settings_dark_theme_system',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settings_dark_theme_dark {
    return Intl.message(
      'Dark',
      name: 'settings_dark_theme_dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settings_dark_theme_light {
    return Intl.message(
      'Light',
      name: 'settings_dark_theme_light',
      desc: '',
      args: [],
    );
  }

  /// `Sync`
  String get settings_sync {
    return Intl.message(
      'Sync',
      name: 'settings_sync',
      desc: '',
      args: [],
    );
  }

  /// `Sync frequency`
  String get settings_sync_frequency {
    return Intl.message(
      'Sync frequency',
      name: 'settings_sync_frequency',
      desc: '',
      args: [],
    );
  }

  /// `never`
  String get settings_sync_frequency_never {
    return Intl.message(
      'never',
      name: 'settings_sync_frequency_never',
      desc: '',
      args: [],
    );
  }

  /// `5 minutes`
  String get settings_sync_frequency_minutes5 {
    return Intl.message(
      '5 minutes',
      name: 'settings_sync_frequency_minutes5',
      desc: '',
      args: [],
    );
  }

  /// `30 minutes`
  String get settings_sync_frequency_minutes30 {
    return Intl.message(
      '30 minutes',
      name: 'settings_sync_frequency_minutes30',
      desc: '',
      args: [],
    );
  }

  /// `1 hour`
  String get settings_sync_frequency_hours1 {
    return Intl.message(
      '1 hour',
      name: 'settings_sync_frequency_hours1',
      desc: '',
      args: [],
    );
  }

  /// `2 hours`
  String get settings_sync_frequency_hours2 {
    return Intl.message(
      '2 hours',
      name: 'settings_sync_frequency_hours2',
      desc: '',
      args: [],
    );
  }

  /// `daily`
  String get settings_sync_frequency_daily {
    return Intl.message(
      'daily',
      name: 'settings_sync_frequency_daily',
      desc: '',
      args: [],
    );
  }

  /// `weekly`
  String get settings_sync_frequency_weekly {
    return Intl.message(
      'weekly',
      name: 'settings_sync_frequency_weekly',
      desc: '',
      args: [],
    );
  }

  /// `monthly`
  String get settings_sync_frequency_monthly {
    return Intl.message(
      'monthly',
      name: 'settings_sync_frequency_monthly',
      desc: '',
      args: [],
    );
  }

  /// `yearly`
  String get settings_sync_frequency_yearly {
    return Intl.message(
      'yearly',
      name: 'settings_sync_frequency_yearly',
      desc: '',
      args: [],
    );
  }

  /// `Sync period`
  String get settings_sync_period {
    return Intl.message(
      'Sync period',
      name: 'settings_sync_period',
      desc: '',
      args: [],
    );
  }

  /// `all time`
  String get settings_sync_period_all_time {
    return Intl.message(
      'all time',
      name: 'settings_sync_period_all_time',
      desc: '',
      args: [],
    );
  }

  /// `1 month`
  String get settings_sync_period_months1 {
    return Intl.message(
      '1 month',
      name: 'settings_sync_period_months1',
      desc: '',
      args: [],
    );
  }

  /// `3 months`
  String get settings_sync_period_months3 {
    return Intl.message(
      '3 months',
      name: 'settings_sync_period_months3',
      desc: '',
      args: [],
    );
  }

  /// `6 months`
  String get settings_sync_period_months6 {
    return Intl.message(
      '6 months',
      name: 'settings_sync_period_months6',
      desc: '',
      args: [],
    );
  }

  /// `1 year`
  String get settings_sync_period_years1 {
    return Intl.message(
      '1 year',
      name: 'settings_sync_period_years1',
      desc: '',
      args: [],
    );
  }

  /// `Manage accounts`
  String get settings_accounts_manage {
    return Intl.message(
      'Manage accounts',
      name: 'settings_accounts_manage',
      desc: '',
      args: [],
    );
  }

  /// `Add new account`
  String get settings_accounts_add {
    return Intl.message(
      'Add new account',
      name: 'settings_accounts_add',
      desc: '',
      args: [],
    );
  }

  /// `Relogin to account`
  String get settings_accounts_relogin {
    return Intl.message(
      'Relogin to account',
      name: 'settings_accounts_relogin',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get settings_accounts_delete {
    return Intl.message(
      'Delete account',
      name: 'settings_accounts_delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout and delete {account}?`
  String settings_accounts_delete_description(Object account) {
    return Intl.message(
      'Are you sure you want to logout and delete $account?',
      name: 'settings_accounts_delete_description',
      desc: '',
      args: [account],
    );
  }

  /// `About`
  String get settings_about {
    return Intl.message(
      'About',
      name: 'settings_about',
      desc: '',
      args: [],
    );
  }

  /// `Version {version}`
  String settings_about_app_version(Object version) {
    return Intl.message(
      'Version $version',
      name: 'settings_about_app_version',
      desc: '',
      args: [version],
    );
  }

  /// `Terms of Service`
  String get settings_about_terms_of_service {
    return Intl.message(
      'Terms of Service',
      name: 'settings_about_terms_of_service',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get settings_about_privacy_policy {
    return Intl.message(
      'Privacy policy',
      name: 'settings_about_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get btn_login {
    return Intl.message(
      'Login',
      name: 'btn_login',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get btn_delete {
    return Intl.message(
      'Delete',
      name: 'btn_delete',
      desc: '',
      args: [],
    );
  }

  /// `Show email in light theme`
  String get btn_show_email_in_light_theme {
    return Intl.message(
      'Show email in light theme',
      name: 'btn_show_email_in_light_theme',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get btn_cancel {
    return Intl.message(
      'Cancel',
      name: 'btn_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get btn_close {
    return Intl.message(
      'Close',
      name: 'btn_close',
      desc: '',
      args: [],
    );
  }

  /// `To spam`
  String get btn_to_spam {
    return Intl.message(
      'To spam',
      name: 'btn_to_spam',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get btn_save {
    return Intl.message(
      'Save',
      name: 'btn_save',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get btn_discard {
    return Intl.message(
      'Discard',
      name: 'btn_discard',
      desc: '',
      args: [],
    );
  }

  /// `Add account`
  String get btn_add_account {
    return Intl.message(
      'Add account',
      name: 'btn_add_account',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get btn_show_all {
    return Intl.message(
      'Show all',
      name: 'btn_show_all',
      desc: '',
      args: [],
    );
  }

  /// `Please enter hostname`
  String get error_login_input_hostname {
    return Intl.message(
      'Please enter hostname',
      name: 'error_login_input_hostname',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get error_login_input_email {
    return Intl.message(
      'Please enter email',
      name: 'error_login_input_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get error_login_input_password {
    return Intl.message(
      'Please enter password',
      name: 'error_login_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Could not detect domain from this email, please specify your server URL manually.`
  String get error_login_auto_discover {
    return Intl.message(
      'Could not detect domain from this email, please specify your server URL manually.',
      name: 'error_login_auto_discover',
      desc: '',
      args: [],
    );
  }

  /// `This user doesn't have mail accounts`
  String get error_login_no_accounts {
    return Intl.message(
      'This user doesn\'t have mail accounts',
      name: 'error_login_no_accounts',
      desc: '',
      args: [],
    );
  }

  /// `This account already exists in your accounts list.`
  String get error_login_account_exists {
    return Intl.message(
      'This account already exists in your accounts list.',
      name: 'error_login_account_exists',
      desc: '',
      args: [],
    );
  }

  /// `Please provide recipients`
  String get error_compose_no_receivers {
    return Intl.message(
      'Please provide recipients',
      name: 'error_compose_no_receivers',
      desc: '',
      args: [],
    );
  }

  /// `Please wait until attachments are uploaded`
  String get error_compose_wait_attachments {
    return Intl.message(
      'Please wait until attachments are uploaded',
      name: 'error_compose_wait_attachments',
      desc: '',
      args: [],
    );
  }

  /// `Please specify the name`
  String get error_contacts_save_name_empty {
    return Intl.message(
      'Please specify the name',
      name: 'error_contacts_save_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `Please specify an email`
  String get error_contacts_email_empty {
    return Intl.message(
      'Please specify an email',
      name: 'error_contacts_email_empty',
      desc: '',
      args: [],
    );
  }

  /// `Could not connect to the server`
  String get error_connection {
    return Intl.message(
      'Could not connect to the server',
      name: 'error_connection',
      desc: '',
      args: [],
    );
  }

  /// `You're offline`
  String get error_connection_offline {
    return Intl.message(
      'You\'re offline',
      name: 'error_connection_offline',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get error_input_validation_empty {
    return Intl.message(
      'This field is required',
      name: 'error_input_validation_empty',
      desc: '',
      args: [],
    );
  }

  /// `The email is not valid`
  String get error_input_validation_email {
    return Intl.message(
      'The email is not valid',
      name: 'error_input_validation_email',
      desc: '',
      args: [],
    );
  }

  /// `The name cannot contain "/\*?<>|:"`
  String get error_input_validation_name_illegal_symbol {
    return Intl.message(
      'The name cannot contain "/\\*?<>|:"',
      name: 'error_input_validation_name_illegal_symbol',
      desc: '',
      args: [],
    );
  }

  /// `This name already exists`
  String get error_input_validation_unique_name {
    return Intl.message(
      'This name already exists',
      name: 'error_input_validation_unique_name',
      desc: '',
      args: [],
    );
  }

  /// `Invalid token`
  String get error_server_invalid_token {
    return Intl.message(
      'Invalid token',
      name: 'error_server_invalid_token',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email/password`
  String get error_server_auth_error {
    return Intl.message(
      'Invalid email/password',
      name: 'error_server_auth_error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid input parameter`
  String get error_server_invalid_input_parameter {
    return Intl.message(
      'Invalid input parameter',
      name: 'error_server_invalid_input_parameter',
      desc: '',
      args: [],
    );
  }

  /// `Database error`
  String get error_server_data_base_error {
    return Intl.message(
      'Database error',
      name: 'error_server_data_base_error',
      desc: '',
      args: [],
    );
  }

  /// `License problem`
  String get error_server_license_problem {
    return Intl.message(
      'License problem',
      name: 'error_server_license_problem',
      desc: '',
      args: [],
    );
  }

  /// `Demo account`
  String get error_server_demo_account {
    return Intl.message(
      'Demo account',
      name: 'error_server_demo_account',
      desc: '',
      args: [],
    );
  }

  /// `Captcha error`
  String get error_server_captcha_error {
    return Intl.message(
      'Captcha error',
      name: 'error_server_captcha_error',
      desc: '',
      args: [],
    );
  }

  /// `Access denied`
  String get error_server_access_denied {
    return Intl.message(
      'Access denied',
      name: 'error_server_access_denied',
      desc: '',
      args: [],
    );
  }

  /// `Unknown email`
  String get error_server_unknown_email {
    return Intl.message(
      'Unknown email',
      name: 'error_server_unknown_email',
      desc: '',
      args: [],
    );
  }

  /// `User is not allowed`
  String get error_server_user_not_allowed {
    return Intl.message(
      'User is not allowed',
      name: 'error_server_user_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Such user already exists`
  String get error_server_user_already_exists {
    return Intl.message(
      'Such user already exists',
      name: 'error_server_user_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `System is not configured`
  String get error_server_system_not_configured {
    return Intl.message(
      'System is not configured',
      name: 'error_server_system_not_configured',
      desc: '',
      args: [],
    );
  }

  /// `Module not found`
  String get error_server_module_not_found {
    return Intl.message(
      'Module not found',
      name: 'error_server_module_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Method not found`
  String get error_server_method_not_found {
    return Intl.message(
      'Method not found',
      name: 'error_server_method_not_found',
      desc: '',
      args: [],
    );
  }

  /// `License limit`
  String get error_server_license_limit {
    return Intl.message(
      'License limit',
      name: 'error_server_license_limit',
      desc: '',
      args: [],
    );
  }

  /// `Cannot save settings`
  String get error_server_can_not_save_settings {
    return Intl.message(
      'Cannot save settings',
      name: 'error_server_can_not_save_settings',
      desc: '',
      args: [],
    );
  }

  /// `Cannot change password`
  String get error_server_can_not_change_password {
    return Intl.message(
      'Cannot change password',
      name: 'error_server_can_not_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Account's old password is not correct`
  String get error_server_account_old_password_not_correct {
    return Intl.message(
      'Account\'s old password is not correct',
      name: 'error_server_account_old_password_not_correct',
      desc: '',
      args: [],
    );
  }

  /// `Cannot create contact`
  String get error_server_can_not_create_contact {
    return Intl.message(
      'Cannot create contact',
      name: 'error_server_can_not_create_contact',
      desc: '',
      args: [],
    );
  }

  /// `Cannot create group`
  String get error_server_can_not_create_group {
    return Intl.message(
      'Cannot create group',
      name: 'error_server_can_not_create_group',
      desc: '',
      args: [],
    );
  }

  /// `Cannot update contact`
  String get error_server_can_not_update_contact {
    return Intl.message(
      'Cannot update contact',
      name: 'error_server_can_not_update_contact',
      desc: '',
      args: [],
    );
  }

  /// `Cannot update group`
  String get error_server_can_not_update_group {
    return Intl.message(
      'Cannot update group',
      name: 'error_server_can_not_update_group',
      desc: '',
      args: [],
    );
  }

  /// `Contact data has been modified by another application`
  String
      get error_server_contact_data_has_been_modified_by_another_application {
    return Intl.message(
      'Contact data has been modified by another application',
      name:
          'error_server_contact_data_has_been_modified_by_another_application',
      desc: '',
      args: [],
    );
  }

  /// `Cannot get contact`
  String get error_server_can_not_get_contact {
    return Intl.message(
      'Cannot get contact',
      name: 'error_server_can_not_get_contact',
      desc: '',
      args: [],
    );
  }

  /// `Cannot create account`
  String get error_server_can_not_create_account {
    return Intl.message(
      'Cannot create account',
      name: 'error_server_can_not_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Such account already exists`
  String get error_server_account_exists {
    return Intl.message(
      'Such account already exists',
      name: 'error_server_account_exists',
      desc: '',
      args: [],
    );
  }

  /// `Rest other error`
  String get error_server_rest_other_error {
    return Intl.message(
      'Rest other error',
      name: 'error_server_rest_other_error',
      desc: '',
      args: [],
    );
  }

  /// `Rest api disabled`
  String get error_server_rest_api_disabled {
    return Intl.message(
      'Rest api disabled',
      name: 'error_server_rest_api_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Rest unknown method`
  String get error_server_rest_unknown_method {
    return Intl.message(
      'Rest unknown method',
      name: 'error_server_rest_unknown_method',
      desc: '',
      args: [],
    );
  }

  /// `Rest invalid parameters`
  String get error_server_rest_invalid_parameters {
    return Intl.message(
      'Rest invalid parameters',
      name: 'error_server_rest_invalid_parameters',
      desc: '',
      args: [],
    );
  }

  /// `Rest invalid credentials`
  String get error_server_rest_invalid_credentials {
    return Intl.message(
      'Rest invalid credentials',
      name: 'error_server_rest_invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Rest invalid token`
  String get error_server_rest_invalid_token {
    return Intl.message(
      'Rest invalid token',
      name: 'error_server_rest_invalid_token',
      desc: '',
      args: [],
    );
  }

  /// `Rest token expired`
  String get error_server_rest_token_expired {
    return Intl.message(
      'Rest token expired',
      name: 'error_server_rest_token_expired',
      desc: '',
      args: [],
    );
  }

  /// `Rest account lookup failed`
  String get error_server_rest_account_find_failed {
    return Intl.message(
      'Rest account lookup failed',
      name: 'error_server_rest_account_find_failed',
      desc: '',
      args: [],
    );
  }

  /// `Rest tenant lookup failed`
  String get error_server_rest_tenant_find_failed {
    return Intl.message(
      'Rest tenant lookup failed',
      name: 'error_server_rest_tenant_find_failed',
      desc: '',
      args: [],
    );
  }

  /// `Calendars not allowed`
  String get error_server_calendars_not_allowed {
    return Intl.message(
      'Calendars not allowed',
      name: 'error_server_calendars_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Files not allowed`
  String get error_server_files_not_allowed {
    return Intl.message(
      'Files not allowed',
      name: 'error_server_files_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Contacts not allowed`
  String get error_server_contacts_not_allowed {
    return Intl.message(
      'Contacts not allowed',
      name: 'error_server_contacts_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Helpdesk user already exists`
  String get error_server_helpdesk_user_already_exists {
    return Intl.message(
      'Helpdesk user already exists',
      name: 'error_server_helpdesk_user_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Helpdesk system user already exists`
  String get error_server_helpdesk_system_user_exists {
    return Intl.message(
      'Helpdesk system user already exists',
      name: 'error_server_helpdesk_system_user_exists',
      desc: '',
      args: [],
    );
  }

  /// `Cannot create helpdesk user`
  String get error_server_can_not_create_helpdesk_user {
    return Intl.message(
      'Cannot create helpdesk user',
      name: 'error_server_can_not_create_helpdesk_user',
      desc: '',
      args: [],
    );
  }

  /// `Helpdesk unknown user`
  String get error_server_helpdesk_unknown_user {
    return Intl.message(
      'Helpdesk unknown user',
      name: 'error_server_helpdesk_unknown_user',
      desc: '',
      args: [],
    );
  }

  /// `Helpdesk deactivated user`
  String get error_server_helpdesk_unactivated_user {
    return Intl.message(
      'Helpdesk deactivated user',
      name: 'error_server_helpdesk_unactivated_user',
      desc: '',
      args: [],
    );
  }

  /// `Voice not allowed`
  String get error_server_voice_not_allowed {
    return Intl.message(
      'Voice not allowed',
      name: 'error_server_voice_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect file extension`
  String get error_server_incorrect_file_extension {
    return Intl.message(
      'Incorrect file extension',
      name: 'error_server_incorrect_file_extension',
      desc: '',
      args: [],
    );
  }

  /// `You have reached your cloud storage space limit. Can't upload file.`
  String get error_server_can_not_upload_file_quota {
    return Intl.message(
      'You have reached your cloud storage space limit. Can\'t upload file.',
      name: 'error_server_can_not_upload_file_quota',
      desc: '',
      args: [],
    );
  }

  /// `Such file already exists`
  String get error_server_file_already_exists {
    return Intl.message(
      'Such file already exists',
      name: 'error_server_file_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `File not found`
  String get error_server_file_not_found {
    return Intl.message(
      'File not found',
      name: 'error_server_file_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Cannot upload due to file limit`
  String get error_server_can_not_upload_file_limit {
    return Intl.message(
      'Cannot upload due to file limit',
      name: 'error_server_can_not_upload_file_limit',
      desc: '',
      args: [],
    );
  }

  /// `Mail server error`
  String get error_server_mail_server_error {
    return Intl.message(
      'Mail server error',
      name: 'error_server_mail_server_error',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get error_unknown {
    return Intl.message(
      'Unknown error',
      name: 'error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `EEE, MMM d, yyyy, HH:mm`
  String get format_compose_forward_date {
    return Intl.message(
      'EEE, MMM d, yyyy, HH:mm',
      name: 'format_compose_forward_date',
      desc: '',
      args: [],
    );
  }

  /// `EEE, MMM d, yyyy 'at' HH:mm`
  String get format_compose_reply_date {
    return Intl.message(
      'EEE, MMM d, yyyy \'at\' HH:mm',
      name: 'format_compose_reply_date',
      desc: '',
      args: [],
    );
  }

  /// `MMM d, yyyy`
  String get format_contacts_birth_date {
    return Intl.message(
      'MMM d, yyyy',
      name: 'format_contacts_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get label_message_yesterday {
    return Intl.message(
      'Yesterday',
      name: 'label_message_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Your account is protected with\nTwo Factor Authentication.\nPlease provide the PIN code.`
  String get hint_2fa {
    return Intl.message(
      'Your account is protected with\nTwo Factor Authentication.\nPlease provide the PIN code.',
      name: 'hint_2fa',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get input_2fa_pin {
    return Intl.message(
      'Verification code',
      name: 'input_2fa_pin',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get btn_verify_pin {
    return Intl.message(
      'Verify',
      name: 'btn_verify_pin',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get error_invalid_pin {
    return Intl.message(
      'Invalid code',
      name: 'error_invalid_pin',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get btn_done {
    return Intl.message(
      'Done',
      name: 'btn_done',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to exit?`
  String get hint_confirm_exit {
    return Intl.message(
      'Are you sure want to exit?',
      name: 'hint_confirm_exit',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get btn_exit {
    return Intl.message(
      'Exit',
      name: 'btn_exit',
      desc: '',
      args: [],
    );
  }

  /// `OpenPGP`
  String get label_pgp_settings {
    return Intl.message(
      'OpenPGP',
      name: 'label_pgp_settings',
      desc: '',
      args: [],
    );
  }

  /// `Public keys`
  String get label_pgp_public_keys {
    return Intl.message(
      'Public keys',
      name: 'label_pgp_public_keys',
      desc: '',
      args: [],
    );
  }

  /// `Private keys`
  String get label_pgp_private_keys {
    return Intl.message(
      'Private keys',
      name: 'label_pgp_private_keys',
      desc: '',
      args: [],
    );
  }

  /// `Export all public keys`
  String get btn_pgp_export_all_public_keys {
    return Intl.message(
      'Export all public keys',
      name: 'btn_pgp_export_all_public_keys',
      desc: '',
      args: [],
    );
  }

  /// `Import keys from text`
  String get btn_pgp_import_keys_from_text {
    return Intl.message(
      'Import keys from text',
      name: 'btn_pgp_import_keys_from_text',
      desc: '',
      args: [],
    );
  }

  /// `Import keys from file`
  String get btn_pgp_import_keys_from_file {
    return Intl.message(
      'Import keys from file',
      name: 'btn_pgp_import_keys_from_file',
      desc: '',
      args: [],
    );
  }

  /// `Import from text`
  String get btn_pgp_import_from_text {
    return Intl.message(
      'Import from text',
      name: 'btn_pgp_import_from_text',
      desc: '',
      args: [],
    );
  }

  /// `Import from file`
  String get btn_pgp_import_from_file {
    return Intl.message(
      'Import from file',
      name: 'btn_pgp_import_from_file',
      desc: '',
      args: [],
    );
  }

  /// `Generate keys`
  String get btn_pgp_generate_keys {
    return Intl.message(
      'Generate keys',
      name: 'btn_pgp_generate_keys',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get btn_pgp_generate {
    return Intl.message(
      'Generate',
      name: 'btn_pgp_generate',
      desc: '',
      args: [],
    );
  }

  /// `Length`
  String get label_length {
    return Intl.message(
      'Length',
      name: 'label_length',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get btn_download {
    return Intl.message(
      'Download',
      name: 'btn_download',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get btn_share {
    return Intl.message(
      'Share',
      name: 'btn_share',
      desc: '',
      args: [],
    );
  }

  /// `Public key`
  String get label_pgp_public_key {
    return Intl.message(
      'Public key',
      name: 'label_pgp_public_key',
      desc: '',
      args: [],
    );
  }

  /// `Private key`
  String get label_pgp_private_key {
    return Intl.message(
      'Private key',
      name: 'label_pgp_private_key',
      desc: '',
      args: [],
    );
  }

  /// `Import keys`
  String get label_pgp_import_key {
    return Intl.message(
      'Import keys',
      name: 'label_pgp_import_key',
      desc: '',
      args: [],
    );
  }

  /// `Import selected keys`
  String get btn_pgp_import_selected_key {
    return Intl.message(
      'Import selected keys',
      name: 'btn_pgp_import_selected_key',
      desc: '',
      args: [],
    );
  }

  /// `Check keys`
  String get btn_pgp_check_keys {
    return Intl.message(
      'Check keys',
      name: 'btn_pgp_check_keys',
      desc: '',
      args: [],
    );
  }

  /// `Keys not found`
  String get error_pgp_keys_not_found {
    return Intl.message(
      'Keys not found',
      name: 'error_pgp_keys_not_found',
      desc: '',
      args: [],
    );
  }

  /// `All public keys`
  String get label_pgp_all_public_key {
    return Intl.message(
      'All public keys',
      name: 'label_pgp_all_public_key',
      desc: '',
      args: [],
    );
  }

  /// `Download all`
  String get btn_pgp_download_all {
    return Intl.message(
      'Download all',
      name: 'btn_pgp_download_all',
      desc: '',
      args: [],
    );
  }

  /// `Send all`
  String get btn_php_send_all {
    return Intl.message(
      'Send all',
      name: 'btn_php_send_all',
      desc: '',
      args: [],
    );
  }

  /// `Downloading to {path}`
  String label_pgp_downloading_to(Object path) {
    return Intl.message(
      'Downloading to $path',
      name: 'label_pgp_downloading_to',
      desc: '',
      args: [path],
    );
  }

  /// `Are you sure you want to delete OpenPGP key for {user}?`
  String hint_pgp_delete_user_key_confirm(Object user) {
    return Intl.message(
      'Are you sure you want to delete OpenPGP key for $user?',
      name: 'hint_pgp_delete_user_key_confirm',
      desc: '',
      args: [user],
    );
  }

  /// `Sign/Encrypt`
  String get btn_pgp_sign_or_encrypt {
    return Intl.message(
      'Sign/Encrypt',
      name: 'btn_pgp_sign_or_encrypt',
      desc: '',
      args: [],
    );
  }

  /// `Open PGP Sign/Encrypt`
  String get label_pgp_sign_or_encrypt {
    return Intl.message(
      'Open PGP Sign/Encrypt',
      name: 'label_pgp_sign_or_encrypt',
      desc: '',
      args: [],
    );
  }

  /// `Open PGP Decrypt`
  String get label_pgp_decrypt {
    return Intl.message(
      'Open PGP Decrypt',
      name: 'label_pgp_decrypt',
      desc: '',
      args: [],
    );
  }

  /// `Sign`
  String get label_pgp_sign {
    return Intl.message(
      'Sign',
      name: 'label_pgp_sign',
      desc: '',
      args: [],
    );
  }

  /// `Encrypt`
  String get btn_pgp_encrypt {
    return Intl.message(
      'Encrypt',
      name: 'btn_pgp_encrypt',
      desc: '',
      args: [],
    );
  }

  /// `Decrypt`
  String get btn_pgp_decrypt {
    return Intl.message(
      'Decrypt',
      name: 'btn_pgp_decrypt',
      desc: '',
      args: [],
    );
  }

  /// `invalid password`
  String get error_pgp_invalid_password {
    return Intl.message(
      'invalid password',
      name: 'error_pgp_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `No private key found for {users} user.`
  String error_pgp_not_found_keys_for(Object users) {
    return Intl.message(
      'No private key found for $users user.',
      name: 'error_pgp_not_found_keys_for',
      desc: '',
      args: [users],
    );
  }

  /// `Undo PGP`
  String get btn_pgp_undo_pgp {
    return Intl.message(
      'Undo PGP',
      name: 'btn_pgp_undo_pgp',
      desc: '',
      args: [],
    );
  }

  /// `Message was successfully verified.`
  String get label_pgp_verified {
    return Intl.message(
      'Message was successfully verified.',
      name: 'label_pgp_verified',
      desc: '',
      args: [],
    );
  }

  /// `Message wasn't verified.`
  String get label_pgp_not_verified {
    return Intl.message(
      'Message wasn\'t verified.',
      name: 'label_pgp_not_verified',
      desc: '',
      args: [],
    );
  }

  /// `Message was successfully decrypted and verified.`
  String get label_pgp_decrypted_and_verified {
    return Intl.message(
      'Message was successfully decrypted and verified.',
      name: 'label_pgp_decrypted_and_verified',
      desc: '',
      args: [],
    );
  }

  /// `Message was successfully decrypted but wasn't verified.`
  String get label_pgp_decrypted_but_not_verified {
    return Intl.message(
      'Message was successfully decrypted but wasn\'t verified.',
      name: 'label_pgp_decrypted_but_not_verified',
      desc: '',
      args: [],
    );
  }

  /// `Invalid key or password.`
  String get error_pgp_invalid_key_or_password {
    return Intl.message(
      'Invalid key or password.',
      name: 'error_pgp_invalid_key_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Cannot decrypt message.`
  String get error_pgp_can_not_decrypt {
    return Intl.message(
      'Cannot decrypt message.',
      name: 'error_pgp_can_not_decrypt',
      desc: '',
      args: [],
    );
  }

  /// `To encrypt your message you need to specify at least one recipient.`
  String get error_pgp_need_contact_for_encrypt {
    return Intl.message(
      'To encrypt your message you need to specify at least one recipient.',
      name: 'error_pgp_need_contact_for_encrypt',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get button_pgp_verify_sign {
    return Intl.message(
      'Verify',
      name: 'button_pgp_verify_sign',
      desc: '',
      args: [],
    );
  }

  /// `Keys which are already in the system are greyed out.`
  String get hint_pgp_already_have_keys {
    return Intl.message(
      'Keys which are already in the system are greyed out.',
      name: 'hint_pgp_already_have_keys',
      desc: '',
      args: [],
    );
  }

  /// `Find in email`
  String get btn_contact_find_in_email {
    return Intl.message(
      'Find in email',
      name: 'btn_contact_find_in_email',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get btn_message_resend {
    return Intl.message(
      'Resend',
      name: 'btn_message_resend',
      desc: '',
      args: [],
    );
  }

  /// `Empty Trash`
  String get btn_message_empty_trash_folder {
    return Intl.message(
      'Empty Trash',
      name: 'btn_message_empty_trash_folder',
      desc: '',
      args: [],
    );
  }

  /// `Empty Spam`
  String get btn_message_empty_spam_folder {
    return Intl.message(
      'Empty Spam',
      name: 'btn_message_empty_spam_folder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all messages in folder {folder}?`
  String hint_message_empty_folder(Object folder) {
    return Intl.message(
      'Are you sure you want to delete all messages in folder $folder?',
      name: 'hint_message_empty_folder',
      desc: '',
      args: [folder],
    );
  }

  /// `Send a self-destructing secure email`
  String get label_self_destructing {
    return Intl.message(
      'Send a self-destructing secure email',
      name: 'label_self_destructing',
      desc: '',
      args: [],
    );
  }

  /// `24 hours`
  String get self_destructing_life_time_day {
    return Intl.message(
      '24 hours',
      name: 'self_destructing_life_time_day',
      desc: '',
      args: [],
    );
  }

  /// `72 hours`
  String get self_destructing_life_time_days_3 {
    return Intl.message(
      '72 hours',
      name: 'self_destructing_life_time_days_3',
      desc: '',
      args: [],
    );
  }

  /// `7 days`
  String get self_destructing_life_time_days_7 {
    return Intl.message(
      '7 days',
      name: 'self_destructing_life_time_days_7',
      desc: '',
      args: [],
    );
  }

  /// `Message lifetime`
  String get message_lifetime {
    return Intl.message(
      'Message lifetime',
      name: 'message_lifetime',
      desc: '',
      args: [],
    );
  }

  /// `No name`
  String get label_pgp_key_with_not_name {
    return Intl.message(
      'No name',
      name: 'label_pgp_key_with_not_name',
      desc: '',
      args: [],
    );
  }

  /// `Will not sign the data.`
  String get label_self_destructing_not_sign_data {
    return Intl.message(
      'Will not sign the data.',
      name: 'label_self_destructing_not_sign_data',
      desc: '',
      args: [],
    );
  }

  /// `Will sign the data with your private key.`
  String get label_self_destructing_sign_data {
    return Intl.message(
      'Will sign the data with your private key.',
      name: 'label_self_destructing_sign_data',
      desc: '',
      args: [],
    );
  }

  /// `Password-based`
  String get input_self_destructing_password_based_encryption {
    return Intl.message(
      'Password-based',
      name: 'input_self_destructing_password_based_encryption',
      desc: '',
      args: [],
    );
  }

  /// `Key-based`
  String get input_self_destructing_key_based_encryption {
    return Intl.message(
      'Key-based',
      name: 'input_self_destructing_key_based_encryption',
      desc: '',
      args: [],
    );
  }

  /// `The Password-based encryption will be used.`
  String get label_self_destructing_password_based_encryption_used {
    return Intl.message(
      'The Password-based encryption will be used.',
      name: 'label_self_destructing_password_based_encryption_used',
      desc: '',
      args: [],
    );
  }

  /// `The Key-based encryption will be used.`
  String get label_self_destructing_key_based_encryption_used {
    return Intl.message(
      'The Key-based encryption will be used.',
      name: 'label_self_destructing_key_based_encryption_used',
      desc: '',
      args: [],
    );
  }

  /// `Selected recipient has PGP public key. The message can be encrypted using this key.`
  String get hint_self_destructing_encrypt_with_key {
    return Intl.message(
      'Selected recipient has PGP public key. The message can be encrypted using this key.',
      name: 'hint_self_destructing_encrypt_with_key',
      desc: '',
      args: [],
    );
  }

  /// `Selected recipient has no PGP public key. The key-based encryption is not allowed`
  String get hint_self_destructing_encrypt_with_not_key {
    return Intl.message(
      'Selected recipient has no PGP public key. The key-based encryption is not allowed',
      name: 'hint_self_destructing_encrypt_with_not_key',
      desc: '',
      args: [],
    );
  }

  /// `Add digital signature`
  String get input_self_destructing_add_digital_signature {
    return Intl.message(
      'Add digital signature',
      name: 'input_self_destructing_add_digital_signature',
      desc: '',
      args: [],
    );
  }

  /// `Select recipient`
  String get error_pgp_select_recipient {
    return Intl.message(
      'Select recipient',
      name: 'error_pgp_select_recipient',
      desc: '',
      args: [],
    );
  }

  /// `Hello,\n{sender} user sent you a self-destructing secure email.\nYou can read it using the following link:\n{link}\n{message_password}The message will be accessible for {lifeTime} starting from {now}`
  String template_self_destructing_message(Object sender, Object link,
      Object message_password, Object lifeTime, Object now) {
    return Intl.message(
      'Hello,\n$sender user sent you a self-destructing secure email.\nYou can read it using the following link:\n$link\n${message_password}The message will be accessible for $lifeTime starting from $now',
      name: 'template_self_destructing_message',
      desc: '',
      args: [sender, link, message_password, lifeTime, now],
    );
  }

  /// `The message is password-protected. The password is: {password}\n`
  String template_self_destructing_message_password(Object password) {
    return Intl.message(
      'The message is password-protected. The password is: $password\n',
      name: 'template_self_destructing_message_password',
      desc: '',
      args: [password],
    );
  }

  /// `The secure message was shared with you`
  String get template_self_destructing_message_title {
    return Intl.message(
      'The secure message was shared with you',
      name: 'template_self_destructing_message_title',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get btn_ok {
    return Intl.message(
      'Ok',
      name: 'btn_ok',
      desc: '',
      args: [],
    );
  }

  /// `The self-descructing secure emails support plain text only. All the formatting will be removed. Also, attachments cannot be encrypted and will be removed from the message.`
  String get hint_self_destructing_supports_plain_text_only {
    return Intl.message(
      'The self-descructing secure emails support plain text only. All the formatting will be removed. Also, attachments cannot be encrypted and will be removed from the message.',
      name: 'hint_self_destructing_supports_plain_text_only',
      desc: '',
      args: [],
    );
  }

  /// `The password must be sent using a different channel.\n  Store the password somewhere. You will not be able to recover it otherwise.`
  String get hint_self_destructing_sent_password_using_different_channel {
    return Intl.message(
      'The password must be sent using a different channel.\n  Store the password somewhere. You will not be able to recover it otherwise.',
      name: 'hint_self_destructing_sent_password_using_different_channel',
      desc: '',
      args: [],
    );
  }

  /// `Self-destructing`
  String get btn_self_destructing {
    return Intl.message(
      'Self-destructing',
      name: 'btn_self_destructing',
      desc: '',
      args: [],
    );
  }

  /// `Password coppied to clipboard`
  String get hint_self_destructing_password_coppied_to_clipboard {
    return Intl.message(
      'Password coppied to clipboard',
      name: 'hint_self_destructing_password_coppied_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Mobile apps are not allowed in your account.`
  String get hint_login_upgrade_your_plan {
    return Intl.message(
      'Mobile apps are not allowed in your account.',
      name: 'hint_login_upgrade_your_plan',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get btn_login_back_to_login {
    return Intl.message(
      'Back to login',
      name: 'btn_login_back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `The PGP key will not be valid`
  String get error_contact_pgp_key_will_not_be_valid {
    return Intl.message(
      'The PGP key will not be valid',
      name: 'error_contact_pgp_key_will_not_be_valid',
      desc: '',
      args: [],
    );
  }

  /// `Re import`
  String get btn_contact_key_re_import {
    return Intl.message(
      'Re import',
      name: 'btn_contact_key_re_import',
      desc: '',
      args: [],
    );
  }

  /// `Delete Key`
  String get btn_contact_delete_key {
    return Intl.message(
      'Delete Key',
      name: 'btn_contact_delete_key',
      desc: '',
      args: [],
    );
  }

  /// `Select key`
  String get label_contact_select_key {
    return Intl.message(
      'Select key',
      name: 'label_contact_select_key',
      desc: '',
      args: [],
    );
  }

  /// `The keys will be imported to contacts`
  String get hint_pgp_keys_will_be_import_to_contacts {
    return Intl.message(
      'The keys will be imported to contacts',
      name: 'hint_pgp_keys_will_be_import_to_contacts',
      desc: '',
      args: [],
    );
  }

  /// `For these keys contacts will be created`
  String get hint_pgp_keys_contacts_will_be_created {
    return Intl.message(
      'For these keys contacts will be created',
      name: 'hint_pgp_keys_contacts_will_be_created',
      desc: '',
      args: [],
    );
  }

  /// `Your keys`
  String get hint_pgp_your_keys {
    return Intl.message(
      'Your keys',
      name: 'hint_pgp_your_keys',
      desc: '',
      args: [],
    );
  }

  /// `External public keys`
  String get label_pgp_contact_public_keys {
    return Intl.message(
      'External public keys',
      name: 'label_pgp_contact_public_keys',
      desc: '',
      args: [],
    );
  }

  /// `Move to: `
  String get label_message_move_to {
    return Intl.message(
      'Move to: ',
      name: 'label_message_move_to',
      desc: '',
      args: [],
    );
  }

  /// `Move`
  String get btn_message_move {
    return Intl.message(
      'Move',
      name: 'btn_message_move',
      desc: '',
      args: [],
    );
  }

  /// `Move to folder`
  String get label_message_move_to_folder {
    return Intl.message(
      'Move to folder',
      name: 'label_message_move_to_folder',
      desc: '',
      args: [],
    );
  }

  /// `Advanced search`
  String get btn_message_advanced_search {
    return Intl.message(
      'Advanced search',
      name: 'btn_message_advanced_search',
      desc: '',
      args: [],
    );
  }

  /// `Advanced search`
  String get label_message_advanced_search {
    return Intl.message(
      'Advanced search',
      name: 'label_message_advanced_search',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get input_message_search_text {
    return Intl.message(
      'Text',
      name: 'input_message_search_text',
      desc: '',
      args: [],
    );
  }

  /// `Since`
  String get input_message_search_since {
    return Intl.message(
      'Since',
      name: 'input_message_search_since',
      desc: '',
      args: [],
    );
  }

  /// `Till`
  String get input_message_search_till {
    return Intl.message(
      'Till',
      name: 'input_message_search_till',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get label_pgp_share_warning {
    return Intl.message(
      'Warning',
      name: 'label_pgp_share_warning',
      desc: '',
      args: [],
    );
  }

  /// `You are going to share your private PGP key. The key must be kept from the 3rd parties. Do you want to continue?`
  String get hint_pgp_share_warning {
    return Intl.message(
      'You are going to share your private PGP key. The key must be kept from the 3rd parties. Do you want to continue?',
      name: 'hint_pgp_share_warning',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get btn_vcf_import {
    return Intl.message(
      'Import',
      name: 'btn_vcf_import',
      desc: '',
      args: [],
    );
  }

  /// `Import contact from vcf?`
  String get hint_vcf_import {
    return Intl.message(
      'Import contact from vcf?',
      name: 'hint_vcf_import',
      desc: '',
      args: [],
    );
  }

  /// `View message headers`
  String get label_message_headers {
    return Intl.message(
      'View message headers',
      name: 'label_message_headers',
      desc: '',
      args: [],
    );
  }

  /// `Forward as attachment`
  String get label_forward_as_attachment {
    return Intl.message(
      'Forward as attachment',
      name: 'label_forward_as_attachment',
      desc: '',
      args: [],
    );
  }

  /// `No name`
  String get label_contact_with_not_name {
    return Intl.message(
      'No name',
      name: 'label_contact_with_not_name',
      desc: '',
      args: [],
    );
  }

  /// `This user is already logged in`
  String get error_user_already_logged {
    return Intl.message(
      'This user is already logged in',
      name: 'error_user_already_logged',
      desc: '',
      args: [],
    );
  }

  /// `Unread`
  String get btn_unread {
    return Intl.message(
      'Unread',
      name: 'btn_unread',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get btn_read {
    return Intl.message(
      'Read',
      name: 'btn_read',
      desc: '',
      args: [],
    );
  }

  /// `Show details`
  String get btn_show_details {
    return Intl.message(
      'Show details',
      name: 'btn_show_details',
      desc: '',
      args: [],
    );
  }

  /// `Hide details`
  String get btn_hide_details {
    return Intl.message(
      'Hide details',
      name: 'btn_hide_details',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get label_notifications_settings {
    return Intl.message(
      'Notifications',
      name: 'label_notifications_settings',
      desc: '',
      args: [],
    );
  }

  /// `Device identifier`
  String get label_device_identifier {
    return Intl.message(
      'Device identifier',
      name: 'label_device_identifier',
      desc: '',
      args: [],
    );
  }

  /// `Token storing status`
  String get label_token_storing_status {
    return Intl.message(
      'Token storing status',
      name: 'label_token_storing_status',
      desc: '',
      args: [],
    );
  }

  /// `Resend Push Token`
  String get btn_resend_push_token {
    return Intl.message(
      'Resend Push Token',
      name: 'btn_resend_push_token',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get label_token_successful {
    return Intl.message(
      'Successful',
      name: 'label_token_successful',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get label_token_failed {
    return Intl.message(
      'Failed',
      name: 'label_token_failed',
      desc: '',
      args: [],
    );
  }

  /// `Device id copied to clipboard`
  String get label_device_id_copied_to_clip_board {
    return Intl.message(
      'Device id copied to clipboard',
      name: 'label_device_id_copied_to_clip_board',
      desc: '',
      args: [],
    );
  }

  /// `Discard unsaved changes?`
  String get label_discard_not_saved_changes {
    return Intl.message(
      'Discard unsaved changes?',
      name: 'label_discard_not_saved_changes',
      desc: '',
      args: [],
    );
  }

  /// `Contacts imported successfully`
  String get label_contacts_were_imported_successfully {
    return Intl.message(
      'Contacts imported successfully',
      name: 'label_contacts_were_imported_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Encrypt`
  String get label_pgp_encrypt {
    return Intl.message(
      'Encrypt',
      name: 'label_pgp_encrypt',
      desc: '',
      args: [],
    );
  }

  /// `If you want messages to this contact to be automatically encrypted and/or signed, check the boxes below. Please note that these messages will be converted to plain text. Attachments will not be encrypted.`
  String get hint_auto_encrypt_messages {
    return Intl.message(
      'If you want messages to this contact to be automatically encrypted and/or signed, check the boxes below. Please note that these messages will be converted to plain text. Attachments will not be encrypted.',
      name: 'hint_auto_encrypt_messages',
      desc: '',
      args: [],
    );
  }

  /// `Delete all`
  String get btn_log_delete_all {
    return Intl.message(
      'Delete all',
      name: 'btn_log_delete_all',
      desc: '',
      args: [],
    );
  }

  /// `Record log in background`
  String get label_record_log_in_background {
    return Intl.message(
      'Record log in background',
      name: 'label_record_log_in_background',
      desc: '',
      args: [],
    );
  }

  /// `Show debug view`
  String get label_show_debug_view {
    return Intl.message(
      'Show debug view',
      name: 'label_show_debug_view',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all logs?`
  String get hint_log_delete_all {
    return Intl.message(
      'Are you sure you want to delete all logs?',
      name: 'hint_log_delete_all',
      desc: '',
      args: [],
    );
  }

  /// `Counter of uploaded message`
  String get label_enable_uploaded_message_counter {
    return Intl.message(
      'Counter of uploaded message',
      name: 'label_enable_uploaded_message_counter',
      desc: '',
      args: [],
    );
  }

  /// `No PGP public key was found`
  String get error_no_pgp_key {
    return Intl.message(
      'No PGP public key was found',
      name: 'error_no_pgp_key',
      desc: '',
      args: [],
    );
  }

  /// `PGP Settings`
  String get label_contact_pgp_settings {
    return Intl.message(
      'PGP Settings',
      name: 'label_contact_pgp_settings',
      desc: '',
      args: [],
    );
  }

  /// `The message will be automatically encrypted and/or signed for contacts with OpenPgp keys.\n OpenPGP supports plain text only. All the formatting will be removed before encryption.`
  String get hint_pgp_message_automatically_encrypt {
    return Intl.message(
      'The message will be automatically encrypted and/or signed for contacts with OpenPgp keys.\n OpenPGP supports plain text only. All the formatting will be removed before encryption.',
      name: 'hint_pgp_message_automatically_encrypt',
      desc: '',
      args: [],
    );
  }

  /// `Not spam`
  String get btn_not_spam {
    return Intl.message(
      'Not spam',
      name: 'btn_not_spam',
      desc: '',
      args: [],
    );
  }

  /// `password is empty`
  String get error_password_is_empty {
    return Intl.message(
      'password is empty',
      name: 'error_password_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Required password for PGP key`
  String get label_encryption_password_for_pgp_key {
    return Intl.message(
      'Required password for PGP key',
      name: 'label_encryption_password_for_pgp_key',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the file?`
  String get debug_hint_log_delete_record {
    return Intl.message(
      'Are you sure you want to delete the file?',
      name: 'debug_hint_log_delete_record',
      desc: '',
      args: [],
    );
  }

  /// `Can't connect to the server`
  String get error_timeout {
    return Intl.message(
      'Can\'t connect to the server',
      name: 'error_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Invalid security key`
  String get fido_error_invalid_key {
    return Intl.message(
      'Invalid security key',
      name: 'fido_error_invalid_key',
      desc: '',
      args: [],
    );
  }

  /// `Two Factor Verification`
  String get tfa_label {
    return Intl.message(
      'Two Factor Verification',
      name: 'tfa_label',
      desc: '',
      args: [],
    );
  }

  /// `This extra step is intended to confirm it’s really you trying to sign in`
  String get tfa_hint_step {
    return Intl.message(
      'This extra step is intended to confirm it’s really you trying to sign in',
      name: 'tfa_hint_step',
      desc: '',
      args: [],
    );
  }

  /// `Use security key`
  String get fido_btn_use_key {
    return Intl.message(
      'Use security key',
      name: 'fido_btn_use_key',
      desc: '',
      args: [],
    );
  }

  /// `Please scan your security key or insert it to the device`
  String get fido_label_connect_your_key {
    return Intl.message(
      'Please scan your security key or insert it to the device',
      name: 'fido_label_connect_your_key',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get fido_label_success {
    return Intl.message(
      'Success',
      name: 'fido_label_success',
      desc: '',
      args: [],
    );
  }

  /// `Other options`
  String get tfa_btn_other_options {
    return Intl.message(
      'Other options',
      name: 'tfa_btn_other_options',
      desc: '',
      args: [],
    );
  }

  /// `Use Backup code`
  String get tfa_btn_use_backup_code {
    return Intl.message(
      'Use Backup code',
      name: 'tfa_btn_use_backup_code',
      desc: '',
      args: [],
    );
  }

  /// `Use Authenticator app`
  String get tfa_btn_use_auth_app {
    return Intl.message(
      'Use Authenticator app',
      name: 'tfa_btn_use_auth_app',
      desc: '',
      args: [],
    );
  }

  /// `Use your Security key`
  String get tfa_btn_use_security_key {
    return Intl.message(
      'Use your Security key',
      name: 'tfa_btn_use_security_key',
      desc: '',
      args: [],
    );
  }

  /// `Security options available`
  String get tfa_label_hint_security_options {
    return Intl.message(
      'Security options available',
      name: 'tfa_label_hint_security_options',
      desc: '',
      args: [],
    );
  }

  /// `Touch you security key`
  String get fido_label_touch_your_key {
    return Intl.message(
      'Touch you security key',
      name: 'fido_label_touch_your_key',
      desc: '',
      args: [],
    );
  }

  /// `Please follow the instructions in the popup dialog`
  String get fido_hint_follow_the_instructions {
    return Intl.message(
      'Please follow the instructions in the popup dialog',
      name: 'fido_hint_follow_the_instructions',
      desc: '',
      args: [],
    );
  }

  /// `There was a problem`
  String get fido_error_title {
    return Intl.message(
      'There was a problem',
      name: 'fido_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Try using your security key again or try another way to verify it's you`
  String get fido_error_hint {
    return Intl.message(
      'Try using your security key again or try another way to verify it\'s you',
      name: 'fido_error_hint',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get fido_btn_try_again {
    return Intl.message(
      'Try again',
      name: 'fido_btn_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Specify verification code from the Authenticator app`
  String get tfa_input_hint_code_from_app {
    return Intl.message(
      'Specify verification code from the Authenticator app',
      name: 'tfa_input_hint_code_from_app',
      desc: '',
      args: [],
    );
  }

  /// `Invalid backup code`
  String get tfa_error_invalid_backup_code {
    return Intl.message(
      'Invalid backup code',
      name: 'tfa_error_invalid_backup_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter one of your 8-character backup codes`
  String get tfa_label_enter_backup_code {
    return Intl.message(
      'Enter one of your 8-character backup codes',
      name: 'tfa_label_enter_backup_code',
      desc: '',
      args: [],
    );
  }

  /// `Backup code`
  String get tfa_input_backup_code {
    return Intl.message(
      'Backup code',
      name: 'tfa_input_backup_code',
      desc: '',
      args: [],
    );
  }

  /// `You're all set`
  String get tfa_label_trust_device {
    return Intl.message(
      'You\'re all set',
      name: 'tfa_label_trust_device',
      desc: '',
      args: [],
    );
  }

  /// `Don't ask again on this device for {daysCount} days`
  String tfa_check_box_trust_device(Object daysCount) {
    return Intl.message(
      'Don\'t ask again on this device for $daysCount days',
      name: 'tfa_check_box_trust_device',
      desc: '',
      args: [daysCount],
    );
  }

  /// `Continue`
  String get tfa_button_continue {
    return Intl.message(
      'Continue',
      name: 'tfa_button_continue',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get btn_back {
    return Intl.message(
      'Back',
      name: 'btn_back',
      desc: '',
      args: [],
    );
  }

  /// `Message not found`
  String get error_message_not_found {
    return Intl.message(
      'Message not found',
      name: 'error_message_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Delete cached data and keys`
  String get clear_cache_during_logout {
    return Intl.message(
      'Delete cached data and keys',
      name: 'clear_cache_during_logout',
      desc: '',
      args: [],
    );
  }

  /// `No permission to access the local storage. Check your device settings.`
  String get no_permission_to_local_storage {
    return Intl.message(
      'No permission to access the local storage. Check your device settings.',
      name: 'no_permission_to_local_storage',
      desc: '',
      args: [],
    );
  }

  /// `You already have a public or private key`
  String get already_have_key {
    return Intl.message(
      'You already have a public or private key',
      name: 'already_have_key',
      desc: '',
      args: [],
    );
  }

  /// `Keys that are available for import`
  String get hint_pgp_keys_for_import {
    return Intl.message(
      'Keys that are available for import',
      name: 'hint_pgp_keys_for_import',
      desc: '',
      args: [],
    );
  }

  /// `Keys that are already in the system will not be imported`
  String get hint_pgp_existed_keys {
    return Intl.message(
      'Keys that are already in the system will not be imported',
      name: 'hint_pgp_existed_keys',
      desc: '',
      args: [],
    );
  }

  /// `External private keys are not supported and will not be imported`
  String get hint_pgp_external_private_keys {
    return Intl.message(
      'External private keys are not supported and will not be imported',
      name: 'hint_pgp_external_private_keys',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
