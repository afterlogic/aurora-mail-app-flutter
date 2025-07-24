// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(organizer) => "Organisator: ${organizer}";

  static String m1(emails) => "BCC: ${emails}";

  static String m2(emails) => "CC: ${emails}";

  static String m3(emails) => "Von: ${emails}";

  static String m4(date) => "Gesendet: ${date}";

  static String m5(subject) => "Betreff: ${subject}";

  static String m6(emails) => "An: ${emails}";

  static String m7(time, from) => "Am ${time} schrieb ${from}:";

  static String m8(contact) =>
      "Sind Sie sicher, dass Sie ${contact} löschen möchten?";

  static String m9(group) =>
      "Sind Sie sicher, dass Sie ${group} löschen möchten? Die Kontakte dieser Gruppe werden nicht gelöscht.";

  static String m10(contact, storage) =>
      "${contact} wird bald im ${storage} Speicher erscheinen";

  static String m11(users) =>
      "Kein privater Schlüssel für ${users} Benutzer gefunden.";

  static String m12(name) =>
      "Sind Sie sicher, dass Sie die Datei ${name} löschen möchten?";

  static String m13(folder) =>
      "Sind Sie sicher, dass Sie alle Nachrichten im Ordner ${folder} löschen möchten?";

  static String m14(user) =>
      "Sind Sie sicher, dass Sie den OpenPGP-Schlüssel für ${user} löschen möchten?";

  static String m15(path) => "Herunterladen nach ${path}";

  static String m16(path) => "Datei heruntergeladen nach: ${path}";

  static String m17(fileName) => "${fileName} wird heruntergeladen...";

  static String m18(path) => "Datei hochgeladen nach: ${path}";

  static String m19(fileName) => "${fileName} wird hochgeladen...";

  static String m20(subject) =>
      "Sind Sie sicher, dass Sie ${subject} löschen möchten?";

  static String m21(version) => "Version ${version}";

  static String m22(account) =>
      "Sind Sie sicher, dass Sie sich abmelden und ${account} löschen möchten?";

  static String m23(sender, link, message_password, lifeTime, now) =>
      "Hallo,\n${sender} Benutzer hat Ihnen eine selbstzerstörende sichere E-Mail gesendet.\nSie können sie über den folgenden Link lesen:\n${link}\n${message_password}Die Nachricht wird für ${lifeTime} ab ${now} zugänglich sein";

  static String m24(password) =>
      "Die Nachricht ist passwortgeschützt. Das Passwort lautet: ${password}\n";

  static String m25(daysCount) =>
      "Auf diesem Gerät für ${daysCount} Tage nicht mehr fragen";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Hinzufügen"),
        "already_have_key": MessageLookupByLibrary.simpleMessage(
            "Sie haben bereits einen öffentlichen oder privaten Schlüssel"),
        "app_title": MessageLookupByLibrary.simpleMessage("Mail Client"),
        "btn_add_account":
            MessageLookupByLibrary.simpleMessage("Konto hinzufügen"),
        "btn_back": MessageLookupByLibrary.simpleMessage("Zurück"),
        "btn_cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "btn_close": MessageLookupByLibrary.simpleMessage("Schließen"),
        "btn_contact_delete_key":
            MessageLookupByLibrary.simpleMessage("Schlüssel löschen"),
        "btn_contact_find_in_email":
            MessageLookupByLibrary.simpleMessage("In E-Mail finden"),
        "btn_contact_key_re_import":
            MessageLookupByLibrary.simpleMessage("Erneut importieren"),
        "btn_delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "btn_discard": MessageLookupByLibrary.simpleMessage("Verwerfen"),
        "btn_done": MessageLookupByLibrary.simpleMessage("Fertig"),
        "btn_download": MessageLookupByLibrary.simpleMessage("Herunterladen"),
        "btn_exit": MessageLookupByLibrary.simpleMessage("Beenden"),
        "btn_hide_details":
            MessageLookupByLibrary.simpleMessage("Details ausblenden"),
        "btn_log_delete_all":
            MessageLookupByLibrary.simpleMessage("Alle löschen"),
        "btn_login": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "btn_login_back_to_login":
            MessageLookupByLibrary.simpleMessage("Zurück zur Anmeldung"),
        "btn_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Erweiterte Suche"),
        "btn_message_empty_spam_folder":
            MessageLookupByLibrary.simpleMessage("Spam leeren"),
        "btn_message_empty_trash_folder":
            MessageLookupByLibrary.simpleMessage("Papierkorb leeren"),
        "btn_message_move": MessageLookupByLibrary.simpleMessage("Verschieben"),
        "btn_message_resend":
            MessageLookupByLibrary.simpleMessage("Erneut senden"),
        "btn_not_spam": MessageLookupByLibrary.simpleMessage("Kein Spam"),
        "btn_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "btn_pgp_check_keys":
            MessageLookupByLibrary.simpleMessage("Schlüssel prüfen"),
        "btn_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Entschlüsseln"),
        "btn_pgp_download_all":
            MessageLookupByLibrary.simpleMessage("Alle herunterladen"),
        "btn_pgp_encrypt":
            MessageLookupByLibrary.simpleMessage("Verschlüsseln"),
        "btn_pgp_export_all_public_keys": MessageLookupByLibrary.simpleMessage(
            "Alle öffentlichen Schlüssel exportieren"),
        "btn_pgp_generate": MessageLookupByLibrary.simpleMessage("Generieren"),
        "btn_pgp_generate_keys":
            MessageLookupByLibrary.simpleMessage("Schlüssel generieren"),
        "btn_pgp_import_from_file":
            MessageLookupByLibrary.simpleMessage("Aus Datei importieren"),
        "btn_pgp_import_from_text":
            MessageLookupByLibrary.simpleMessage("Aus Text importieren"),
        "btn_pgp_import_keys_from_file": MessageLookupByLibrary.simpleMessage(
            "Schlüssel aus Datei importieren"),
        "btn_pgp_import_keys_from_text": MessageLookupByLibrary.simpleMessage(
            "Schlüssel aus Text importieren"),
        "btn_pgp_import_selected_key": MessageLookupByLibrary.simpleMessage(
            "Ausgewählte Schlüssel importieren"),
        "btn_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Signieren/Verschlüsseln"),
        "btn_pgp_undo_pgp":
            MessageLookupByLibrary.simpleMessage("PGP rückgängig machen"),
        "btn_php_send_all": MessageLookupByLibrary.simpleMessage("Alle senden"),
        "btn_read": MessageLookupByLibrary.simpleMessage("Gelesen"),
        "btn_resend_push_token":
            MessageLookupByLibrary.simpleMessage("Push-Token erneut senden"),
        "btn_save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "btn_self_destructing":
            MessageLookupByLibrary.simpleMessage("Selbstzerstörend"),
        "btn_share": MessageLookupByLibrary.simpleMessage("Teilen"),
        "btn_show_all": MessageLookupByLibrary.simpleMessage("Alle anzeigen"),
        "btn_show_details":
            MessageLookupByLibrary.simpleMessage("Details anzeigen"),
        "btn_show_email_in_light_theme": MessageLookupByLibrary.simpleMessage(
            "E-Mail im hellen Design anzeigen"),
        "btn_to_spam":
            MessageLookupByLibrary.simpleMessage("Als Spam markieren"),
        "btn_unread": MessageLookupByLibrary.simpleMessage("Ungelesen"),
        "btn_vcf_import": MessageLookupByLibrary.simpleMessage("Importieren"),
        "btn_verify_pin": MessageLookupByLibrary.simpleMessage("Bestätigen"),
        "button_pgp_verify_sign":
            MessageLookupByLibrary.simpleMessage("Verifizieren"),
        "calendar": MessageLookupByLibrary.simpleMessage("Kalender"),
        "calendar_add_attendee_title":
            MessageLookupByLibrary.simpleMessage("Teilnehmer hinzufügen"),
        "calendar_always": MessageLookupByLibrary.simpleMessage("Immer"),
        "calendar_before": MessageLookupByLibrary.simpleMessage("vor"),
        "calendar_create_event":
            MessageLookupByLibrary.simpleMessage("Ereignis erstellen"),
        "calendar_create_event_title":
            MessageLookupByLibrary.simpleMessage("Ereignis erstellen"),
        "calendar_create_task":
            MessageLookupByLibrary.simpleMessage("Aufgabe erstellen"),
        "calendar_create_task_title":
            MessageLookupByLibrary.simpleMessage("Aufgabe erstellen"),
        "calendar_delete_event_title":
            MessageLookupByLibrary.simpleMessage("Ereignis löschen"),
        "calendar_delete_task_title":
            MessageLookupByLibrary.simpleMessage("Aufgabe löschen"),
        "calendar_drawer_get_link":
            MessageLookupByLibrary.simpleMessage("Link abrufen"),
        "calendar_drawer_my_calendars":
            MessageLookupByLibrary.simpleMessage("Meine Kalender"),
        "calendar_edit_event_title":
            MessageLookupByLibrary.simpleMessage("Ereignis bearbeiten"),
        "calendar_edit_task_title":
            MessageLookupByLibrary.simpleMessage("Aufgabe bearbeiten"),
        "calendar_event_title":
            MessageLookupByLibrary.simpleMessage("Ereignis"),
        "calendar_filter_all": MessageLookupByLibrary.simpleMessage("Alle"),
        "calendar_filter_completed":
            MessageLookupByLibrary.simpleMessage("Abgeschlossen"),
        "calendar_filter_data": MessageLookupByLibrary.simpleMessage("Daten"),
        "calendar_filter_has_date":
            MessageLookupByLibrary.simpleMessage("Hat ein Datum"),
        "calendar_filter_task_status":
            MessageLookupByLibrary.simpleMessage("Aufgabenstatus"),
        "calendar_filter_title": MessageLookupByLibrary.simpleMessage("Filter"),
        "calendar_filter_uncompleted":
            MessageLookupByLibrary.simpleMessage("Nicht abgeschlossen"),
        "calendar_filter_without_date":
            MessageLookupByLibrary.simpleMessage("Ohne Datum"),
        "calendar_get_public_link": MessageLookupByLibrary.simpleMessage(
            "Öffentlichen Link zum Kalender abrufen"),
        "calendar_input_all_day":
            MessageLookupByLibrary.simpleMessage("Ganztägig"),
        "calendar_input_attendees":
            MessageLookupByLibrary.simpleMessage("Teilnehmer"),
        "calendar_input_description":
            MessageLookupByLibrary.simpleMessage("Beschreibung"),
        "calendar_input_location": MessageLookupByLibrary.simpleMessage("Ort"),
        "calendar_input_reminders":
            MessageLookupByLibrary.simpleMessage("Erinnerungen"),
        "calendar_input_title": MessageLookupByLibrary.simpleMessage("Titel"),
        "calendar_organizer_label": m0,
        "calendar_please_select_calendar":
            MessageLookupByLibrary.simpleMessage("Bitte Kalender auswählen"),
        "calendar_read_permission":
            MessageLookupByLibrary.simpleMessage("lesen"),
        "calendar_select_calendar":
            MessageLookupByLibrary.simpleMessage("Kalender auswählen"),
        "calendar_selected_calendar_not_found":
            MessageLookupByLibrary.simpleMessage(
                "Ausgewählter Kalender nicht gefunden"),
        "calendar_sharing_all": MessageLookupByLibrary.simpleMessage("Alle"),
        "calendar_sharing_title":
            MessageLookupByLibrary.simpleMessage("Kalender teilen"),
        "calendar_tab_day": MessageLookupByLibrary.simpleMessage("Tag"),
        "calendar_tab_month": MessageLookupByLibrary.simpleMessage("Monat"),
        "calendar_tab_tasks": MessageLookupByLibrary.simpleMessage("Aufgaben"),
        "calendar_tab_week": MessageLookupByLibrary.simpleMessage("Woche"),
        "calendar_task_title": MessageLookupByLibrary.simpleMessage("Aufgabe"),
        "calendar_until": MessageLookupByLibrary.simpleMessage("bis"),
        "clear_cache_during_logout": MessageLookupByLibrary.simpleMessage(
            "Zwischengespeicherte Daten und Schlüssel löschen"),
        "compose_body_placeholder":
            MessageLookupByLibrary.simpleMessage("Nachricht"),
        "compose_discard_save_dialog_description":
            MessageLookupByLibrary.simpleMessage(
                "Änderungen in Entwürfen speichern?"),
        "compose_discard_save_dialog_title":
            MessageLookupByLibrary.simpleMessage("Änderungen verwerfen"),
        "compose_forward_bcc": m1,
        "compose_forward_body_original_message":
            MessageLookupByLibrary.simpleMessage(
                "---- Ursprüngliche Nachricht ----"),
        "compose_forward_cc": m2,
        "compose_forward_from": m3,
        "compose_forward_sent": m4,
        "compose_forward_subject": m5,
        "compose_forward_to": m6,
        "compose_reply_body_title": m7,
        "contacts": MessageLookupByLibrary.simpleMessage("Kontakte"),
        "contacts_add":
            MessageLookupByLibrary.simpleMessage("Kontakt hinzufügen"),
        "contacts_delete_desc_with_name": m8,
        "contacts_delete_selected": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie die ausgewählten Kontakte löschen möchten?"),
        "contacts_delete_title":
            MessageLookupByLibrary.simpleMessage("Kontakt löschen"),
        "contacts_delete_title_plural":
            MessageLookupByLibrary.simpleMessage("Kontakte löschen"),
        "contacts_drawer_section_groups":
            MessageLookupByLibrary.simpleMessage("Gruppen"),
        "contacts_drawer_section_storages":
            MessageLookupByLibrary.simpleMessage("Speicher"),
        "contacts_drawer_storage_all":
            MessageLookupByLibrary.simpleMessage("Alle"),
        "contacts_drawer_storage_personal":
            MessageLookupByLibrary.simpleMessage("Persönlich"),
        "contacts_drawer_storage_shared":
            MessageLookupByLibrary.simpleMessage("Mit allen geteilt"),
        "contacts_drawer_storage_team":
            MessageLookupByLibrary.simpleMessage("Team"),
        "contacts_edit":
            MessageLookupByLibrary.simpleMessage("Kontakt bearbeiten"),
        "contacts_edit_cancel": MessageLookupByLibrary.simpleMessage(
            "Kontakt bearbeiten abbrechen"),
        "contacts_edit_save":
            MessageLookupByLibrary.simpleMessage("Änderungen speichern"),
        "contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Keine E-Mail-Adresse"),
        "contacts_empty":
            MessageLookupByLibrary.simpleMessage("Keine Kontakte"),
        "contacts_group_add":
            MessageLookupByLibrary.simpleMessage("Gruppe hinzufügen"),
        "contacts_group_add_to_group":
            MessageLookupByLibrary.simpleMessage("Zur Gruppe hinzufügen"),
        "contacts_group_delete_desc_with_name": m9,
        "contacts_group_delete_title":
            MessageLookupByLibrary.simpleMessage("Gruppe löschen"),
        "contacts_group_edit":
            MessageLookupByLibrary.simpleMessage("Gruppe bearbeiten"),
        "contacts_group_edit_cancel":
            MessageLookupByLibrary.simpleMessage("Gruppe bearbeiten abbrechen"),
        "contacts_group_edit_is_organization":
            MessageLookupByLibrary.simpleMessage(
                "Diese Gruppe ist ein Unternehmen"),
        "contacts_group_view_app_bar_delete":
            MessageLookupByLibrary.simpleMessage("Diese Gruppe löschen"),
        "contacts_group_view_app_bar_edit":
            MessageLookupByLibrary.simpleMessage("Gruppe bearbeiten"),
        "contacts_group_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "E-Mail an die Kontakte in dieser Gruppe"),
        "contacts_groups_empty":
            MessageLookupByLibrary.simpleMessage("Keine Gruppen"),
        "contacts_list_app_bar_all_contacts":
            MessageLookupByLibrary.simpleMessage("Alle Kontakte"),
        "contacts_list_app_bar_view_group":
            MessageLookupByLibrary.simpleMessage("Gruppe anzeigen"),
        "contacts_list_its_me_flag":
            MessageLookupByLibrary.simpleMessage("Das bin ich!"),
        "contacts_remove_from_group": MessageLookupByLibrary.simpleMessage(
            "Kontakte aus Gruppe entfernen"),
        "contacts_remove_selected": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie die ausgewählten Kontakte aus der Gruppe entfernen möchten?"),
        "contacts_shared_message": m10,
        "contacts_view_address":
            MessageLookupByLibrary.simpleMessage("Adresse"),
        "contacts_view_app_bar_attach":
            MessageLookupByLibrary.simpleMessage("Senden"),
        "contacts_view_app_bar_delete_contact":
            MessageLookupByLibrary.simpleMessage("Löschen"),
        "contacts_view_app_bar_edit_contact":
            MessageLookupByLibrary.simpleMessage("Bearbeiten"),
        "contacts_view_app_bar_search_messages":
            MessageLookupByLibrary.simpleMessage("Nachrichten suchen"),
        "contacts_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage("E-Mail an diesen Kontakt"),
        "contacts_view_app_bar_share":
            MessageLookupByLibrary.simpleMessage("Teilen"),
        "contacts_view_app_bar_unshare":
            MessageLookupByLibrary.simpleMessage("Nicht mehr teilen"),
        "contacts_view_birthday":
            MessageLookupByLibrary.simpleMessage("Geburtstag"),
        "contacts_view_business_address":
            MessageLookupByLibrary.simpleMessage("Geschäftsadresse"),
        "contacts_view_business_email":
            MessageLookupByLibrary.simpleMessage("Geschäftliche E-Mail"),
        "contacts_view_business_phone":
            MessageLookupByLibrary.simpleMessage("Geschäftliches Telefon"),
        "contacts_view_city": MessageLookupByLibrary.simpleMessage("Stadt"),
        "contacts_view_company":
            MessageLookupByLibrary.simpleMessage("Unternehmen"),
        "contacts_view_country":
            MessageLookupByLibrary.simpleMessage("Land/Region"),
        "contacts_view_department":
            MessageLookupByLibrary.simpleMessage("Abteilung"),
        "contacts_view_display_name":
            MessageLookupByLibrary.simpleMessage("Anzeigename"),
        "contacts_view_email": MessageLookupByLibrary.simpleMessage("E-Mail"),
        "contacts_view_facebook":
            MessageLookupByLibrary.simpleMessage("Facebook"),
        "contacts_view_fax": MessageLookupByLibrary.simpleMessage("Fax"),
        "contacts_view_first_name":
            MessageLookupByLibrary.simpleMessage("Vorname"),
        "contacts_view_hide_additional_fields":
            MessageLookupByLibrary.simpleMessage(
                "Zusätzliche Felder ausblenden"),
        "contacts_view_job_title":
            MessageLookupByLibrary.simpleMessage("Berufsbezeichnung"),
        "contacts_view_last_name":
            MessageLookupByLibrary.simpleMessage("Nachname"),
        "contacts_view_mobile": MessageLookupByLibrary.simpleMessage("Mobil"),
        "contacts_view_name": MessageLookupByLibrary.simpleMessage("Name"),
        "contacts_view_nickname":
            MessageLookupByLibrary.simpleMessage("Spitzname"),
        "contacts_view_notes": MessageLookupByLibrary.simpleMessage("Notizen"),
        "contacts_view_office": MessageLookupByLibrary.simpleMessage("Büro"),
        "contacts_view_other_email":
            MessageLookupByLibrary.simpleMessage("Andere E-Mail"),
        "contacts_view_personal_address":
            MessageLookupByLibrary.simpleMessage("Private Adresse"),
        "contacts_view_personal_email":
            MessageLookupByLibrary.simpleMessage("Private E-Mail"),
        "contacts_view_personal_phone":
            MessageLookupByLibrary.simpleMessage("Privates Telefon"),
        "contacts_view_phone": MessageLookupByLibrary.simpleMessage("Telefon"),
        "contacts_view_province":
            MessageLookupByLibrary.simpleMessage("Bundesland/Provinz"),
        "contacts_view_section_business":
            MessageLookupByLibrary.simpleMessage("Geschäftlich"),
        "contacts_view_section_group_name":
            MessageLookupByLibrary.simpleMessage("Gruppenname"),
        "contacts_view_section_groups":
            MessageLookupByLibrary.simpleMessage("Gruppen"),
        "contacts_view_section_home":
            MessageLookupByLibrary.simpleMessage("Zuhause"),
        "contacts_view_section_key":
            MessageLookupByLibrary.simpleMessage("Schlüssel"),
        "contacts_view_section_other_info":
            MessageLookupByLibrary.simpleMessage("Sonstiges"),
        "contacts_view_section_personal":
            MessageLookupByLibrary.simpleMessage("Persönlich"),
        "contacts_view_show_additional_fields":
            MessageLookupByLibrary.simpleMessage("Zusätzliche Felder anzeigen"),
        "contacts_view_skype": MessageLookupByLibrary.simpleMessage("Skype"),
        "contacts_view_street_address":
            MessageLookupByLibrary.simpleMessage("Straße"),
        "contacts_view_web_page":
            MessageLookupByLibrary.simpleMessage("Webseite"),
        "contacts_view_zip":
            MessageLookupByLibrary.simpleMessage("Postleitzahl"),
        "debug_hint_log_delete_record": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie die Datei löschen möchten?"),
        "error_compose_no_receivers": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie Empfänger an"),
        "error_compose_wait_attachments": MessageLookupByLibrary.simpleMessage(
            "Bitte warten Sie, bis die Anhänge hochgeladen sind"),
        "error_connection": MessageLookupByLibrary.simpleMessage(
            "Verbindung zum Server konnte nicht hergestellt werden"),
        "error_connection_offline":
            MessageLookupByLibrary.simpleMessage("Sie sind offline"),
        "error_contact_pgp_key_will_not_be_valid":
            MessageLookupByLibrary.simpleMessage(
                "Der PGP-Schlüssel wird nicht gültig sein"),
        "error_contacts_email_empty": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie eine E-Mail an"),
        "error_contacts_save_name_empty": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie den Namen an"),
        "error_input_validation_email":
            MessageLookupByLibrary.simpleMessage("Die E-Mail ist nicht gültig"),
        "error_input_validation_empty": MessageLookupByLibrary.simpleMessage(
            "Dieses Feld ist erforderlich"),
        "error_input_validation_name_illegal_symbol":
            MessageLookupByLibrary.simpleMessage(
                "Der Name darf nicht \"/\\*?<>|:\" enthalten"),
        "error_input_validation_unique_name":
            MessageLookupByLibrary.simpleMessage(
                "Dieser Name existiert bereits"),
        "error_invalid_pin":
            MessageLookupByLibrary.simpleMessage("Ungültiger Code"),
        "error_login_account_exists": MessageLookupByLibrary.simpleMessage(
            "Dieses Konto existiert bereits in Ihrer Kontenliste."),
        "error_login_auto_discover": MessageLookupByLibrary.simpleMessage(
            "Domain konnte nicht aus dieser E-Mail erkannt werden, bitte geben Sie Ihre Server-URL manuell an."),
        "error_login_input_email": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie die E-Mail ein"),
        "error_login_input_hostname": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie den Hostnamen ein"),
        "error_login_input_password": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie das Passwort ein"),
        "error_login_no_accounts": MessageLookupByLibrary.simpleMessage(
            "Dieser Benutzer hat keine E-Mail-Konten"),
        "error_message_not_found":
            MessageLookupByLibrary.simpleMessage("Nachricht nicht gefunden"),
        "error_no_pgp_key": MessageLookupByLibrary.simpleMessage(
            "Kein PGP-öffentlicher Schlüssel gefunden"),
        "error_password_is_empty":
            MessageLookupByLibrary.simpleMessage("Passwort ist leer"),
        "error_pgp_can_not_decrypt": MessageLookupByLibrary.simpleMessage(
            "Nachricht kann nicht entschlüsselt werden."),
        "error_pgp_invalid_key_or_password":
            MessageLookupByLibrary.simpleMessage(
                "Ungültiger Schlüssel oder Passwort."),
        "error_pgp_invalid_password":
            MessageLookupByLibrary.simpleMessage("ungültiges Passwort"),
        "error_pgp_keys_not_found":
            MessageLookupByLibrary.simpleMessage("Schlüssel nicht gefunden"),
        "error_pgp_need_contact_for_encrypt": MessageLookupByLibrary.simpleMessage(
            "Um Ihre Nachricht zu verschlüsseln, müssen Sie mindestens einen Empfänger angeben."),
        "error_pgp_not_found_keys_for": m11,
        "error_pgp_select_recipient":
            MessageLookupByLibrary.simpleMessage("Empfänger auswählen"),
        "error_server_access_denied":
            MessageLookupByLibrary.simpleMessage("Zugriff verweigert"),
        "error_server_account_exists": MessageLookupByLibrary.simpleMessage(
            "Solches Konto existiert bereits"),
        "error_server_account_old_password_not_correct":
            MessageLookupByLibrary.simpleMessage(
                "Das alte Passwort des Kontos ist nicht korrekt"),
        "error_server_auth_error":
            MessageLookupByLibrary.simpleMessage("Ungültige E-Mail/Passwort"),
        "error_server_calendars_not_allowed":
            MessageLookupByLibrary.simpleMessage("Kalender nicht erlaubt"),
        "error_server_can_not_change_password":
            MessageLookupByLibrary.simpleMessage(
                "Passwort kann nicht geändert werden"),
        "error_server_can_not_create_account":
            MessageLookupByLibrary.simpleMessage(
                "Konto kann nicht erstellt werden"),
        "error_server_can_not_create_contact":
            MessageLookupByLibrary.simpleMessage(
                "Kontakt kann nicht erstellt werden"),
        "error_server_can_not_create_group":
            MessageLookupByLibrary.simpleMessage(
                "Gruppe kann nicht erstellt werden"),
        "error_server_can_not_create_helpdesk_user":
            MessageLookupByLibrary.simpleMessage(
                "Helpdesk-Benutzer kann nicht erstellt werden"),
        "error_server_can_not_get_contact":
            MessageLookupByLibrary.simpleMessage(
                "Kontakt kann nicht abgerufen werden"),
        "error_server_can_not_save_settings":
            MessageLookupByLibrary.simpleMessage(
                "Einstellungen können nicht gespeichert werden"),
        "error_server_can_not_update_contact":
            MessageLookupByLibrary.simpleMessage(
                "Kontakt kann nicht aktualisiert werden"),
        "error_server_can_not_update_group":
            MessageLookupByLibrary.simpleMessage(
                "Gruppe kann nicht aktualisiert werden"),
        "error_server_can_not_upload_file_limit":
            MessageLookupByLibrary.simpleMessage(
                "Upload aufgrund von Dateilimit nicht möglich"),
        "error_server_can_not_upload_file_quota":
            MessageLookupByLibrary.simpleMessage(
                "Sie haben Ihr Cloud-Speicherlimit erreicht. Datei kann nicht hochgeladen werden."),
        "error_server_captcha_error":
            MessageLookupByLibrary.simpleMessage("Captcha-Fehler"),
        "error_server_contact_data_has_been_modified_by_another_application":
            MessageLookupByLibrary.simpleMessage(
                "Kontaktdaten wurden von einer anderen Anwendung geändert"),
        "error_server_contacts_not_allowed":
            MessageLookupByLibrary.simpleMessage("Kontakte nicht erlaubt"),
        "error_server_data_base_error":
            MessageLookupByLibrary.simpleMessage("Datenbankfehler"),
        "error_server_demo_account":
            MessageLookupByLibrary.simpleMessage("Demo-Konto"),
        "error_server_file_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Solche Datei existiert bereits"),
        "error_server_file_not_found":
            MessageLookupByLibrary.simpleMessage("Datei nicht gefunden"),
        "error_server_files_not_allowed":
            MessageLookupByLibrary.simpleMessage("Dateien nicht erlaubt"),
        "error_server_helpdesk_system_user_exists":
            MessageLookupByLibrary.simpleMessage(
                "Helpdesk-Systembenutzer existiert bereits"),
        "error_server_helpdesk_unactivated_user":
            MessageLookupByLibrary.simpleMessage(
                "Deaktivierter Helpdesk-Benutzer"),
        "error_server_helpdesk_unknown_user":
            MessageLookupByLibrary.simpleMessage(
                "Unbekannter Helpdesk-Benutzer"),
        "error_server_helpdesk_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Helpdesk-Benutzer existiert bereits"),
        "error_server_incorrect_file_extension":
            MessageLookupByLibrary.simpleMessage("Falsche Dateierweiterung"),
        "error_server_invalid_input_parameter":
            MessageLookupByLibrary.simpleMessage("Ungültiger Eingabeparameter"),
        "error_server_invalid_token":
            MessageLookupByLibrary.simpleMessage("Ungültiger Token"),
        "error_server_license_limit":
            MessageLookupByLibrary.simpleMessage("Lizenzlimit"),
        "error_server_license_problem":
            MessageLookupByLibrary.simpleMessage("Lizenzproblem"),
        "error_server_mail_server_error":
            MessageLookupByLibrary.simpleMessage("Mail-Server-Fehler"),
        "error_server_method_not_found":
            MessageLookupByLibrary.simpleMessage("Methode nicht gefunden"),
        "error_server_module_not_found":
            MessageLookupByLibrary.simpleMessage("Modul nicht gefunden"),
        "error_server_rest_account_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "REST-Kontosuche fehlgeschlagen"),
        "error_server_rest_api_disabled":
            MessageLookupByLibrary.simpleMessage("REST-API deaktiviert"),
        "error_server_rest_invalid_credentials":
            MessageLookupByLibrary.simpleMessage("Ungültige REST-Anmeldedaten"),
        "error_server_rest_invalid_parameters":
            MessageLookupByLibrary.simpleMessage("Ungültige REST-Parameter"),
        "error_server_rest_invalid_token":
            MessageLookupByLibrary.simpleMessage("Ungültiger REST-Token"),
        "error_server_rest_other_error":
            MessageLookupByLibrary.simpleMessage("Sonstiger REST-Fehler"),
        "error_server_rest_tenant_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "REST-Mandantensuche fehlgeschlagen"),
        "error_server_rest_token_expired":
            MessageLookupByLibrary.simpleMessage("REST-Token abgelaufen"),
        "error_server_rest_unknown_method":
            MessageLookupByLibrary.simpleMessage("Unbekannte REST-Methode"),
        "error_server_system_not_configured":
            MessageLookupByLibrary.simpleMessage(
                "System ist nicht konfiguriert"),
        "error_server_unknown_email":
            MessageLookupByLibrary.simpleMessage("Unbekannte E-Mail"),
        "error_server_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Solcher Benutzer existiert bereits"),
        "error_server_user_not_allowed": MessageLookupByLibrary.simpleMessage(
            "Benutzer ist nicht berechtigt"),
        "error_server_voice_not_allowed":
            MessageLookupByLibrary.simpleMessage("Sprache nicht erlaubt"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Verbindung zum Server nicht möglich"),
        "error_unknown":
            MessageLookupByLibrary.simpleMessage("Unbekannter Fehler"),
        "error_user_already_logged": MessageLookupByLibrary.simpleMessage(
            "Dieser Benutzer ist bereits angemeldet"),
        "fido_btn_try_again":
            MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
        "fido_btn_use_key": MessageLookupByLibrary.simpleMessage(
            "Sicherheitsschlüssel verwenden"),
        "fido_error_hint": MessageLookupByLibrary.simpleMessage(
            "Versuchen Sie, Ihren Sicherheitsschlüssel erneut zu verwenden oder versuchen Sie eine andere Methode, um zu bestätigen, dass Sie es sind"),
        "fido_error_invalid_key": MessageLookupByLibrary.simpleMessage(
            "Ungültiger Sicherheitsschlüssel"),
        "fido_error_title":
            MessageLookupByLibrary.simpleMessage("Es gab ein Problem"),
        "fido_hint_follow_the_instructions":
            MessageLookupByLibrary.simpleMessage(
                "Bitte folgen Sie den Anweisungen im Popup-Dialog"),
        "fido_label_connect_your_key": MessageLookupByLibrary.simpleMessage(
            "Bitte scannen Sie Ihren Sicherheitsschlüssel oder stecken Sie ihn in das Gerät"),
        "fido_label_success":
            MessageLookupByLibrary.simpleMessage("Erfolgreich"),
        "fido_label_touch_your_key": MessageLookupByLibrary.simpleMessage(
            "Berühren Sie Ihren Sicherheitsschlüssel"),
        "folders_drafts": MessageLookupByLibrary.simpleMessage("Entwürfe"),
        "folders_empty": MessageLookupByLibrary.simpleMessage("Keine Ordner"),
        "folders_inbox": MessageLookupByLibrary.simpleMessage("Posteingang"),
        "folders_notes": MessageLookupByLibrary.simpleMessage("Notizen"),
        "folders_sent": MessageLookupByLibrary.simpleMessage("Gesendet"),
        "folders_spam": MessageLookupByLibrary.simpleMessage("Spam"),
        "folders_starred": MessageLookupByLibrary.simpleMessage("Markiert"),
        "folders_trash": MessageLookupByLibrary.simpleMessage("Papierkorb"),
        "format_compose_forward_date":
            MessageLookupByLibrary.simpleMessage("EEE, MMM d, yyyy, HH:mm"),
        "format_compose_reply_date": MessageLookupByLibrary.simpleMessage(
            "EEE, MMM d, yyyy \'um\' HH:mm"),
        "format_contacts_birth_date":
            MessageLookupByLibrary.simpleMessage("MMM d, yyyy"),
        "hint_2fa": MessageLookupByLibrary.simpleMessage(
            "Ihr Konto ist mit\nZwei-Faktor-Authentifizierung geschützt.\nBitte geben Sie den PIN-Code ein."),
        "hint_auto_encrypt_messages": MessageLookupByLibrary.simpleMessage(
            "Wenn Sie möchten, dass Nachrichten an diesen Kontakt automatisch verschlüsselt und/oder signiert werden, aktivieren Sie die Kontrollkästchen unten. Bitte beachten Sie, dass diese Nachrichten in einfachen Text umgewandelt werden. Anhänge werden nicht verschlüsselt."),
        "hint_confirm_exit": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie beenden möchten?"),
        "hint_log_delete_all": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie alle Protokolle löschen möchten?"),
        "hint_log_delete_record": m12,
        "hint_login_upgrade_your_plan": MessageLookupByLibrary.simpleMessage(
            "Mobile Apps sind in Ihrem Konto nicht erlaubt."),
        "hint_message_empty_folder": m13,
        "hint_pgp_already_have_keys": MessageLookupByLibrary.simpleMessage(
            "Schlüssel, die bereits im System vorhanden sind, sind ausgegraut."),
        "hint_pgp_delete_user_key_confirm": m14,
        "hint_pgp_existed_keys": MessageLookupByLibrary.simpleMessage(
            "Schlüssel, die bereits im System vorhanden sind, werden nicht importiert"),
        "hint_pgp_external_private_keys": MessageLookupByLibrary.simpleMessage(
            "Externe private Schlüssel werden nicht unterstützt und nicht importiert"),
        "hint_pgp_keys_contacts_will_be_created":
            MessageLookupByLibrary.simpleMessage(
                "Für diese Schlüssel werden Kontakte erstellt"),
        "hint_pgp_keys_for_import": MessageLookupByLibrary.simpleMessage(
            "Schlüssel, die für den Import verfügbar sind"),
        "hint_pgp_keys_will_be_import_to_contacts":
            MessageLookupByLibrary.simpleMessage(
                "Die Schlüssel werden in Kontakte importiert"),
        "hint_pgp_message_automatically_encrypt":
            MessageLookupByLibrary.simpleMessage(
                "Die Nachricht wird automatisch verschlüsselt und/oder signiert für Kontakte mit OpenPgp-Schlüsseln.\n OpenPGP unterstützt nur einfachen Text. Alle Formatierungen werden vor der Verschlüsselung entfernt."),
        "hint_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
            "Sie sind dabei, Ihren privaten PGP-Schlüssel zu teilen. Der Schlüssel muss vor Dritten geschützt werden. Möchten Sie fortfahren?"),
        "hint_pgp_your_keys":
            MessageLookupByLibrary.simpleMessage("Ihre Schlüssel"),
        "hint_self_destructing_encrypt_with_key":
            MessageLookupByLibrary.simpleMessage(
                "Der ausgewählte Empfänger hat einen PGP-öffentlichen Schlüssel. Die Nachricht kann mit diesem Schlüssel verschlüsselt werden."),
        "hint_self_destructing_encrypt_with_not_key":
            MessageLookupByLibrary.simpleMessage(
                "Der ausgewählte Empfänger hat keinen PGP-öffentlichen Schlüssel. Die schlüssel-basierte Verschlüsselung ist nicht erlaubt"),
        "hint_self_destructing_password_coppied_to_clipboard":
            MessageLookupByLibrary.simpleMessage(
                "Passwort in Zwischenablage kopiert"),
        "hint_self_destructing_sent_password_using_different_channel":
            MessageLookupByLibrary.simpleMessage(
                "Das Passwort muss über einen anderen Kanal gesendet werden.\nSpeichern Sie das Passwort irgendwo. Sie können es sonst nicht wiederherstellen."),
        "hint_self_destructing_supports_plain_text_only":
            MessageLookupByLibrary.simpleMessage(
                "Die selbstzerstörenden sicheren E-Mails unterstützen nur einfachen Text. Alle Formatierungen werden entfernt. Außerdem können Anhänge nicht verschlüsselt werden und werden aus der Nachricht entfernt."),
        "hint_vcf_import": MessageLookupByLibrary.simpleMessage(
            "Kontakt aus VCF importieren?"),
        "input_2fa_pin":
            MessageLookupByLibrary.simpleMessage("Bestätigungscode"),
        "input_message_search_since":
            MessageLookupByLibrary.simpleMessage("Seit"),
        "input_message_search_text":
            MessageLookupByLibrary.simpleMessage("Text"),
        "input_message_search_till":
            MessageLookupByLibrary.simpleMessage("Bis"),
        "input_self_destructing_add_digital_signature":
            MessageLookupByLibrary.simpleMessage(
                "Digitale Signatur hinzufügen"),
        "input_self_destructing_key_based_encryption":
            MessageLookupByLibrary.simpleMessage("Schlüssel-basiert"),
        "input_self_destructing_password_based_encryption":
            MessageLookupByLibrary.simpleMessage("Passwort-basiert"),
        "label_contact_pgp_settings":
            MessageLookupByLibrary.simpleMessage("PGP-Einstellungen"),
        "label_contact_select_key":
            MessageLookupByLibrary.simpleMessage("Schlüssel auswählen"),
        "label_contact_with_not_name":
            MessageLookupByLibrary.simpleMessage("Kein Name"),
        "label_contacts_were_imported_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Kontakte erfolgreich importiert"),
        "label_device_id_copied_to_clip_board":
            MessageLookupByLibrary.simpleMessage(
                "Geräte-ID in Zwischenablage kopiert"),
        "label_device_identifier":
            MessageLookupByLibrary.simpleMessage("Geräte-ID"),
        "label_discard_not_saved_changes": MessageLookupByLibrary.simpleMessage(
            "Nicht gespeicherte Änderungen verwerfen?"),
        "label_enable_uploaded_message_counter":
            MessageLookupByLibrary.simpleMessage(
                "Zähler für hochgeladene Nachrichten"),
        "label_encryption_password_for_pgp_key":
            MessageLookupByLibrary.simpleMessage(
                "Erforderliches Passwort für PGP-Schlüssel"),
        "label_forward_as_attachment":
            MessageLookupByLibrary.simpleMessage("Als Anhang weiterleiten"),
        "label_length": MessageLookupByLibrary.simpleMessage("Länge"),
        "label_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Erweiterte Suche"),
        "label_message_headers": MessageLookupByLibrary.simpleMessage(
            "Nachrichtenkopfzeilen anzeigen"),
        "label_message_move_to":
            MessageLookupByLibrary.simpleMessage("Verschieben nach: "),
        "label_message_move_to_folder":
            MessageLookupByLibrary.simpleMessage("In Ordner verschieben"),
        "label_message_yesterday":
            MessageLookupByLibrary.simpleMessage("Gestern"),
        "label_notifications_settings":
            MessageLookupByLibrary.simpleMessage("Benachrichtigungen"),
        "label_pgp_all_public_key":
            MessageLookupByLibrary.simpleMessage("Alle öffentlichen Schlüssel"),
        "label_pgp_contact_public_keys": MessageLookupByLibrary.simpleMessage(
            "Externe öffentliche Schlüssel"),
        "label_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP Entschlüsseln"),
        "label_pgp_decrypted_and_verified":
            MessageLookupByLibrary.simpleMessage(
                "Nachricht wurde erfolgreich entschlüsselt und verifiziert."),
        "label_pgp_decrypted_but_not_verified":
            MessageLookupByLibrary.simpleMessage(
                "Nachricht wurde erfolgreich entschlüsselt, aber nicht verifiziert."),
        "label_pgp_downloading_to": m15,
        "label_pgp_encrypt":
            MessageLookupByLibrary.simpleMessage("Verschlüsseln"),
        "label_pgp_import_key":
            MessageLookupByLibrary.simpleMessage("Schlüssel importieren"),
        "label_pgp_key_with_not_name":
            MessageLookupByLibrary.simpleMessage("Kein Name"),
        "label_pgp_not_verified": MessageLookupByLibrary.simpleMessage(
            "Nachricht wurde nicht verifiziert."),
        "label_pgp_private_key":
            MessageLookupByLibrary.simpleMessage("Privater Schlüssel"),
        "label_pgp_private_keys":
            MessageLookupByLibrary.simpleMessage("Private Schlüssel"),
        "label_pgp_public_key":
            MessageLookupByLibrary.simpleMessage("Öffentlicher Schlüssel"),
        "label_pgp_public_keys":
            MessageLookupByLibrary.simpleMessage("Öffentliche Schlüssel"),
        "label_pgp_settings": MessageLookupByLibrary.simpleMessage("OpenPGP"),
        "label_pgp_share_warning":
            MessageLookupByLibrary.simpleMessage("Warnung"),
        "label_pgp_sign": MessageLookupByLibrary.simpleMessage("Signieren"),
        "label_pgp_sign_or_encrypt": MessageLookupByLibrary.simpleMessage(
            "Open PGP Signieren/Verschlüsseln"),
        "label_pgp_verified": MessageLookupByLibrary.simpleMessage(
            "Nachricht wurde erfolgreich verifiziert."),
        "label_record_log_in_background": MessageLookupByLibrary.simpleMessage(
            "Protokoll im Hintergrund aufzeichnen"),
        "label_self_destructing": MessageLookupByLibrary.simpleMessage(
            "Selbstzerstörende sichere E-Mail senden"),
        "label_self_destructing_key_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Die schlüssel-basierte Verschlüsselung wird verwendet."),
        "label_self_destructing_not_sign_data":
            MessageLookupByLibrary.simpleMessage(
                "Wird die Daten nicht signieren."),
        "label_self_destructing_password_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Die passwort-basierte Verschlüsselung wird verwendet."),
        "label_self_destructing_sign_data":
            MessageLookupByLibrary.simpleMessage(
                "Wird die Daten mit Ihrem privaten Schlüssel signieren."),
        "label_show_debug_view":
            MessageLookupByLibrary.simpleMessage("Debug-Ansicht anzeigen"),
        "label_token_failed":
            MessageLookupByLibrary.simpleMessage("Fehlgeschlagen"),
        "label_token_storing_status":
            MessageLookupByLibrary.simpleMessage("Token-Speicherstatus"),
        "label_token_successful":
            MessageLookupByLibrary.simpleMessage("Erfolgreich"),
        "login_input_email": MessageLookupByLibrary.simpleMessage("E-Mail"),
        "login_input_host": MessageLookupByLibrary.simpleMessage("Host"),
        "login_input_password":
            MessageLookupByLibrary.simpleMessage("Passwort"),
        "login_to_continue":
            MessageLookupByLibrary.simpleMessage("Anmelden um fortzufahren"),
        "message_lifetime":
            MessageLookupByLibrary.simpleMessage("Nachrichtenlebensdauer"),
        "messages_always_show_images": MessageLookupByLibrary.simpleMessage(
            "Bilder von diesem Absender immer anzeigen."),
        "messages_attachment_delete":
            MessageLookupByLibrary.simpleMessage("Anhang löschen"),
        "messages_attachment_download":
            MessageLookupByLibrary.simpleMessage("Anhang herunterladen"),
        "messages_attachment_download_cancel":
            MessageLookupByLibrary.simpleMessage("Download abbrechen"),
        "messages_attachment_download_failed":
            MessageLookupByLibrary.simpleMessage("Download fehlgeschlagen"),
        "messages_attachment_download_success": m16,
        "messages_attachment_downloading": m17,
        "messages_attachment_upload":
            MessageLookupByLibrary.simpleMessage("Anhang hochladen"),
        "messages_attachment_upload_cancel":
            MessageLookupByLibrary.simpleMessage("Upload abbrechen"),
        "messages_attachment_upload_failed":
            MessageLookupByLibrary.simpleMessage("Upload fehlgeschlagen"),
        "messages_attachment_upload_success": m18,
        "messages_attachment_uploading": m19,
        "messages_attachments_empty":
            MessageLookupByLibrary.simpleMessage("Keine Anhänge"),
        "messages_bcc": MessageLookupByLibrary.simpleMessage("BCC"),
        "messages_cc": MessageLookupByLibrary.simpleMessage("CC"),
        "messages_delete_desc": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie diese Nachricht löschen möchten?"),
        "messages_delete_desc_with_count": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie diese Nachrichten löschen möchten?"),
        "messages_delete_desc_with_subject": m20,
        "messages_delete_title":
            MessageLookupByLibrary.simpleMessage("Nachricht löschen"),
        "messages_delete_title_with_count":
            MessageLookupByLibrary.simpleMessage("Nachrichten löschen"),
        "messages_empty":
            MessageLookupByLibrary.simpleMessage("Keine Nachrichten"),
        "messages_filter_unread":
            MessageLookupByLibrary.simpleMessage("Ungelesene Nachrichten:"),
        "messages_forward":
            MessageLookupByLibrary.simpleMessage("Weiterleiten"),
        "messages_from": MessageLookupByLibrary.simpleMessage("Von"),
        "messages_images_security_alert": MessageLookupByLibrary.simpleMessage(
            "Bilder in dieser Nachricht wurden zu Ihrer Sicherheit blockiert."),
        "messages_list_app_bar_contacts":
            MessageLookupByLibrary.simpleMessage("Kontakte"),
        "messages_list_app_bar_loading_folders":
            MessageLookupByLibrary.simpleMessage("Ordner werden geladen..."),
        "messages_list_app_bar_logout":
            MessageLookupByLibrary.simpleMessage("Abmelden"),
        "messages_list_app_bar_mail":
            MessageLookupByLibrary.simpleMessage("Mail"),
        "messages_list_app_bar_search":
            MessageLookupByLibrary.simpleMessage("Suchen"),
        "messages_list_app_bar_settings":
            MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "messages_no_receivers":
            MessageLookupByLibrary.simpleMessage("Keine Empfänger"),
        "messages_no_subject":
            MessageLookupByLibrary.simpleMessage("Kein Betreff"),
        "messages_reply": MessageLookupByLibrary.simpleMessage("Antworten"),
        "messages_reply_all":
            MessageLookupByLibrary.simpleMessage("Allen antworten"),
        "messages_saved_in_drafts": MessageLookupByLibrary.simpleMessage(
            "Nachricht in Entwürfen gespeichert"),
        "messages_sending":
            MessageLookupByLibrary.simpleMessage("Nachricht wird gesendet..."),
        "messages_show_details":
            MessageLookupByLibrary.simpleMessage("Details anzeigen"),
        "messages_show_images":
            MessageLookupByLibrary.simpleMessage("Bilder anzeigen."),
        "messages_subject": MessageLookupByLibrary.simpleMessage("Betreff"),
        "messages_to": MessageLookupByLibrary.simpleMessage("An"),
        "messages_to_me": MessageLookupByLibrary.simpleMessage("An mich"),
        "messages_unknown_recipient":
            MessageLookupByLibrary.simpleMessage("Kein Empfänger"),
        "messages_unknown_sender":
            MessageLookupByLibrary.simpleMessage("Kein Absender"),
        "messages_view_tab_attachments":
            MessageLookupByLibrary.simpleMessage("Anhänge"),
        "messages_view_tab_message_body":
            MessageLookupByLibrary.simpleMessage("Nachrichtentext"),
        "no_permission_to_local_storage": MessageLookupByLibrary.simpleMessage(
            "Keine Berechtigung für den Zugriff auf den lokalen Speicher. Überprüfen Sie Ihre Geräteeinstellungen."),
        "remove": MessageLookupByLibrary.simpleMessage("Entfernen"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "save_changes_question":
            MessageLookupByLibrary.simpleMessage("Änderungen speichern?"),
        "self_destructing_life_time_day":
            MessageLookupByLibrary.simpleMessage("24 Stunden"),
        "self_destructing_life_time_days_3":
            MessageLookupByLibrary.simpleMessage("72 Stunden"),
        "self_destructing_life_time_days_7":
            MessageLookupByLibrary.simpleMessage("7 Tage"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "settings_24_time_format":
            MessageLookupByLibrary.simpleMessage("24-Stunden-Format"),
        "settings_about": MessageLookupByLibrary.simpleMessage("Über"),
        "settings_about_app_version": m21,
        "settings_about_privacy_policy":
            MessageLookupByLibrary.simpleMessage("Datenschutzrichtlinie"),
        "settings_about_terms_of_service":
            MessageLookupByLibrary.simpleMessage("Nutzungsbedingungen"),
        "settings_accounts_add":
            MessageLookupByLibrary.simpleMessage("Neues Konto hinzufügen"),
        "settings_accounts_delete":
            MessageLookupByLibrary.simpleMessage("Konto löschen"),
        "settings_accounts_delete_description": m22,
        "settings_accounts_manage":
            MessageLookupByLibrary.simpleMessage("Konten verwalten"),
        "settings_accounts_relogin":
            MessageLookupByLibrary.simpleMessage("Erneut in Konto anmelden"),
        "settings_common": MessageLookupByLibrary.simpleMessage("Allgemein"),
        "settings_dark_theme":
            MessageLookupByLibrary.simpleMessage("App-Design"),
        "settings_dark_theme_dark":
            MessageLookupByLibrary.simpleMessage("Dunkel"),
        "settings_dark_theme_light":
            MessageLookupByLibrary.simpleMessage("Hell"),
        "settings_dark_theme_system":
            MessageLookupByLibrary.simpleMessage("System-Design"),
        "settings_language": MessageLookupByLibrary.simpleMessage("Sprache"),
        "settings_language_system":
            MessageLookupByLibrary.simpleMessage("Systemsprache"),
        "settings_sync":
            MessageLookupByLibrary.simpleMessage("Synchronisation"),
        "settings_sync_frequency":
            MessageLookupByLibrary.simpleMessage("Synchronisationsfrequenz"),
        "settings_sync_frequency_daily":
            MessageLookupByLibrary.simpleMessage("täglich"),
        "settings_sync_frequency_hours1":
            MessageLookupByLibrary.simpleMessage("1 Stunde"),
        "settings_sync_frequency_hours2":
            MessageLookupByLibrary.simpleMessage("2 Stunden"),
        "settings_sync_frequency_minutes30":
            MessageLookupByLibrary.simpleMessage("30 Minuten"),
        "settings_sync_frequency_minutes5":
            MessageLookupByLibrary.simpleMessage("5 Minuten"),
        "settings_sync_frequency_monthly":
            MessageLookupByLibrary.simpleMessage("monatlich"),
        "settings_sync_frequency_never":
            MessageLookupByLibrary.simpleMessage("nie"),
        "settings_sync_frequency_weekly":
            MessageLookupByLibrary.simpleMessage("wöchentlich"),
        "settings_sync_frequency_yearly":
            MessageLookupByLibrary.simpleMessage("jährlich"),
        "settings_sync_period":
            MessageLookupByLibrary.simpleMessage("Synchronisationszeitraum"),
        "settings_sync_period_all_time":
            MessageLookupByLibrary.simpleMessage("alle Zeit"),
        "settings_sync_period_months1":
            MessageLookupByLibrary.simpleMessage("1 Monat"),
        "settings_sync_period_months3":
            MessageLookupByLibrary.simpleMessage("3 Monate"),
        "settings_sync_period_months6":
            MessageLookupByLibrary.simpleMessage("6 Monate"),
        "settings_sync_period_years1":
            MessageLookupByLibrary.simpleMessage("1 Jahr"),
        "template_self_destructing_message": m23,
        "template_self_destructing_message_password": m24,
        "template_self_destructing_message_title":
            MessageLookupByLibrary.simpleMessage(
                "Die sichere Nachricht wurde mit Ihnen geteilt"),
        "tfa_btn_other_options":
            MessageLookupByLibrary.simpleMessage("Andere Optionen"),
        "tfa_btn_use_auth_app":
            MessageLookupByLibrary.simpleMessage("Authenticator-App verwenden"),
        "tfa_btn_use_backup_code":
            MessageLookupByLibrary.simpleMessage("Backup-Code verwenden"),
        "tfa_btn_use_security_key": MessageLookupByLibrary.simpleMessage(
            "Ihren Sicherheitsschlüssel verwenden"),
        "tfa_button_continue":
            MessageLookupByLibrary.simpleMessage("Fortfahren"),
        "tfa_check_box_trust_device": m25,
        "tfa_error_invalid_backup_code":
            MessageLookupByLibrary.simpleMessage("Ungültiger Backup-Code"),
        "tfa_hint_step": MessageLookupByLibrary.simpleMessage(
            "Dieser zusätzliche Schritt soll bestätigen, dass Sie es wirklich sind, der sich anmelden möchte"),
        "tfa_input_backup_code":
            MessageLookupByLibrary.simpleMessage("Backup-Code"),
        "tfa_input_hint_code_from_app": MessageLookupByLibrary.simpleMessage(
            "Geben Sie den Bestätigungscode aus der Authenticator-App an"),
        "tfa_label":
            MessageLookupByLibrary.simpleMessage("Zwei-Faktor-Verifizierung"),
        "tfa_label_enter_backup_code": MessageLookupByLibrary.simpleMessage(
            "Geben Sie einen Ihrer 8-stelligen Backup-Codes ein"),
        "tfa_label_hint_security_options": MessageLookupByLibrary.simpleMessage(
            "Verfügbare Sicherheitsoptionen"),
        "tfa_label_trust_device":
            MessageLookupByLibrary.simpleMessage("Sie sind bereit")
      };
}
