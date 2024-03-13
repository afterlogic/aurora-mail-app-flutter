// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(emails) => "Скрытая копия: ${emails}";

  static String m1(emails) => "Копия: ${emails}";

  static String m2(emails) => "От: ${emails}";

  static String m3(date) => "Отправлено: ${date}";

  static String m4(subject) => "Тема: ${subject}";

  static String m5(emails) => "Кому: ${emails}";

  static String m6(time, from) => "В ${time}, ${from} написал(а):";

  static String m7(contact) => "Вы действительно хотите удалить ${contact}?";

  static String m8(group) =>
      "Вы действительно хотите удалить ${group}? Контакты этой группы удалены не будут.";

  static String m9(contact, storage) =>
      "${contact} скоро появится в хранилище ${storage}";

  static String m10(users) => "Ключи для пользователя ${users} не найдены";

  static String m11(folder) =>
      "Вы уверены, что хотите удалить все сообщение в папке ${folder}?";

  static String m12(user) =>
      "Вы действительно хотите удалить OpenPGP key для ${user}?";

  static String m13(path) => "Загруженно в ${path}";

  static String m14(path) => "Файл загружен в: ${path}";

  static String m15(fileName) => "Загрузка ${fileName}...";

  static String m16(path) => "Файл загружен в: ${path}";

  static String m17(fileName) => "Загрузка ${fileName}...";

  static String m18(subject) => "Вы уверены, что хотите удалить ${subject}?";

  static String m19(version) => "Версия ${version}";

  static String m20(account) =>
      "Вы действительно хотите выйти из аккаунта ${account} и удалить его?";

  static String m21(sender, link, message_password, lifeTime, now) =>
      "Hello,\n${sender} user sent you a self-destructing secure email.\nYou can read it by the following link:\n${link}\n${message_password}The message will be accessible for ${lifeTime} starting from ${now}";

  static String m22(password) =>
      "The message is password-protected. The password is: ${password}\n";

  static String m23(daysCount) =>
      "Don\'t ask again on this device for ${daysCount} days";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "already_have_key": MessageLookupByLibrary.simpleMessage(
            "У вас уже есть открытый или закрытый ключ"),
        "app_title": MessageLookupByLibrary.simpleMessage("Mail Client"),
        "btn_add_account":
            MessageLookupByLibrary.simpleMessage("Добавить аккаунт"),
        "btn_back": MessageLookupByLibrary.simpleMessage("Back"),
        "btn_cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "btn_close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "btn_contact_delete_key":
            MessageLookupByLibrary.simpleMessage("Удалить ключ"),
        "btn_contact_find_in_email":
            MessageLookupByLibrary.simpleMessage("Искать в письмах"),
        "btn_contact_key_re_import":
            MessageLookupByLibrary.simpleMessage("Импортировать заново"),
        "btn_delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "btn_discard": MessageLookupByLibrary.simpleMessage("Сбросить"),
        "btn_done": MessageLookupByLibrary.simpleMessage("Готово"),
        "btn_download": MessageLookupByLibrary.simpleMessage("Скачать"),
        "btn_exit": MessageLookupByLibrary.simpleMessage("Выйти"),
        "btn_hide_details":
            MessageLookupByLibrary.simpleMessage("Hide details"),
        "btn_log_delete_all":
            MessageLookupByLibrary.simpleMessage("Delete all"),
        "btn_login": MessageLookupByLibrary.simpleMessage("Войти"),
        "btn_login_back_to_login":
            MessageLookupByLibrary.simpleMessage("Back to login"),
        "btn_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Расширенный поиск"),
        "btn_message_empty_spam_folder":
            MessageLookupByLibrary.simpleMessage("Очистить Спам"),
        "btn_message_empty_trash_folder":
            MessageLookupByLibrary.simpleMessage("Очистить Корзину"),
        "btn_message_move": MessageLookupByLibrary.simpleMessage("Move"),
        "btn_message_resend": MessageLookupByLibrary.simpleMessage("Повторить"),
        "btn_not_spam": MessageLookupByLibrary.simpleMessage("Not spam"),
        "btn_ok": MessageLookupByLibrary.simpleMessage("Ок"),
        "btn_pgp_check_keys":
            MessageLookupByLibrary.simpleMessage("Проверить ключи"),
        "btn_pgp_decrypt": MessageLookupByLibrary.simpleMessage("Дешифровать"),
        "btn_pgp_download_all":
            MessageLookupByLibrary.simpleMessage("Скачать всё"),
        "btn_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Зашифровать"),
        "btn_pgp_export_all_public_keys": MessageLookupByLibrary.simpleMessage(
            "Экспортировать все публичные ключи"),
        "btn_pgp_generate": MessageLookupByLibrary.simpleMessage("Создать"),
        "btn_pgp_generate_keys":
            MessageLookupByLibrary.simpleMessage("Создать ключи"),
        "btn_pgp_import_from_file":
            MessageLookupByLibrary.simpleMessage("Импортировать из файла"),
        "btn_pgp_import_from_text":
            MessageLookupByLibrary.simpleMessage("Импортировать из текста"),
        "btn_pgp_import_keys_from_file":
            MessageLookupByLibrary.simpleMessage("Импортировать ключ из файла"),
        "btn_pgp_import_keys_from_text": MessageLookupByLibrary.simpleMessage(
            "Импортировать ключ из текста"),
        "btn_pgp_import_selected_key":
            MessageLookupByLibrary.simpleMessage("Импортировать выбранные"),
        "btn_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Sign/Encrypt"),
        "btn_pgp_undo_pgp":
            MessageLookupByLibrary.simpleMessage("Отменить PGP"),
        "btn_php_send_all":
            MessageLookupByLibrary.simpleMessage("Отправить всё"),
        "btn_read": MessageLookupByLibrary.simpleMessage("Read"),
        "btn_resend_push_token":
            MessageLookupByLibrary.simpleMessage("Resend Push Token"),
        "btn_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "btn_self_destructing":
            MessageLookupByLibrary.simpleMessage("Self-destructing"),
        "btn_share": MessageLookupByLibrary.simpleMessage("Поделиться"),
        "btn_show_all": MessageLookupByLibrary.simpleMessage("Показать все"),
        "btn_show_details":
            MessageLookupByLibrary.simpleMessage("Show details"),
        "btn_show_email_in_light_theme": MessageLookupByLibrary.simpleMessage(
            "Показать светлый вариант письма"),
        "btn_to_spam": MessageLookupByLibrary.simpleMessage("Спам"),
        "btn_unread": MessageLookupByLibrary.simpleMessage("Unread"),
        "btn_vcf_import": MessageLookupByLibrary.simpleMessage("Import"),
        "btn_verify_pin":
            MessageLookupByLibrary.simpleMessage("Подтвердите PIN"),
        "button_pgp_verify_sign":
            MessageLookupByLibrary.simpleMessage("Проверить"),
        "clear_cache_during_logout": MessageLookupByLibrary.simpleMessage(
            "Очистить локальный кэш и сохранённые ключи"),
        "compose_body_placeholder":
            MessageLookupByLibrary.simpleMessage("Текст сообщения..."),
        "compose_discard_save_dialog_description":
            MessageLookupByLibrary.simpleMessage(
                "Сохранить изменения в черновиках?"),
        "compose_discard_save_dialog_title":
            MessageLookupByLibrary.simpleMessage("Сбросить изменения"),
        "compose_forward_bcc": m0,
        "compose_forward_body_original_message":
            MessageLookupByLibrary.simpleMessage(
                "---- Оригинал сообщения ----"),
        "compose_forward_cc": m1,
        "compose_forward_from": m2,
        "compose_forward_sent": m3,
        "compose_forward_subject": m4,
        "compose_forward_to": m5,
        "compose_reply_body_title": m6,
        "contacts": MessageLookupByLibrary.simpleMessage("Контакты"),
        "contacts_add":
            MessageLookupByLibrary.simpleMessage("Добавить контакт"),
        "contacts_delete_desc_with_name": m7,
        "contacts_delete_title":
            MessageLookupByLibrary.simpleMessage("Удалить контакт"),
        "contacts_drawer_section_groups":
            MessageLookupByLibrary.simpleMessage("Группы"),
        "contacts_drawer_section_storages":
            MessageLookupByLibrary.simpleMessage("Хранилища"),
        "contacts_drawer_storage_all":
            MessageLookupByLibrary.simpleMessage("Все"),
        "contacts_drawer_storage_personal":
            MessageLookupByLibrary.simpleMessage("Личные"),
        "contacts_drawer_storage_shared":
            MessageLookupByLibrary.simpleMessage("Доступные всем"),
        "contacts_drawer_storage_team":
            MessageLookupByLibrary.simpleMessage("Коллеги"),
        "contacts_edit":
            MessageLookupByLibrary.simpleMessage("Редактировать контакт"),
        "contacts_edit_cancel": MessageLookupByLibrary.simpleMessage(
            "Отменить редактирование контакта"),
        "contacts_edit_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Нет эл. почты"),
        "contacts_empty": MessageLookupByLibrary.simpleMessage("Контактов нет"),
        "contacts_group_add":
            MessageLookupByLibrary.simpleMessage("Добавить группу"),
        "contacts_group_delete_desc_with_name": m8,
        "contacts_group_delete_title":
            MessageLookupByLibrary.simpleMessage("Удалить группу"),
        "contacts_group_edit":
            MessageLookupByLibrary.simpleMessage("Редактировать группу"),
        "contacts_group_edit_cancel": MessageLookupByLibrary.simpleMessage(
            "Отменить редактирование группы"),
        "contacts_group_edit_is_organization":
            MessageLookupByLibrary.simpleMessage(
                "Эта группа является компанией"),
        "contacts_group_view_app_bar_delete":
            MessageLookupByLibrary.simpleMessage("Удалить группу"),
        "contacts_group_view_app_bar_edit":
            MessageLookupByLibrary.simpleMessage("Редактировать группу"),
        "contacts_group_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "Отправить сообщение контактам в этой группе"),
        "contacts_groups_empty":
            MessageLookupByLibrary.simpleMessage("Групп нет"),
        "contacts_list_app_bar_all_contacts":
            MessageLookupByLibrary.simpleMessage("Все контакты"),
        "contacts_list_app_bar_view_group":
            MessageLookupByLibrary.simpleMessage("Инфорамация о группе"),
        "contacts_list_its_me_flag":
            MessageLookupByLibrary.simpleMessage("Это я!"),
        "contacts_shared_message": m9,
        "contacts_view_address": MessageLookupByLibrary.simpleMessage("Адрес"),
        "contacts_view_app_bar_attach":
            MessageLookupByLibrary.simpleMessage("Переслать"),
        "contacts_view_app_bar_delete_contact":
            MessageLookupByLibrary.simpleMessage("Удалить"),
        "contacts_view_app_bar_edit_contact":
            MessageLookupByLibrary.simpleMessage("Редактировать"),
        "contacts_view_app_bar_search_messages":
            MessageLookupByLibrary.simpleMessage("Найти сообщения"),
        "contacts_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage("Написать"),
        "contacts_view_app_bar_share":
            MessageLookupByLibrary.simpleMessage("Сделать общим"),
        "contacts_view_app_bar_unshare":
            MessageLookupByLibrary.simpleMessage("Сделать личным"),
        "contacts_view_birthday":
            MessageLookupByLibrary.simpleMessage("День рождения"),
        "contacts_view_business_address":
            MessageLookupByLibrary.simpleMessage("Рабочий адрес"),
        "contacts_view_business_email":
            MessageLookupByLibrary.simpleMessage("Рабочая эл. почта"),
        "contacts_view_business_phone":
            MessageLookupByLibrary.simpleMessage("Рабочий телефон"),
        "contacts_view_city": MessageLookupByLibrary.simpleMessage("Город"),
        "contacts_view_company":
            MessageLookupByLibrary.simpleMessage("Компания"),
        "contacts_view_country": MessageLookupByLibrary.simpleMessage("Страна"),
        "contacts_view_department":
            MessageLookupByLibrary.simpleMessage("Отдел"),
        "contacts_view_display_name":
            MessageLookupByLibrary.simpleMessage("Отображаемое имя"),
        "contacts_view_email":
            MessageLookupByLibrary.simpleMessage("Эл. почта"),
        "contacts_view_facebook":
            MessageLookupByLibrary.simpleMessage("Facebook"),
        "contacts_view_fax": MessageLookupByLibrary.simpleMessage("Факс"),
        "contacts_view_first_name": MessageLookupByLibrary.simpleMessage("Имя"),
        "contacts_view_hide_additional_fields":
            MessageLookupByLibrary.simpleMessage("Скрыть дополнительные поля"),
        "contacts_view_job_title":
            MessageLookupByLibrary.simpleMessage("Должность"),
        "contacts_view_last_name":
            MessageLookupByLibrary.simpleMessage("Фамилия"),
        "contacts_view_mobile":
            MessageLookupByLibrary.simpleMessage("Мобильный"),
        "contacts_view_name": MessageLookupByLibrary.simpleMessage("Имя"),
        "contacts_view_nickname": MessageLookupByLibrary.simpleMessage("Ник"),
        "contacts_view_notes": MessageLookupByLibrary.simpleMessage("Заметки"),
        "contacts_view_office": MessageLookupByLibrary.simpleMessage("Офис"),
        "contacts_view_other_email":
            MessageLookupByLibrary.simpleMessage("Дополнительная эл. почта"),
        "contacts_view_personal_address":
            MessageLookupByLibrary.simpleMessage("Домашний адрес"),
        "contacts_view_personal_email":
            MessageLookupByLibrary.simpleMessage("Домашняя эл. почта"),
        "contacts_view_personal_phone":
            MessageLookupByLibrary.simpleMessage("Личный телефон"),
        "contacts_view_phone": MessageLookupByLibrary.simpleMessage("Телефон"),
        "contacts_view_province":
            MessageLookupByLibrary.simpleMessage("Регион"),
        "contacts_view_section_business":
            MessageLookupByLibrary.simpleMessage("Бизнес"),
        "contacts_view_section_group_name":
            MessageLookupByLibrary.simpleMessage("Имя группы"),
        "contacts_view_section_groups":
            MessageLookupByLibrary.simpleMessage("Группы"),
        "contacts_view_section_home":
            MessageLookupByLibrary.simpleMessage("Дом"),
        "contacts_view_section_other_info":
            MessageLookupByLibrary.simpleMessage("Прочее"),
        "contacts_view_section_personal":
            MessageLookupByLibrary.simpleMessage("Личное"),
        "contacts_view_show_additional_fields":
            MessageLookupByLibrary.simpleMessage(
                "Показать дополнительные поля"),
        "contacts_view_skype": MessageLookupByLibrary.simpleMessage("Skype"),
        "contacts_view_street_address":
            MessageLookupByLibrary.simpleMessage("Улица"),
        "contacts_view_web_page":
            MessageLookupByLibrary.simpleMessage("Веб сайт"),
        "contacts_view_zip": MessageLookupByLibrary.simpleMessage("Индекс"),
        "debug_hint_log_delete_record": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete the file?"),
        "error_compose_no_receivers":
            MessageLookupByLibrary.simpleMessage("Укажите получателей"),
        "error_compose_wait_attachments": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста подождите пока загрузятся вложения"),
        "error_connection": MessageLookupByLibrary.simpleMessage(
            "Не удалось установить соединение с сервером"),
        "error_connection_offline": MessageLookupByLibrary.simpleMessage(
            "Отсутствует подключение к инетернету"),
        "error_contact_pgp_key_will_not_be_valid":
            MessageLookupByLibrary.simpleMessage(
                "Pgp ключ не будет действительным"),
        "error_contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Укажите эл. почту"),
        "error_contacts_save_name_empty":
            MessageLookupByLibrary.simpleMessage("Укажите имя"),
        "error_input_validation_email":
            MessageLookupByLibrary.simpleMessage("Неверный email"),
        "error_input_validation_empty":
            MessageLookupByLibrary.simpleMessage("Это поле обязательно"),
        "error_input_validation_name_illegal_symbol":
            MessageLookupByLibrary.simpleMessage(
                "Имя не может содержать \"/\\*?<>|:\""),
        "error_input_validation_unique_name":
            MessageLookupByLibrary.simpleMessage("Такое имя уже записано"),
        "error_invalid_pin":
            MessageLookupByLibrary.simpleMessage("Неверный PIN"),
        "error_login_account_exists": MessageLookupByLibrary.simpleMessage(
            "Этот аккаунт уже находится в списке ваших аккаунтов."),
        "error_login_auto_discover": MessageLookupByLibrary.simpleMessage(
            "Не удалось определить домен автоматически, пожалуйста, укажите его вручную."),
        "error_login_input_email":
            MessageLookupByLibrary.simpleMessage("Введите эл. почту"),
        "error_login_input_hostname":
            MessageLookupByLibrary.simpleMessage("Введите домен"),
        "error_login_input_password":
            MessageLookupByLibrary.simpleMessage("Введите пароль"),
        "error_login_no_accounts": MessageLookupByLibrary.simpleMessage(
            "У данного пользователя нет почтовых аккаунтов"),
        "error_message_not_found":
            MessageLookupByLibrary.simpleMessage("Message not found"),
        "error_no_pgp_key":
            MessageLookupByLibrary.simpleMessage("No PGP public key was found"),
        "error_password_is_empty":
            MessageLookupByLibrary.simpleMessage("password is empty"),
        "error_pgp_can_not_decrypt":
            MessageLookupByLibrary.simpleMessage("Не удалось дешифровать."),
        "error_pgp_invalid_key_or_password":
            MessageLookupByLibrary.simpleMessage("Неверный ключ либо пароль."),
        "error_pgp_invalid_password":
            MessageLookupByLibrary.simpleMessage("Неверный пароль"),
        "error_pgp_keys_not_found":
            MessageLookupByLibrary.simpleMessage("Ключи не найдены"),
        "error_pgp_need_contact_for_encrypt": MessageLookupByLibrary.simpleMessage(
            "Чтобы зашифровать сообщение нужно указать хотя бы одного получателя."),
        "error_pgp_not_found_keys_for": m10,
        "error_pgp_select_recipient":
            MessageLookupByLibrary.simpleMessage("Выберите получателя"),
        "error_server_access_denied":
            MessageLookupByLibrary.simpleMessage("Доступ запрещён"),
        "error_server_account_exists": MessageLookupByLibrary.simpleMessage(
            "Такой аккаунт уже существует"),
        "error_server_account_old_password_not_correct":
            MessageLookupByLibrary.simpleMessage(
                "Неправильный старый пароль учетной записи"),
        "error_server_auth_error": MessageLookupByLibrary.simpleMessage(
            "Неверный адрес электронной почты / пароль"),
        "error_server_calendars_not_allowed":
            MessageLookupByLibrary.simpleMessage("Календари не разрешены"),
        "error_server_can_not_change_password":
            MessageLookupByLibrary.simpleMessage("Не удалось сменить пароль"),
        "error_server_can_not_create_account":
            MessageLookupByLibrary.simpleMessage("Не могу создать аккаунт"),
        "error_server_can_not_create_contact":
            MessageLookupByLibrary.simpleMessage("Не удалось создать контакт"),
        "error_server_can_not_create_group":
            MessageLookupByLibrary.simpleMessage("Не удалось создать группу"),
        "error_server_can_not_create_helpdesk_user":
            MessageLookupByLibrary.simpleMessage(
                "Невозможно создать пользователя службы поддержки"),
        "error_server_can_not_get_contact":
            MessageLookupByLibrary.simpleMessage("Не удалось получить контакт"),
        "error_server_can_not_save_settings":
            MessageLookupByLibrary.simpleMessage(
                "Не удалось сохранить настройки"),
        "error_server_can_not_update_contact":
            MessageLookupByLibrary.simpleMessage("Не удается обновить контакт"),
        "error_server_can_not_update_group":
            MessageLookupByLibrary.simpleMessage("Не удается обновить группу"),
        "error_server_can_not_upload_file_limit":
            MessageLookupByLibrary.simpleMessage(
                "Превышен лимит загрузки файлов"),
        "error_server_can_not_upload_file_quota":
            MessageLookupByLibrary.simpleMessage(
                "Вы достигли лимита места в облачном хранилище. Не могу загрузить файл."),
        "error_server_captcha_error":
            MessageLookupByLibrary.simpleMessage("Ошибка Captcha"),
        "error_server_contact_data_has_been_modified_by_another_application":
            MessageLookupByLibrary.simpleMessage(
                "Контактные данные были изменены другим приложением"),
        "error_server_contacts_not_allowed":
            MessageLookupByLibrary.simpleMessage("Контакты не разрешены"),
        "error_server_data_base_error":
            MessageLookupByLibrary.simpleMessage("Ошибка базы данных"),
        "error_server_demo_account":
            MessageLookupByLibrary.simpleMessage("Демо аккаунт"),
        "error_server_file_already_exists":
            MessageLookupByLibrary.simpleMessage("Такой файл уже существует"),
        "error_server_file_not_found":
            MessageLookupByLibrary.simpleMessage("Файл не найден"),
        "error_server_files_not_allowed":
            MessageLookupByLibrary.simpleMessage("Файлы не разрешены"),
        "error_server_helpdesk_system_user_exists":
            MessageLookupByLibrary.simpleMessage(
                "Пользователь системы службы поддержки уже существует"),
        "error_server_helpdesk_unactivated_user":
            MessageLookupByLibrary.simpleMessage(
                "Неактивированный пользователь службы поддержки"),
        "error_server_helpdesk_unknown_user":
            MessageLookupByLibrary.simpleMessage(
                "Служба поддержки неизвестного пользователя"),
        "error_server_helpdesk_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Пользователь службы поддержки уже существует"),
        "error_server_incorrect_file_extension":
            MessageLookupByLibrary.simpleMessage("Неверное расширение файла"),
        "error_server_invalid_input_parameter":
            MessageLookupByLibrary.simpleMessage("Неверный входной параметр"),
        "error_server_invalid_token":
            MessageLookupByLibrary.simpleMessage("Неверный токен"),
        "error_server_license_limit":
            MessageLookupByLibrary.simpleMessage("Лимит лицензии"),
        "error_server_license_problem":
            MessageLookupByLibrary.simpleMessage("Проблема с лицензией"),
        "error_server_mail_server_error":
            MessageLookupByLibrary.simpleMessage("Ошибка почтового сервера"),
        "error_server_method_not_found":
            MessageLookupByLibrary.simpleMessage("Метод не найден"),
        "error_server_module_not_found":
            MessageLookupByLibrary.simpleMessage("Модуль не найден"),
        "error_server_rest_account_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "Не удалось найти аккаунт REST"),
        "error_server_rest_api_disabled":
            MessageLookupByLibrary.simpleMessage("Остальные API отключены"),
        "error_server_rest_invalid_credentials":
            MessageLookupByLibrary.simpleMessage(
                "Неверные учетные данные REST"),
        "error_server_rest_invalid_parameters":
            MessageLookupByLibrary.simpleMessage("Неверные параметры REST"),
        "error_server_rest_invalid_token":
            MessageLookupByLibrary.simpleMessage("Недействительный токен REST"),
        "error_server_rest_other_error":
            MessageLookupByLibrary.simpleMessage("Другая ошибка REST"),
        "error_server_rest_tenant_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "Не удалось найти тенант REST"),
        "error_server_rest_token_expired": MessageLookupByLibrary.simpleMessage(
            "Срок действия токена REST истек"),
        "error_server_rest_unknown_method":
            MessageLookupByLibrary.simpleMessage("Неизвестный метод REST"),
        "error_server_system_not_configured":
            MessageLookupByLibrary.simpleMessage("Система не настроена"),
        "error_server_unknown_email": MessageLookupByLibrary.simpleMessage(
            "Неизвестный адрес электронной почты"),
        "error_server_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Такой пользователь уже существует"),
        "error_server_user_not_allowed":
            MessageLookupByLibrary.simpleMessage("Пользователь не допущен"),
        "error_server_voice_not_allowed":
            MessageLookupByLibrary.simpleMessage("Голос не разрешен"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Can\'t connect to the server"),
        "error_unknown":
            MessageLookupByLibrary.simpleMessage("Неизвестная ошибка"),
        "error_user_already_logged": MessageLookupByLibrary.simpleMessage(
            "Это пользователь уже авторизирован"),
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
        "folders_drafts": MessageLookupByLibrary.simpleMessage("Черновики"),
        "folders_empty": MessageLookupByLibrary.simpleMessage("Нет папок"),
        "folders_inbox": MessageLookupByLibrary.simpleMessage("Входящие"),
        "folders_sent": MessageLookupByLibrary.simpleMessage("Отправленные"),
        "folders_spam": MessageLookupByLibrary.simpleMessage("Спам"),
        "folders_starred": MessageLookupByLibrary.simpleMessage("Отмеченные"),
        "folders_trash": MessageLookupByLibrary.simpleMessage("Корзина"),
        "format_compose_forward_date":
            MessageLookupByLibrary.simpleMessage("EEE, d MMM, yyyy, HH:mm"),
        "format_compose_reply_date": MessageLookupByLibrary.simpleMessage(
            "EEE, d MMM, yyyy \'at\' HH:mm"),
        "format_contacts_birth_date":
            MessageLookupByLibrary.simpleMessage("d MMM, yyyy"),
        "hint_2fa": MessageLookupByLibrary.simpleMessage(
            "Ваш аккаунт защищён\nдвухфакторной аутентификацией.\nУкажите PIN код."),
        "hint_auto_encrypt_messages": MessageLookupByLibrary.simpleMessage(
            "If you want messages to this contact to be automatically encrypted and/or signed, check the boxes below. Please note that these messages will be converted to plain text. Attachments will not be encrypted."),
        "hint_confirm_exit": MessageLookupByLibrary.simpleMessage(
            "Вы уверены что хотите выйти?"),
        "hint_log_delete_all": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete all logs"),
        "hint_login_upgrade_your_plan": MessageLookupByLibrary.simpleMessage(
            "Mobile apps are not allowed in your account."),
        "hint_message_empty_folder": m11,
        "hint_pgp_already_have_keys": MessageLookupByLibrary.simpleMessage(
            "Ключи, которые уже есть в системе, выделены серым цветом."),
        "hint_pgp_delete_user_key_confirm": m12,
        "hint_pgp_existed_keys": MessageLookupByLibrary.simpleMessage(
            "Ключи, которые уже есть в системе, и не будут импортированы"),
        "hint_pgp_external_private_keys": MessageLookupByLibrary.simpleMessage(
            "Внешние закрытые ключи не поддерживаются и не будут импортированы"),
        "hint_pgp_keys_contacts_will_be_created":
            MessageLookupByLibrary.simpleMessage(
                "Для этих ключей будут созданны контакты"),
        "hint_pgp_keys_for_import": MessageLookupByLibrary.simpleMessage(
            "Ключи, доступные для импорта"),
        "hint_pgp_keys_will_be_import_to_contacts":
            MessageLookupByLibrary.simpleMessage(
                "Эти ключи будут экспортированны в контакты"),
        "hint_pgp_message_automatically_encrypt":
            MessageLookupByLibrary.simpleMessage(
                "The message will be automatically encrypted and/or signed for contacts with OpenPgp keys.\n OpenPGP supports plain text only. All the formatting will be removed before encryption."),
        "hint_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
            "Вы собираетесь поделиться своим закрытым PGP-ключом. Закрытый ключ должен храниться только у владельца. Продолжить?"),
        "hint_pgp_your_keys":
            MessageLookupByLibrary.simpleMessage("Ваши ключи"),
        "hint_self_destructing_encrypt_with_key":
            MessageLookupByLibrary.simpleMessage(
                "Selected recipient has PGP public key. The message can be encrypted using this key."),
        "hint_self_destructing_encrypt_with_not_key":
            MessageLookupByLibrary.simpleMessage(
                "Selected recipient has no PGP public key. The key-based encryption is not allowed"),
        "hint_self_destructing_password_coppied_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Пароль скопирован"),
        "hint_self_destructing_sent_password_using_different_channel":
            MessageLookupByLibrary.simpleMessage(
                "The password must be sent using a different channel.\n  Store the password somewhere. You will not be able to recover it otherwise."),
        "hint_self_destructing_supports_plain_text_only":
            MessageLookupByLibrary.simpleMessage(
                "The self-descructing secure emails support plain text only. All the formatting will be removed. Also, attachments cannot be encrypted and will be removed from the message."),
        "hint_vcf_import":
            MessageLookupByLibrary.simpleMessage("Import contact from vcf?"),
        "input_2fa_pin": MessageLookupByLibrary.simpleMessage("PIN"),
        "input_message_search_since":
            MessageLookupByLibrary.simpleMessage("От"),
        "input_message_search_text":
            MessageLookupByLibrary.simpleMessage("Текст"),
        "input_message_search_till": MessageLookupByLibrary.simpleMessage("До"),
        "input_self_destructing_add_digital_signature":
            MessageLookupByLibrary.simpleMessage("Add digital signature"),
        "input_self_destructing_key_based_encryption":
            MessageLookupByLibrary.simpleMessage("Key-based"),
        "input_self_destructing_password_based_encryption":
            MessageLookupByLibrary.simpleMessage("Password-based"),
        "label_contact_pgp_settings":
            MessageLookupByLibrary.simpleMessage("PGP Settings"),
        "label_contact_select_key":
            MessageLookupByLibrary.simpleMessage("Выберите ключ"),
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
            MessageLookupByLibrary.simpleMessage("Discard not saved changes?"),
        "label_enable_uploaded_message_counter":
            MessageLookupByLibrary.simpleMessage("Counter of uploaded message"),
        "label_encryption_password_for_pgp_key":
            MessageLookupByLibrary.simpleMessage(
                "Required password for PGP key"),
        "label_forward_as_attachment":
            MessageLookupByLibrary.simpleMessage("Forward as attachment"),
        "label_length": MessageLookupByLibrary.simpleMessage("Длина"),
        "label_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Advanced search"),
        "label_message_headers":
            MessageLookupByLibrary.simpleMessage("Заголовки письма"),
        "label_message_move_to":
            MessageLookupByLibrary.simpleMessage("Переместить в: "),
        "label_message_move_to_folder":
            MessageLookupByLibrary.simpleMessage("Переместить в папку"),
        "label_message_yesterday":
            MessageLookupByLibrary.simpleMessage("Вчера"),
        "label_notifications_settings":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "label_pgp_all_public_key":
            MessageLookupByLibrary.simpleMessage("Все публичные ключи"),
        "label_pgp_contact_public_keys":
            MessageLookupByLibrary.simpleMessage("Публичные ключи контактов"),
        "label_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP дешифровка"),
        "label_pgp_decrypted_and_verified":
            MessageLookupByLibrary.simpleMessage(
                "Сообщение успешно дешифровано и проверено."),
        "label_pgp_decrypted_but_not_verified":
            MessageLookupByLibrary.simpleMessage(
                "Сообщение успешно дешифровано, но не проверено."),
        "label_pgp_downloading_to": m13,
        "label_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Encrypt"),
        "label_pgp_import_key":
            MessageLookupByLibrary.simpleMessage("Импорт ключей"),
        "label_pgp_key_with_not_name":
            MessageLookupByLibrary.simpleMessage("Без имени"),
        "label_pgp_not_verified":
            MessageLookupByLibrary.simpleMessage("Сообщение не проверено."),
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
            MessageLookupByLibrary.simpleMessage("Предупреждение"),
        "label_pgp_sign": MessageLookupByLibrary.simpleMessage("Подписать"),
        "label_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP шифрование"),
        "label_pgp_verified": MessageLookupByLibrary.simpleMessage(
            "Сообщение успешно проверено."),
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
        "login_input_email": MessageLookupByLibrary.simpleMessage("Почта"),
        "login_input_host": MessageLookupByLibrary.simpleMessage("Домен"),
        "login_input_password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "login_to_continue":
            MessageLookupByLibrary.simpleMessage("Войдите в аккаунт"),
        "message_lifetime":
            MessageLookupByLibrary.simpleMessage("Message lifetime"),
        "messages_always_show_images": MessageLookupByLibrary.simpleMessage(
            "Всегда показывать изображения в сообщениях от данного отправителя."),
        "messages_attachment_delete":
            MessageLookupByLibrary.simpleMessage("Удалить файл"),
        "messages_attachment_download":
            MessageLookupByLibrary.simpleMessage("Скачать файл"),
        "messages_attachment_download_cancel":
            MessageLookupByLibrary.simpleMessage("Отменить загрузку"),
        "messages_attachment_download_failed":
            MessageLookupByLibrary.simpleMessage("Ошибка загрузки"),
        "messages_attachment_download_success": m14,
        "messages_attachment_downloading": m15,
        "messages_attachment_upload":
            MessageLookupByLibrary.simpleMessage("Загрузить файл"),
        "messages_attachment_upload_cancel":
            MessageLookupByLibrary.simpleMessage("Отменить загрузку"),
        "messages_attachment_upload_failed":
            MessageLookupByLibrary.simpleMessage("Загрузка не удалась"),
        "messages_attachment_upload_success": m16,
        "messages_attachment_uploading": m17,
        "messages_attachments_empty":
            MessageLookupByLibrary.simpleMessage("Нет вложений"),
        "messages_bcc": MessageLookupByLibrary.simpleMessage("Скрытая копия"),
        "messages_cc": MessageLookupByLibrary.simpleMessage("Копия"),
        "messages_delete_desc": MessageLookupByLibrary.simpleMessage(
            "Вы уверены, что хотите удалить это сообщение?"),
        "messages_delete_desc_with_count": MessageLookupByLibrary.simpleMessage(
            "Вы уверены, что хотите удалить эти сообщения?"),
        "messages_delete_desc_with_subject": m18,
        "messages_delete_title":
            MessageLookupByLibrary.simpleMessage("Удалить сообщение"),
        "messages_delete_title_with_count":
            MessageLookupByLibrary.simpleMessage("Удалить сообщения"),
        "messages_empty": MessageLookupByLibrary.simpleMessage("Нет сообщений"),
        "messages_filter_unread":
            MessageLookupByLibrary.simpleMessage("Непрочитаные сообщения"),
        "messages_forward": MessageLookupByLibrary.simpleMessage("Переслать"),
        "messages_from": MessageLookupByLibrary.simpleMessage("От кого"),
        "messages_images_security_alert": MessageLookupByLibrary.simpleMessage(
            "Из соображений безобазности картинки были заблокированы."),
        "messages_list_app_bar_contacts":
            MessageLookupByLibrary.simpleMessage("Контакты"),
        "messages_list_app_bar_loading_folders":
            MessageLookupByLibrary.simpleMessage("Загрузка папок..."),
        "messages_list_app_bar_logout":
            MessageLookupByLibrary.simpleMessage("Выйти"),
        "messages_list_app_bar_mail":
            MessageLookupByLibrary.simpleMessage("Почта"),
        "messages_list_app_bar_search":
            MessageLookupByLibrary.simpleMessage("Поиск"),
        "messages_list_app_bar_settings":
            MessageLookupByLibrary.simpleMessage("Настройки"),
        "messages_no_receivers":
            MessageLookupByLibrary.simpleMessage("Нет получателей"),
        "messages_no_subject": MessageLookupByLibrary.simpleMessage("Без темы"),
        "messages_reply": MessageLookupByLibrary.simpleMessage("Ответить"),
        "messages_reply_all":
            MessageLookupByLibrary.simpleMessage("Ответить всем"),
        "messages_saved_in_drafts": MessageLookupByLibrary.simpleMessage(
            "Сообщение сохранено в черновиках"),
        "messages_sending":
            MessageLookupByLibrary.simpleMessage("Отправка сообщения..."),
        "messages_show_details":
            MessageLookupByLibrary.simpleMessage("Показать детали"),
        "messages_show_images":
            MessageLookupByLibrary.simpleMessage("Показать изображения."),
        "messages_subject": MessageLookupByLibrary.simpleMessage("Тема"),
        "messages_to": MessageLookupByLibrary.simpleMessage("Кому"),
        "messages_to_me": MessageLookupByLibrary.simpleMessage("Мне"),
        "messages_unknown_recipient":
            MessageLookupByLibrary.simpleMessage("Нет получателя"),
        "messages_unknown_sender":
            MessageLookupByLibrary.simpleMessage("Нет отправителя"),
        "messages_view_tab_attachments":
            MessageLookupByLibrary.simpleMessage("Вложения"),
        "messages_view_tab_message_body":
            MessageLookupByLibrary.simpleMessage("Тело письма"),
        "no_permission_to_local_storage": MessageLookupByLibrary.simpleMessage(
            "Нет разрешения для доступа к файлам. Проверьте настройки на вашем устройстве."),
        "self_destructing_life_time_day":
            MessageLookupByLibrary.simpleMessage("24 hours"),
        "self_destructing_life_time_days_3":
            MessageLookupByLibrary.simpleMessage("72 hours"),
        "self_destructing_life_time_days_7":
            MessageLookupByLibrary.simpleMessage("7 days"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "settings_24_time_format":
            MessageLookupByLibrary.simpleMessage("24 часовой формат времени"),
        "settings_about": MessageLookupByLibrary.simpleMessage("О приложении"),
        "settings_about_app_version": m19,
        "settings_about_privacy_policy":
            MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
        "settings_about_terms_of_service":
            MessageLookupByLibrary.simpleMessage("Правила пользования"),
        "settings_accounts_add":
            MessageLookupByLibrary.simpleMessage("Добавить новый аккаунт"),
        "settings_accounts_delete":
            MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
        "settings_accounts_delete_description": m20,
        "settings_accounts_manage":
            MessageLookupByLibrary.simpleMessage("Управление аккаунтами"),
        "settings_accounts_relogin":
            MessageLookupByLibrary.simpleMessage("Войти в аккаунт"),
        "settings_common": MessageLookupByLibrary.simpleMessage("Общие"),
        "settings_dark_theme": MessageLookupByLibrary.simpleMessage("Тема"),
        "settings_dark_theme_dark":
            MessageLookupByLibrary.simpleMessage("Тёмная"),
        "settings_dark_theme_light":
            MessageLookupByLibrary.simpleMessage("Светлая"),
        "settings_dark_theme_system":
            MessageLookupByLibrary.simpleMessage("Системная"),
        "settings_language": MessageLookupByLibrary.simpleMessage("Язык"),
        "settings_language_system":
            MessageLookupByLibrary.simpleMessage("Язык системы"),
        "settings_sync": MessageLookupByLibrary.simpleMessage("Синхронизация"),
        "settings_sync_frequency":
            MessageLookupByLibrary.simpleMessage("Обновлять каждые"),
        "settings_sync_frequency_daily":
            MessageLookupByLibrary.simpleMessage("ежедневно"),
        "settings_sync_frequency_hours1":
            MessageLookupByLibrary.simpleMessage("1 час"),
        "settings_sync_frequency_hours2":
            MessageLookupByLibrary.simpleMessage("два часа"),
        "settings_sync_frequency_minutes30":
            MessageLookupByLibrary.simpleMessage("30 минут"),
        "settings_sync_frequency_minutes5":
            MessageLookupByLibrary.simpleMessage("5 минут"),
        "settings_sync_frequency_monthly":
            MessageLookupByLibrary.simpleMessage("ежемесячно"),
        "settings_sync_frequency_never":
            MessageLookupByLibrary.simpleMessage("отключено"),
        "settings_sync_period":
            MessageLookupByLibrary.simpleMessage("Синхронизировать письма за"),
        "settings_sync_period_all_time":
            MessageLookupByLibrary.simpleMessage("все время"),
        "settings_sync_period_months1":
            MessageLookupByLibrary.simpleMessage("1 месяц"),
        "settings_sync_period_months3":
            MessageLookupByLibrary.simpleMessage("3 месяца"),
        "settings_sync_period_months6":
            MessageLookupByLibrary.simpleMessage("6 месяцев"),
        "settings_sync_period_years1":
            MessageLookupByLibrary.simpleMessage("1 год"),
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
