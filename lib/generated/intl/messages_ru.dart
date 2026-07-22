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

  static String m0(storeName) =>
      "Не удалось пройти проверку приложения. Установите последнюю версию из ${storeName}.";

  static String m1(calendarName) =>
      "Вы уверены, что хотите удалить календарь ${calendarName}?";

  static String m2(organizer) => "Организатор: ${organizer}";

  static String m3(calendarName) =>
      "Вы уверены, что хотите отписаться от календаря ${calendarName}?";

  static String m4(emails) => "Скрытая копия: ${emails}";

  static String m5(emails) => "Копия: ${emails}";

  static String m6(emails) => "От: ${emails}";

  static String m7(date) => "Отправлено: ${date}";

  static String m8(subject) => "Тема: ${subject}";

  static String m9(emails) => "Кому: ${emails}";

  static String m10(time, from) => "В ${time}, ${from} написал(а):";

  static String m11(contact) => "Вы действительно хотите удалить ${contact}?";

  static String m12(group) =>
      "Вы действительно хотите удалить ${group}? Контакты этой группы удалены не будут.";

  static String m13(contact, storage) =>
      "${contact} скоро появится в хранилище ${storage}";

  static String m14(users) => "Ключи для пользователя ${users} не найдены";

  static String m15(name) => "Вы уверены, что хотите удалить файл ${name}?";

  static String m16(folder) =>
      "Вы уверены, что хотите удалить все сообщение в папке ${folder}?";

  static String m17(user) =>
      "Вы действительно хотите удалить OpenPGP key для ${user}?";

  static String m18(path) => "Загруженно в ${path}";

  static String m19(path) => "Файл загружен в: ${path}";

  static String m20(fileName) => "Загрузка ${fileName}...";

  static String m21(path) => "Файл загружен в: ${path}";

  static String m22(fileName) => "Загрузка ${fileName}...";

  static String m23(subject) => "Вы уверены, что хотите удалить ${subject}?";

  static String m24(version) => "Версия ${version}";

  static String m25(account) =>
      "Вы действительно хотите выйти из аккаунта ${account} и удалить его?";

  static String m26(sender, link, message_password, lifeTime, now) =>
      "Здравствуйте,\nПользователь ${sender} отправил вам самоуничтожающееся защищенное письмо.\nВы можете прочитать его по следующей ссылке:\n${link}\n${message_password}Сообщение будет доступно в течение ${lifeTime} начиная с ${now}";

  static String m27(password) =>
      "Сообщение защищено паролем. Пароль: ${password}\n";

  static String m28(daysCount) =>
      "Не спрашивать снова на этом устройстве в течение ${daysCount} дней";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "already_have_key": MessageLookupByLibrary.simpleMessage(
      "У вас уже есть открытый или закрытый ключ",
    ),
    "app_check_validation_fail": m0,
    "app_title": MessageLookupByLibrary.simpleMessage("Mail Client"),
    "btn_add_account": MessageLookupByLibrary.simpleMessage("Добавить аккаунт"),
    "btn_back": MessageLookupByLibrary.simpleMessage("Назад"),
    "btn_cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "btn_close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "btn_contact_delete_key": MessageLookupByLibrary.simpleMessage(
      "Удалить ключ",
    ),
    "btn_contact_find_in_email": MessageLookupByLibrary.simpleMessage(
      "Искать в письмах",
    ),
    "btn_contact_key_re_import": MessageLookupByLibrary.simpleMessage(
      "Импортировать заново",
    ),
    "btn_delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "btn_discard": MessageLookupByLibrary.simpleMessage("Сбросить"),
    "btn_done": MessageLookupByLibrary.simpleMessage("Готово"),
    "btn_download": MessageLookupByLibrary.simpleMessage("Скачать"),
    "btn_exit": MessageLookupByLibrary.simpleMessage("Выйти"),
    "btn_hide_details": MessageLookupByLibrary.simpleMessage("Скрыть детали"),
    "btn_log_delete_all": MessageLookupByLibrary.simpleMessage("Удалить все"),
    "btn_login": MessageLookupByLibrary.simpleMessage("Войти"),
    "btn_login_back_to_login": MessageLookupByLibrary.simpleMessage(
      "Вернуться к входу",
    ),
    "btn_login_open_web_version": MessageLookupByLibrary.simpleMessage(
      "Открыть веб-версию",
    ),
    "btn_message_advanced_search": MessageLookupByLibrary.simpleMessage(
      "Расширенный поиск",
    ),
    "btn_message_empty_spam_folder": MessageLookupByLibrary.simpleMessage(
      "Очистить Спам",
    ),
    "btn_message_empty_trash_folder": MessageLookupByLibrary.simpleMessage(
      "Очистить Корзину",
    ),
    "btn_message_move": MessageLookupByLibrary.simpleMessage("Переместить"),
    "btn_message_resend": MessageLookupByLibrary.simpleMessage("Повторить"),
    "btn_not_spam": MessageLookupByLibrary.simpleMessage("Не спам"),
    "btn_ok": MessageLookupByLibrary.simpleMessage("Ок"),
    "btn_pgp_check_keys": MessageLookupByLibrary.simpleMessage(
      "Проверить ключи",
    ),
    "btn_pgp_decrypt": MessageLookupByLibrary.simpleMessage("Дешифровать"),
    "btn_pgp_download_all": MessageLookupByLibrary.simpleMessage("Скачать всё"),
    "btn_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Зашифровать"),
    "btn_pgp_export_all_public_keys": MessageLookupByLibrary.simpleMessage(
      "Экспортировать все публичные ключи",
    ),
    "btn_pgp_generate": MessageLookupByLibrary.simpleMessage("Создать"),
    "btn_pgp_generate_keys": MessageLookupByLibrary.simpleMessage(
      "Создать ключи",
    ),
    "btn_pgp_import_from_file": MessageLookupByLibrary.simpleMessage(
      "Импортировать из файла",
    ),
    "btn_pgp_import_from_text": MessageLookupByLibrary.simpleMessage(
      "Импортировать из текста",
    ),
    "btn_pgp_import_keys_from_file": MessageLookupByLibrary.simpleMessage(
      "Импортировать ключ из файла",
    ),
    "btn_pgp_import_keys_from_text": MessageLookupByLibrary.simpleMessage(
      "Импортировать ключ из текста",
    ),
    "btn_pgp_import_selected_key": MessageLookupByLibrary.simpleMessage(
      "Импортировать выбранные",
    ),
    "btn_pgp_sign_or_encrypt": MessageLookupByLibrary.simpleMessage(
      "Подписать/Зашифровать",
    ),
    "btn_pgp_undo_pgp": MessageLookupByLibrary.simpleMessage("Отменить PGP"),
    "btn_php_send_all": MessageLookupByLibrary.simpleMessage("Отправить всё"),
    "btn_read": MessageLookupByLibrary.simpleMessage("Прочитанные"),
    "btn_resend_push_token": MessageLookupByLibrary.simpleMessage(
      "Переслать Push токен",
    ),
    "btn_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "btn_self_destructing": MessageLookupByLibrary.simpleMessage(
      "Самоуничтожающееся",
    ),
    "btn_share": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "btn_show_all": MessageLookupByLibrary.simpleMessage("Показать все"),
    "btn_show_details": MessageLookupByLibrary.simpleMessage("Показать детали"),
    "btn_show_email_in_light_theme": MessageLookupByLibrary.simpleMessage(
      "Показать светлый вариант письма",
    ),
    "btn_to_spam": MessageLookupByLibrary.simpleMessage("Спам"),
    "btn_unread": MessageLookupByLibrary.simpleMessage("Непрочитанные"),
    "btn_vcf_import": MessageLookupByLibrary.simpleMessage("Импорт"),
    "btn_verify_pin": MessageLookupByLibrary.simpleMessage("Подтвердите PIN"),
    "button_pgp_verify_sign": MessageLookupByLibrary.simpleMessage("Проверить"),
    "calendar": MessageLookupByLibrary.simpleMessage("Календарь"),
    "calendar_add_attendee_title": MessageLookupByLibrary.simpleMessage(
      "Добавить участника",
    ),
    "calendar_always": MessageLookupByLibrary.simpleMessage("Всегда"),
    "calendar_before": MessageLookupByLibrary.simpleMessage("до"),
    "calendar_color_label": MessageLookupByLibrary.simpleMessage("Цвет"),
    "calendar_create_event": MessageLookupByLibrary.simpleMessage(
      "Создать событие",
    ),
    "calendar_create_event_title": MessageLookupByLibrary.simpleMessage(
      "Создать событие",
    ),
    "calendar_create_task": MessageLookupByLibrary.simpleMessage(
      "Создать задачу",
    ),
    "calendar_create_task_title": MessageLookupByLibrary.simpleMessage(
      "Создать задачу",
    ),
    "calendar_create_title": MessageLookupByLibrary.simpleMessage(
      "Создать календарь",
    ),
    "calendar_delete_calendar": MessageLookupByLibrary.simpleMessage(
      "Удалить календарь",
    ),
    "calendar_delete_confirm_message": m1,
    "calendar_delete_event_title": MessageLookupByLibrary.simpleMessage(
      "Удалить событие",
    ),
    "calendar_delete_task_title": MessageLookupByLibrary.simpleMessage(
      "Удалить задачу",
    ),
    "calendar_description_label": MessageLookupByLibrary.simpleMessage(
      "Описание",
    ),
    "calendar_drawer_get_link": MessageLookupByLibrary.simpleMessage(
      "Получить ссылку",
    ),
    "calendar_drawer_my_calendars": MessageLookupByLibrary.simpleMessage(
      "Мои календари",
    ),
    "calendar_edit_event_title": MessageLookupByLibrary.simpleMessage(
      "Редактировать событие",
    ),
    "calendar_edit_task_title": MessageLookupByLibrary.simpleMessage(
      "Редактировать задачу",
    ),
    "calendar_edit_title": MessageLookupByLibrary.simpleMessage(
      "Редактировать календарь",
    ),
    "calendar_event_title": MessageLookupByLibrary.simpleMessage("Событие"),
    "calendar_filter_all": MessageLookupByLibrary.simpleMessage("Все"),
    "calendar_filter_completed": MessageLookupByLibrary.simpleMessage(
      "Завершенные",
    ),
    "calendar_filter_data": MessageLookupByLibrary.simpleMessage("Данные"),
    "calendar_filter_has_date": MessageLookupByLibrary.simpleMessage(
      "Имеет дату",
    ),
    "calendar_filter_task_status": MessageLookupByLibrary.simpleMessage(
      "Статус задачи",
    ),
    "calendar_filter_title": MessageLookupByLibrary.simpleMessage("Фильтр"),
    "calendar_filter_uncompleted": MessageLookupByLibrary.simpleMessage(
      "Незавершенные",
    ),
    "calendar_filter_without_date": MessageLookupByLibrary.simpleMessage(
      "Без даты",
    ),
    "calendar_get_public_link": MessageLookupByLibrary.simpleMessage(
      "Получить публичную ссылку на календарь",
    ),
    "calendar_ical_url_label": MessageLookupByLibrary.simpleMessage("iCal URL"),
    "calendar_import_ics_file": MessageLookupByLibrary.simpleMessage(
      "Импорт ICS файла",
    ),
    "calendar_input_all_day": MessageLookupByLibrary.simpleMessage("Весь день"),
    "calendar_input_attendees": MessageLookupByLibrary.simpleMessage(
      "Участники",
    ),
    "calendar_input_description": MessageLookupByLibrary.simpleMessage(
      "Описание",
    ),
    "calendar_input_location": MessageLookupByLibrary.simpleMessage(
      "Местоположение",
    ),
    "calendar_input_reminders": MessageLookupByLibrary.simpleMessage(
      "Напоминания",
    ),
    "calendar_input_title": MessageLookupByLibrary.simpleMessage("Название"),
    "calendar_name_label": MessageLookupByLibrary.simpleMessage(
      "Название календаря",
    ),
    "calendar_organizer_label": m2,
    "calendar_please_select_calendar": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите календарь",
    ),
    "calendar_read_permission": MessageLookupByLibrary.simpleMessage("чтение"),
    "calendar_save_changes_question": MessageLookupByLibrary.simpleMessage(
      "Сохранить изменения?",
    ),
    "calendar_select_calendar": MessageLookupByLibrary.simpleMessage(
      "Выберите календарь",
    ),
    "calendar_selected_calendar_not_found":
        MessageLookupByLibrary.simpleMessage("Выбранный календарь не найден"),
    "calendar_shared_with_all": MessageLookupByLibrary.simpleMessage(
      "Доступные всем",
    ),
    "calendar_shared_with_me": MessageLookupByLibrary.simpleMessage(
      "Доступные мне",
    ),
    "calendar_sharing_all": MessageLookupByLibrary.simpleMessage("Все"),
    "calendar_sharing_title": MessageLookupByLibrary.simpleMessage(
      "Поделиться календарем",
    ),
    "calendar_subscribe_ical_feed": MessageLookupByLibrary.simpleMessage(
      "Подписаться на iCal поток",
    ),
    "calendar_tab_day": MessageLookupByLibrary.simpleMessage("День"),
    "calendar_tab_month": MessageLookupByLibrary.simpleMessage("Месяц"),
    "calendar_tab_tasks": MessageLookupByLibrary.simpleMessage("Задачи"),
    "calendar_tab_week": MessageLookupByLibrary.simpleMessage("Неделя"),
    "calendar_task_title": MessageLookupByLibrary.simpleMessage("Задача"),
    "calendar_unsubscribe": MessageLookupByLibrary.simpleMessage("Отписаться"),
    "calendar_unsubscribe_confirm_message": m3,
    "calendar_unsubscribe_from_calendar": MessageLookupByLibrary.simpleMessage(
      "Отписаться от календаря",
    ),
    "calendar_until": MessageLookupByLibrary.simpleMessage("до"),
    "calendar_validation_enter_text": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите текст",
    ),
    "clear_cache_during_logout": MessageLookupByLibrary.simpleMessage(
      "Очистить локальный кэш и сохранённые ключи",
    ),
    "compose_body_placeholder": MessageLookupByLibrary.simpleMessage(
      "Текст сообщения",
    ),
    "compose_discard_save_dialog_description":
        MessageLookupByLibrary.simpleMessage(
          "Сохранить изменения в черновиках?",
        ),
    "compose_discard_save_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Сбросить изменения",
    ),
    "compose_forward_bcc": m4,
    "compose_forward_body_original_message":
        MessageLookupByLibrary.simpleMessage("---- Оригинал сообщения ----"),
    "compose_forward_cc": m5,
    "compose_forward_from": m6,
    "compose_forward_sent": m7,
    "compose_forward_subject": m8,
    "compose_forward_to": m9,
    "compose_reply_body_title": m10,
    "contacts": MessageLookupByLibrary.simpleMessage("Контакты"),
    "contacts_add": MessageLookupByLibrary.simpleMessage("Добавить контакт"),
    "contacts_delete_desc_with_name": m11,
    "contacts_delete_selected": MessageLookupByLibrary.simpleMessage(
      "Вы действительно хотите удалить выбранные контакты?",
    ),
    "contacts_delete_title": MessageLookupByLibrary.simpleMessage(
      "Удалить контакт",
    ),
    "contacts_delete_title_plural": MessageLookupByLibrary.simpleMessage(
      "Удалить контакты",
    ),
    "contacts_drawer_section_groups": MessageLookupByLibrary.simpleMessage(
      "Группы",
    ),
    "contacts_drawer_section_storages": MessageLookupByLibrary.simpleMessage(
      "Хранилища",
    ),
    "contacts_drawer_storage_all": MessageLookupByLibrary.simpleMessage("Все"),
    "contacts_drawer_storage_personal": MessageLookupByLibrary.simpleMessage(
      "Личные",
    ),
    "contacts_drawer_storage_shared": MessageLookupByLibrary.simpleMessage(
      "Доступные всем",
    ),
    "contacts_drawer_storage_team": MessageLookupByLibrary.simpleMessage(
      "Коллеги",
    ),
    "contacts_edit": MessageLookupByLibrary.simpleMessage(
      "Редактировать контакт",
    ),
    "contacts_edit_cancel": MessageLookupByLibrary.simpleMessage(
      "Отменить редактирование контакта",
    ),
    "contacts_edit_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "contacts_email_empty": MessageLookupByLibrary.simpleMessage(
      "Нет эл. почты",
    ),
    "contacts_empty": MessageLookupByLibrary.simpleMessage("Контактов нет"),
    "contacts_group_add": MessageLookupByLibrary.simpleMessage(
      "Добавить группу",
    ),
    "contacts_group_add_to_group": MessageLookupByLibrary.simpleMessage(
      "Добавить в группу",
    ),
    "contacts_group_delete_desc_with_name": m12,
    "contacts_group_delete_title": MessageLookupByLibrary.simpleMessage(
      "Удалить группу",
    ),
    "contacts_group_edit": MessageLookupByLibrary.simpleMessage(
      "Редактировать группу",
    ),
    "contacts_group_edit_cancel": MessageLookupByLibrary.simpleMessage(
      "Отменить редактирование группы",
    ),
    "contacts_group_edit_is_organization": MessageLookupByLibrary.simpleMessage(
      "Эта группа является компанией",
    ),
    "contacts_group_view_app_bar_delete": MessageLookupByLibrary.simpleMessage(
      "Удалить группу",
    ),
    "contacts_group_view_app_bar_edit": MessageLookupByLibrary.simpleMessage(
      "Редактировать группу",
    ),
    "contacts_group_view_app_bar_send_message":
        MessageLookupByLibrary.simpleMessage(
          "Отправить сообщение контактам в этой группе",
        ),
    "contacts_groups_empty": MessageLookupByLibrary.simpleMessage("Групп нет"),
    "contacts_list_app_bar_all_contacts": MessageLookupByLibrary.simpleMessage(
      "Все контакты",
    ),
    "contacts_list_app_bar_view_group": MessageLookupByLibrary.simpleMessage(
      "Инфорамация о группе",
    ),
    "contacts_list_its_me_flag": MessageLookupByLibrary.simpleMessage("Это я!"),
    "contacts_remove_from_group": MessageLookupByLibrary.simpleMessage(
      "Убрать контакты из группы",
    ),
    "contacts_remove_selected": MessageLookupByLibrary.simpleMessage(
      "Вы действительно хотите убрать выбранные контакты из группы?",
    ),
    "contacts_shared_message": m13,
    "contacts_view_address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "contacts_view_app_bar_attach": MessageLookupByLibrary.simpleMessage(
      "Переслать",
    ),
    "contacts_view_app_bar_delete_contact":
        MessageLookupByLibrary.simpleMessage("Удалить"),
    "contacts_view_app_bar_edit_contact": MessageLookupByLibrary.simpleMessage(
      "Редактировать",
    ),
    "contacts_view_app_bar_search_messages":
        MessageLookupByLibrary.simpleMessage("Найти сообщения"),
    "contacts_view_app_bar_send_message": MessageLookupByLibrary.simpleMessage(
      "Написать",
    ),
    "contacts_view_app_bar_share": MessageLookupByLibrary.simpleMessage(
      "Сделать общим",
    ),
    "contacts_view_app_bar_unshare": MessageLookupByLibrary.simpleMessage(
      "Сделать личным",
    ),
    "contacts_view_birthday": MessageLookupByLibrary.simpleMessage(
      "День рождения",
    ),
    "contacts_view_business_address": MessageLookupByLibrary.simpleMessage(
      "Рабочий адрес",
    ),
    "contacts_view_business_email": MessageLookupByLibrary.simpleMessage(
      "Рабочая эл. почта",
    ),
    "contacts_view_business_phone": MessageLookupByLibrary.simpleMessage(
      "Рабочий телефон",
    ),
    "contacts_view_city": MessageLookupByLibrary.simpleMessage("Город"),
    "contacts_view_company": MessageLookupByLibrary.simpleMessage("Компания"),
    "contacts_view_country": MessageLookupByLibrary.simpleMessage("Страна"),
    "contacts_view_department": MessageLookupByLibrary.simpleMessage("Отдел"),
    "contacts_view_display_name": MessageLookupByLibrary.simpleMessage(
      "Отображаемое имя",
    ),
    "contacts_view_email": MessageLookupByLibrary.simpleMessage("Эл. почта"),
    "contacts_view_facebook": MessageLookupByLibrary.simpleMessage("Facebook"),
    "contacts_view_fax": MessageLookupByLibrary.simpleMessage("Факс"),
    "contacts_view_first_name": MessageLookupByLibrary.simpleMessage("Имя"),
    "contacts_view_hide_additional_fields":
        MessageLookupByLibrary.simpleMessage("Скрыть дополнительные поля"),
    "contacts_view_job_title": MessageLookupByLibrary.simpleMessage(
      "Должность",
    ),
    "contacts_view_last_name": MessageLookupByLibrary.simpleMessage("Фамилия"),
    "contacts_view_mobile": MessageLookupByLibrary.simpleMessage("Мобильный"),
    "contacts_view_name": MessageLookupByLibrary.simpleMessage("Имя"),
    "contacts_view_nickname": MessageLookupByLibrary.simpleMessage("Ник"),
    "contacts_view_notes": MessageLookupByLibrary.simpleMessage("Заметки"),
    "contacts_view_office": MessageLookupByLibrary.simpleMessage("Офис"),
    "contacts_view_other_email": MessageLookupByLibrary.simpleMessage(
      "Дополнительная эл. почта",
    ),
    "contacts_view_personal_address": MessageLookupByLibrary.simpleMessage(
      "Домашний адрес",
    ),
    "contacts_view_personal_email": MessageLookupByLibrary.simpleMessage(
      "Домашняя эл. почта",
    ),
    "contacts_view_personal_phone": MessageLookupByLibrary.simpleMessage(
      "Личный телефон",
    ),
    "contacts_view_phone": MessageLookupByLibrary.simpleMessage("Телефон"),
    "contacts_view_province": MessageLookupByLibrary.simpleMessage("Регион"),
    "contacts_view_section_business": MessageLookupByLibrary.simpleMessage(
      "Бизнес",
    ),
    "contacts_view_section_group_name": MessageLookupByLibrary.simpleMessage(
      "Имя группы",
    ),
    "contacts_view_section_groups": MessageLookupByLibrary.simpleMessage(
      "Группы",
    ),
    "contacts_view_section_home": MessageLookupByLibrary.simpleMessage("Дом"),
    "contacts_view_section_key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "contacts_view_section_other_info": MessageLookupByLibrary.simpleMessage(
      "Прочее",
    ),
    "contacts_view_section_personal": MessageLookupByLibrary.simpleMessage(
      "Личное",
    ),
    "contacts_view_show_additional_fields":
        MessageLookupByLibrary.simpleMessage("Показать дополнительные поля"),
    "contacts_view_skype": MessageLookupByLibrary.simpleMessage("Skype"),
    "contacts_view_street_address": MessageLookupByLibrary.simpleMessage(
      "Улица",
    ),
    "contacts_view_web_page": MessageLookupByLibrary.simpleMessage("Веб сайт"),
    "contacts_view_zip": MessageLookupByLibrary.simpleMessage("Индекс"),
    "debug_hint_log_delete_record": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить файл?",
    ),
    "error_compose_no_receivers": MessageLookupByLibrary.simpleMessage(
      "Укажите получателей",
    ),
    "error_compose_wait_attachments": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста подождите пока загрузятся вложения",
    ),
    "error_connection": MessageLookupByLibrary.simpleMessage(
      "Не удалось установить соединение с сервером",
    ),
    "error_connection_offline": MessageLookupByLibrary.simpleMessage(
      "Отсутствует подключение к инетернету",
    ),
    "error_contact_pgp_key_will_not_be_valid":
        MessageLookupByLibrary.simpleMessage(
          "Pgp ключ не будет действительным",
        ),
    "error_contacts_email_empty": MessageLookupByLibrary.simpleMessage(
      "Укажите эл. почту",
    ),
    "error_contacts_save_name_empty": MessageLookupByLibrary.simpleMessage(
      "Укажите имя",
    ),
    "error_input_validation_email": MessageLookupByLibrary.simpleMessage(
      "Неверный email",
    ),
    "error_input_validation_empty": MessageLookupByLibrary.simpleMessage(
      "Это поле обязательно",
    ),
    "error_input_validation_name_illegal_symbol":
        MessageLookupByLibrary.simpleMessage(
          "Имя не может содержать \"/\\*?<>|:\"",
        ),
    "error_input_validation_unique_name": MessageLookupByLibrary.simpleMessage(
      "Такое имя уже записано",
    ),
    "error_invalid_pin": MessageLookupByLibrary.simpleMessage("Неверный PIN"),
    "error_login_account_exists": MessageLookupByLibrary.simpleMessage(
      "Этот аккаунт уже находится в списке ваших аккаунтов.",
    ),
    "error_login_auto_discover": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить домен автоматически, пожалуйста, укажите его вручную.",
    ),
    "error_login_input_email": MessageLookupByLibrary.simpleMessage(
      "Введите эл. почту",
    ),
    "error_login_input_hostname": MessageLookupByLibrary.simpleMessage(
      "Введите домен",
    ),
    "error_login_input_password": MessageLookupByLibrary.simpleMessage(
      "Введите пароль",
    ),
    "error_login_no_accounts": MessageLookupByLibrary.simpleMessage(
      "У данного пользователя нет почтовых аккаунтов",
    ),
    "error_message_not_found": MessageLookupByLibrary.simpleMessage(
      "Сообщение не найдено",
    ),
    "error_no_pgp_key": MessageLookupByLibrary.simpleMessage(
      "Публичный ключ PGP не найден",
    ),
    "error_password_is_empty": MessageLookupByLibrary.simpleMessage(
      "пароль пустой",
    ),
    "error_pgp_can_not_decrypt": MessageLookupByLibrary.simpleMessage(
      "Не удалось дешифровать.",
    ),
    "error_pgp_invalid_key_or_password": MessageLookupByLibrary.simpleMessage(
      "Неверный ключ либо пароль.",
    ),
    "error_pgp_invalid_password": MessageLookupByLibrary.simpleMessage(
      "Неверный пароль",
    ),
    "error_pgp_keys_not_found": MessageLookupByLibrary.simpleMessage(
      "Ключи не найдены",
    ),
    "error_pgp_need_contact_for_encrypt": MessageLookupByLibrary.simpleMessage(
      "Чтобы зашифровать сообщение нужно указать хотя бы одного получателя.",
    ),
    "error_pgp_not_found_keys_for": m14,
    "error_pgp_select_recipient": MessageLookupByLibrary.simpleMessage(
      "Выберите получателя",
    ),
    "error_server_access_denied": MessageLookupByLibrary.simpleMessage(
      "Доступ запрещён",
    ),
    "error_server_account_exists": MessageLookupByLibrary.simpleMessage(
      "Такой аккаунт уже существует",
    ),
    "error_server_account_old_password_not_correct":
        MessageLookupByLibrary.simpleMessage(
          "Неправильный старый пароль учетной записи",
        ),
    "error_server_auth_error": MessageLookupByLibrary.simpleMessage(
      "Неверный адрес электронной почты / пароль",
    ),
    "error_server_calendars_not_allowed": MessageLookupByLibrary.simpleMessage(
      "Календари не разрешены",
    ),
    "error_server_can_not_change_password":
        MessageLookupByLibrary.simpleMessage("Не удалось сменить пароль"),
    "error_server_can_not_create_account": MessageLookupByLibrary.simpleMessage(
      "Не могу создать аккаунт",
    ),
    "error_server_can_not_create_contact": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать контакт",
    ),
    "error_server_can_not_create_group": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать группу",
    ),
    "error_server_can_not_create_helpdesk_user":
        MessageLookupByLibrary.simpleMessage(
          "Невозможно создать пользователя службы поддержки",
        ),
    "error_server_can_not_get_contact": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить контакт",
    ),
    "error_server_can_not_save_settings": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить настройки",
    ),
    "error_server_can_not_update_contact": MessageLookupByLibrary.simpleMessage(
      "Не удается обновить контакт",
    ),
    "error_server_can_not_update_group": MessageLookupByLibrary.simpleMessage(
      "Не удается обновить группу",
    ),
    "error_server_can_not_upload_file_limit":
        MessageLookupByLibrary.simpleMessage("Превышен лимит загрузки файлов"),
    "error_server_can_not_upload_file_quota": MessageLookupByLibrary.simpleMessage(
      "Вы достигли лимита места в облачном хранилище. Не могу загрузить файл.",
    ),
    "error_server_captcha_error": MessageLookupByLibrary.simpleMessage(
      "Ошибка Captcha",
    ),
    "error_server_contact_data_has_been_modified_by_another_application":
        MessageLookupByLibrary.simpleMessage(
          "Контактные данные были изменены другим приложением",
        ),
    "error_server_contacts_not_allowed": MessageLookupByLibrary.simpleMessage(
      "Контакты не разрешены",
    ),
    "error_server_data_base_error": MessageLookupByLibrary.simpleMessage(
      "Ошибка базы данных",
    ),
    "error_server_demo_account": MessageLookupByLibrary.simpleMessage(
      "Демо аккаунт",
    ),
    "error_server_file_already_exists": MessageLookupByLibrary.simpleMessage(
      "Такой файл уже существует",
    ),
    "error_server_file_not_found": MessageLookupByLibrary.simpleMessage(
      "Файл не найден",
    ),
    "error_server_files_not_allowed": MessageLookupByLibrary.simpleMessage(
      "Файлы не разрешены",
    ),
    "error_server_helpdesk_system_user_exists":
        MessageLookupByLibrary.simpleMessage(
          "Пользователь системы службы поддержки уже существует",
        ),
    "error_server_helpdesk_unactivated_user":
        MessageLookupByLibrary.simpleMessage(
          "Неактивированный пользователь службы поддержки",
        ),
    "error_server_helpdesk_unknown_user": MessageLookupByLibrary.simpleMessage(
      "Служба поддержки неизвестного пользователя",
    ),
    "error_server_helpdesk_user_already_exists":
        MessageLookupByLibrary.simpleMessage(
          "Пользователь службы поддержки уже существует",
        ),
    "error_server_incorrect_file_extension":
        MessageLookupByLibrary.simpleMessage("Неверное расширение файла"),
    "error_server_invalid_input_parameter":
        MessageLookupByLibrary.simpleMessage("Неверный входной параметр"),
    "error_server_invalid_token": MessageLookupByLibrary.simpleMessage(
      "Неверный токен",
    ),
    "error_server_license_limit": MessageLookupByLibrary.simpleMessage(
      "Лимит лицензии",
    ),
    "error_server_license_problem": MessageLookupByLibrary.simpleMessage(
      "Проблема с лицензией",
    ),
    "error_server_mail_server_error": MessageLookupByLibrary.simpleMessage(
      "Ошибка почтового сервера",
    ),
    "error_server_method_not_found": MessageLookupByLibrary.simpleMessage(
      "Метод не найден",
    ),
    "error_server_module_not_found": MessageLookupByLibrary.simpleMessage(
      "Модуль не найден",
    ),
    "error_server_rest_account_find_failed":
        MessageLookupByLibrary.simpleMessage("Не удалось найти аккаунт REST"),
    "error_server_rest_api_disabled": MessageLookupByLibrary.simpleMessage(
      "Остальные API отключены",
    ),
    "error_server_rest_invalid_credentials":
        MessageLookupByLibrary.simpleMessage("Неверные учетные данные REST"),
    "error_server_rest_invalid_parameters":
        MessageLookupByLibrary.simpleMessage("Неверные параметры REST"),
    "error_server_rest_invalid_token": MessageLookupByLibrary.simpleMessage(
      "Недействительный токен REST",
    ),
    "error_server_rest_other_error": MessageLookupByLibrary.simpleMessage(
      "Другая ошибка REST",
    ),
    "error_server_rest_tenant_find_failed":
        MessageLookupByLibrary.simpleMessage("Не удалось найти тенант REST"),
    "error_server_rest_token_expired": MessageLookupByLibrary.simpleMessage(
      "Срок действия токена REST истек",
    ),
    "error_server_rest_unknown_method": MessageLookupByLibrary.simpleMessage(
      "Неизвестный метод REST",
    ),
    "error_server_system_not_configured": MessageLookupByLibrary.simpleMessage(
      "Система не настроена",
    ),
    "error_server_unknown_email": MessageLookupByLibrary.simpleMessage(
      "Неизвестный адрес электронной почты",
    ),
    "error_server_user_already_exists": MessageLookupByLibrary.simpleMessage(
      "Такой пользователь уже существует",
    ),
    "error_server_user_not_allowed": MessageLookupByLibrary.simpleMessage(
      "Пользователь не допущен",
    ),
    "error_server_voice_not_allowed": MessageLookupByLibrary.simpleMessage(
      "Голос не разрешен",
    ),
    "error_timeout": MessageLookupByLibrary.simpleMessage(
      "Не удается подключиться к серверу",
    ),
    "error_unknown": MessageLookupByLibrary.simpleMessage("Неизвестная ошибка"),
    "error_user_already_logged": MessageLookupByLibrary.simpleMessage(
      "Это пользователь уже авторизирован",
    ),
    "fido_btn_try_again": MessageLookupByLibrary.simpleMessage(
      "Попробовать снова",
    ),
    "fido_btn_use_key": MessageLookupByLibrary.simpleMessage(
      "Использовать ключ безопасности",
    ),
    "fido_error_hint": MessageLookupByLibrary.simpleMessage(
      "Попробуйте использовать ваш ключ безопасности снова или попробуйте другой способ подтверждения",
    ),
    "fido_error_invalid_key": MessageLookupByLibrary.simpleMessage(
      "Недействительный ключ безопасности",
    ),
    "fido_error_title": MessageLookupByLibrary.simpleMessage(
      "Возникла проблема",
    ),
    "fido_hint_follow_the_instructions": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, следуйте инструкциям во всплывающем диалоге",
    ),
    "fido_label_connect_your_key": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, отсканируйте ваш ключ безопасности или вставьте его в устройство",
    ),
    "fido_label_success": MessageLookupByLibrary.simpleMessage("Успешно"),
    "fido_label_touch_your_key": MessageLookupByLibrary.simpleMessage(
      "Коснитесь вашего ключа безопасности",
    ),
    "folders_drafts": MessageLookupByLibrary.simpleMessage("Черновики"),
    "folders_empty": MessageLookupByLibrary.simpleMessage("Нет папок"),
    "folders_inbox": MessageLookupByLibrary.simpleMessage("Входящие"),
    "folders_notes": MessageLookupByLibrary.simpleMessage("Заметки"),
    "folders_sent": MessageLookupByLibrary.simpleMessage("Отправленные"),
    "folders_spam": MessageLookupByLibrary.simpleMessage("Спам"),
    "folders_starred": MessageLookupByLibrary.simpleMessage("Отмеченные"),
    "folders_trash": MessageLookupByLibrary.simpleMessage("Корзина"),
    "format_compose_forward_date": MessageLookupByLibrary.simpleMessage(
      "EEE, d MMM, yyyy, HH:mm",
    ),
    "format_compose_reply_date": MessageLookupByLibrary.simpleMessage(
      "EEE, d MMM, yyyy \'at\' HH:mm",
    ),
    "format_contacts_birth_date": MessageLookupByLibrary.simpleMessage(
      "d MMM, yyyy",
    ),
    "hint_2fa": MessageLookupByLibrary.simpleMessage(
      "Ваш аккаунт защищён\nдвухфакторной аутентификацией.\nУкажите PIN код.",
    ),
    "hint_auto_encrypt_messages": MessageLookupByLibrary.simpleMessage(
      "Если вы хотите, чтобы сообщения этому контакту автоматически шифровались и/или подписывались, отметьте поля ниже. Обратите внимание, что эти сообщения будут преобразованы в простой текст. Вложения не будут зашифрованы.",
    ),
    "hint_confirm_exit": MessageLookupByLibrary.simpleMessage(
      "Вы уверены что хотите выйти?",
    ),
    "hint_log_delete_all": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить все логи?",
    ),
    "hint_log_delete_record": m15,
    "hint_login_configure_2FA": MessageLookupByLibrary.simpleMessage(
      "По соображениям безопасности для доступа к приложению требуется двухфакторная аутентификация (2FA).\nПожалуйста, настройте 2FA в веб-версии через настройки безопасности.",
    ),
    "hint_login_upgrade_your_plan": MessageLookupByLibrary.simpleMessage(
      "Мобильные приложения не разрешены в вашем аккаунте.",
    ),
    "hint_message_empty_folder": m16,
    "hint_pgp_already_have_keys": MessageLookupByLibrary.simpleMessage(
      "Ключи, которые уже есть в системе, выделены серым цветом.",
    ),
    "hint_pgp_delete_user_key_confirm": m17,
    "hint_pgp_existed_keys": MessageLookupByLibrary.simpleMessage(
      "Ключи, которые уже есть в системе, и не будут импортированы",
    ),
    "hint_pgp_external_private_keys": MessageLookupByLibrary.simpleMessage(
      "Внешние закрытые ключи не поддерживаются и не будут импортированы",
    ),
    "hint_pgp_keys_contacts_will_be_created":
        MessageLookupByLibrary.simpleMessage(
          "Для этих ключей будут созданны контакты",
        ),
    "hint_pgp_keys_for_import": MessageLookupByLibrary.simpleMessage(
      "Ключи, доступные для импорта",
    ),
    "hint_pgp_keys_will_be_import_to_contacts":
        MessageLookupByLibrary.simpleMessage(
          "Эти ключи будут экспортированны в контакты",
        ),
    "hint_pgp_message_automatically_encrypt": MessageLookupByLibrary.simpleMessage(
      "Сообщение будет автоматически зашифровано и/или подписано для контактов с ключами OpenPgp.\n OpenPGP поддерживает только простой текст. Все форматирование будет удалено перед шифрованием.",
    ),
    "hint_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
      "Вы собираетесь поделиться своим закрытым PGP-ключом. Закрытый ключ должен храниться только у владельца. Продолжить?",
    ),
    "hint_pgp_your_keys": MessageLookupByLibrary.simpleMessage("Ваши ключи"),
    "hint_self_destructing_encrypt_with_key": MessageLookupByLibrary.simpleMessage(
      "У выбранного получателя есть публичный ключ PGP. Сообщение может быть зашифровано с использованием этого ключа.",
    ),
    "hint_self_destructing_encrypt_with_not_key":
        MessageLookupByLibrary.simpleMessage(
          "У выбранного получателя нет публичного ключа PGP. Шифрование на основе ключа не разрешено",
        ),
    "hint_self_destructing_password_coppied_to_clipboard":
        MessageLookupByLibrary.simpleMessage("Пароль скопирован"),
    "hint_self_destructing_sent_password_using_different_channel":
        MessageLookupByLibrary.simpleMessage(
          "Пароль должен быть отправлен по другому каналу.\nСохраните пароль где-нибудь. Иначе вы не сможете его восстановить.",
        ),
    "hint_self_destructing_supports_plain_text_only":
        MessageLookupByLibrary.simpleMessage(
          "Самоуничтожающиеся защищенные письма поддерживают только простой текст. Все форматирование будет удалено. Также вложения не могут быть зашифрованы и будут удалены из сообщения.",
        ),
    "hint_vcf_import": MessageLookupByLibrary.simpleMessage(
      "Импортировать контакт из vcf?",
    ),
    "input_2fa_pin": MessageLookupByLibrary.simpleMessage("PIN"),
    "input_message_search_since": MessageLookupByLibrary.simpleMessage("От"),
    "input_message_search_text": MessageLookupByLibrary.simpleMessage("Текст"),
    "input_message_search_till": MessageLookupByLibrary.simpleMessage("До"),
    "input_self_destructing_add_digital_signature":
        MessageLookupByLibrary.simpleMessage("Добавить цифровую подпись"),
    "input_self_destructing_key_based_encryption":
        MessageLookupByLibrary.simpleMessage("На основе ключа"),
    "input_self_destructing_password_based_encryption":
        MessageLookupByLibrary.simpleMessage("На основе пароля"),
    "label_contact_pgp_settings": MessageLookupByLibrary.simpleMessage(
      "Настройки PGP",
    ),
    "label_contact_select_key": MessageLookupByLibrary.simpleMessage(
      "Выберите ключ",
    ),
    "label_contact_with_not_name": MessageLookupByLibrary.simpleMessage(
      "Без имени",
    ),
    "label_contacts_were_imported_successfully":
        MessageLookupByLibrary.simpleMessage("Контакты успешно импортированы"),
    "label_device_id_copied_to_clip_board":
        MessageLookupByLibrary.simpleMessage(
          "ID устройства скопирован в буфер обмена",
        ),
    "label_device_identifier": MessageLookupByLibrary.simpleMessage(
      "Идентификатор устройства",
    ),
    "label_discard_not_saved_changes": MessageLookupByLibrary.simpleMessage(
      "Отменить несохраненные изменения?",
    ),
    "label_enable_uploaded_message_counter":
        MessageLookupByLibrary.simpleMessage("Счетчик загруженных сообщений"),
    "label_encryption_password_for_pgp_key":
        MessageLookupByLibrary.simpleMessage("Требуется пароль для ключа PGP"),
    "label_forward_as_attachment": MessageLookupByLibrary.simpleMessage(
      "Переслать как вложение",
    ),
    "label_length": MessageLookupByLibrary.simpleMessage("Длина"),
    "label_message_advanced_search": MessageLookupByLibrary.simpleMessage(
      "Расширенный поиск",
    ),
    "label_message_headers": MessageLookupByLibrary.simpleMessage(
      "Заголовки письма",
    ),
    "label_message_move_to": MessageLookupByLibrary.simpleMessage(
      "Переместить в: ",
    ),
    "label_message_move_to_folder": MessageLookupByLibrary.simpleMessage(
      "Переместить в папку",
    ),
    "label_message_yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
    "label_notifications_settings": MessageLookupByLibrary.simpleMessage(
      "Уведомления",
    ),
    "label_pgp_all_public_key": MessageLookupByLibrary.simpleMessage(
      "Все публичные ключи",
    ),
    "label_pgp_contact_public_keys": MessageLookupByLibrary.simpleMessage(
      "Публичные ключи контактов",
    ),
    "label_pgp_decrypt": MessageLookupByLibrary.simpleMessage(
      "Open PGP дешифровка",
    ),
    "label_pgp_decrypted_and_verified": MessageLookupByLibrary.simpleMessage(
      "Сообщение успешно дешифровано и проверено.",
    ),
    "label_pgp_decrypted_but_not_verified":
        MessageLookupByLibrary.simpleMessage(
          "Сообщение успешно дешифровано, но не проверено.",
        ),
    "label_pgp_downloading_to": m18,
    "label_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Зашифровать"),
    "label_pgp_import_key": MessageLookupByLibrary.simpleMessage(
      "Импорт ключей",
    ),
    "label_pgp_key_with_not_name": MessageLookupByLibrary.simpleMessage(
      "Без имени",
    ),
    "label_pgp_not_verified": MessageLookupByLibrary.simpleMessage(
      "Сообщение не проверено.",
    ),
    "label_pgp_private_key": MessageLookupByLibrary.simpleMessage(
      "Приватный ключ",
    ),
    "label_pgp_private_keys": MessageLookupByLibrary.simpleMessage(
      "Приватные ключи",
    ),
    "label_pgp_public_key": MessageLookupByLibrary.simpleMessage(
      "Публичный ключ",
    ),
    "label_pgp_public_keys": MessageLookupByLibrary.simpleMessage(
      "Публичные ключи",
    ),
    "label_pgp_settings": MessageLookupByLibrary.simpleMessage("OpenPGP"),
    "label_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
      "Предупреждение",
    ),
    "label_pgp_sign": MessageLookupByLibrary.simpleMessage("Подписать"),
    "label_pgp_sign_or_encrypt": MessageLookupByLibrary.simpleMessage(
      "Open PGP шифрование",
    ),
    "label_pgp_verified": MessageLookupByLibrary.simpleMessage(
      "Сообщение успешно проверено.",
    ),
    "label_record_log_in_background": MessageLookupByLibrary.simpleMessage(
      "Записывать лог в фоне",
    ),
    "label_self_destructing": MessageLookupByLibrary.simpleMessage(
      "Отправить самоуничтожающееся защищенное письмо",
    ),
    "label_self_destructing_key_based_encryption_used":
        MessageLookupByLibrary.simpleMessage(
          "Будет использовано шифрование на основе ключа.",
        ),
    "label_self_destructing_not_sign_data":
        MessageLookupByLibrary.simpleMessage("Данные не будут подписаны."),
    "label_self_destructing_password_based_encryption_used":
        MessageLookupByLibrary.simpleMessage(
          "Будет использовано шифрование на основе пароля.",
        ),
    "label_self_destructing_sign_data": MessageLookupByLibrary.simpleMessage(
      "Данные будут подписаны вашим приватным ключом.",
    ),
    "label_show_debug_view": MessageLookupByLibrary.simpleMessage(
      "Показать отладочный вид",
    ),
    "label_token_failed": MessageLookupByLibrary.simpleMessage("Неудачно"),
    "label_token_storing_status": MessageLookupByLibrary.simpleMessage(
      "Статус сохранения токена",
    ),
    "label_token_successful": MessageLookupByLibrary.simpleMessage("Успешно"),
    "login_continue": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "login_input_email": MessageLookupByLibrary.simpleMessage("Почта"),
    "login_input_host": MessageLookupByLibrary.simpleMessage("Домен"),
    "login_input_password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "login_no_account_yet": MessageLookupByLibrary.simpleMessage(
      "Еще нет аккаунта? ",
    ),
    "login_register_now": MessageLookupByLibrary.simpleMessage(
      "Зарегистрироваться",
    ),
    "login_sign_in": MessageLookupByLibrary.simpleMessage("Войти"),
    "login_to_continue": MessageLookupByLibrary.simpleMessage(
      "Войдите в аккаунт",
    ),
    "message_lifetime": MessageLookupByLibrary.simpleMessage(
      "Время жизни сообщения",
    ),
    "messages_always_show_images": MessageLookupByLibrary.simpleMessage(
      "Всегда показывать изображения в сообщениях от данного отправителя.",
    ),
    "messages_attachment_delete": MessageLookupByLibrary.simpleMessage(
      "Удалить файл",
    ),
    "messages_attachment_download": MessageLookupByLibrary.simpleMessage(
      "Скачать файл",
    ),
    "messages_attachment_download_cancel": MessageLookupByLibrary.simpleMessage(
      "Отменить загрузку",
    ),
    "messages_attachment_download_failed": MessageLookupByLibrary.simpleMessage(
      "Ошибка загрузки",
    ),
    "messages_attachment_download_success": m19,
    "messages_attachment_downloading": m20,
    "messages_attachment_upload": MessageLookupByLibrary.simpleMessage(
      "Загрузить файл",
    ),
    "messages_attachment_upload_cancel": MessageLookupByLibrary.simpleMessage(
      "Отменить загрузку",
    ),
    "messages_attachment_upload_failed": MessageLookupByLibrary.simpleMessage(
      "Загрузка не удалась",
    ),
    "messages_attachment_upload_success": m21,
    "messages_attachment_uploading": m22,
    "messages_attachments_empty": MessageLookupByLibrary.simpleMessage(
      "Нет вложений",
    ),
    "messages_bcc": MessageLookupByLibrary.simpleMessage("BCC"),
    "messages_cc": MessageLookupByLibrary.simpleMessage("CC"),
    "messages_delete_desc": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить это сообщение?",
    ),
    "messages_delete_desc_with_count": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить эти сообщения?",
    ),
    "messages_delete_desc_with_subject": m23,
    "messages_delete_title": MessageLookupByLibrary.simpleMessage(
      "Удалить сообщение",
    ),
    "messages_delete_title_with_count": MessageLookupByLibrary.simpleMessage(
      "Удалить сообщения",
    ),
    "messages_empty": MessageLookupByLibrary.simpleMessage("Нет сообщений"),
    "messages_filter_unread": MessageLookupByLibrary.simpleMessage(
      "Непрочитаные сообщения",
    ),
    "messages_forward": MessageLookupByLibrary.simpleMessage("Переслать"),
    "messages_from": MessageLookupByLibrary.simpleMessage("От кого"),
    "messages_images_security_alert": MessageLookupByLibrary.simpleMessage(
      "Из соображений безобазности картинки были заблокированы.",
    ),
    "messages_list_app_bar_contacts": MessageLookupByLibrary.simpleMessage(
      "Контакты",
    ),
    "messages_list_app_bar_loading_folders":
        MessageLookupByLibrary.simpleMessage("Загрузка папок..."),
    "messages_list_app_bar_logout": MessageLookupByLibrary.simpleMessage(
      "Выйти",
    ),
    "messages_list_app_bar_mail": MessageLookupByLibrary.simpleMessage("Почта"),
    "messages_list_app_bar_search": MessageLookupByLibrary.simpleMessage(
      "Поиск",
    ),
    "messages_list_app_bar_settings": MessageLookupByLibrary.simpleMessage(
      "Настройки",
    ),
    "messages_no_receivers": MessageLookupByLibrary.simpleMessage(
      "Нет получателей",
    ),
    "messages_no_subject": MessageLookupByLibrary.simpleMessage("Без объекта"),
    "messages_reply": MessageLookupByLibrary.simpleMessage("Ответить"),
    "messages_reply_all": MessageLookupByLibrary.simpleMessage("Ответить всем"),
    "messages_saved_in_drafts": MessageLookupByLibrary.simpleMessage(
      "Сообщение сохранено в черновиках",
    ),
    "messages_sending": MessageLookupByLibrary.simpleMessage(
      "Отправка сообщения...",
    ),
    "messages_show_details": MessageLookupByLibrary.simpleMessage(
      "Показать детали",
    ),
    "messages_show_images": MessageLookupByLibrary.simpleMessage(
      "Показать изображения.",
    ),
    "messages_subject": MessageLookupByLibrary.simpleMessage("Объект"),
    "messages_to": MessageLookupByLibrary.simpleMessage("Кому"),
    "messages_to_me": MessageLookupByLibrary.simpleMessage("Мне"),
    "messages_unknown_recipient": MessageLookupByLibrary.simpleMessage(
      "Нет получателя",
    ),
    "messages_unknown_sender": MessageLookupByLibrary.simpleMessage(
      "Нет отправителя",
    ),
    "messages_view_tab_attachments": MessageLookupByLibrary.simpleMessage(
      "Вложения",
    ),
    "messages_view_tab_message_body": MessageLookupByLibrary.simpleMessage(
      "Тело письма",
    ),
    "no_permission_to_local_storage": MessageLookupByLibrary.simpleMessage(
      "Нет разрешения для доступа к файлам. Проверьте настройки на вашем устройстве.",
    ),
    "record_not_found": MessageLookupByLibrary.simpleMessage(
      "Запись не найдена",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Удалить"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "save_changes_question": MessageLookupByLibrary.simpleMessage(
      "Сохранить изменения?",
    ),
    "self_destructing_life_time_day": MessageLookupByLibrary.simpleMessage(
      "24 часа",
    ),
    "self_destructing_life_time_days_3": MessageLookupByLibrary.simpleMessage(
      "72 часа",
    ),
    "self_destructing_life_time_days_7": MessageLookupByLibrary.simpleMessage(
      "7 дней",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "settings_24_time_format": MessageLookupByLibrary.simpleMessage(
      "24 часовой формат времени",
    ),
    "settings_about": MessageLookupByLibrary.simpleMessage("О приложении"),
    "settings_about_app_version": m24,
    "settings_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "settings_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
      "Правила пользования",
    ),
    "settings_accounts_add": MessageLookupByLibrary.simpleMessage(
      "Добавить новый аккаунт",
    ),
    "settings_accounts_delete": MessageLookupByLibrary.simpleMessage(
      "Удалить аккаунт",
    ),
    "settings_accounts_delete_description": m25,
    "settings_accounts_manage": MessageLookupByLibrary.simpleMessage(
      "Управление аккаунтами",
    ),
    "settings_accounts_relogin": MessageLookupByLibrary.simpleMessage(
      "Войти в аккаунт",
    ),
    "settings_common": MessageLookupByLibrary.simpleMessage("Общие"),
    "settings_dark_theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "settings_dark_theme_dark": MessageLookupByLibrary.simpleMessage("Тёмная"),
    "settings_dark_theme_light": MessageLookupByLibrary.simpleMessage(
      "Светлая",
    ),
    "settings_dark_theme_system": MessageLookupByLibrary.simpleMessage(
      "Системная",
    ),
    "settings_delete_account": MessageLookupByLibrary.simpleMessage(
      "Удалить аккаунт",
    ),
    "settings_language": MessageLookupByLibrary.simpleMessage("Язык"),
    "settings_language_system": MessageLookupByLibrary.simpleMessage(
      "Язык системы",
    ),
    "settings_sync": MessageLookupByLibrary.simpleMessage("Синхронизация"),
    "settings_sync_frequency": MessageLookupByLibrary.simpleMessage(
      "Обновлять каждые",
    ),
    "settings_sync_frequency_daily": MessageLookupByLibrary.simpleMessage(
      "ежедневно",
    ),
    "settings_sync_frequency_hours1": MessageLookupByLibrary.simpleMessage(
      "1 час",
    ),
    "settings_sync_frequency_hours2": MessageLookupByLibrary.simpleMessage(
      "два часа",
    ),
    "settings_sync_frequency_minutes30": MessageLookupByLibrary.simpleMessage(
      "30 минут",
    ),
    "settings_sync_frequency_minutes5": MessageLookupByLibrary.simpleMessage(
      "5 минут",
    ),
    "settings_sync_frequency_monthly": MessageLookupByLibrary.simpleMessage(
      "ежемесячно",
    ),
    "settings_sync_frequency_never": MessageLookupByLibrary.simpleMessage(
      "отключено",
    ),
    "settings_sync_frequency_weekly": MessageLookupByLibrary.simpleMessage(
      "еженедельно",
    ),
    "settings_sync_frequency_yearly": MessageLookupByLibrary.simpleMessage(
      "ежегодно",
    ),
    "settings_sync_period": MessageLookupByLibrary.simpleMessage(
      "Синхронизировать письма за",
    ),
    "settings_sync_period_all_time": MessageLookupByLibrary.simpleMessage(
      "все время",
    ),
    "settings_sync_period_months1": MessageLookupByLibrary.simpleMessage(
      "1 месяц",
    ),
    "settings_sync_period_months3": MessageLookupByLibrary.simpleMessage(
      "3 месяца",
    ),
    "settings_sync_period_months6": MessageLookupByLibrary.simpleMessage(
      "6 месяцев",
    ),
    "settings_sync_period_years1": MessageLookupByLibrary.simpleMessage(
      "1 год",
    ),
    "template_self_destructing_message": m26,
    "template_self_destructing_message_password": m27,
    "template_self_destructing_message_title":
        MessageLookupByLibrary.simpleMessage(
          "С вами поделились защищенным сообщением",
        ),
    "tfa_btn_other_options": MessageLookupByLibrary.simpleMessage(
      "Другие варианты",
    ),
    "tfa_btn_use_auth_app": MessageLookupByLibrary.simpleMessage(
      "Использовать приложение аутентификатор",
    ),
    "tfa_btn_use_backup_code": MessageLookupByLibrary.simpleMessage(
      "Использовать резервный код",
    ),
    "tfa_btn_use_security_key": MessageLookupByLibrary.simpleMessage(
      "Использовать ваш ключ безопасности",
    ),
    "tfa_button_continue": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "tfa_check_box_trust_device": m28,
    "tfa_error_invalid_backup_code": MessageLookupByLibrary.simpleMessage(
      "Недействительный резервный код",
    ),
    "tfa_hint_step": MessageLookupByLibrary.simpleMessage(
      "Этот дополнительный шаг предназначен для подтверждения того, что это действительно вы пытаетесь войти",
    ),
    "tfa_input_backup_code": MessageLookupByLibrary.simpleMessage(
      "Резервный код",
    ),
    "tfa_input_hint_code_from_app": MessageLookupByLibrary.simpleMessage(
      "Укажите код подтверждения из приложения аутентификатор",
    ),
    "tfa_label": MessageLookupByLibrary.simpleMessage("Двухфакторная проверка"),
    "tfa_label_enter_backup_code": MessageLookupByLibrary.simpleMessage(
      "Введите один из ваших 8-символьных резервных кодов",
    ),
    "tfa_label_hint_security_options": MessageLookupByLibrary.simpleMessage(
      "Доступные варианты безопасности",
    ),
    "tfa_label_trust_device": MessageLookupByLibrary.simpleMessage(
      "Все готово",
    ),
    "week_titles": MessageLookupByLibrary.simpleMessage("Пн,Вт,Ср,Чт,Пт,Сб,Вс"),
  };
}
