// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(storeName) =>
      "Verifica dell\'app non riuscita. Installa la versione più recente dall\'${storeName}.";

  static String m1(calendarName) =>
      "Sei sicuro di voler eliminare il calendario ${calendarName}?";

  static String m2(organizer) => "Organizzatore: ${organizer}";

  static String m3(calendarName) =>
      "Sei sicuro di volerti disiscrivere dal calendario ${calendarName}?";

  static String m4(emails) => "BCC: ${emails}";

  static String m5(emails) => "CC: ${emails}";

  static String m6(emails) => "Da: ${emails}";

  static String m7(date) => "Inviato: ${date}";

  static String m8(subject) => "Oggetto: ${subject}";

  static String m9(emails) => "A: ${emails}";

  static String m10(time, from) => "Il ${time}, ${from} ha scritto:";

  static String m11(contact) => "Sei sicuro di voler eliminare ${contact}?";

  static String m12(group) =>
      "Sei sicuro di voler eliminare ${group}? I contatti di questo gruppo non verranno eliminati.";

  static String m13(contact, storage) =>
      "${contact} apparirà presto nell\'archivio ${storage}";

  static String m14(users) =>
      "Nessuna chiave privata trovata per l\'utente ${users}.";

  static String m15(name) => "Sei sicuro di voler eliminare il file ${name}?";

  static String m16(folder) =>
      "Sei sicuro di voler eliminare tutti i messaggi nella cartella ${folder}?";

  static String m17(user) =>
      "Sei sicuro di voler eliminare la chiave OpenPGP per ${user}?";

  static String m18(path) => "Scaricamento in ${path}";

  static String m19(path) => "File scaricato in: ${path}";

  static String m20(fileName) => "Scaricamento ${fileName}...";

  static String m21(path) => "File caricato in: ${path}";

  static String m22(fileName) => "Caricamento ${fileName}...";

  static String m23(subject) => "Sei sicuro di voler eliminare ${subject}?";

  static String m24(version) => "Versione ${version}";

  static String m25(account) =>
      "Sei sicuro di voler disconnetterti ed eliminare ${account}?";

  static String m26(sender, link, message_password, lifeTime, now) =>
      "Ciao,\nl\'utente ${sender} ti ha inviato un\'email sicura autodistruttiva.\nPuoi leggerla usando il seguente link:\n${link}\n${message_password}Il messaggio sarà accessibile per ${lifeTime} a partire da ${now}";

  static String m27(password) =>
      "Il messaggio è protetto da password. La password è: ${password}\n";

  static String m28(daysCount) =>
      "Non chiedere di nuovo su questo dispositivo per ${daysCount} giorni";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Aggiungi"),
        "already_have_key": MessageLookupByLibrary.simpleMessage(
            "Hai già una chiave pubblica o privata"),
        "app_check_validation_fail": m0,
        "app_title": MessageLookupByLibrary.simpleMessage("Client di Posta"),
        "btn_add_account":
            MessageLookupByLibrary.simpleMessage("Aggiungi account"),
        "btn_back": MessageLookupByLibrary.simpleMessage("Indietro"),
        "btn_cancel": MessageLookupByLibrary.simpleMessage("Annulla"),
        "btn_close": MessageLookupByLibrary.simpleMessage("Chiudi"),
        "btn_contact_delete_key":
            MessageLookupByLibrary.simpleMessage("Elimina Chiave"),
        "btn_contact_find_in_email":
            MessageLookupByLibrary.simpleMessage("Trova nell\'email"),
        "btn_contact_key_re_import":
            MessageLookupByLibrary.simpleMessage("Reimporta"),
        "btn_delete": MessageLookupByLibrary.simpleMessage("Elimina"),
        "btn_discard": MessageLookupByLibrary.simpleMessage("Scarta"),
        "btn_done": MessageLookupByLibrary.simpleMessage("Fatto"),
        "btn_download": MessageLookupByLibrary.simpleMessage("Scarica"),
        "btn_exit": MessageLookupByLibrary.simpleMessage("Esci"),
        "btn_hide_details":
            MessageLookupByLibrary.simpleMessage("Nascondi dettagli"),
        "btn_log_delete_all":
            MessageLookupByLibrary.simpleMessage("Elimina tutto"),
        "btn_login": MessageLookupByLibrary.simpleMessage("Accedi"),
        "btn_login_back_to_login":
            MessageLookupByLibrary.simpleMessage("Torna al login"),
        "btn_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Ricerca avanzata"),
        "btn_message_empty_spam_folder":
            MessageLookupByLibrary.simpleMessage("Svuota Spam"),
        "btn_message_empty_trash_folder":
            MessageLookupByLibrary.simpleMessage("Svuota Cestino"),
        "btn_message_move": MessageLookupByLibrary.simpleMessage("Sposta"),
        "btn_message_resend": MessageLookupByLibrary.simpleMessage("Reinvia"),
        "btn_not_spam": MessageLookupByLibrary.simpleMessage("Non spam"),
        "btn_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "btn_pgp_check_keys":
            MessageLookupByLibrary.simpleMessage("Controlla chiavi"),
        "btn_pgp_decrypt": MessageLookupByLibrary.simpleMessage("Decripta"),
        "btn_pgp_download_all":
            MessageLookupByLibrary.simpleMessage("Scarica tutto"),
        "btn_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Cripta"),
        "btn_pgp_export_all_public_keys": MessageLookupByLibrary.simpleMessage(
            "Esporta tutte le chiavi pubbliche"),
        "btn_pgp_generate": MessageLookupByLibrary.simpleMessage("Genera"),
        "btn_pgp_generate_keys":
            MessageLookupByLibrary.simpleMessage("Genera chiavi"),
        "btn_pgp_import_from_file":
            MessageLookupByLibrary.simpleMessage("Importa da file"),
        "btn_pgp_import_from_text":
            MessageLookupByLibrary.simpleMessage("Importa da testo"),
        "btn_pgp_import_keys_from_file":
            MessageLookupByLibrary.simpleMessage("Importa chiavi da file"),
        "btn_pgp_import_keys_from_text":
            MessageLookupByLibrary.simpleMessage("Importa chiavi da testo"),
        "btn_pgp_import_selected_key":
            MessageLookupByLibrary.simpleMessage("Importa chiavi selezionate"),
        "btn_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Firma/Cripta"),
        "btn_pgp_undo_pgp": MessageLookupByLibrary.simpleMessage("Annulla PGP"),
        "btn_php_send_all": MessageLookupByLibrary.simpleMessage("Invia tutto"),
        "btn_read": MessageLookupByLibrary.simpleMessage("Letto"),
        "btn_resend_push_token":
            MessageLookupByLibrary.simpleMessage("Reinvia Token Push"),
        "btn_save": MessageLookupByLibrary.simpleMessage("Salva"),
        "btn_self_destructing":
            MessageLookupByLibrary.simpleMessage("Autodistruttiva"),
        "btn_share": MessageLookupByLibrary.simpleMessage("Condividi"),
        "btn_show_all": MessageLookupByLibrary.simpleMessage("Mostra tutto"),
        "btn_show_details":
            MessageLookupByLibrary.simpleMessage("Mostra dettagli"),
        "btn_show_email_in_light_theme":
            MessageLookupByLibrary.simpleMessage("Mostra email in tema chiaro"),
        "btn_to_spam": MessageLookupByLibrary.simpleMessage("Segna come spam"),
        "btn_unread": MessageLookupByLibrary.simpleMessage("Non letto"),
        "btn_vcf_import": MessageLookupByLibrary.simpleMessage("Importa"),
        "btn_verify_pin": MessageLookupByLibrary.simpleMessage("Verifica"),
        "button_pgp_verify_sign":
            MessageLookupByLibrary.simpleMessage("Verifica"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendario"),
        "calendar_add_attendee_title":
            MessageLookupByLibrary.simpleMessage("Aggiungi partecipante"),
        "calendar_always": MessageLookupByLibrary.simpleMessage("Sempre"),
        "calendar_before": MessageLookupByLibrary.simpleMessage("prima"),
        "calendar_color_label": MessageLookupByLibrary.simpleMessage("Colore"),
        "calendar_create_event":
            MessageLookupByLibrary.simpleMessage("Crea evento"),
        "calendar_create_event_title":
            MessageLookupByLibrary.simpleMessage("Crea Evento"),
        "calendar_create_task":
            MessageLookupByLibrary.simpleMessage("Crea attività"),
        "calendar_create_task_title":
            MessageLookupByLibrary.simpleMessage("Crea Attività"),
        "calendar_create_title":
            MessageLookupByLibrary.simpleMessage("Crea calendario"),
        "calendar_delete_calendar":
            MessageLookupByLibrary.simpleMessage("Elimina calendario"),
        "calendar_delete_confirm_message": m1,
        "calendar_delete_event_title":
            MessageLookupByLibrary.simpleMessage("Elimina evento"),
        "calendar_delete_task_title":
            MessageLookupByLibrary.simpleMessage("Elimina attività"),
        "calendar_description_label":
            MessageLookupByLibrary.simpleMessage("Descrizione"),
        "calendar_drawer_get_link":
            MessageLookupByLibrary.simpleMessage("Ottieni un link"),
        "calendar_drawer_my_calendars":
            MessageLookupByLibrary.simpleMessage("I miei calendari"),
        "calendar_edit_event_title":
            MessageLookupByLibrary.simpleMessage("Modifica Evento"),
        "calendar_edit_task_title":
            MessageLookupByLibrary.simpleMessage("Modifica Attività"),
        "calendar_edit_title":
            MessageLookupByLibrary.simpleMessage("Modifica calendario"),
        "calendar_event_title": MessageLookupByLibrary.simpleMessage("Evento"),
        "calendar_filter_all": MessageLookupByLibrary.simpleMessage("Tutti"),
        "calendar_filter_completed":
            MessageLookupByLibrary.simpleMessage("Completati"),
        "calendar_filter_data": MessageLookupByLibrary.simpleMessage("Dati"),
        "calendar_filter_has_date":
            MessageLookupByLibrary.simpleMessage("Ha una data"),
        "calendar_filter_task_status":
            MessageLookupByLibrary.simpleMessage("Stato attività"),
        "calendar_filter_title": MessageLookupByLibrary.simpleMessage("Filtro"),
        "calendar_filter_uncompleted":
            MessageLookupByLibrary.simpleMessage("Non completati"),
        "calendar_filter_without_date":
            MessageLookupByLibrary.simpleMessage("Senza data"),
        "calendar_get_public_link": MessageLookupByLibrary.simpleMessage(
            "Ottieni un link pubblico al calendario"),
        "calendar_ical_url_label":
            MessageLookupByLibrary.simpleMessage("URL iCal"),
        "calendar_import_ics_file":
            MessageLookupByLibrary.simpleMessage("Importa file ICS"),
        "calendar_input_all_day":
            MessageLookupByLibrary.simpleMessage("Tutto il giorno"),
        "calendar_input_attendees":
            MessageLookupByLibrary.simpleMessage("Partecipanti"),
        "calendar_input_description":
            MessageLookupByLibrary.simpleMessage("Descrizione"),
        "calendar_input_location":
            MessageLookupByLibrary.simpleMessage("Posizione"),
        "calendar_input_reminders":
            MessageLookupByLibrary.simpleMessage("Promemoria"),
        "calendar_input_title": MessageLookupByLibrary.simpleMessage("Titolo"),
        "calendar_name_label":
            MessageLookupByLibrary.simpleMessage("Nome calendario"),
        "calendar_organizer_label": m2,
        "calendar_please_select_calendar":
            MessageLookupByLibrary.simpleMessage("Seleziona calendario"),
        "calendar_read_permission":
            MessageLookupByLibrary.simpleMessage("lettura"),
        "calendar_save_changes_question":
            MessageLookupByLibrary.simpleMessage("Salvare le modifiche?"),
        "calendar_select_calendar":
            MessageLookupByLibrary.simpleMessage("Seleziona calendario"),
        "calendar_selected_calendar_not_found":
            MessageLookupByLibrary.simpleMessage(
                "Calendario selezionato non trovato"),
        "calendar_shared_with_all":
            MessageLookupByLibrary.simpleMessage("Condiviso con tutti"),
        "calendar_shared_with_me":
            MessageLookupByLibrary.simpleMessage("Condiviso con me"),
        "calendar_sharing_all": MessageLookupByLibrary.simpleMessage("Tutti"),
        "calendar_sharing_title":
            MessageLookupByLibrary.simpleMessage("Condividi calendario"),
        "calendar_subscribe_ical_feed":
            MessageLookupByLibrary.simpleMessage("Iscriviti al feed iCal"),
        "calendar_tab_day": MessageLookupByLibrary.simpleMessage("Giorno"),
        "calendar_tab_month": MessageLookupByLibrary.simpleMessage("Mese"),
        "calendar_tab_tasks": MessageLookupByLibrary.simpleMessage("Attività"),
        "calendar_tab_week": MessageLookupByLibrary.simpleMessage("Settimana"),
        "calendar_task_title": MessageLookupByLibrary.simpleMessage("Attività"),
        "calendar_unsubscribe":
            MessageLookupByLibrary.simpleMessage("Disiscriviti"),
        "calendar_unsubscribe_confirm_message": m3,
        "calendar_unsubscribe_from_calendar":
            MessageLookupByLibrary.simpleMessage("Disiscriviti dal calendario"),
        "calendar_until": MessageLookupByLibrary.simpleMessage("fino a"),
        "calendar_validation_enter_text":
            MessageLookupByLibrary.simpleMessage("Inserisci il testo"),
        "clear_cache_during_logout":
            MessageLookupByLibrary.simpleMessage("Elimina dati cache e chiavi"),
        "compose_body_placeholder":
            MessageLookupByLibrary.simpleMessage("Messaggio"),
        "compose_discard_save_dialog_description":
            MessageLookupByLibrary.simpleMessage(
                "Salvare le modifiche nelle bozze?"),
        "compose_discard_save_dialog_title":
            MessageLookupByLibrary.simpleMessage("Scarta modifiche"),
        "compose_forward_bcc": m4,
        "compose_forward_body_original_message":
            MessageLookupByLibrary.simpleMessage(
                "---- Messaggio Originale ----"),
        "compose_forward_cc": m5,
        "compose_forward_from": m6,
        "compose_forward_sent": m7,
        "compose_forward_subject": m8,
        "compose_forward_to": m9,
        "compose_reply_body_title": m10,
        "contacts": MessageLookupByLibrary.simpleMessage("Contatti"),
        "contacts_add":
            MessageLookupByLibrary.simpleMessage("Aggiungi contatto"),
        "contacts_delete_desc_with_name": m11,
        "contacts_delete_selected": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler eliminare i contatti selezionati?"),
        "contacts_delete_title":
            MessageLookupByLibrary.simpleMessage("Elimina contatto"),
        "contacts_delete_title_plural":
            MessageLookupByLibrary.simpleMessage("Elimina contatti"),
        "contacts_drawer_section_groups":
            MessageLookupByLibrary.simpleMessage("Gruppi"),
        "contacts_drawer_section_storages":
            MessageLookupByLibrary.simpleMessage("Archivi"),
        "contacts_drawer_storage_all":
            MessageLookupByLibrary.simpleMessage("Tutti"),
        "contacts_drawer_storage_personal":
            MessageLookupByLibrary.simpleMessage("Personale"),
        "contacts_drawer_storage_shared":
            MessageLookupByLibrary.simpleMessage("Condiviso con tutti"),
        "contacts_drawer_storage_team":
            MessageLookupByLibrary.simpleMessage("Team"),
        "contacts_edit":
            MessageLookupByLibrary.simpleMessage("Modifica contatto"),
        "contacts_edit_cancel":
            MessageLookupByLibrary.simpleMessage("Annulla modifica contatto"),
        "contacts_edit_save":
            MessageLookupByLibrary.simpleMessage("Salva modifiche"),
        "contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Nessun indirizzo email"),
        "contacts_empty":
            MessageLookupByLibrary.simpleMessage("Nessun contatto"),
        "contacts_group_add":
            MessageLookupByLibrary.simpleMessage("Aggiungi gruppo"),
        "contacts_group_add_to_group":
            MessageLookupByLibrary.simpleMessage("Aggiungi al gruppo"),
        "contacts_group_delete_desc_with_name": m12,
        "contacts_group_delete_title":
            MessageLookupByLibrary.simpleMessage("Elimina gruppo"),
        "contacts_group_edit":
            MessageLookupByLibrary.simpleMessage("Modifica gruppo"),
        "contacts_group_edit_cancel":
            MessageLookupByLibrary.simpleMessage("Annulla modifica gruppo"),
        "contacts_group_edit_is_organization":
            MessageLookupByLibrary.simpleMessage("Questo gruppo è un\'Azienda"),
        "contacts_group_view_app_bar_delete":
            MessageLookupByLibrary.simpleMessage("Elimina questo gruppo"),
        "contacts_group_view_app_bar_edit":
            MessageLookupByLibrary.simpleMessage("Modifica gruppo"),
        "contacts_group_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "Invia email ai contatti di questo gruppo"),
        "contacts_groups_empty":
            MessageLookupByLibrary.simpleMessage("Nessun gruppo"),
        "contacts_list_app_bar_all_contacts":
            MessageLookupByLibrary.simpleMessage("Tutti i contatti"),
        "contacts_list_app_bar_view_group":
            MessageLookupByLibrary.simpleMessage("Visualizza gruppo"),
        "contacts_list_its_me_flag":
            MessageLookupByLibrary.simpleMessage("Sono io!"),
        "contacts_remove_from_group":
            MessageLookupByLibrary.simpleMessage("Rimuovi contatti dal gruppo"),
        "contacts_remove_selected": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler rimuovere i contatti selezionati dal gruppo?"),
        "contacts_shared_message": m13,
        "contacts_view_address":
            MessageLookupByLibrary.simpleMessage("Indirizzo"),
        "contacts_view_app_bar_attach":
            MessageLookupByLibrary.simpleMessage("Invia"),
        "contacts_view_app_bar_delete_contact":
            MessageLookupByLibrary.simpleMessage("Elimina"),
        "contacts_view_app_bar_edit_contact":
            MessageLookupByLibrary.simpleMessage("Modifica"),
        "contacts_view_app_bar_search_messages":
            MessageLookupByLibrary.simpleMessage("Cerca messaggi"),
        "contacts_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "Invia email a questo contatto"),
        "contacts_view_app_bar_share":
            MessageLookupByLibrary.simpleMessage("Condividi"),
        "contacts_view_app_bar_unshare":
            MessageLookupByLibrary.simpleMessage("Non condividere"),
        "contacts_view_birthday":
            MessageLookupByLibrary.simpleMessage("Compleanno"),
        "contacts_view_business_address":
            MessageLookupByLibrary.simpleMessage("Indirizzo di Lavoro"),
        "contacts_view_business_email":
            MessageLookupByLibrary.simpleMessage("Email di lavoro"),
        "contacts_view_business_phone":
            MessageLookupByLibrary.simpleMessage("Telefono di Lavoro"),
        "contacts_view_city": MessageLookupByLibrary.simpleMessage("Città"),
        "contacts_view_company":
            MessageLookupByLibrary.simpleMessage("Azienda"),
        "contacts_view_country":
            MessageLookupByLibrary.simpleMessage("Paese/Regione"),
        "contacts_view_department":
            MessageLookupByLibrary.simpleMessage("Dipartimento"),
        "contacts_view_display_name":
            MessageLookupByLibrary.simpleMessage("Nome visualizzato"),
        "contacts_view_email": MessageLookupByLibrary.simpleMessage("Email"),
        "contacts_view_facebook":
            MessageLookupByLibrary.simpleMessage("Facebook"),
        "contacts_view_fax": MessageLookupByLibrary.simpleMessage("Fax"),
        "contacts_view_first_name":
            MessageLookupByLibrary.simpleMessage("Nome"),
        "contacts_view_hide_additional_fields":
            MessageLookupByLibrary.simpleMessage("Nascondi campi aggiuntivi"),
        "contacts_view_job_title":
            MessageLookupByLibrary.simpleMessage("Titolo di Lavoro"),
        "contacts_view_last_name":
            MessageLookupByLibrary.simpleMessage("Cognome"),
        "contacts_view_mobile":
            MessageLookupByLibrary.simpleMessage("Cellulare"),
        "contacts_view_name": MessageLookupByLibrary.simpleMessage("Nome"),
        "contacts_view_nickname":
            MessageLookupByLibrary.simpleMessage("Soprannome"),
        "contacts_view_notes": MessageLookupByLibrary.simpleMessage("Note"),
        "contacts_view_office": MessageLookupByLibrary.simpleMessage("Ufficio"),
        "contacts_view_other_email":
            MessageLookupByLibrary.simpleMessage("Altra email"),
        "contacts_view_personal_address":
            MessageLookupByLibrary.simpleMessage("Indirizzo Personale"),
        "contacts_view_personal_email":
            MessageLookupByLibrary.simpleMessage("Email personale"),
        "contacts_view_personal_phone":
            MessageLookupByLibrary.simpleMessage("Telefono Personale"),
        "contacts_view_phone": MessageLookupByLibrary.simpleMessage("Telefono"),
        "contacts_view_province":
            MessageLookupByLibrary.simpleMessage("Stato/Provincia"),
        "contacts_view_section_business":
            MessageLookupByLibrary.simpleMessage("Lavoro"),
        "contacts_view_section_group_name":
            MessageLookupByLibrary.simpleMessage("Nome Gruppo"),
        "contacts_view_section_groups":
            MessageLookupByLibrary.simpleMessage("Gruppi"),
        "contacts_view_section_home":
            MessageLookupByLibrary.simpleMessage("Casa"),
        "contacts_view_section_key":
            MessageLookupByLibrary.simpleMessage("Chiave"),
        "contacts_view_section_other_info":
            MessageLookupByLibrary.simpleMessage("Altro"),
        "contacts_view_section_personal":
            MessageLookupByLibrary.simpleMessage("Personale"),
        "contacts_view_show_additional_fields":
            MessageLookupByLibrary.simpleMessage("Mostra campi aggiuntivi"),
        "contacts_view_skype": MessageLookupByLibrary.simpleMessage("Skype"),
        "contacts_view_street_address":
            MessageLookupByLibrary.simpleMessage("Via"),
        "contacts_view_web_page":
            MessageLookupByLibrary.simpleMessage("Pagina Web"),
        "contacts_view_zip":
            MessageLookupByLibrary.simpleMessage("Codice Postale"),
        "debug_hint_log_delete_record": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler eliminare il file?"),
        "error_compose_no_receivers":
            MessageLookupByLibrary.simpleMessage("Fornisci i destinatari"),
        "error_compose_wait_attachments": MessageLookupByLibrary.simpleMessage(
            "Attendi che gli allegati vengano caricati"),
        "error_connection": MessageLookupByLibrary.simpleMessage(
            "Impossibile connettersi al server"),
        "error_connection_offline":
            MessageLookupByLibrary.simpleMessage("Sei offline"),
        "error_contact_pgp_key_will_not_be_valid":
            MessageLookupByLibrary.simpleMessage(
                "La chiave PGP non sarà valida"),
        "error_contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Specifica un\'email"),
        "error_contacts_save_name_empty":
            MessageLookupByLibrary.simpleMessage("Specifica il nome"),
        "error_input_validation_email":
            MessageLookupByLibrary.simpleMessage("L\'email non è valida"),
        "error_input_validation_empty":
            MessageLookupByLibrary.simpleMessage("Questo campo è obbligatorio"),
        "error_input_validation_name_illegal_symbol":
            MessageLookupByLibrary.simpleMessage(
                "Il nome non può contenere \"/\\*?<>|:\""),
        "error_input_validation_unique_name":
            MessageLookupByLibrary.simpleMessage("Questo nome esiste già"),
        "error_invalid_pin":
            MessageLookupByLibrary.simpleMessage("Codice non valido"),
        "error_login_account_exists": MessageLookupByLibrary.simpleMessage(
            "Questo account esiste già nella tua lista di account."),
        "error_login_auto_discover": MessageLookupByLibrary.simpleMessage(
            "Impossibile rilevare il dominio da questa email, specifica manualmente l\'URL del server."),
        "error_login_input_email":
            MessageLookupByLibrary.simpleMessage("Inserisci l\'email"),
        "error_login_input_hostname":
            MessageLookupByLibrary.simpleMessage("Inserisci il nome host"),
        "error_login_input_password":
            MessageLookupByLibrary.simpleMessage("Inserisci la password"),
        "error_login_no_accounts": MessageLookupByLibrary.simpleMessage(
            "Questo utente non ha account di posta"),
        "error_message_not_found":
            MessageLookupByLibrary.simpleMessage("Messaggio non trovato"),
        "error_no_pgp_key": MessageLookupByLibrary.simpleMessage(
            "Nessuna chiave pubblica PGP trovata"),
        "error_password_is_empty":
            MessageLookupByLibrary.simpleMessage("la password è vuota"),
        "error_pgp_can_not_decrypt": MessageLookupByLibrary.simpleMessage(
            "Impossibile decriptare il messaggio."),
        "error_pgp_invalid_key_or_password":
            MessageLookupByLibrary.simpleMessage(
                "Chiave o password non valida."),
        "error_pgp_invalid_password":
            MessageLookupByLibrary.simpleMessage("password non valida"),
        "error_pgp_keys_not_found":
            MessageLookupByLibrary.simpleMessage("Chiavi non trovate"),
        "error_pgp_need_contact_for_encrypt": MessageLookupByLibrary.simpleMessage(
            "Per criptare il tuo messaggio devi specificare almeno un destinatario."),
        "error_pgp_not_found_keys_for": m14,
        "error_pgp_select_recipient":
            MessageLookupByLibrary.simpleMessage("Seleziona destinatario"),
        "error_server_access_denied":
            MessageLookupByLibrary.simpleMessage("Accesso negato"),
        "error_server_account_exists":
            MessageLookupByLibrary.simpleMessage("Tale account esiste già"),
        "error_server_account_old_password_not_correct":
            MessageLookupByLibrary.simpleMessage(
                "La vecchia password dell\'account non è corretta"),
        "error_server_auth_error":
            MessageLookupByLibrary.simpleMessage("Email/password non valida"),
        "error_server_calendars_not_allowed":
            MessageLookupByLibrary.simpleMessage("Calendari non consentiti"),
        "error_server_can_not_change_password":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile cambiare la password"),
        "error_server_can_not_create_account":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile creare l\'account"),
        "error_server_can_not_create_contact":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile creare il contatto"),
        "error_server_can_not_create_group":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile creare il gruppo"),
        "error_server_can_not_create_helpdesk_user":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile creare l\'utente helpdesk"),
        "error_server_can_not_get_contact":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile ottenere il contatto"),
        "error_server_can_not_save_settings":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile salvare le impostazioni"),
        "error_server_can_not_update_contact":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile aggiornare il contatto"),
        "error_server_can_not_update_group":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile aggiornare il gruppo"),
        "error_server_can_not_upload_file_limit":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare a causa del limite di file"),
        "error_server_can_not_upload_file_quota":
            MessageLookupByLibrary.simpleMessage(
                "Hai raggiunto il limite di spazio di archiviazione cloud. Impossibile caricare il file."),
        "error_server_captcha_error":
            MessageLookupByLibrary.simpleMessage("Errore captcha"),
        "error_server_contact_data_has_been_modified_by_another_application":
            MessageLookupByLibrary.simpleMessage(
                "I dati del contatto sono stati modificati da un\'altra applicazione"),
        "error_server_contacts_not_allowed":
            MessageLookupByLibrary.simpleMessage("Contatti non consentiti"),
        "error_server_data_base_error":
            MessageLookupByLibrary.simpleMessage("Errore del database"),
        "error_server_demo_account":
            MessageLookupByLibrary.simpleMessage("Account demo"),
        "error_server_file_already_exists":
            MessageLookupByLibrary.simpleMessage("Tale file esiste già"),
        "error_server_file_not_found":
            MessageLookupByLibrary.simpleMessage("File non trovato"),
        "error_server_files_not_allowed":
            MessageLookupByLibrary.simpleMessage("File non consentiti"),
        "error_server_helpdesk_system_user_exists":
            MessageLookupByLibrary.simpleMessage(
                "L\'utente di sistema helpdesk esiste già"),
        "error_server_helpdesk_unactivated_user":
            MessageLookupByLibrary.simpleMessage("Utente helpdesk disattivato"),
        "error_server_helpdesk_unknown_user":
            MessageLookupByLibrary.simpleMessage("Utente helpdesk sconosciuto"),
        "error_server_helpdesk_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "L\'utente helpdesk esiste già"),
        "error_server_incorrect_file_extension":
            MessageLookupByLibrary.simpleMessage(
                "Estensione file non corretta"),
        "error_server_invalid_input_parameter":
            MessageLookupByLibrary.simpleMessage(
                "Parametro di input non valido"),
        "error_server_invalid_token":
            MessageLookupByLibrary.simpleMessage("Token non valido"),
        "error_server_license_limit":
            MessageLookupByLibrary.simpleMessage("Limite di licenza"),
        "error_server_license_problem":
            MessageLookupByLibrary.simpleMessage("Problema di licenza"),
        "error_server_mail_server_error":
            MessageLookupByLibrary.simpleMessage("Errore del server di posta"),
        "error_server_method_not_found":
            MessageLookupByLibrary.simpleMessage("Metodo non trovato"),
        "error_server_module_not_found":
            MessageLookupByLibrary.simpleMessage("Modulo non trovato"),
        "error_server_rest_account_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "Ricerca account REST fallita"),
        "error_server_rest_api_disabled":
            MessageLookupByLibrary.simpleMessage("API REST disabilitata"),
        "error_server_rest_invalid_credentials":
            MessageLookupByLibrary.simpleMessage("Credenziali REST non valide"),
        "error_server_rest_invalid_parameters":
            MessageLookupByLibrary.simpleMessage("Parametri REST non validi"),
        "error_server_rest_invalid_token":
            MessageLookupByLibrary.simpleMessage("Token REST non valido"),
        "error_server_rest_other_error":
            MessageLookupByLibrary.simpleMessage("Altro errore REST"),
        "error_server_rest_tenant_find_failed":
            MessageLookupByLibrary.simpleMessage("Ricerca tenant REST fallita"),
        "error_server_rest_token_expired":
            MessageLookupByLibrary.simpleMessage("Token REST scaduto"),
        "error_server_rest_unknown_method":
            MessageLookupByLibrary.simpleMessage("Metodo REST sconosciuto"),
        "error_server_system_not_configured":
            MessageLookupByLibrary.simpleMessage("Sistema non configurato"),
        "error_server_unknown_email":
            MessageLookupByLibrary.simpleMessage("Email sconosciuta"),
        "error_server_user_already_exists":
            MessageLookupByLibrary.simpleMessage("Tale utente esiste già"),
        "error_server_user_not_allowed":
            MessageLookupByLibrary.simpleMessage("Utente non autorizzato"),
        "error_server_voice_not_allowed":
            MessageLookupByLibrary.simpleMessage("Voce non consentita"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Impossibile connettersi al server"),
        "error_unknown":
            MessageLookupByLibrary.simpleMessage("Errore sconosciuto"),
        "error_user_already_logged": MessageLookupByLibrary.simpleMessage(
            "Questo utente è già connesso"),
        "fido_btn_try_again": MessageLookupByLibrary.simpleMessage("Riprova"),
        "fido_btn_use_key":
            MessageLookupByLibrary.simpleMessage("Usa chiave di sicurezza"),
        "fido_error_hint": MessageLookupByLibrary.simpleMessage(
            "Prova a usare di nuovo la tua chiave di sicurezza o prova un altro modo per verificare che sei tu"),
        "fido_error_invalid_key": MessageLookupByLibrary.simpleMessage(
            "Chiave di sicurezza non valida"),
        "fido_error_title":
            MessageLookupByLibrary.simpleMessage("C\'è stato un problema"),
        "fido_hint_follow_the_instructions":
            MessageLookupByLibrary.simpleMessage(
                "Segui le istruzioni nella finestra di dialogo popup"),
        "fido_label_connect_your_key": MessageLookupByLibrary.simpleMessage(
            "Scansiona la tua chiave di sicurezza o inseriscila nel dispositivo"),
        "fido_label_success": MessageLookupByLibrary.simpleMessage("Successo"),
        "fido_label_touch_your_key": MessageLookupByLibrary.simpleMessage(
            "Tocca la tua chiave di sicurezza"),
        "folders_drafts": MessageLookupByLibrary.simpleMessage("Bozze"),
        "folders_empty":
            MessageLookupByLibrary.simpleMessage("Nessuna cartella"),
        "folders_inbox":
            MessageLookupByLibrary.simpleMessage("Posta in arrivo"),
        "folders_notes": MessageLookupByLibrary.simpleMessage("Note"),
        "folders_sent": MessageLookupByLibrary.simpleMessage("Inviati"),
        "folders_spam": MessageLookupByLibrary.simpleMessage("Spam"),
        "folders_starred": MessageLookupByLibrary.simpleMessage("Speciali"),
        "folders_trash": MessageLookupByLibrary.simpleMessage("Cestino"),
        "format_compose_forward_date":
            MessageLookupByLibrary.simpleMessage("EEE, MMM d, yyyy, HH:mm"),
        "format_compose_reply_date": MessageLookupByLibrary.simpleMessage(
            "EEE, MMM d, yyyy \'alle\' HH:mm"),
        "format_contacts_birth_date":
            MessageLookupByLibrary.simpleMessage("MMM d, yyyy"),
        "hint_2fa": MessageLookupByLibrary.simpleMessage(
            "Il tuo account è protetto con\nAutenticazione a Due Fattori.\nInserisci il codice PIN."),
        "hint_auto_encrypt_messages": MessageLookupByLibrary.simpleMessage(
            "Se vuoi che i messaggi a questo contatto vengano automaticamente criptati e/o firmati, seleziona le caselle sottostanti. Nota che questi messaggi verranno convertiti in testo semplice. Gli allegati non verranno criptati."),
        "hint_confirm_exit":
            MessageLookupByLibrary.simpleMessage("Sei sicuro di voler uscire?"),
        "hint_log_delete_all": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler eliminare tutti i log?"),
        "hint_log_delete_record": m15,
        "hint_login_upgrade_your_plan": MessageLookupByLibrary.simpleMessage(
            "Le app mobili non sono consentite nel tuo account."),
        "hint_message_empty_folder": m16,
        "hint_pgp_already_have_keys": MessageLookupByLibrary.simpleMessage(
            "Le chiavi che sono già nel sistema sono disattivate."),
        "hint_pgp_delete_user_key_confirm": m17,
        "hint_pgp_existed_keys": MessageLookupByLibrary.simpleMessage(
            "Le chiavi che sono già nel sistema non verranno importate"),
        "hint_pgp_external_private_keys": MessageLookupByLibrary.simpleMessage(
            "Le chiavi private esterne non sono supportate e non verranno importate"),
        "hint_pgp_keys_contacts_will_be_created":
            MessageLookupByLibrary.simpleMessage(
                "Per queste chiavi verranno creati i contatti"),
        "hint_pgp_keys_for_import": MessageLookupByLibrary.simpleMessage(
            "Chiavi disponibili per l\'importazione"),
        "hint_pgp_keys_will_be_import_to_contacts":
            MessageLookupByLibrary.simpleMessage(
                "Le chiavi verranno importate nei contatti"),
        "hint_pgp_message_automatically_encrypt":
            MessageLookupByLibrary.simpleMessage(
                "Il messaggio verrà automaticamente criptato e/o firmato per i contatti con chiavi OpenPgp.\n OpenPGP supporta solo testo semplice. Tutta la formattazione verrà rimossa prima della crittografia."),
        "hint_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
            "Stai per condividere la tua chiave privata PGP. La chiave deve essere tenuta lontana da terze parti. Vuoi continuare?"),
        "hint_pgp_your_keys":
            MessageLookupByLibrary.simpleMessage("Le tue chiavi"),
        "hint_self_destructing_encrypt_with_key":
            MessageLookupByLibrary.simpleMessage(
                "Il destinatario selezionato ha una chiave pubblica PGP. Il messaggio può essere criptato usando questa chiave."),
        "hint_self_destructing_encrypt_with_not_key":
            MessageLookupByLibrary.simpleMessage(
                "Il destinatario selezionato non ha una chiave pubblica PGP. La crittografia basata su chiave non è consentita"),
        "hint_self_destructing_password_coppied_to_clipboard":
            MessageLookupByLibrary.simpleMessage(
                "Password copiata negli appunti"),
        "hint_self_destructing_sent_password_using_different_channel":
            MessageLookupByLibrary.simpleMessage(
                "La password deve essere inviata usando un canale diverso.\nConserva la password da qualche parte. Non potrai recuperarla altrimenti."),
        "hint_self_destructing_supports_plain_text_only":
            MessageLookupByLibrary.simpleMessage(
                "Le email sicure autodistruttive supportano solo testo semplice. Tutta la formattazione verrà rimossa. Inoltre, gli allegati non possono essere criptati e verranno rimossi dal messaggio."),
        "hint_vcf_import": MessageLookupByLibrary.simpleMessage(
            "Importare il contatto da vcf?"),
        "input_2fa_pin":
            MessageLookupByLibrary.simpleMessage("Codice di verifica"),
        "input_message_search_since":
            MessageLookupByLibrary.simpleMessage("Da"),
        "input_message_search_text":
            MessageLookupByLibrary.simpleMessage("Testo"),
        "input_message_search_till":
            MessageLookupByLibrary.simpleMessage("Fino a"),
        "input_self_destructing_add_digital_signature":
            MessageLookupByLibrary.simpleMessage("Aggiungi firma digitale"),
        "input_self_destructing_key_based_encryption":
            MessageLookupByLibrary.simpleMessage("Basata su chiave"),
        "input_self_destructing_password_based_encryption":
            MessageLookupByLibrary.simpleMessage("Basata su password"),
        "label_contact_pgp_settings":
            MessageLookupByLibrary.simpleMessage("Impostazioni PGP"),
        "label_contact_select_key":
            MessageLookupByLibrary.simpleMessage("Seleziona chiave"),
        "label_contact_with_not_name":
            MessageLookupByLibrary.simpleMessage("Nessun nome"),
        "label_contacts_were_imported_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Contatti importati con successo"),
        "label_device_id_copied_to_clip_board":
            MessageLookupByLibrary.simpleMessage(
                "ID dispositivo copiato negli appunti"),
        "label_device_identifier":
            MessageLookupByLibrary.simpleMessage("Identificatore dispositivo"),
        "label_discard_not_saved_changes": MessageLookupByLibrary.simpleMessage(
            "Scartare le modifiche non salvate?"),
        "label_enable_uploaded_message_counter":
            MessageLookupByLibrary.simpleMessage("Contatore messaggi caricati"),
        "label_encryption_password_for_pgp_key":
            MessageLookupByLibrary.simpleMessage(
                "Password richiesta per la chiave PGP"),
        "label_forward_as_attachment":
            MessageLookupByLibrary.simpleMessage("Inoltra come allegato"),
        "label_length": MessageLookupByLibrary.simpleMessage("Lunghezza"),
        "label_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Ricerca avanzata"),
        "label_message_headers": MessageLookupByLibrary.simpleMessage(
            "Visualizza intestazioni messaggio"),
        "label_message_move_to":
            MessageLookupByLibrary.simpleMessage("Sposta in: "),
        "label_message_move_to_folder":
            MessageLookupByLibrary.simpleMessage("Sposta nella cartella"),
        "label_message_yesterday": MessageLookupByLibrary.simpleMessage("Ieri"),
        "label_notifications_settings":
            MessageLookupByLibrary.simpleMessage("Notifiche"),
        "label_pgp_all_public_key":
            MessageLookupByLibrary.simpleMessage("Tutte le chiavi pubbliche"),
        "label_pgp_contact_public_keys":
            MessageLookupByLibrary.simpleMessage("Chiavi pubbliche esterne"),
        "label_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP Decripta"),
        "label_pgp_decrypted_and_verified":
            MessageLookupByLibrary.simpleMessage(
                "Il messaggio è stato decriptato e verificato con successo."),
        "label_pgp_decrypted_but_not_verified":
            MessageLookupByLibrary.simpleMessage(
                "Il messaggio è stato decriptato con successo ma non verificato."),
        "label_pgp_downloading_to": m18,
        "label_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Cripta"),
        "label_pgp_import_key":
            MessageLookupByLibrary.simpleMessage("Importa chiavi"),
        "label_pgp_key_with_not_name":
            MessageLookupByLibrary.simpleMessage("Nessun nome"),
        "label_pgp_not_verified": MessageLookupByLibrary.simpleMessage(
            "Il messaggio non è stato verificato."),
        "label_pgp_private_key":
            MessageLookupByLibrary.simpleMessage("Chiave privata"),
        "label_pgp_private_keys":
            MessageLookupByLibrary.simpleMessage("Chiavi private"),
        "label_pgp_public_key":
            MessageLookupByLibrary.simpleMessage("Chiave pubblica"),
        "label_pgp_public_keys":
            MessageLookupByLibrary.simpleMessage("Chiavi pubbliche"),
        "label_pgp_settings": MessageLookupByLibrary.simpleMessage("OpenPGP"),
        "label_pgp_share_warning":
            MessageLookupByLibrary.simpleMessage("Avviso"),
        "label_pgp_sign": MessageLookupByLibrary.simpleMessage("Firma"),
        "label_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP Firma/Cripta"),
        "label_pgp_verified": MessageLookupByLibrary.simpleMessage(
            "Il messaggio è stato verificato con successo."),
        "label_record_log_in_background":
            MessageLookupByLibrary.simpleMessage("Registra log in background"),
        "label_self_destructing": MessageLookupByLibrary.simpleMessage(
            "Invia un\'email sicura autodistruttiva"),
        "label_self_destructing_key_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Verrà utilizzata la crittografia basata su chiave."),
        "label_self_destructing_not_sign_data":
            MessageLookupByLibrary.simpleMessage("Non firmerà i dati."),
        "label_self_destructing_password_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Verrà utilizzata la crittografia basata su password."),
        "label_self_destructing_sign_data":
            MessageLookupByLibrary.simpleMessage(
                "Firmerà i dati con la tua chiave privata."),
        "label_show_debug_view":
            MessageLookupByLibrary.simpleMessage("Mostra vista debug"),
        "label_token_failed": MessageLookupByLibrary.simpleMessage("Fallito"),
        "label_token_storing_status":
            MessageLookupByLibrary.simpleMessage("Stato memorizzazione token"),
        "label_token_successful":
            MessageLookupByLibrary.simpleMessage("Riuscito"),
        "login_continue": MessageLookupByLibrary.simpleMessage("Continua"),
        "login_input_email": MessageLookupByLibrary.simpleMessage("Email"),
        "login_input_host": MessageLookupByLibrary.simpleMessage("Host"),
        "login_input_password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "login_no_account_yet":
            MessageLookupByLibrary.simpleMessage("Non hai ancora un account? "),
        "login_register_now":
            MessageLookupByLibrary.simpleMessage("Registrati ora"),
        "login_sign_in": MessageLookupByLibrary.simpleMessage("Accedi"),
        "login_to_continue":
            MessageLookupByLibrary.simpleMessage("Accedi per continuare"),
        "message_lifetime":
            MessageLookupByLibrary.simpleMessage("Durata del messaggio"),
        "messages_always_show_images": MessageLookupByLibrary.simpleMessage(
            "Mostra sempre le immagini nei messaggi di questo mittente."),
        "messages_attachment_delete":
            MessageLookupByLibrary.simpleMessage("Elimina allegato"),
        "messages_attachment_download":
            MessageLookupByLibrary.simpleMessage("Scarica allegato"),
        "messages_attachment_download_cancel":
            MessageLookupByLibrary.simpleMessage("Annulla download"),
        "messages_attachment_download_failed":
            MessageLookupByLibrary.simpleMessage("Download fallito"),
        "messages_attachment_download_success": m19,
        "messages_attachment_downloading": m20,
        "messages_attachment_upload":
            MessageLookupByLibrary.simpleMessage("Carica allegato"),
        "messages_attachment_upload_cancel":
            MessageLookupByLibrary.simpleMessage("Annulla caricamento"),
        "messages_attachment_upload_failed":
            MessageLookupByLibrary.simpleMessage("Caricamento fallito"),
        "messages_attachment_upload_success": m21,
        "messages_attachment_uploading": m22,
        "messages_attachments_empty":
            MessageLookupByLibrary.simpleMessage("Nessun allegato"),
        "messages_bcc": MessageLookupByLibrary.simpleMessage("BCC"),
        "messages_cc": MessageLookupByLibrary.simpleMessage("CC"),
        "messages_delete_desc": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler eliminare questo messaggio?"),
        "messages_delete_desc_with_count": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler eliminare questi messaggi?"),
        "messages_delete_desc_with_subject": m23,
        "messages_delete_title":
            MessageLookupByLibrary.simpleMessage("Elimina messaggio"),
        "messages_delete_title_with_count":
            MessageLookupByLibrary.simpleMessage("Elimina messaggi"),
        "messages_empty":
            MessageLookupByLibrary.simpleMessage("Nessun messaggio"),
        "messages_filter_unread":
            MessageLookupByLibrary.simpleMessage("Messaggi non letti:"),
        "messages_forward": MessageLookupByLibrary.simpleMessage("Inoltra"),
        "messages_from": MessageLookupByLibrary.simpleMessage("Da"),
        "messages_images_security_alert": MessageLookupByLibrary.simpleMessage(
            "Le immagini in questo messaggio sono state bloccate per la tua sicurezza."),
        "messages_list_app_bar_contacts":
            MessageLookupByLibrary.simpleMessage("Contatti"),
        "messages_list_app_bar_loading_folders":
            MessageLookupByLibrary.simpleMessage("Caricamento cartelle..."),
        "messages_list_app_bar_logout":
            MessageLookupByLibrary.simpleMessage("Disconnetti"),
        "messages_list_app_bar_mail":
            MessageLookupByLibrary.simpleMessage("Posta"),
        "messages_list_app_bar_search":
            MessageLookupByLibrary.simpleMessage("Cerca"),
        "messages_list_app_bar_settings":
            MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "messages_no_receivers":
            MessageLookupByLibrary.simpleMessage("Nessun destinatario"),
        "messages_no_subject":
            MessageLookupByLibrary.simpleMessage("Nessun oggetto"),
        "messages_reply": MessageLookupByLibrary.simpleMessage("Rispondi"),
        "messages_reply_all":
            MessageLookupByLibrary.simpleMessage("Rispondi a tutti"),
        "messages_saved_in_drafts": MessageLookupByLibrary.simpleMessage(
            "Messaggio salvato nelle bozze"),
        "messages_sending":
            MessageLookupByLibrary.simpleMessage("Invio messaggio..."),
        "messages_show_details":
            MessageLookupByLibrary.simpleMessage("Mostra dettagli"),
        "messages_show_images":
            MessageLookupByLibrary.simpleMessage("Mostra immagini."),
        "messages_subject": MessageLookupByLibrary.simpleMessage("Oggetto"),
        "messages_to": MessageLookupByLibrary.simpleMessage("A"),
        "messages_to_me": MessageLookupByLibrary.simpleMessage("A me"),
        "messages_unknown_recipient":
            MessageLookupByLibrary.simpleMessage("Nessun destinatario"),
        "messages_unknown_sender":
            MessageLookupByLibrary.simpleMessage("Nessun mittente"),
        "messages_view_tab_attachments":
            MessageLookupByLibrary.simpleMessage("Allegati"),
        "messages_view_tab_message_body":
            MessageLookupByLibrary.simpleMessage("Corpo del messaggio"),
        "no_permission_to_local_storage": MessageLookupByLibrary.simpleMessage(
            "Nessun permesso per accedere all\'archiviazione locale. Controlla le impostazioni del dispositivo."),
        "record_not_found":
            MessageLookupByLibrary.simpleMessage("Record non trovato"),
        "remove": MessageLookupByLibrary.simpleMessage("Rimuovi"),
        "save": MessageLookupByLibrary.simpleMessage("Salva"),
        "save_changes_question":
            MessageLookupByLibrary.simpleMessage("Salvare le modifiche?"),
        "self_destructing_life_time_day":
            MessageLookupByLibrary.simpleMessage("24 ore"),
        "self_destructing_life_time_days_3":
            MessageLookupByLibrary.simpleMessage("72 ore"),
        "self_destructing_life_time_days_7":
            MessageLookupByLibrary.simpleMessage("7 giorni"),
        "settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "settings_24_time_format":
            MessageLookupByLibrary.simpleMessage("Formato 24 ore"),
        "settings_about": MessageLookupByLibrary.simpleMessage("Informazioni"),
        "settings_about_app_version": m24,
        "settings_about_privacy_policy":
            MessageLookupByLibrary.simpleMessage("Politica sulla privacy"),
        "settings_about_terms_of_service":
            MessageLookupByLibrary.simpleMessage("Termini di Servizio"),
        "settings_accounts_add":
            MessageLookupByLibrary.simpleMessage("Aggiungi nuovo account"),
        "settings_accounts_delete":
            MessageLookupByLibrary.simpleMessage("Elimina account"),
        "settings_accounts_delete_description": m25,
        "settings_accounts_manage":
            MessageLookupByLibrary.simpleMessage("Gestisci account"),
        "settings_accounts_relogin":
            MessageLookupByLibrary.simpleMessage("Riaccedi all\'account"),
        "settings_common": MessageLookupByLibrary.simpleMessage("Comune"),
        "settings_dark_theme":
            MessageLookupByLibrary.simpleMessage("Tema dell\'app"),
        "settings_dark_theme_dark":
            MessageLookupByLibrary.simpleMessage("Scuro"),
        "settings_dark_theme_light":
            MessageLookupByLibrary.simpleMessage("Chiaro"),
        "settings_dark_theme_system":
            MessageLookupByLibrary.simpleMessage("Tema del sistema"),
        "settings_delete_account":
            MessageLookupByLibrary.simpleMessage("Elimina account"),
        "settings_language": MessageLookupByLibrary.simpleMessage("Lingua"),
        "settings_language_system":
            MessageLookupByLibrary.simpleMessage("Lingua del sistema"),
        "settings_sync":
            MessageLookupByLibrary.simpleMessage("Sincronizzazione"),
        "settings_sync_frequency": MessageLookupByLibrary.simpleMessage(
            "Frequenza di sincronizzazione"),
        "settings_sync_frequency_daily":
            MessageLookupByLibrary.simpleMessage("giornaliera"),
        "settings_sync_frequency_hours1":
            MessageLookupByLibrary.simpleMessage("1 ora"),
        "settings_sync_frequency_hours2":
            MessageLookupByLibrary.simpleMessage("2 ore"),
        "settings_sync_frequency_minutes30":
            MessageLookupByLibrary.simpleMessage("30 minuti"),
        "settings_sync_frequency_minutes5":
            MessageLookupByLibrary.simpleMessage("5 minuti"),
        "settings_sync_frequency_monthly":
            MessageLookupByLibrary.simpleMessage("mensile"),
        "settings_sync_frequency_never":
            MessageLookupByLibrary.simpleMessage("mai"),
        "settings_sync_frequency_weekly":
            MessageLookupByLibrary.simpleMessage("settimanale"),
        "settings_sync_frequency_yearly":
            MessageLookupByLibrary.simpleMessage("annuale"),
        "settings_sync_period":
            MessageLookupByLibrary.simpleMessage("Periodo di sincronizzazione"),
        "settings_sync_period_all_time":
            MessageLookupByLibrary.simpleMessage("sempre"),
        "settings_sync_period_months1":
            MessageLookupByLibrary.simpleMessage("1 mese"),
        "settings_sync_period_months3":
            MessageLookupByLibrary.simpleMessage("3 mesi"),
        "settings_sync_period_months6":
            MessageLookupByLibrary.simpleMessage("6 mesi"),
        "settings_sync_period_years1":
            MessageLookupByLibrary.simpleMessage("1 anno"),
        "template_self_destructing_message": m26,
        "template_self_destructing_message_password": m27,
        "template_self_destructing_message_title":
            MessageLookupByLibrary.simpleMessage(
                "Il messaggio sicuro è stato condiviso con te"),
        "tfa_btn_other_options":
            MessageLookupByLibrary.simpleMessage("Altre opzioni"),
        "tfa_btn_use_auth_app":
            MessageLookupByLibrary.simpleMessage("Usa app Authenticator"),
        "tfa_btn_use_backup_code":
            MessageLookupByLibrary.simpleMessage("Usa codice di backup"),
        "tfa_btn_use_security_key": MessageLookupByLibrary.simpleMessage(
            "Usa la tua chiave di sicurezza"),
        "tfa_button_continue": MessageLookupByLibrary.simpleMessage("Continua"),
        "tfa_check_box_trust_device": m28,
        "tfa_error_invalid_backup_code":
            MessageLookupByLibrary.simpleMessage("Codice di backup non valido"),
        "tfa_hint_step": MessageLookupByLibrary.simpleMessage(
            "Questo passaggio aggiuntivo serve a confermare che sei davvero tu che stai cercando di accedere"),
        "tfa_input_backup_code":
            MessageLookupByLibrary.simpleMessage("Codice di backup"),
        "tfa_input_hint_code_from_app": MessageLookupByLibrary.simpleMessage(
            "Specifica il codice di verifica dall\'app Authenticator"),
        "tfa_label":
            MessageLookupByLibrary.simpleMessage("Verifica a Due Fattori"),
        "tfa_label_enter_backup_code": MessageLookupByLibrary.simpleMessage(
            "Inserisci uno dei tuoi codici di backup a 8 caratteri"),
        "tfa_label_hint_security_options": MessageLookupByLibrary.simpleMessage(
            "Opzioni di sicurezza disponibili"),
        "tfa_label_trust_device":
            MessageLookupByLibrary.simpleMessage("Tutto pronto"),
        "week_titles":
            MessageLookupByLibrary.simpleMessage("Lu,Ma,Me,Gi,Ve,Sa,Do")
      };
}
