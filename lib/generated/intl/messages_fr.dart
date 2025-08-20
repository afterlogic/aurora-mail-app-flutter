// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m1(organizer) => "Organisateur : ${organizer}";

  static String m3(emails) => "BCC : ${emails}";

  static String m4(emails) => "CC : ${emails}";

  static String m5(emails) => "De : ${emails}";

  static String m6(date) => "Envoyé : ${date}";

  static String m7(subject) => "Objet : ${subject}";

  static String m8(emails) => "À : ${emails}";

  static String m9(time, from) => "Le ${time}, ${from} a écrit :";

  static String m10(contact) => "Voulez-vous vraiment supprimer ${contact} ?";

  static String m11(group) =>
      "Voulez-vous vraiment supprimer ${group} ? Les contacts de ce groupe ne seront pas supprimés.";

  static String m12(contact, storage) =>
      "${contact} apparaîtra bientôt dans le stockage ${storage}";

  static String m13(users) =>
      "Aucune clé privée trouvée pour l\'utilisateur ${users}.";

  static String m14(name) =>
      "Voulez-vous vraiment supprimer le fichier ${name} ?";

  static String m15(folder) =>
      "Voulez-vous vraiment supprimer tous les messages du dossier ${folder} ?";

  static String m16(user) =>
      "Voulez-vous vraiment supprimer la clé OpenPGP pour ${user} ?";

  static String m17(path) => "Téléchargement vers ${path}";

  static String m18(path) => "Fichier téléchargé dans : ${path}";

  static String m19(fileName) => "Téléchargement de ${fileName}...";

  static String m20(path) => "Fichier importé dans : ${path}";

  static String m21(fileName) => "Importer de ${fileName}...";

  static String m22(subject) => "Voulez-vous vraiment supprimer ${subject} ?";

  static String m23(version) => "Version ${version}";

  static String m24(account) =>
      "Voulez-vous vraiment déconnecter et supprimer ${account} ?";

  static String m25(sender, link, message_password, lifeTime, now) =>
      "Bonjour,\nL\'utilisateur ${sender} vous a envoyé un e-mail sécurisé auto-destructeur.\nVous pouvez le lire en utilisant le lien suivant :\n${link}\n${message_password}Le message sera accessible pendant ${lifeTime} à partir de ${now}";

  static String m26(password) =>
      "Le message est protégé par mot de passe. Le mot de passe est : ${password}\n";

  static String m27(daysCount) =>
      "Ne plus demander sur cet appareil pendant ${daysCount} jours";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Ajouter"),
        "already_have_key": MessageLookupByLibrary.simpleMessage(
            "Vous avez déjà une clé publique ou privée"),
        "app_title":
            MessageLookupByLibrary.simpleMessage("Client de messagerie"),
        "btn_add_account":
            MessageLookupByLibrary.simpleMessage("Ajouter un compte"),
        "btn_back": MessageLookupByLibrary.simpleMessage("Retour"),
        "btn_cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "btn_close": MessageLookupByLibrary.simpleMessage("Fermer"),
        "btn_contact_delete_key":
            MessageLookupByLibrary.simpleMessage("Supprimer la clé"),
        "btn_contact_find_in_email":
            MessageLookupByLibrary.simpleMessage("Trouver dans l\'e-mail"),
        "btn_contact_key_re_import":
            MessageLookupByLibrary.simpleMessage("Réimporter"),
        "btn_delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "btn_discard": MessageLookupByLibrary.simpleMessage("Ignorer"),
        "btn_done": MessageLookupByLibrary.simpleMessage("Terminé"),
        "btn_download": MessageLookupByLibrary.simpleMessage("Télécharger"),
        "btn_exit": MessageLookupByLibrary.simpleMessage("Quitter"),
        "btn_hide_details":
            MessageLookupByLibrary.simpleMessage("Masquer les détails"),
        "btn_log_delete_all":
            MessageLookupByLibrary.simpleMessage("Tout supprimer"),
        "btn_login": MessageLookupByLibrary.simpleMessage("Connexion"),
        "btn_login_back_to_login":
            MessageLookupByLibrary.simpleMessage("Retour à la connexion"),
        "btn_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Recherche avancée"),
        "btn_message_empty_spam_folder":
            MessageLookupByLibrary.simpleMessage("Vider le spam"),
        "btn_message_empty_trash_folder":
            MessageLookupByLibrary.simpleMessage("Vider la corbeille"),
        "btn_message_move": MessageLookupByLibrary.simpleMessage("Déplacer"),
        "btn_message_resend": MessageLookupByLibrary.simpleMessage("Renvoyer"),
        "btn_not_spam": MessageLookupByLibrary.simpleMessage("Pas spam"),
        "btn_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "btn_pgp_check_keys":
            MessageLookupByLibrary.simpleMessage("Vérifier les clés"),
        "btn_pgp_decrypt": MessageLookupByLibrary.simpleMessage("Déchiffrer"),
        "btn_pgp_download_all":
            MessageLookupByLibrary.simpleMessage("Tout télécharger"),
        "btn_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Chiffrer"),
        "btn_pgp_export_all_public_keys": MessageLookupByLibrary.simpleMessage(
            "Exporter toutes les clés publiques"),
        "btn_pgp_generate": MessageLookupByLibrary.simpleMessage("Générer"),
        "btn_pgp_generate_keys":
            MessageLookupByLibrary.simpleMessage("Générer des clés"),
        "btn_pgp_import_from_file":
            MessageLookupByLibrary.simpleMessage("Importer depuis un fichier"),
        "btn_pgp_import_from_text":
            MessageLookupByLibrary.simpleMessage("Importer depuis le texte"),
        "btn_pgp_import_keys_from_file": MessageLookupByLibrary.simpleMessage(
            "Importer les clés depuis un fichier"),
        "btn_pgp_import_keys_from_text": MessageLookupByLibrary.simpleMessage(
            "Importer les clés depuis le texte"),
        "btn_pgp_import_selected_key": MessageLookupByLibrary.simpleMessage(
            "Importer les clés sélectionnées"),
        "btn_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Signer/Chiffrer"),
        "btn_pgp_undo_pgp": MessageLookupByLibrary.simpleMessage("Annuler PGP"),
        "btn_php_send_all":
            MessageLookupByLibrary.simpleMessage("Tout envoyer"),
        "btn_read": MessageLookupByLibrary.simpleMessage("Lu"),
        "btn_resend_push_token":
            MessageLookupByLibrary.simpleMessage("Renvoyer le jeton push"),
        "btn_save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
        "btn_self_destructing":
            MessageLookupByLibrary.simpleMessage("Auto-destructeur"),
        "btn_share": MessageLookupByLibrary.simpleMessage("Partager"),
        "btn_show_all": MessageLookupByLibrary.simpleMessage("Tout afficher"),
        "btn_show_details":
            MessageLookupByLibrary.simpleMessage("Afficher les détails"),
        "btn_show_email_in_light_theme": MessageLookupByLibrary.simpleMessage(
            "Afficher l\'e-mail en thème clair"),
        "btn_to_spam": MessageLookupByLibrary.simpleMessage("Vers spam"),
        "btn_unread": MessageLookupByLibrary.simpleMessage("Non lu"),
        "btn_vcf_import": MessageLookupByLibrary.simpleMessage("Importer"),
        "btn_verify_pin": MessageLookupByLibrary.simpleMessage("Vérifier"),
        "button_pgp_verify_sign":
            MessageLookupByLibrary.simpleMessage("Vérifier"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendrier"),
        "calendar_add_attendee_title":
            MessageLookupByLibrary.simpleMessage("Ajouter un participant"),
        "calendar_always": MessageLookupByLibrary.simpleMessage("Toujours"),
        "calendar_before": MessageLookupByLibrary.simpleMessage("avant"),
        "calendar_color_label": MessageLookupByLibrary.simpleMessage("Couleur"),
        "calendar_create_event":
            MessageLookupByLibrary.simpleMessage("Créer un événement"),
        "calendar_create_event_title":
            MessageLookupByLibrary.simpleMessage("Créer un événement"),
        "calendar_create_task":
            MessageLookupByLibrary.simpleMessage("Créer une tâche"),
        "calendar_create_task_title":
            MessageLookupByLibrary.simpleMessage("Créer une tâche"),
        "calendar_create_title":
            MessageLookupByLibrary.simpleMessage("Créer un calendrier"),
        "calendar_delete_calendar":
            MessageLookupByLibrary.simpleMessage("Supprimer le calendrier"),
        "calendar_delete_event_title":
            MessageLookupByLibrary.simpleMessage("Supprimer l\'événement"),
        "calendar_delete_task_title":
            MessageLookupByLibrary.simpleMessage("Supprimer la tâche"),
        "calendar_description_label":
            MessageLookupByLibrary.simpleMessage("Description"),
        "calendar_drawer_get_link":
            MessageLookupByLibrary.simpleMessage("Obtenir un lien"),
        "calendar_drawer_my_calendars":
            MessageLookupByLibrary.simpleMessage("Mes calendriers"),
        "calendar_edit_event_title":
            MessageLookupByLibrary.simpleMessage("Modifier l\'événement"),
        "calendar_edit_task_title":
            MessageLookupByLibrary.simpleMessage("Modifier la tâche"),
        "calendar_edit_title":
            MessageLookupByLibrary.simpleMessage("Modifier le calendrier"),
        "calendar_event_title":
            MessageLookupByLibrary.simpleMessage("Événement"),
        "calendar_filter_all": MessageLookupByLibrary.simpleMessage("Tous"),
        "calendar_filter_completed":
            MessageLookupByLibrary.simpleMessage("Terminées"),
        "calendar_filter_data": MessageLookupByLibrary.simpleMessage("Données"),
        "calendar_filter_has_date":
            MessageLookupByLibrary.simpleMessage("A une date"),
        "calendar_filter_task_status":
            MessageLookupByLibrary.simpleMessage("Statut de la tâche"),
        "calendar_filter_title": MessageLookupByLibrary.simpleMessage("Filtre"),
        "calendar_filter_uncompleted":
            MessageLookupByLibrary.simpleMessage("Non terminées"),
        "calendar_filter_without_date":
            MessageLookupByLibrary.simpleMessage("Sans date"),
        "calendar_get_public_link": MessageLookupByLibrary.simpleMessage(
            "Obtenir un lien public vers le calendrier"),
        "calendar_ical_url_label":
            MessageLookupByLibrary.simpleMessage("URL iCal"),
        "calendar_import_ics_file":
            MessageLookupByLibrary.simpleMessage("Importer un fichier ICS"),
        "calendar_input_all_day":
            MessageLookupByLibrary.simpleMessage("Toute la journée"),
        "calendar_input_attendees":
            MessageLookupByLibrary.simpleMessage("Participants"),
        "calendar_input_description":
            MessageLookupByLibrary.simpleMessage("Description"),
        "calendar_input_location":
            MessageLookupByLibrary.simpleMessage("Emplacement"),
        "calendar_input_reminders":
            MessageLookupByLibrary.simpleMessage("Rappels"),
        "calendar_input_title": MessageLookupByLibrary.simpleMessage("Titre"),
        "calendar_name_label":
            MessageLookupByLibrary.simpleMessage("Nom du calendrier"),
        "calendar_organizer_label": m1,
        "calendar_please_select_calendar": MessageLookupByLibrary.simpleMessage(
            "Veuillez sélectionner un calendrier"),
        "calendar_read_permission":
            MessageLookupByLibrary.simpleMessage("lecture"),
        "calendar_select_calendar":
            MessageLookupByLibrary.simpleMessage("Sélectionner un calendrier"),
        "calendar_selected_calendar_not_found":
            MessageLookupByLibrary.simpleMessage(
                "Calendrier sélectionné introuvable"),
        "calendar_shared_with_all":
            MessageLookupByLibrary.simpleMessage("Partagé avec tous"),
        "calendar_shared_with_me":
            MessageLookupByLibrary.simpleMessage("Partagé avec moi"),
        "calendar_sharing_all": MessageLookupByLibrary.simpleMessage("Tous"),
        "calendar_sharing_title":
            MessageLookupByLibrary.simpleMessage("Partager le calendrier"),
        "calendar_subscribe_ical_feed":
            MessageLookupByLibrary.simpleMessage("S\'abonner au flux iCal"),
        "calendar_tab_day": MessageLookupByLibrary.simpleMessage("Jour"),
        "calendar_tab_month": MessageLookupByLibrary.simpleMessage("Mois"),
        "calendar_tab_tasks": MessageLookupByLibrary.simpleMessage("Tâches"),
        "calendar_tab_week": MessageLookupByLibrary.simpleMessage("Semaine"),
        "calendar_task_title": MessageLookupByLibrary.simpleMessage("Tâche"),
        "calendar_unsubscribe":
            MessageLookupByLibrary.simpleMessage("Se désabonner"),
        "calendar_unsubscribe_from_calendar":
            MessageLookupByLibrary.simpleMessage("Se désabonner du calendrier"),
        "calendar_until": MessageLookupByLibrary.simpleMessage("jusqu\'à"),
        "calendar_validation_enter_text":
            MessageLookupByLibrary.simpleMessage("Veuillez saisir du texte"),
        "clear_cache_during_logout": MessageLookupByLibrary.simpleMessage(
            "Supprimer les données en cache et les clés"),
        "compose_body_placeholder":
            MessageLookupByLibrary.simpleMessage("Message"),
        "compose_discard_save_dialog_description":
            MessageLookupByLibrary.simpleMessage(
                "Enregistrer les modifications dans les brouillons ?"),
        "compose_discard_save_dialog_title":
            MessageLookupByLibrary.simpleMessage("Ignorer les modifications"),
        "compose_forward_bcc": m3,
        "compose_forward_body_original_message":
            MessageLookupByLibrary.simpleMessage("---- Message original ----"),
        "compose_forward_cc": m4,
        "compose_forward_from": m5,
        "compose_forward_sent": m6,
        "compose_forward_subject": m7,
        "compose_forward_to": m8,
        "compose_reply_body_title": m9,
        "contacts": MessageLookupByLibrary.simpleMessage("Contacts"),
        "contacts_add":
            MessageLookupByLibrary.simpleMessage("Ajouter un contact"),
        "contacts_delete_desc_with_name": m10,
        "contacts_delete_selected": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment supprimer les contacts sélectionnés ?"),
        "contacts_delete_title":
            MessageLookupByLibrary.simpleMessage("Supprimer le contact"),
        "contacts_delete_title_plural":
            MessageLookupByLibrary.simpleMessage("Supprimer les contacts"),
        "contacts_drawer_section_groups":
            MessageLookupByLibrary.simpleMessage("Groupes"),
        "contacts_drawer_section_storages":
            MessageLookupByLibrary.simpleMessage("Stockages"),
        "contacts_drawer_storage_all":
            MessageLookupByLibrary.simpleMessage("Tous"),
        "contacts_drawer_storage_personal":
            MessageLookupByLibrary.simpleMessage("Personnel"),
        "contacts_drawer_storage_shared":
            MessageLookupByLibrary.simpleMessage("Partagé avec tous"),
        "contacts_drawer_storage_team":
            MessageLookupByLibrary.simpleMessage("Équipe"),
        "contacts_edit":
            MessageLookupByLibrary.simpleMessage("Modifier le contact"),
        "contacts_edit_cancel": MessageLookupByLibrary.simpleMessage(
            "Annuler la modification du contact"),
        "contacts_edit_save": MessageLookupByLibrary.simpleMessage(
            "Enregistrer les modifications"),
        "contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Aucune adresse e-mail"),
        "contacts_empty": MessageLookupByLibrary.simpleMessage("Aucun contact"),
        "contacts_group_add":
            MessageLookupByLibrary.simpleMessage("Ajouter un groupe"),
        "contacts_group_add_to_group":
            MessageLookupByLibrary.simpleMessage("Ajouter au groupe"),
        "contacts_group_delete_desc_with_name": m11,
        "contacts_group_delete_title":
            MessageLookupByLibrary.simpleMessage("Supprimer le groupe"),
        "contacts_group_edit":
            MessageLookupByLibrary.simpleMessage("Modifier le groupe"),
        "contacts_group_edit_cancel": MessageLookupByLibrary.simpleMessage(
            "Annuler la modification du groupe"),
        "contacts_group_edit_is_organization":
            MessageLookupByLibrary.simpleMessage(
                "Ce groupe est une entreprise"),
        "contacts_group_view_app_bar_delete":
            MessageLookupByLibrary.simpleMessage("Supprimer ce groupe"),
        "contacts_group_view_app_bar_edit":
            MessageLookupByLibrary.simpleMessage("Modifier le groupe"),
        "contacts_group_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "Envoyer un e-mail aux contacts de ce groupe"),
        "contacts_groups_empty":
            MessageLookupByLibrary.simpleMessage("Aucun groupe"),
        "contacts_list_app_bar_all_contacts":
            MessageLookupByLibrary.simpleMessage("Tous les contacts"),
        "contacts_list_app_bar_view_group":
            MessageLookupByLibrary.simpleMessage("Voir le groupe"),
        "contacts_list_its_me_flag":
            MessageLookupByLibrary.simpleMessage("C\'est moi !"),
        "contacts_remove_from_group": MessageLookupByLibrary.simpleMessage(
            "Supprimer les contacts du groupe"),
        "contacts_remove_selected": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment supprimer les contacts sélectionnés du groupe ?"),
        "contacts_shared_message": m12,
        "contacts_view_address":
            MessageLookupByLibrary.simpleMessage("Adresse"),
        "contacts_view_app_bar_attach":
            MessageLookupByLibrary.simpleMessage("Envoyer"),
        "contacts_view_app_bar_delete_contact":
            MessageLookupByLibrary.simpleMessage("Supprimer"),
        "contacts_view_app_bar_edit_contact":
            MessageLookupByLibrary.simpleMessage("Modifier"),
        "contacts_view_app_bar_search_messages":
            MessageLookupByLibrary.simpleMessage("Rechercher des messages"),
        "contacts_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "Envoyer un e-mail à ce contact"),
        "contacts_view_app_bar_share":
            MessageLookupByLibrary.simpleMessage("Partager"),
        "contacts_view_app_bar_unshare":
            MessageLookupByLibrary.simpleMessage("Ne plus partager"),
        "contacts_view_birthday":
            MessageLookupByLibrary.simpleMessage("Anniversaire"),
        "contacts_view_business_address":
            MessageLookupByLibrary.simpleMessage("Adresse professionnelle"),
        "contacts_view_business_email":
            MessageLookupByLibrary.simpleMessage("E-mail professionnel"),
        "contacts_view_business_phone":
            MessageLookupByLibrary.simpleMessage("Téléphone professionnel"),
        "contacts_view_city": MessageLookupByLibrary.simpleMessage("Ville"),
        "contacts_view_company":
            MessageLookupByLibrary.simpleMessage("Entreprise"),
        "contacts_view_country":
            MessageLookupByLibrary.simpleMessage("Pays/Région"),
        "contacts_view_department":
            MessageLookupByLibrary.simpleMessage("Département"),
        "contacts_view_display_name":
            MessageLookupByLibrary.simpleMessage("Nom d\'affichage"),
        "contacts_view_email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "contacts_view_facebook":
            MessageLookupByLibrary.simpleMessage("Facebook"),
        "contacts_view_fax": MessageLookupByLibrary.simpleMessage("Fax"),
        "contacts_view_first_name":
            MessageLookupByLibrary.simpleMessage("Prénom"),
        "contacts_view_hide_additional_fields":
            MessageLookupByLibrary.simpleMessage(
                "Masquer les champs supplémentaires"),
        "contacts_view_job_title":
            MessageLookupByLibrary.simpleMessage("Titre du poste"),
        "contacts_view_last_name":
            MessageLookupByLibrary.simpleMessage("Nom de famille"),
        "contacts_view_mobile": MessageLookupByLibrary.simpleMessage("Mobile"),
        "contacts_view_name": MessageLookupByLibrary.simpleMessage("Nom"),
        "contacts_view_nickname":
            MessageLookupByLibrary.simpleMessage("Surnom"),
        "contacts_view_notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "contacts_view_office": MessageLookupByLibrary.simpleMessage("Bureau"),
        "contacts_view_other_email":
            MessageLookupByLibrary.simpleMessage("Autre e-mail"),
        "contacts_view_personal_address":
            MessageLookupByLibrary.simpleMessage("Adresse personnelle"),
        "contacts_view_personal_email":
            MessageLookupByLibrary.simpleMessage("E-mail personnel"),
        "contacts_view_personal_phone":
            MessageLookupByLibrary.simpleMessage("Téléphone personnel"),
        "contacts_view_phone":
            MessageLookupByLibrary.simpleMessage("Téléphone"),
        "contacts_view_province":
            MessageLookupByLibrary.simpleMessage("État/Province"),
        "contacts_view_section_business":
            MessageLookupByLibrary.simpleMessage("Professionnel"),
        "contacts_view_section_group_name":
            MessageLookupByLibrary.simpleMessage("Nom du groupe"),
        "contacts_view_section_groups":
            MessageLookupByLibrary.simpleMessage("Groupes"),
        "contacts_view_section_home":
            MessageLookupByLibrary.simpleMessage("Domicile"),
        "contacts_view_section_key":
            MessageLookupByLibrary.simpleMessage("Clé"),
        "contacts_view_section_other_info":
            MessageLookupByLibrary.simpleMessage("Autre"),
        "contacts_view_section_personal":
            MessageLookupByLibrary.simpleMessage("Personnel"),
        "contacts_view_show_additional_fields":
            MessageLookupByLibrary.simpleMessage(
                "Afficher les champs supplémentaires"),
        "contacts_view_skype": MessageLookupByLibrary.simpleMessage("Skype"),
        "contacts_view_street_address":
            MessageLookupByLibrary.simpleMessage("Rue"),
        "contacts_view_web_page":
            MessageLookupByLibrary.simpleMessage("Page web"),
        "contacts_view_zip":
            MessageLookupByLibrary.simpleMessage("Code postal"),
        "debug_hint_log_delete_record": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment supprimer le fichier ?"),
        "error_compose_no_receivers": MessageLookupByLibrary.simpleMessage(
            "Veuillez fournir des destinataires"),
        "error_compose_wait_attachments": MessageLookupByLibrary.simpleMessage(
            "Veuillez attendre que les pièces jointes soient téléversées"),
        "error_connection": MessageLookupByLibrary.simpleMessage(
            "Impossible de se connecter au serveur"),
        "error_connection_offline":
            MessageLookupByLibrary.simpleMessage("Vous êtes hors ligne"),
        "error_contact_pgp_key_will_not_be_valid":
            MessageLookupByLibrary.simpleMessage(
                "La clé PGP ne sera pas valide"),
        "error_contacts_email_empty": MessageLookupByLibrary.simpleMessage(
            "Veuillez spécifier un e-mail"),
        "error_contacts_save_name_empty":
            MessageLookupByLibrary.simpleMessage("Veuillez spécifier le nom"),
        "error_input_validation_email":
            MessageLookupByLibrary.simpleMessage("L\'e-mail n\'est pas valide"),
        "error_input_validation_empty":
            MessageLookupByLibrary.simpleMessage("Ce champ est obligatoire"),
        "error_input_validation_name_illegal_symbol":
            MessageLookupByLibrary.simpleMessage(
                "Le nom ne peut pas contenir \"/\\*?<>|:\""),
        "error_input_validation_unique_name":
            MessageLookupByLibrary.simpleMessage("Ce nom existe déjà"),
        "error_invalid_pin":
            MessageLookupByLibrary.simpleMessage("Code invalide"),
        "error_login_account_exists": MessageLookupByLibrary.simpleMessage(
            "Ce compte existe déjà dans votre liste de comptes."),
        "error_login_auto_discover": MessageLookupByLibrary.simpleMessage(
            "Impossible de détecter le domaine à partir de cet e-mail, veuillez spécifier manuellement l\'URL de votre serveur."),
        "error_login_input_email":
            MessageLookupByLibrary.simpleMessage("Veuillez saisir l\'e-mail"),
        "error_login_input_hostname": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir le nom d\'hôte"),
        "error_login_input_password": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir le mot de passe"),
        "error_login_no_accounts": MessageLookupByLibrary.simpleMessage(
            "Cet utilisateur n\'a pas de comptes de messagerie"),
        "error_message_not_found":
            MessageLookupByLibrary.simpleMessage("Message non trouvé"),
        "error_no_pgp_key": MessageLookupByLibrary.simpleMessage(
            "Aucune clé publique PGP trouvée"),
        "error_password_is_empty":
            MessageLookupByLibrary.simpleMessage("le mot de passe est vide"),
        "error_pgp_can_not_decrypt": MessageLookupByLibrary.simpleMessage(
            "Impossible de déchiffrer le message."),
        "error_pgp_invalid_key_or_password":
            MessageLookupByLibrary.simpleMessage(
                "Clé ou mot de passe invalide."),
        "error_pgp_invalid_password":
            MessageLookupByLibrary.simpleMessage("mot de passe invalide"),
        "error_pgp_keys_not_found":
            MessageLookupByLibrary.simpleMessage("Clés non trouvées"),
        "error_pgp_need_contact_for_encrypt": MessageLookupByLibrary.simpleMessage(
            "Pour chiffrer votre message, vous devez spécifier au moins un destinataire."),
        "error_pgp_not_found_keys_for": m13,
        "error_pgp_select_recipient": MessageLookupByLibrary.simpleMessage(
            "Sélectionner le destinataire"),
        "error_server_access_denied":
            MessageLookupByLibrary.simpleMessage("Accès refusé"),
        "error_server_account_exists":
            MessageLookupByLibrary.simpleMessage("Ce compte existe déjà"),
        "error_server_account_old_password_not_correct":
            MessageLookupByLibrary.simpleMessage(
                "L\'ancien mot de passe du compte n\'est pas correct"),
        "error_server_auth_error": MessageLookupByLibrary.simpleMessage(
            "E-mail/mot de passe invalide"),
        "error_server_calendars_not_allowed":
            MessageLookupByLibrary.simpleMessage("Calendriers non autorisés"),
        "error_server_can_not_change_password":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de changer le mot de passe"),
        "error_server_can_not_create_account":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de créer le compte"),
        "error_server_can_not_create_contact":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de créer le contact"),
        "error_server_can_not_create_group":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de créer le groupe"),
        "error_server_can_not_create_helpdesk_user":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de créer l\'utilisateur du service d\'assistance"),
        "error_server_can_not_get_contact":
            MessageLookupByLibrary.simpleMessage(
                "Impossible d\'obtenir le contact"),
        "error_server_can_not_save_settings":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de sauvegarder les paramètres"),
        "error_server_can_not_update_contact":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de mettre à jour le contact"),
        "error_server_can_not_update_group":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de mettre à jour le groupe"),
        "error_server_can_not_upload_file_limit":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de téléverser en raison de la limite de fichier"),
        "error_server_can_not_upload_file_quota":
            MessageLookupByLibrary.simpleMessage(
                "Vous avez atteint la limite d\'espace de stockage cloud. Impossible de téléverser le fichier."),
        "error_server_captcha_error":
            MessageLookupByLibrary.simpleMessage("Erreur de captcha"),
        "error_server_contact_data_has_been_modified_by_another_application":
            MessageLookupByLibrary.simpleMessage(
                "Les données du contact ont été modifiées par une autre application"),
        "error_server_contacts_not_allowed":
            MessageLookupByLibrary.simpleMessage("Contacts non autorisés"),
        "error_server_data_base_error":
            MessageLookupByLibrary.simpleMessage("Erreur de base de données"),
        "error_server_demo_account":
            MessageLookupByLibrary.simpleMessage("Compte de démonstration"),
        "error_server_file_already_exists":
            MessageLookupByLibrary.simpleMessage("Ce fichier existe déjà"),
        "error_server_file_not_found":
            MessageLookupByLibrary.simpleMessage("Fichier non trouvé"),
        "error_server_files_not_allowed":
            MessageLookupByLibrary.simpleMessage("Fichiers non autorisés"),
        "error_server_helpdesk_system_user_exists":
            MessageLookupByLibrary.simpleMessage(
                "L\'utilisateur système du service d\'assistance existe déjà"),
        "error_server_helpdesk_unactivated_user":
            MessageLookupByLibrary.simpleMessage(
                "Utilisateur désactivé du service d\'assistance"),
        "error_server_helpdesk_unknown_user":
            MessageLookupByLibrary.simpleMessage(
                "Utilisateur inconnu du service d\'assistance"),
        "error_server_helpdesk_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "L\'utilisateur du service d\'assistance existe déjà"),
        "error_server_incorrect_file_extension":
            MessageLookupByLibrary.simpleMessage(
                "Extension de fichier incorrecte"),
        "error_server_invalid_input_parameter":
            MessageLookupByLibrary.simpleMessage(
                "Paramètre d\'entrée invalide"),
        "error_server_invalid_token":
            MessageLookupByLibrary.simpleMessage("Jeton invalide"),
        "error_server_license_limit":
            MessageLookupByLibrary.simpleMessage("Limite de licence"),
        "error_server_license_problem":
            MessageLookupByLibrary.simpleMessage("Problème de licence"),
        "error_server_mail_server_error": MessageLookupByLibrary.simpleMessage(
            "Erreur du serveur de messagerie"),
        "error_server_method_not_found":
            MessageLookupByLibrary.simpleMessage("Méthode non trouvée"),
        "error_server_module_not_found":
            MessageLookupByLibrary.simpleMessage("Module non trouvé"),
        "error_server_rest_account_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "Échec de la recherche de compte REST"),
        "error_server_rest_api_disabled":
            MessageLookupByLibrary.simpleMessage("API REST désactivée"),
        "error_server_rest_invalid_credentials":
            MessageLookupByLibrary.simpleMessage("Identifiants REST invalides"),
        "error_server_rest_invalid_parameters":
            MessageLookupByLibrary.simpleMessage("Paramètres REST invalides"),
        "error_server_rest_invalid_token":
            MessageLookupByLibrary.simpleMessage("Jeton REST invalide"),
        "error_server_rest_other_error":
            MessageLookupByLibrary.simpleMessage("Autre erreur REST"),
        "error_server_rest_tenant_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "Échec de la recherche de locataire REST"),
        "error_server_rest_token_expired":
            MessageLookupByLibrary.simpleMessage("Jeton REST expiré"),
        "error_server_rest_unknown_method":
            MessageLookupByLibrary.simpleMessage("Méthode REST inconnue"),
        "error_server_system_not_configured":
            MessageLookupByLibrary.simpleMessage(
                "Le système n\'est pas configuré"),
        "error_server_unknown_email":
            MessageLookupByLibrary.simpleMessage("E-mail inconnu"),
        "error_server_user_already_exists":
            MessageLookupByLibrary.simpleMessage("Cet utilisateur existe déjà"),
        "error_server_user_not_allowed":
            MessageLookupByLibrary.simpleMessage("Utilisateur non autorisé"),
        "error_server_voice_not_allowed":
            MessageLookupByLibrary.simpleMessage("Voix non autorisée"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Impossible de se connecter au serveur"),
        "error_unknown":
            MessageLookupByLibrary.simpleMessage("Erreur inconnue"),
        "error_user_already_logged": MessageLookupByLibrary.simpleMessage(
            "Cet utilisateur est déjà connecté"),
        "fido_btn_try_again": MessageLookupByLibrary.simpleMessage("Réessayer"),
        "fido_btn_use_key":
            MessageLookupByLibrary.simpleMessage("Utiliser la clé de sécurité"),
        "fido_error_hint": MessageLookupByLibrary.simpleMessage(
            "Essayez d\'utiliser à nouveau votre clé de sécurité ou essayez une autre façon de vérifier que c\'est vous"),
        "fido_error_invalid_key":
            MessageLookupByLibrary.simpleMessage("Clé de sécurité invalide"),
        "fido_error_title":
            MessageLookupByLibrary.simpleMessage("Il y a eu un problème"),
        "fido_hint_follow_the_instructions": MessageLookupByLibrary.simpleMessage(
            "Veuillez suivre les instructions dans la boîte de dialogue contextuelle"),
        "fido_label_connect_your_key": MessageLookupByLibrary.simpleMessage(
            "Veuillez scanner votre clé de sécurité ou l\'insérer dans l\'appareil"),
        "fido_label_success": MessageLookupByLibrary.simpleMessage("Succès"),
        "fido_label_touch_your_key": MessageLookupByLibrary.simpleMessage(
            "Touchez votre clé de sécurité"),
        "folders_drafts": MessageLookupByLibrary.simpleMessage("Brouillons"),
        "folders_empty": MessageLookupByLibrary.simpleMessage("Aucun dossier"),
        "folders_inbox":
            MessageLookupByLibrary.simpleMessage("Boîte de réception"),
        "folders_notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "folders_sent": MessageLookupByLibrary.simpleMessage("Envoyés"),
        "folders_spam": MessageLookupByLibrary.simpleMessage("Spam"),
        "folders_starred": MessageLookupByLibrary.simpleMessage("Favoris"),
        "folders_trash": MessageLookupByLibrary.simpleMessage("Corbeille"),
        "format_compose_forward_date":
            MessageLookupByLibrary.simpleMessage("EEE, MMM d, yyyy, HH:mm"),
        "format_compose_reply_date": MessageLookupByLibrary.simpleMessage(
            "EEE, MMM d, yyyy \'à\' HH:mm"),
        "format_contacts_birth_date":
            MessageLookupByLibrary.simpleMessage("MMM d, yyyy"),
        "hint_2fa": MessageLookupByLibrary.simpleMessage(
            "Votre compte est protégé par\nune authentification à deux facteurs.\nVeuillez fournir le code PIN."),
        "hint_auto_encrypt_messages": MessageLookupByLibrary.simpleMessage(
            "Si vous voulez que les messages à ce contact soient automatiquement chiffrés et/ou signés, cochez les cases ci-dessous. Veuillez noter que ces messages seront convertis en texte brut. Les pièces jointes ne seront pas chiffrées."),
        "hint_confirm_exit": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment quitter ?"),
        "hint_log_delete_all": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment supprimer tous les journaux ?"),
        "hint_log_delete_record": m14,
        "hint_login_upgrade_your_plan": MessageLookupByLibrary.simpleMessage(
            "Les applications mobiles ne sont pas autorisées dans votre compte."),
        "hint_message_empty_folder": m15,
        "hint_pgp_already_have_keys": MessageLookupByLibrary.simpleMessage(
            "Les clés qui sont déjà dans le système sont grisées."),
        "hint_pgp_delete_user_key_confirm": m16,
        "hint_pgp_existed_keys": MessageLookupByLibrary.simpleMessage(
            "Les clés qui sont déjà dans le système ne seront pas importées"),
        "hint_pgp_external_private_keys": MessageLookupByLibrary.simpleMessage(
            "Les clés privées externes ne sont pas prises en charge et ne seront pas importées"),
        "hint_pgp_keys_contacts_will_be_created":
            MessageLookupByLibrary.simpleMessage(
                "Pour ces clés, des contacts seront créés"),
        "hint_pgp_keys_for_import": MessageLookupByLibrary.simpleMessage(
            "Clés disponibles pour l\'importation"),
        "hint_pgp_keys_will_be_import_to_contacts":
            MessageLookupByLibrary.simpleMessage(
                "Les clés seront importées dans les contacts"),
        "hint_pgp_message_automatically_encrypt":
            MessageLookupByLibrary.simpleMessage(
                "Le message sera automatiquement chiffré et/ou signé pour les contacts avec des clés OpenPgp.\n OpenPGP ne prend en charge que le texte brut. Tout le formatage sera supprimé avant le chiffrement."),
        "hint_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
            "Vous allez partager votre clé PGP privée. La clé doit être tenue à l\'écart des tiers. Voulez-vous continuer ?"),
        "hint_pgp_your_keys": MessageLookupByLibrary.simpleMessage("Vos clés"),
        "hint_self_destructing_encrypt_with_key":
            MessageLookupByLibrary.simpleMessage(
                "Le destinataire sélectionné a une clé publique PGP. Le message peut être chiffré en utilisant cette clé."),
        "hint_self_destructing_encrypt_with_not_key":
            MessageLookupByLibrary.simpleMessage(
                "Le destinataire sélectionné n\'a pas de clé publique PGP. Le chiffrement basé sur clé n\'est pas autorisé"),
        "hint_self_destructing_password_coppied_to_clipboard":
            MessageLookupByLibrary.simpleMessage(
                "Mot de passe copié dans le presse-papiers"),
        "hint_self_destructing_sent_password_using_different_channel":
            MessageLookupByLibrary.simpleMessage(
                "Le mot de passe doit être envoyé par un canal différent.\nStockez le mot de passe quelque part. Vous ne pourrez pas le récupérer autrement."),
        "hint_self_destructing_supports_plain_text_only":
            MessageLookupByLibrary.simpleMessage(
                "Les e-mails sécurisés auto-destructeurs ne prennent en charge que le texte brut. Tout le formatage sera supprimé. De plus, les pièces jointes ne peuvent pas être chiffrées et seront supprimées du message."),
        "hint_vcf_import": MessageLookupByLibrary.simpleMessage(
            "Importer le contact depuis vcf ?"),
        "input_2fa_pin":
            MessageLookupByLibrary.simpleMessage("Code de vérification"),
        "input_message_search_since":
            MessageLookupByLibrary.simpleMessage("Depuis"),
        "input_message_search_text":
            MessageLookupByLibrary.simpleMessage("Texte"),
        "input_message_search_till":
            MessageLookupByLibrary.simpleMessage("Jusqu\'à"),
        "input_self_destructing_add_digital_signature":
            MessageLookupByLibrary.simpleMessage(
                "Ajouter une signature numérique"),
        "input_self_destructing_key_based_encryption":
            MessageLookupByLibrary.simpleMessage("Basé sur clé"),
        "input_self_destructing_password_based_encryption":
            MessageLookupByLibrary.simpleMessage("Basé sur mot de passe"),
        "label_contact_pgp_settings":
            MessageLookupByLibrary.simpleMessage("Paramètres PGP"),
        "label_contact_select_key":
            MessageLookupByLibrary.simpleMessage("Sélectionner la clé"),
        "label_contact_with_not_name":
            MessageLookupByLibrary.simpleMessage("Aucun nom"),
        "label_contacts_were_imported_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Contacts importés avec succès"),
        "label_device_id_copied_to_clip_board":
            MessageLookupByLibrary.simpleMessage(
                "ID de l\'appareil copié dans le presse-papiers"),
        "label_device_identifier":
            MessageLookupByLibrary.simpleMessage("Identifiant de l\'appareil"),
        "label_discard_not_saved_changes": MessageLookupByLibrary.simpleMessage(
            "Ignorer les modifications non sauvegardées ?"),
        "label_enable_uploaded_message_counter":
            MessageLookupByLibrary.simpleMessage(
                "Compteur de messages téléversés"),
        "label_encryption_password_for_pgp_key":
            MessageLookupByLibrary.simpleMessage(
                "Mot de passe requis pour la clé PGP"),
        "label_forward_as_attachment":
            MessageLookupByLibrary.simpleMessage("Transférer en pièce jointe"),
        "label_length": MessageLookupByLibrary.simpleMessage("Longueur"),
        "label_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Recherche avancée"),
        "label_message_headers": MessageLookupByLibrary.simpleMessage(
            "Voir les en-têtes du message"),
        "label_message_move_to":
            MessageLookupByLibrary.simpleMessage("Déplacer vers : "),
        "label_message_move_to_folder":
            MessageLookupByLibrary.simpleMessage("Déplacer vers le dossier"),
        "label_message_yesterday": MessageLookupByLibrary.simpleMessage("Hier"),
        "label_notifications_settings":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "label_pgp_all_public_key":
            MessageLookupByLibrary.simpleMessage("Toutes les clés publiques"),
        "label_pgp_contact_public_keys":
            MessageLookupByLibrary.simpleMessage("Clés publiques externes"),
        "label_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Déchiffrer OpenPGP"),
        "label_pgp_decrypted_and_verified":
            MessageLookupByLibrary.simpleMessage(
                "Le message a été déchiffré et vérifié avec succès."),
        "label_pgp_decrypted_but_not_verified":
            MessageLookupByLibrary.simpleMessage(
                "Le message a été déchiffré avec succès mais n\'a pas été vérifié."),
        "label_pgp_downloading_to": m17,
        "label_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Chiffrer"),
        "label_pgp_import_key":
            MessageLookupByLibrary.simpleMessage("Importer les clés"),
        "label_pgp_key_with_not_name":
            MessageLookupByLibrary.simpleMessage("Aucun nom"),
        "label_pgp_not_verified": MessageLookupByLibrary.simpleMessage(
            "Le message n\'a pas été vérifié."),
        "label_pgp_private_key":
            MessageLookupByLibrary.simpleMessage("Clé privée"),
        "label_pgp_private_keys":
            MessageLookupByLibrary.simpleMessage("Clés privées"),
        "label_pgp_public_key":
            MessageLookupByLibrary.simpleMessage("Clé publique"),
        "label_pgp_public_keys":
            MessageLookupByLibrary.simpleMessage("Clés publiques"),
        "label_pgp_settings": MessageLookupByLibrary.simpleMessage("OpenPGP"),
        "label_pgp_share_warning":
            MessageLookupByLibrary.simpleMessage("Avertissement"),
        "label_pgp_sign": MessageLookupByLibrary.simpleMessage("Signer"),
        "label_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Signer/Chiffrer OpenPGP"),
        "label_pgp_verified": MessageLookupByLibrary.simpleMessage(
            "Le message a été vérifié avec succès."),
        "label_record_log_in_background": MessageLookupByLibrary.simpleMessage(
            "Enregistrer le journal en arrière-plan"),
        "label_self_destructing": MessageLookupByLibrary.simpleMessage(
            "Envoyer un e-mail sécurisé auto-destructeur"),
        "label_self_destructing_key_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Le chiffrement basé sur clé sera utilisé."),
        "label_self_destructing_not_sign_data":
            MessageLookupByLibrary.simpleMessage("Ne signera pas les données."),
        "label_self_destructing_password_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Le chiffrement basé sur mot de passe sera utilisé."),
        "label_self_destructing_sign_data":
            MessageLookupByLibrary.simpleMessage(
                "Signera les données avec votre clé privée."),
        "label_show_debug_view":
            MessageLookupByLibrary.simpleMessage("Afficher la vue de débogage"),
        "label_token_failed": MessageLookupByLibrary.simpleMessage("Échec"),
        "label_token_storing_status":
            MessageLookupByLibrary.simpleMessage("Statut de stockage du jeton"),
        "label_token_successful":
            MessageLookupByLibrary.simpleMessage("Réussi"),
        "login_continue": MessageLookupByLibrary.simpleMessage("Continuer"),
        "login_input_email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "login_input_host": MessageLookupByLibrary.simpleMessage("Hôte"),
        "login_input_password":
            MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "login_no_account_yet":
            MessageLookupByLibrary.simpleMessage("Pas encore de compte ? "),
        "login_register_now":
            MessageLookupByLibrary.simpleMessage("S\'inscrire maintenant"),
        "login_sign_in": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "login_to_continue": MessageLookupByLibrary.simpleMessage(
            "Connectez-vous pour continuer"),
        "message_lifetime":
            MessageLookupByLibrary.simpleMessage("Durée de vie du message"),
        "messages_always_show_images": MessageLookupByLibrary.simpleMessage(
            "Toujours afficher les images des messages de cet expéditeur."),
        "messages_attachment_delete":
            MessageLookupByLibrary.simpleMessage("Supprimer la pièce jointe"),
        "messages_attachment_download":
            MessageLookupByLibrary.simpleMessage("Télécharger la pièce jointe"),
        "messages_attachment_download_cancel":
            MessageLookupByLibrary.simpleMessage("Annuler le téléchargement"),
        "messages_attachment_download_failed":
            MessageLookupByLibrary.simpleMessage("Échec du téléchargement"),
        "messages_attachment_download_success": m18,
        "messages_attachment_downloading": m19,
        "messages_attachment_upload":
            MessageLookupByLibrary.simpleMessage("Importer une pièce jointe"),
        "messages_attachment_upload_cancel":
            MessageLookupByLibrary.simpleMessage("Annuler l\'importation"),
        "messages_attachment_upload_failed":
            MessageLookupByLibrary.simpleMessage("Échec de l\'importation"),
        "messages_attachment_upload_success": m20,
        "messages_attachment_uploading": m21,
        "messages_attachments_empty":
            MessageLookupByLibrary.simpleMessage("Aucune pièce jointe"),
        "messages_bcc": MessageLookupByLibrary.simpleMessage("BCC"),
        "messages_cc": MessageLookupByLibrary.simpleMessage("CC"),
        "messages_delete_desc": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment supprimer ce message ?"),
        "messages_delete_desc_with_count": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment supprimer ces messages ?"),
        "messages_delete_desc_with_subject": m22,
        "messages_delete_title":
            MessageLookupByLibrary.simpleMessage("Supprimer le message"),
        "messages_delete_title_with_count":
            MessageLookupByLibrary.simpleMessage("Supprimer les messages"),
        "messages_empty": MessageLookupByLibrary.simpleMessage("Aucun message"),
        "messages_filter_unread":
            MessageLookupByLibrary.simpleMessage("Messages non lus :"),
        "messages_forward": MessageLookupByLibrary.simpleMessage("Transférer"),
        "messages_from": MessageLookupByLibrary.simpleMessage("De"),
        "messages_images_security_alert": MessageLookupByLibrary.simpleMessage(
            "Les images de ce message ont été bloquées pour votre sécurité."),
        "messages_list_app_bar_contacts":
            MessageLookupByLibrary.simpleMessage("Contacts"),
        "messages_list_app_bar_loading_folders":
            MessageLookupByLibrary.simpleMessage("Chargement des dossiers..."),
        "messages_list_app_bar_logout":
            MessageLookupByLibrary.simpleMessage("Se déconnecter"),
        "messages_list_app_bar_mail":
            MessageLookupByLibrary.simpleMessage("Mail"),
        "messages_list_app_bar_search":
            MessageLookupByLibrary.simpleMessage("Rechercher"),
        "messages_list_app_bar_settings":
            MessageLookupByLibrary.simpleMessage("Paramètres"),
        "messages_no_receivers":
            MessageLookupByLibrary.simpleMessage("Aucun destinataire"),
        "messages_no_subject":
            MessageLookupByLibrary.simpleMessage("Aucun objet"),
        "messages_reply": MessageLookupByLibrary.simpleMessage("Répondre"),
        "messages_reply_all":
            MessageLookupByLibrary.simpleMessage("Répondre à tous"),
        "messages_saved_in_drafts": MessageLookupByLibrary.simpleMessage(
            "Message enregistré dans les brouillons"),
        "messages_sending":
            MessageLookupByLibrary.simpleMessage("Envoi du message..."),
        "messages_show_details":
            MessageLookupByLibrary.simpleMessage("Afficher les détails"),
        "messages_show_images":
            MessageLookupByLibrary.simpleMessage("Afficher les images."),
        "messages_subject": MessageLookupByLibrary.simpleMessage("Objet"),
        "messages_to": MessageLookupByLibrary.simpleMessage("À"),
        "messages_to_me": MessageLookupByLibrary.simpleMessage("À moi"),
        "messages_unknown_recipient":
            MessageLookupByLibrary.simpleMessage("Aucun destinataire"),
        "messages_unknown_sender":
            MessageLookupByLibrary.simpleMessage("Aucun expéditeur"),
        "messages_view_tab_attachments":
            MessageLookupByLibrary.simpleMessage("Pièces jointes"),
        "messages_view_tab_message_body":
            MessageLookupByLibrary.simpleMessage("Corps du message"),
        "no_permission_to_local_storage": MessageLookupByLibrary.simpleMessage(
            "Aucune autorisation d\'accès au stockage local. Vérifiez les paramètres de votre appareil."),
        "remove": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
        "save_changes_question": MessageLookupByLibrary.simpleMessage(
            "Enregistrer les modifications ?"),
        "self_destructing_life_time_day":
            MessageLookupByLibrary.simpleMessage("24 heures"),
        "self_destructing_life_time_days_3":
            MessageLookupByLibrary.simpleMessage("72 heures"),
        "self_destructing_life_time_days_7":
            MessageLookupByLibrary.simpleMessage("7 jours"),
        "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "settings_24_time_format":
            MessageLookupByLibrary.simpleMessage("Format 24 heures"),
        "settings_about": MessageLookupByLibrary.simpleMessage("À propos"),
        "settings_about_app_version": m23,
        "settings_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
            "Politique de confidentialité"),
        "settings_about_terms_of_service":
            MessageLookupByLibrary.simpleMessage("Conditions d\'utilisation"),
        "settings_accounts_add":
            MessageLookupByLibrary.simpleMessage("Ajouter un nouveau compte"),
        "settings_accounts_delete":
            MessageLookupByLibrary.simpleMessage("Supprimer le compte"),
        "settings_accounts_delete_description": m24,
        "settings_accounts_manage":
            MessageLookupByLibrary.simpleMessage("Gérer les comptes"),
        "settings_accounts_relogin":
            MessageLookupByLibrary.simpleMessage("Se reconnecter au compte"),
        "settings_common": MessageLookupByLibrary.simpleMessage("Général"),
        "settings_dark_theme":
            MessageLookupByLibrary.simpleMessage("Thème de l\'application"),
        "settings_dark_theme_dark":
            MessageLookupByLibrary.simpleMessage("Sombre"),
        "settings_dark_theme_light":
            MessageLookupByLibrary.simpleMessage("Clair"),
        "settings_dark_theme_system":
            MessageLookupByLibrary.simpleMessage("Thème du système"),
        "settings_delete_account":
            MessageLookupByLibrary.simpleMessage("Supprimer le compte"),
        "settings_language": MessageLookupByLibrary.simpleMessage("Langue"),
        "settings_language_system":
            MessageLookupByLibrary.simpleMessage("Langue du système"),
        "settings_sync":
            MessageLookupByLibrary.simpleMessage("Nouvelles données"),
        "settings_sync_frequency":
            MessageLookupByLibrary.simpleMessage("Mise à jour"),
        "settings_sync_frequency_daily":
            MessageLookupByLibrary.simpleMessage("tout les jours"),
        "settings_sync_frequency_hours1":
            MessageLookupByLibrary.simpleMessage("1 heure"),
        "settings_sync_frequency_hours2":
            MessageLookupByLibrary.simpleMessage("2 heures"),
        "settings_sync_frequency_minutes30":
            MessageLookupByLibrary.simpleMessage("30 minutes"),
        "settings_sync_frequency_minutes5":
            MessageLookupByLibrary.simpleMessage("5 minutes"),
        "settings_sync_frequency_monthly":
            MessageLookupByLibrary.simpleMessage("toutes les mois"),
        "settings_sync_frequency_never":
            MessageLookupByLibrary.simpleMessage("jamais"),
        "settings_sync_frequency_weekly":
            MessageLookupByLibrary.simpleMessage("toutes les semaines"),
        "settings_sync_frequency_yearly":
            MessageLookupByLibrary.simpleMessage("tout les ans"),
        "settings_sync_period":
            MessageLookupByLibrary.simpleMessage("Afficher pour"),
        "settings_sync_period_all_time":
            MessageLookupByLibrary.simpleMessage("tout le temps"),
        "settings_sync_period_months1":
            MessageLookupByLibrary.simpleMessage("1 mois"),
        "settings_sync_period_months3":
            MessageLookupByLibrary.simpleMessage("3 mois"),
        "settings_sync_period_months6":
            MessageLookupByLibrary.simpleMessage("6 mois"),
        "settings_sync_period_years1":
            MessageLookupByLibrary.simpleMessage("1 an"),
        "template_self_destructing_message": m25,
        "template_self_destructing_message_password": m26,
        "template_self_destructing_message_title":
            MessageLookupByLibrary.simpleMessage(
                "Le message sécurisé a été partagé avec vous"),
        "tfa_btn_other_options":
            MessageLookupByLibrary.simpleMessage("Autres options"),
        "tfa_btn_use_auth_app": MessageLookupByLibrary.simpleMessage(
            "Utiliser l\'application d\'authentification"),
        "tfa_btn_use_backup_code": MessageLookupByLibrary.simpleMessage(
            "Utiliser le code de sauvegarde"),
        "tfa_btn_use_security_key": MessageLookupByLibrary.simpleMessage(
            "Utiliser votre clé de sécurité"),
        "tfa_button_continue":
            MessageLookupByLibrary.simpleMessage("Continuer"),
        "tfa_check_box_trust_device": m27,
        "tfa_error_invalid_backup_code":
            MessageLookupByLibrary.simpleMessage("Code de sauvegarde invalide"),
        "tfa_hint_step": MessageLookupByLibrary.simpleMessage(
            "Cette étape supplémentaire est destinée à confirmer que c\'est vraiment vous qui essayez de vous connecter"),
        "tfa_input_backup_code":
            MessageLookupByLibrary.simpleMessage("Code de sauvegarde"),
        "tfa_input_hint_code_from_app": MessageLookupByLibrary.simpleMessage(
            "Spécifiez le code de vérification de l\'application d\'authentification"),
        "tfa_label": MessageLookupByLibrary.simpleMessage(
            "Vérification à deux facteurs"),
        "tfa_label_enter_backup_code": MessageLookupByLibrary.simpleMessage(
            "Entrez l\'un de vos codes de sauvegarde à 8 caractères"),
        "tfa_label_hint_security_options": MessageLookupByLibrary.simpleMessage(
            "Options de sécurité disponibles"),
        "tfa_label_trust_device":
            MessageLookupByLibrary.simpleMessage("Vous êtes prêt"),
        "week_titles":
            MessageLookupByLibrary.simpleMessage("Lu,Ma,Me,Je,Ve,Sa,Di")
      };
}
