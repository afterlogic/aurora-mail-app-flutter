// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(emails) => "BCC: ${emails}";

  static String m1(emails) => "CC: ${emails}";

  static String m2(emails) => "From: ${emails}";

  static String m3(date) => "Sent: ${date}";

  static String m4(subject) => "Subject: ${subject}";

  static String m5(emails) => "To: ${emails}";

  static String m6(time, from) => "On ${time}, ${from} wrote:";

  static String m7(contact) => "Are you sure you want to delete ${contact}?";

  static String m8(group) =>
      "Are you sure you want to delete ${group}? The contacts of this group will not be deleted.";

  static String m9(contact, storage) =>
      "${contact} will soon appear in ${storage} storage";

  static String m10(users) => "No private key found for ${users} user.";

  static String m11(folder) =>
      "Are you sure you want to delete all messages in folder ${folder}?";

  static String m12(user) =>
      "Are you sure you want to delete OpenPGP key for ${user}?";

  static String m13(path) => "Downloading to ${path}";

  static String m14(path) => "File downloaded into: ${path}";

  static String m15(fileName) => "Downloading ${fileName}...";

  static String m16(path) => "File uploaded into: ${path}";

  static String m17(fileName) => "Uploading ${fileName}...";

  static String m18(subject) => "Are you sure you want to delete ${subject}?";

  static String m19(version) => "Version ${version}";

  static String m20(account) =>
      "Are you sure you want to logout and delete ${account}?";

  static String m21(sender, link, message_password, lifeTime, now) =>
      "Hello,\n${sender} user sent you a self-destructing secure email.\nYou can read it using the following link:\n${link}\n${message_password}The message will be accessible for ${lifeTime} starting from ${now}";

  static String m22(password) =>
      "The message is password-protected. The password is: ${password}\n";

  static String m23(daysCount) =>
      "Don\'t ask again on this device for ${daysCount} days";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "already_have_key": MessageLookupByLibrary.simpleMessage(
            "You already have a public or private key"),
        "app_title": MessageLookupByLibrary.simpleMessage("Mail Client"),
        "btn_add_account": MessageLookupByLibrary.simpleMessage("Add account"),
        "btn_back": MessageLookupByLibrary.simpleMessage("Back"),
        "btn_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "btn_close": MessageLookupByLibrary.simpleMessage("Close"),
        "btn_contact_delete_key":
            MessageLookupByLibrary.simpleMessage("Delete Key"),
        "btn_contact_find_in_email":
            MessageLookupByLibrary.simpleMessage("Find in email"),
        "btn_contact_key_re_import":
            MessageLookupByLibrary.simpleMessage("Re import"),
        "btn_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "btn_discard": MessageLookupByLibrary.simpleMessage("Discard"),
        "btn_done": MessageLookupByLibrary.simpleMessage("Done"),
        "btn_download": MessageLookupByLibrary.simpleMessage("Download"),
        "btn_exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "btn_hide_details":
            MessageLookupByLibrary.simpleMessage("Hide details"),
        "btn_log_delete_all":
            MessageLookupByLibrary.simpleMessage("Delete all"),
        "btn_login": MessageLookupByLibrary.simpleMessage("Login"),
        "btn_login_back_to_login":
            MessageLookupByLibrary.simpleMessage("Back to login"),
        "btn_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Advanced search"),
        "btn_message_empty_spam_folder":
            MessageLookupByLibrary.simpleMessage("Empty Spam"),
        "btn_message_empty_trash_folder":
            MessageLookupByLibrary.simpleMessage("Empty Trash"),
        "btn_message_move": MessageLookupByLibrary.simpleMessage("Move"),
        "btn_message_resend": MessageLookupByLibrary.simpleMessage("Resend"),
        "btn_not_spam": MessageLookupByLibrary.simpleMessage("Not spam"),
        "btn_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "btn_pgp_check_keys":
            MessageLookupByLibrary.simpleMessage("Check keys"),
        "btn_pgp_decrypt": MessageLookupByLibrary.simpleMessage("Decrypt"),
        "btn_pgp_download_all":
            MessageLookupByLibrary.simpleMessage("Download all"),
        "btn_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Encrypt"),
        "btn_pgp_export_all_public_keys":
            MessageLookupByLibrary.simpleMessage("Export all public keys"),
        "btn_pgp_generate": MessageLookupByLibrary.simpleMessage("Generate"),
        "btn_pgp_generate_keys":
            MessageLookupByLibrary.simpleMessage("Generate keys"),
        "btn_pgp_import_from_file":
            MessageLookupByLibrary.simpleMessage("Import from file"),
        "btn_pgp_import_from_text":
            MessageLookupByLibrary.simpleMessage("Import from text"),
        "btn_pgp_import_keys_from_file":
            MessageLookupByLibrary.simpleMessage("Import keys from file"),
        "btn_pgp_import_keys_from_text":
            MessageLookupByLibrary.simpleMessage("Import keys from text"),
        "btn_pgp_import_selected_key":
            MessageLookupByLibrary.simpleMessage("Import selected keys"),
        "btn_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Sign/Encrypt"),
        "btn_pgp_undo_pgp": MessageLookupByLibrary.simpleMessage("Undo PGP"),
        "btn_php_send_all": MessageLookupByLibrary.simpleMessage("Send all"),
        "btn_read": MessageLookupByLibrary.simpleMessage("Read"),
        "btn_resend_push_token":
            MessageLookupByLibrary.simpleMessage("Resend Push Token"),
        "btn_save": MessageLookupByLibrary.simpleMessage("Save"),
        "btn_self_destructing":
            MessageLookupByLibrary.simpleMessage("Self-destructing"),
        "btn_share": MessageLookupByLibrary.simpleMessage("Share"),
        "btn_show_all": MessageLookupByLibrary.simpleMessage("Show all"),
        "btn_show_details":
            MessageLookupByLibrary.simpleMessage("Show details"),
        "btn_show_email_in_light_theme":
            MessageLookupByLibrary.simpleMessage("Show email in light theme"),
        "btn_to_spam": MessageLookupByLibrary.simpleMessage("To spam"),
        "btn_unread": MessageLookupByLibrary.simpleMessage("Unread"),
        "btn_vcf_import": MessageLookupByLibrary.simpleMessage("Import"),
        "btn_verify_pin": MessageLookupByLibrary.simpleMessage("Verify"),
        "button_pgp_verify_sign":
            MessageLookupByLibrary.simpleMessage("Verify"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "clear_cache_during_logout":
            MessageLookupByLibrary.simpleMessage("Delete cached data and keys"),
        "compose_body_placeholder":
            MessageLookupByLibrary.simpleMessage("Message text..."),
        "compose_discard_save_dialog_description":
            MessageLookupByLibrary.simpleMessage("Save changes in drafts?"),
        "compose_discard_save_dialog_title":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "compose_forward_bcc": m0,
        "compose_forward_body_original_message":
            MessageLookupByLibrary.simpleMessage("---- Original Message ----"),
        "compose_forward_cc": m1,
        "compose_forward_from": m2,
        "compose_forward_sent": m3,
        "compose_forward_subject": m4,
        "compose_forward_to": m5,
        "compose_reply_body_title": m6,
        "contacts": MessageLookupByLibrary.simpleMessage("Contacts"),
        "contacts_add": MessageLookupByLibrary.simpleMessage("Add contact"),
        "contacts_delete_desc_with_name": m7,
        "contacts_delete_selected": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete selected contacts?"),
        "contacts_delete_title":
            MessageLookupByLibrary.simpleMessage("Delete contact"),
        "contacts_delete_title_plural":
            MessageLookupByLibrary.simpleMessage("Delete contacts"),
        "contacts_drawer_section_groups":
            MessageLookupByLibrary.simpleMessage("Groups"),
        "contacts_drawer_section_storages":
            MessageLookupByLibrary.simpleMessage("Storages"),
        "contacts_drawer_storage_all":
            MessageLookupByLibrary.simpleMessage("All"),
        "contacts_drawer_storage_personal":
            MessageLookupByLibrary.simpleMessage("Personal"),
        "contacts_drawer_storage_shared":
            MessageLookupByLibrary.simpleMessage("Shared with all"),
        "contacts_drawer_storage_team":
            MessageLookupByLibrary.simpleMessage("Team"),
        "contacts_edit": MessageLookupByLibrary.simpleMessage("Edit contact"),
        "contacts_edit_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel editing contact"),
        "contacts_edit_save":
            MessageLookupByLibrary.simpleMessage("Save changes"),
        "contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("No email address"),
        "contacts_empty": MessageLookupByLibrary.simpleMessage("No contacts"),
        "contacts_group_add": MessageLookupByLibrary.simpleMessage("Add group"),
        "contacts_group_add_to_group":
            MessageLookupByLibrary.simpleMessage("Add to group"),
        "contacts_group_delete_desc_with_name": m8,
        "contacts_group_delete_title":
            MessageLookupByLibrary.simpleMessage("Delete group"),
        "contacts_group_edit":
            MessageLookupByLibrary.simpleMessage("Edit group"),
        "contacts_group_edit_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel editing group"),
        "contacts_group_edit_is_organization":
            MessageLookupByLibrary.simpleMessage("This group is a Company"),
        "contacts_group_view_app_bar_delete":
            MessageLookupByLibrary.simpleMessage("Delete this group"),
        "contacts_group_view_app_bar_edit":
            MessageLookupByLibrary.simpleMessage("Edit group"),
        "contacts_group_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "Email to the contacts in this group"),
        "contacts_groups_empty":
            MessageLookupByLibrary.simpleMessage("No groups"),
        "contacts_list_app_bar_all_contacts":
            MessageLookupByLibrary.simpleMessage("All contacts"),
        "contacts_list_app_bar_view_group":
            MessageLookupByLibrary.simpleMessage("View group"),
        "contacts_list_its_me_flag":
            MessageLookupByLibrary.simpleMessage("It\'s me!"),
        "contacts_remove_from_group":
            MessageLookupByLibrary.simpleMessage("Remove contacts from group"),
        "contacts_remove_selected": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to remove selected contacts from group?"),
        "contacts_shared_message": m9,
        "contacts_view_address":
            MessageLookupByLibrary.simpleMessage("Address"),
        "contacts_view_app_bar_attach":
            MessageLookupByLibrary.simpleMessage("Send"),
        "contacts_view_app_bar_delete_contact":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "contacts_view_app_bar_edit_contact":
            MessageLookupByLibrary.simpleMessage("Edit"),
        "contacts_view_app_bar_search_messages":
            MessageLookupByLibrary.simpleMessage("Search messages"),
        "contacts_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage("Email to this contact"),
        "contacts_view_app_bar_share":
            MessageLookupByLibrary.simpleMessage("Share"),
        "contacts_view_app_bar_unshare":
            MessageLookupByLibrary.simpleMessage("Unshare"),
        "contacts_view_birthday":
            MessageLookupByLibrary.simpleMessage("Birthday"),
        "contacts_view_business_address":
            MessageLookupByLibrary.simpleMessage("Business Address"),
        "contacts_view_business_email":
            MessageLookupByLibrary.simpleMessage("Business email"),
        "contacts_view_business_phone":
            MessageLookupByLibrary.simpleMessage("Business Phone"),
        "contacts_view_city": MessageLookupByLibrary.simpleMessage("City"),
        "contacts_view_company":
            MessageLookupByLibrary.simpleMessage("Company"),
        "contacts_view_country":
            MessageLookupByLibrary.simpleMessage("Country/Region"),
        "contacts_view_department":
            MessageLookupByLibrary.simpleMessage("Department"),
        "contacts_view_display_name":
            MessageLookupByLibrary.simpleMessage("Display name"),
        "contacts_view_email": MessageLookupByLibrary.simpleMessage("Email"),
        "contacts_view_facebook":
            MessageLookupByLibrary.simpleMessage("Facebook"),
        "contacts_view_fax": MessageLookupByLibrary.simpleMessage("Fax"),
        "contacts_view_first_name":
            MessageLookupByLibrary.simpleMessage("First name"),
        "contacts_view_hide_additional_fields":
            MessageLookupByLibrary.simpleMessage("Hide additional fields"),
        "contacts_view_job_title":
            MessageLookupByLibrary.simpleMessage("Job Title"),
        "contacts_view_last_name":
            MessageLookupByLibrary.simpleMessage("Last name"),
        "contacts_view_mobile": MessageLookupByLibrary.simpleMessage("Mobile"),
        "contacts_view_name": MessageLookupByLibrary.simpleMessage("Name"),
        "contacts_view_nickname":
            MessageLookupByLibrary.simpleMessage("Nickname"),
        "contacts_view_notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "contacts_view_office": MessageLookupByLibrary.simpleMessage("Office"),
        "contacts_view_other_email":
            MessageLookupByLibrary.simpleMessage("Other email"),
        "contacts_view_personal_address":
            MessageLookupByLibrary.simpleMessage("Personal Address"),
        "contacts_view_personal_email":
            MessageLookupByLibrary.simpleMessage("Personal email"),
        "contacts_view_personal_phone":
            MessageLookupByLibrary.simpleMessage("Personal Phone"),
        "contacts_view_phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "contacts_view_province":
            MessageLookupByLibrary.simpleMessage("State/Province"),
        "contacts_view_section_business":
            MessageLookupByLibrary.simpleMessage("Business"),
        "contacts_view_section_group_name":
            MessageLookupByLibrary.simpleMessage("Group Name"),
        "contacts_view_section_groups":
            MessageLookupByLibrary.simpleMessage("Groups"),
        "contacts_view_section_home":
            MessageLookupByLibrary.simpleMessage("Home"),
        "contacts_view_section_other_info":
            MessageLookupByLibrary.simpleMessage("Other"),
        "contacts_view_section_personal":
            MessageLookupByLibrary.simpleMessage("Personal"),
        "contacts_view_show_additional_fields":
            MessageLookupByLibrary.simpleMessage("Show additional fields"),
        "contacts_view_skype": MessageLookupByLibrary.simpleMessage("Skype"),
        "contacts_view_street_address":
            MessageLookupByLibrary.simpleMessage("Street"),
        "contacts_view_web_page":
            MessageLookupByLibrary.simpleMessage("Web Page"),
        "contacts_view_zip": MessageLookupByLibrary.simpleMessage("Zip Code"),
        "debug_hint_log_delete_record": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete the file?"),
        "error_compose_no_receivers":
            MessageLookupByLibrary.simpleMessage("Please provide recipients"),
        "error_compose_wait_attachments": MessageLookupByLibrary.simpleMessage(
            "Please wait until attachments are uploaded"),
        "error_connection": MessageLookupByLibrary.simpleMessage(
            "Could not connect to the server"),
        "error_connection_offline":
            MessageLookupByLibrary.simpleMessage("You\'re offline"),
        "error_contact_pgp_key_will_not_be_valid":
            MessageLookupByLibrary.simpleMessage(
                "The PGP key will not be valid"),
        "error_contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Please specify an email"),
        "error_contacts_save_name_empty":
            MessageLookupByLibrary.simpleMessage("Please specify the name"),
        "error_input_validation_email":
            MessageLookupByLibrary.simpleMessage("The email is not valid"),
        "error_input_validation_empty":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "error_input_validation_name_illegal_symbol":
            MessageLookupByLibrary.simpleMessage(
                "The name cannot contain \"/\\*?<>|:\""),
        "error_input_validation_unique_name":
            MessageLookupByLibrary.simpleMessage("This name already exists"),
        "error_invalid_pin":
            MessageLookupByLibrary.simpleMessage("Invalid code"),
        "error_login_account_exists": MessageLookupByLibrary.simpleMessage(
            "This account already exists in your accounts list."),
        "error_login_auto_discover": MessageLookupByLibrary.simpleMessage(
            "Could not detect domain from this email, please specify your server URL manually."),
        "error_login_input_email":
            MessageLookupByLibrary.simpleMessage("Please enter email"),
        "error_login_input_hostname":
            MessageLookupByLibrary.simpleMessage("Please enter hostname"),
        "error_login_input_password":
            MessageLookupByLibrary.simpleMessage("Please enter password"),
        "error_login_no_accounts": MessageLookupByLibrary.simpleMessage(
            "This user doesn\'t have mail accounts"),
        "error_message_not_found":
            MessageLookupByLibrary.simpleMessage("Message not found"),
        "error_no_pgp_key":
            MessageLookupByLibrary.simpleMessage("No PGP public key was found"),
        "error_password_is_empty":
            MessageLookupByLibrary.simpleMessage("password is empty"),
        "error_pgp_can_not_decrypt":
            MessageLookupByLibrary.simpleMessage("Cannot decrypt message."),
        "error_pgp_invalid_key_or_password":
            MessageLookupByLibrary.simpleMessage("Invalid key or password."),
        "error_pgp_invalid_password":
            MessageLookupByLibrary.simpleMessage("invalid password"),
        "error_pgp_keys_not_found":
            MessageLookupByLibrary.simpleMessage("Keys not found"),
        "error_pgp_need_contact_for_encrypt": MessageLookupByLibrary.simpleMessage(
            "To encrypt your message you need to specify at least one recipient."),
        "error_pgp_not_found_keys_for": m10,
        "error_pgp_select_recipient":
            MessageLookupByLibrary.simpleMessage("Select recipient"),
        "error_server_access_denied":
            MessageLookupByLibrary.simpleMessage("Access denied"),
        "error_server_account_exists":
            MessageLookupByLibrary.simpleMessage("Such account already exists"),
        "error_server_account_old_password_not_correct":
            MessageLookupByLibrary.simpleMessage(
                "Account\'s old password is not correct"),
        "error_server_auth_error":
            MessageLookupByLibrary.simpleMessage("Invalid email/password"),
        "error_server_calendars_not_allowed":
            MessageLookupByLibrary.simpleMessage("Calendars not allowed"),
        "error_server_can_not_change_password":
            MessageLookupByLibrary.simpleMessage("Cannot change password"),
        "error_server_can_not_create_account":
            MessageLookupByLibrary.simpleMessage("Cannot create account"),
        "error_server_can_not_create_contact":
            MessageLookupByLibrary.simpleMessage("Cannot create contact"),
        "error_server_can_not_create_group":
            MessageLookupByLibrary.simpleMessage("Cannot create group"),
        "error_server_can_not_create_helpdesk_user":
            MessageLookupByLibrary.simpleMessage("Cannot create helpdesk user"),
        "error_server_can_not_get_contact":
            MessageLookupByLibrary.simpleMessage("Cannot get contact"),
        "error_server_can_not_save_settings":
            MessageLookupByLibrary.simpleMessage("Cannot save settings"),
        "error_server_can_not_update_contact":
            MessageLookupByLibrary.simpleMessage("Cannot update contact"),
        "error_server_can_not_update_group":
            MessageLookupByLibrary.simpleMessage("Cannot update group"),
        "error_server_can_not_upload_file_limit":
            MessageLookupByLibrary.simpleMessage(
                "Cannot upload due to file limit"),
        "error_server_can_not_upload_file_quota":
            MessageLookupByLibrary.simpleMessage(
                "You have reached your cloud storage space limit. Can\'t upload file."),
        "error_server_captcha_error":
            MessageLookupByLibrary.simpleMessage("Captcha error"),
        "error_server_contact_data_has_been_modified_by_another_application":
            MessageLookupByLibrary.simpleMessage(
                "Contact data has been modified by another application"),
        "error_server_contacts_not_allowed":
            MessageLookupByLibrary.simpleMessage("Contacts not allowed"),
        "error_server_data_base_error":
            MessageLookupByLibrary.simpleMessage("Database error"),
        "error_server_demo_account":
            MessageLookupByLibrary.simpleMessage("Demo account"),
        "error_server_file_already_exists":
            MessageLookupByLibrary.simpleMessage("Such file already exists"),
        "error_server_file_not_found":
            MessageLookupByLibrary.simpleMessage("File not found"),
        "error_server_files_not_allowed":
            MessageLookupByLibrary.simpleMessage("Files not allowed"),
        "error_server_helpdesk_system_user_exists":
            MessageLookupByLibrary.simpleMessage(
                "Helpdesk system user already exists"),
        "error_server_helpdesk_unactivated_user":
            MessageLookupByLibrary.simpleMessage("Helpdesk deactivated user"),
        "error_server_helpdesk_unknown_user":
            MessageLookupByLibrary.simpleMessage("Helpdesk unknown user"),
        "error_server_helpdesk_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Helpdesk user already exists"),
        "error_server_incorrect_file_extension":
            MessageLookupByLibrary.simpleMessage("Incorrect file extension"),
        "error_server_invalid_input_parameter":
            MessageLookupByLibrary.simpleMessage("Invalid input parameter"),
        "error_server_invalid_token":
            MessageLookupByLibrary.simpleMessage("Invalid token"),
        "error_server_license_limit":
            MessageLookupByLibrary.simpleMessage("License limit"),
        "error_server_license_problem":
            MessageLookupByLibrary.simpleMessage("License problem"),
        "error_server_mail_server_error":
            MessageLookupByLibrary.simpleMessage("Mail server error"),
        "error_server_method_not_found":
            MessageLookupByLibrary.simpleMessage("Method not found"),
        "error_server_module_not_found":
            MessageLookupByLibrary.simpleMessage("Module not found"),
        "error_server_rest_account_find_failed":
            MessageLookupByLibrary.simpleMessage("Rest account lookup failed"),
        "error_server_rest_api_disabled":
            MessageLookupByLibrary.simpleMessage("Rest api disabled"),
        "error_server_rest_invalid_credentials":
            MessageLookupByLibrary.simpleMessage("Rest invalid credentials"),
        "error_server_rest_invalid_parameters":
            MessageLookupByLibrary.simpleMessage("Rest invalid parameters"),
        "error_server_rest_invalid_token":
            MessageLookupByLibrary.simpleMessage("Rest invalid token"),
        "error_server_rest_other_error":
            MessageLookupByLibrary.simpleMessage("Rest other error"),
        "error_server_rest_tenant_find_failed":
            MessageLookupByLibrary.simpleMessage("Rest tenant lookup failed"),
        "error_server_rest_token_expired":
            MessageLookupByLibrary.simpleMessage("Rest token expired"),
        "error_server_rest_unknown_method":
            MessageLookupByLibrary.simpleMessage("Rest unknown method"),
        "error_server_system_not_configured":
            MessageLookupByLibrary.simpleMessage("System is not configured"),
        "error_server_unknown_email":
            MessageLookupByLibrary.simpleMessage("Unknown email"),
        "error_server_user_already_exists":
            MessageLookupByLibrary.simpleMessage("Such user already exists"),
        "error_server_user_not_allowed":
            MessageLookupByLibrary.simpleMessage("User is not allowed"),
        "error_server_voice_not_allowed":
            MessageLookupByLibrary.simpleMessage("Voice not allowed"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Can\'t connect to the server"),
        "error_unknown": MessageLookupByLibrary.simpleMessage("Unknown error"),
        "error_user_already_logged": MessageLookupByLibrary.simpleMessage(
            "This user is already logged in"),
        "fido_btn_try_again": MessageLookupByLibrary.simpleMessage("Try again"),
        "fido_btn_use_key":
            MessageLookupByLibrary.simpleMessage("Use security key"),
        "fido_error_hint": MessageLookupByLibrary.simpleMessage(
            "Try using your security key again or try another way to verify it\'s you"),
        "fido_error_invalid_key":
            MessageLookupByLibrary.simpleMessage("Invalid security key"),
        "fido_error_title":
            MessageLookupByLibrary.simpleMessage("There was a problem"),
        "fido_hint_follow_the_instructions":
            MessageLookupByLibrary.simpleMessage(
                "Please follow the instructions in the popup dialog"),
        "fido_label_connect_your_key": MessageLookupByLibrary.simpleMessage(
            "Please scan your security key or insert it to the device"),
        "fido_label_success": MessageLookupByLibrary.simpleMessage("Success"),
        "fido_label_touch_your_key":
            MessageLookupByLibrary.simpleMessage("Touch you security key"),
        "folders_drafts": MessageLookupByLibrary.simpleMessage("Drafts"),
        "folders_empty": MessageLookupByLibrary.simpleMessage("No folders"),
        "folders_inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "folders_sent": MessageLookupByLibrary.simpleMessage("Sent"),
        "folders_spam": MessageLookupByLibrary.simpleMessage("Spam"),
        "folders_starred": MessageLookupByLibrary.simpleMessage("Starred"),
        "folders_trash": MessageLookupByLibrary.simpleMessage("Trash"),
        "format_compose_forward_date":
            MessageLookupByLibrary.simpleMessage("EEE, MMM d, yyyy, HH:mm"),
        "format_compose_reply_date": MessageLookupByLibrary.simpleMessage(
            "EEE, MMM d, yyyy \'at\' HH:mm"),
        "format_contacts_birth_date":
            MessageLookupByLibrary.simpleMessage("MMM d, yyyy"),
        "hint_2fa": MessageLookupByLibrary.simpleMessage(
            "Your account is protected with\nTwo Factor Authentication.\nPlease provide the PIN code."),
        "hint_auto_encrypt_messages": MessageLookupByLibrary.simpleMessage(
            "If you want messages to this contact to be automatically encrypted and/or signed, check the boxes below. Please note that these messages will be converted to plain text. Attachments will not be encrypted."),
        "hint_confirm_exit":
            MessageLookupByLibrary.simpleMessage("Are you sure want to exit?"),
        "hint_log_delete_all": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete all logs?"),
        "hint_login_upgrade_your_plan": MessageLookupByLibrary.simpleMessage(
            "Mobile apps are not allowed in your account."),
        "hint_message_empty_folder": m11,
        "hint_pgp_already_have_keys": MessageLookupByLibrary.simpleMessage(
            "Keys which are already in the system are greyed out."),
        "hint_pgp_delete_user_key_confirm": m12,
        "hint_pgp_existed_keys": MessageLookupByLibrary.simpleMessage(
            "Keys that are already in the system will not be imported"),
        "hint_pgp_external_private_keys": MessageLookupByLibrary.simpleMessage(
            "External private keys are not supported and will not be imported"),
        "hint_pgp_keys_contacts_will_be_created":
            MessageLookupByLibrary.simpleMessage(
                "For these keys contacts will be created"),
        "hint_pgp_keys_for_import": MessageLookupByLibrary.simpleMessage(
            "Keys that are available for import"),
        "hint_pgp_keys_will_be_import_to_contacts":
            MessageLookupByLibrary.simpleMessage(
                "The keys will be imported to contacts"),
        "hint_pgp_message_automatically_encrypt":
            MessageLookupByLibrary.simpleMessage(
                "The message will be automatically encrypted and/or signed for contacts with OpenPgp keys.\n OpenPGP supports plain text only. All the formatting will be removed before encryption."),
        "hint_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
            "You are going to share your private PGP key. The key must be kept from the 3rd parties. Do you want to continue?"),
        "hint_pgp_your_keys": MessageLookupByLibrary.simpleMessage("Your keys"),
        "hint_self_destructing_encrypt_with_key":
            MessageLookupByLibrary.simpleMessage(
                "Selected recipient has PGP public key. The message can be encrypted using this key."),
        "hint_self_destructing_encrypt_with_not_key":
            MessageLookupByLibrary.simpleMessage(
                "Selected recipient has no PGP public key. The key-based encryption is not allowed"),
        "hint_self_destructing_password_coppied_to_clipboard":
            MessageLookupByLibrary.simpleMessage(
                "Password coppied to clipboard"),
        "hint_self_destructing_sent_password_using_different_channel":
            MessageLookupByLibrary.simpleMessage(
                "The password must be sent using a different channel.\nStore the password somewhere. You will not be able to recover it otherwise."),
        "hint_self_destructing_supports_plain_text_only":
            MessageLookupByLibrary.simpleMessage(
                "The self-descructing secure emails support plain text only. All the formatting will be removed. Also, attachments cannot be encrypted and will be removed from the message."),
        "hint_vcf_import":
            MessageLookupByLibrary.simpleMessage("Import contact from vcf?"),
        "input_2fa_pin":
            MessageLookupByLibrary.simpleMessage("Verification code"),
        "input_message_search_since":
            MessageLookupByLibrary.simpleMessage("Since"),
        "input_message_search_text":
            MessageLookupByLibrary.simpleMessage("Text"),
        "input_message_search_till":
            MessageLookupByLibrary.simpleMessage("Till"),
        "input_self_destructing_add_digital_signature":
            MessageLookupByLibrary.simpleMessage("Add digital signature"),
        "input_self_destructing_key_based_encryption":
            MessageLookupByLibrary.simpleMessage("Key-based"),
        "input_self_destructing_password_based_encryption":
            MessageLookupByLibrary.simpleMessage("Password-based"),
        "label_contact_pgp_settings":
            MessageLookupByLibrary.simpleMessage("PGP Settings"),
        "label_contact_select_key":
            MessageLookupByLibrary.simpleMessage("Select key"),
        "label_contact_with_not_name":
            MessageLookupByLibrary.simpleMessage("No name"),
        "label_contacts_were_imported_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Contacts imported successfully"),
        "label_device_id_copied_to_clip_board":
            MessageLookupByLibrary.simpleMessage(
                "Device id copied to clipboard"),
        "label_device_identifier":
            MessageLookupByLibrary.simpleMessage("Device identifier"),
        "label_discard_not_saved_changes":
            MessageLookupByLibrary.simpleMessage("Discard unsaved changes?"),
        "label_enable_uploaded_message_counter":
            MessageLookupByLibrary.simpleMessage("Counter of uploaded message"),
        "label_encryption_password_for_pgp_key":
            MessageLookupByLibrary.simpleMessage(
                "Required password for PGP key"),
        "label_forward_as_attachment":
            MessageLookupByLibrary.simpleMessage("Forward as attachment"),
        "label_length": MessageLookupByLibrary.simpleMessage("Length"),
        "label_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Advanced search"),
        "label_message_headers":
            MessageLookupByLibrary.simpleMessage("View message headers"),
        "label_message_move_to":
            MessageLookupByLibrary.simpleMessage("Move to: "),
        "label_message_move_to_folder":
            MessageLookupByLibrary.simpleMessage("Move to folder"),
        "label_message_yesterday":
            MessageLookupByLibrary.simpleMessage("Yesterday"),
        "label_notifications_settings":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "label_pgp_all_public_key":
            MessageLookupByLibrary.simpleMessage("All public keys"),
        "label_pgp_contact_public_keys":
            MessageLookupByLibrary.simpleMessage("External public keys"),
        "label_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP Decrypt"),
        "label_pgp_decrypted_and_verified":
            MessageLookupByLibrary.simpleMessage(
                "Message was successfully decrypted and verified."),
        "label_pgp_decrypted_but_not_verified":
            MessageLookupByLibrary.simpleMessage(
                "Message was successfully decrypted but wasn\'t verified."),
        "label_pgp_downloading_to": m13,
        "label_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Encrypt"),
        "label_pgp_import_key":
            MessageLookupByLibrary.simpleMessage("Import keys"),
        "label_pgp_key_with_not_name":
            MessageLookupByLibrary.simpleMessage("No name"),
        "label_pgp_not_verified":
            MessageLookupByLibrary.simpleMessage("Message wasn\'t verified."),
        "label_pgp_private_key":
            MessageLookupByLibrary.simpleMessage("Private key"),
        "label_pgp_private_keys":
            MessageLookupByLibrary.simpleMessage("Private keys"),
        "label_pgp_public_key":
            MessageLookupByLibrary.simpleMessage("Public key"),
        "label_pgp_public_keys":
            MessageLookupByLibrary.simpleMessage("Public keys"),
        "label_pgp_settings": MessageLookupByLibrary.simpleMessage("OpenPGP"),
        "label_pgp_share_warning":
            MessageLookupByLibrary.simpleMessage("Warning"),
        "label_pgp_sign": MessageLookupByLibrary.simpleMessage("Sign"),
        "label_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP Sign/Encrypt"),
        "label_pgp_verified": MessageLookupByLibrary.simpleMessage(
            "Message was successfully verified."),
        "label_record_log_in_background":
            MessageLookupByLibrary.simpleMessage("Record log in background"),
        "label_self_destructing": MessageLookupByLibrary.simpleMessage(
            "Send a self-destructing secure email"),
        "label_self_destructing_key_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "The Key-based encryption will be used."),
        "label_self_destructing_not_sign_data":
            MessageLookupByLibrary.simpleMessage("Will not sign the data."),
        "label_self_destructing_password_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "The Password-based encryption will be used."),
        "label_self_destructing_sign_data":
            MessageLookupByLibrary.simpleMessage(
                "Will sign the data with your private key."),
        "label_show_debug_view":
            MessageLookupByLibrary.simpleMessage("Show debug view"),
        "label_token_failed": MessageLookupByLibrary.simpleMessage("Failed"),
        "label_token_storing_status":
            MessageLookupByLibrary.simpleMessage("Token storing status"),
        "label_token_successful":
            MessageLookupByLibrary.simpleMessage("Successful"),
        "login_input_email": MessageLookupByLibrary.simpleMessage("Email"),
        "login_input_host": MessageLookupByLibrary.simpleMessage("Host"),
        "login_input_password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "login_to_continue":
            MessageLookupByLibrary.simpleMessage("Log in to continue"),
        "message_lifetime":
            MessageLookupByLibrary.simpleMessage("Message lifetime"),
        "messages_always_show_images": MessageLookupByLibrary.simpleMessage(
            "Always show pictures in messages from this sender."),
        "messages_attachment_delete":
            MessageLookupByLibrary.simpleMessage("Delete attachment"),
        "messages_attachment_download":
            MessageLookupByLibrary.simpleMessage("Download attachment"),
        "messages_attachment_download_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel download"),
        "messages_attachment_download_failed":
            MessageLookupByLibrary.simpleMessage("Download failed"),
        "messages_attachment_download_success": m14,
        "messages_attachment_downloading": m15,
        "messages_attachment_upload":
            MessageLookupByLibrary.simpleMessage("Upload attachment"),
        "messages_attachment_upload_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel upload"),
        "messages_attachment_upload_failed":
            MessageLookupByLibrary.simpleMessage("Upload failed"),
        "messages_attachment_upload_success": m16,
        "messages_attachment_uploading": m17,
        "messages_attachments_empty":
            MessageLookupByLibrary.simpleMessage("No attachments"),
        "messages_bcc": MessageLookupByLibrary.simpleMessage("BCC"),
        "messages_cc": MessageLookupByLibrary.simpleMessage("CC"),
        "messages_delete_desc": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this message?"),
        "messages_delete_desc_with_count": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete these messages?"),
        "messages_delete_desc_with_subject": m18,
        "messages_delete_title":
            MessageLookupByLibrary.simpleMessage("Delete message"),
        "messages_delete_title_with_count":
            MessageLookupByLibrary.simpleMessage("Delete messages"),
        "messages_empty": MessageLookupByLibrary.simpleMessage("No messages"),
        "messages_filter_unread":
            MessageLookupByLibrary.simpleMessage("Unread messages:"),
        "messages_forward": MessageLookupByLibrary.simpleMessage("Forward"),
        "messages_from": MessageLookupByLibrary.simpleMessage("From"),
        "messages_images_security_alert": MessageLookupByLibrary.simpleMessage(
            "Pictures in this message have been blocked for your safety."),
        "messages_list_app_bar_contacts":
            MessageLookupByLibrary.simpleMessage("Contacts"),
        "messages_list_app_bar_loading_folders":
            MessageLookupByLibrary.simpleMessage("Loading folders..."),
        "messages_list_app_bar_logout":
            MessageLookupByLibrary.simpleMessage("Log out"),
        "messages_list_app_bar_mail":
            MessageLookupByLibrary.simpleMessage("Mail"),
        "messages_list_app_bar_search":
            MessageLookupByLibrary.simpleMessage("Search"),
        "messages_list_app_bar_settings":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "messages_no_receivers":
            MessageLookupByLibrary.simpleMessage("No recipients"),
        "messages_no_subject":
            MessageLookupByLibrary.simpleMessage("No subject"),
        "messages_reply": MessageLookupByLibrary.simpleMessage("Reply"),
        "messages_reply_all":
            MessageLookupByLibrary.simpleMessage("Reply to all"),
        "messages_saved_in_drafts":
            MessageLookupByLibrary.simpleMessage("Message saved in drafts"),
        "messages_sending":
            MessageLookupByLibrary.simpleMessage("Sending message..."),
        "messages_show_details":
            MessageLookupByLibrary.simpleMessage("Show details"),
        "messages_show_images":
            MessageLookupByLibrary.simpleMessage("Show pictures."),
        "messages_subject": MessageLookupByLibrary.simpleMessage("Subject"),
        "messages_to": MessageLookupByLibrary.simpleMessage("To"),
        "messages_to_me": MessageLookupByLibrary.simpleMessage("To me"),
        "messages_unknown_recipient":
            MessageLookupByLibrary.simpleMessage("No recipient"),
        "messages_unknown_sender":
            MessageLookupByLibrary.simpleMessage("No sender"),
        "messages_view_tab_attachments":
            MessageLookupByLibrary.simpleMessage("Attachments"),
        "messages_view_tab_message_body":
            MessageLookupByLibrary.simpleMessage("Message body"),
        "no_permission_to_local_storage": MessageLookupByLibrary.simpleMessage(
            "No permission to access the local storage. Check your device settings."),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "save_changes_question":
            MessageLookupByLibrary.simpleMessage("Save changes?"),
        "self_destructing_life_time_day":
            MessageLookupByLibrary.simpleMessage("24 hours"),
        "self_destructing_life_time_days_3":
            MessageLookupByLibrary.simpleMessage("72 hours"),
        "self_destructing_life_time_days_7":
            MessageLookupByLibrary.simpleMessage("7 days"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "settings_24_time_format":
            MessageLookupByLibrary.simpleMessage("24 hour format"),
        "settings_about": MessageLookupByLibrary.simpleMessage("About"),
        "settings_about_app_version": m19,
        "settings_about_privacy_policy":
            MessageLookupByLibrary.simpleMessage("Privacy policy"),
        "settings_about_terms_of_service":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "settings_accounts_add":
            MessageLookupByLibrary.simpleMessage("Add new account"),
        "settings_accounts_delete":
            MessageLookupByLibrary.simpleMessage("Delete account"),
        "settings_accounts_delete_description": m20,
        "settings_accounts_manage":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "settings_accounts_relogin":
            MessageLookupByLibrary.simpleMessage("Relogin to account"),
        "settings_common": MessageLookupByLibrary.simpleMessage("Common"),
        "settings_dark_theme":
            MessageLookupByLibrary.simpleMessage("App theme"),
        "settings_dark_theme_dark":
            MessageLookupByLibrary.simpleMessage("Dark"),
        "settings_dark_theme_light":
            MessageLookupByLibrary.simpleMessage("Light"),
        "settings_dark_theme_system":
            MessageLookupByLibrary.simpleMessage("System theme"),
        "settings_language": MessageLookupByLibrary.simpleMessage("Language"),
        "settings_language_system":
            MessageLookupByLibrary.simpleMessage("System language"),
        "settings_sync": MessageLookupByLibrary.simpleMessage("Sync"),
        "settings_sync_frequency":
            MessageLookupByLibrary.simpleMessage("Sync frequency"),
        "settings_sync_frequency_daily":
            MessageLookupByLibrary.simpleMessage("daily"),
        "settings_sync_frequency_hours1":
            MessageLookupByLibrary.simpleMessage("1 hour"),
        "settings_sync_frequency_hours2":
            MessageLookupByLibrary.simpleMessage("2 hours"),
        "settings_sync_frequency_minutes30":
            MessageLookupByLibrary.simpleMessage("30 minutes"),
        "settings_sync_frequency_minutes5":
            MessageLookupByLibrary.simpleMessage("5 minutes"),
        "settings_sync_frequency_monthly":
            MessageLookupByLibrary.simpleMessage("monthly"),
        "settings_sync_frequency_never":
            MessageLookupByLibrary.simpleMessage("never"),
        "settings_sync_frequency_weekly":
            MessageLookupByLibrary.simpleMessage("weekly"),
        "settings_sync_frequency_yearly":
            MessageLookupByLibrary.simpleMessage("yearly"),
        "settings_sync_period":
            MessageLookupByLibrary.simpleMessage("Sync period"),
        "settings_sync_period_all_time":
            MessageLookupByLibrary.simpleMessage("all time"),
        "settings_sync_period_months1":
            MessageLookupByLibrary.simpleMessage("1 month"),
        "settings_sync_period_months3":
            MessageLookupByLibrary.simpleMessage("3 months"),
        "settings_sync_period_months6":
            MessageLookupByLibrary.simpleMessage("6 months"),
        "settings_sync_period_years1":
            MessageLookupByLibrary.simpleMessage("1 year"),
        "template_self_destructing_message": m21,
        "template_self_destructing_message_password": m22,
        "template_self_destructing_message_title":
            MessageLookupByLibrary.simpleMessage(
                "The secure message was shared with you"),
        "tfa_btn_other_options":
            MessageLookupByLibrary.simpleMessage("Other options"),
        "tfa_btn_use_auth_app":
            MessageLookupByLibrary.simpleMessage("Use Authenticator app"),
        "tfa_btn_use_backup_code":
            MessageLookupByLibrary.simpleMessage("Use Backup code"),
        "tfa_btn_use_security_key":
            MessageLookupByLibrary.simpleMessage("Use your Security key"),
        "tfa_button_continue": MessageLookupByLibrary.simpleMessage("Continue"),
        "tfa_check_box_trust_device": m23,
        "tfa_error_invalid_backup_code":
            MessageLookupByLibrary.simpleMessage("Invalid backup code"),
        "tfa_hint_step": MessageLookupByLibrary.simpleMessage(
            "This extra step is intended to confirm it’s really you trying to sign in"),
        "tfa_input_backup_code":
            MessageLookupByLibrary.simpleMessage("Backup code"),
        "tfa_input_hint_code_from_app": MessageLookupByLibrary.simpleMessage(
            "Specify verification code from the Authenticator app"),
        "tfa_label":
            MessageLookupByLibrary.simpleMessage("Two Factor Verification"),
        "tfa_label_enter_backup_code": MessageLookupByLibrary.simpleMessage(
            "Enter one of your 8-character backup codes"),
        "tfa_label_hint_security_options":
            MessageLookupByLibrary.simpleMessage("Security options available"),
        "tfa_label_trust_device":
            MessageLookupByLibrary.simpleMessage("You\'re all set")
      };
}
