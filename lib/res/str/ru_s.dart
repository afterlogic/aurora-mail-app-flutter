import "s.dart";

class RuS extends S {
  final _map = <int, String>{
    0: "Mail Client",
    1: "Домен",
    2: "Почта",
    3: "Пароль",
    4: "Войдите в аккаунт",
    5: "Нет папок",
    6: "Входящие",
    7: "Отмеченные",
    8: "Отправленные",
    9: "Черновики",
    10: "Спам",
    11: "Корзина",
    12: "Ответить",
    13: "Ответить всем",
    14: "Переслать",
    15: "Нет сообщений",
    16: "Непрочитаные сообщения:",
    17: "Удалить сообщение",
    18: "Удалить сообщения",
    19: "Вы уверены, что хотите удалить {subject}?",
    20: "Вы уверены, что хотите удалить это сообщение?",
    21: "Вы уверены, что хотите удалить эти сообщения?",
    22: "Почта",
    23: "Контакты",
    24: "Настройки",
    25: "Выйти",
    26: "Поиск",
    27: "Загрузка папок...",
    28: "Показать детали",
    29: "Из соображений безобазности картинки были заблокированы.",
    30: "Показать изображения.",
    31: "Всегда показывать изображения в сообщениях от данного отправителя.",
    32: "Вложения",
    33: "Тело письма",
    34: "Кому",
    35: "От кого",
    36: "Копия",
    37: "Скрытая копия",
    38: "Тема",
    39: "Без темы",
    40: "Мне",
    41: "Нет получателей",
    42: "Нет отправителя",
    43: "Нет получателя",
    44: "Отправка сообщения...",
    45: "Сообщение сохранено в черновиках",
    46: "Нет вложений",
    47: "Удалить файл",
    48: "Скачать файл",
    49: "Загрузка {fileName}...",
    50: "Ошибка загрузки",
    51: "Отменить загрузку",
    52: "Файл загружен в: {path}",
    53: "Загрузить файл",
    54: "Загрузка {fileName}...",
    55: "Загрузка не удалась",
    56: "Отменить загрузку",
    57: "Файл загружен в: {path}",
    58: "Текст сообщения...",
    59: "---- Оригинал сообщения ----",
    60: "От: {emails}",
    61: "Кому: {emails}",
    62: "Копия: {emails}",
    63: "Скрытая копия: {emails}",
    64: "Отправлено: {date}",
    65: "Тема: {subject}",
    66: "В {time}, {from} написал(а):",
    67: "Сбросить изменения",
    68: "Вы хотите сохранить изменения в черновиках?",
    69: "Контакты",
    70: "Инфорамация о группе",
    71: "Все контакты",
    72: "Это я!",
    73: "Контактов нет",
    74: "Групп нет",
    75: "Нет эл. почты",
    76: "Хранилища",
    77: "Все",
    78: "Личные",
    79: "Коллеги",
    80: "Доступные всем",
    81: "Группы",
    82: "Сделать общим",
    83: "Сделать личным",
    84: "Переслать",
    85: "Написать",
    86: "Найти сообщения",
    87: "Редактировать",
    88: "Удалить",
    89: "{contact} скоро появится в хранилище {storage}",
    90: "Отправить сообщение контактам в этой группе",
    91: "Удалить группу",
    92: "Редактировать группу",
    93: "Показать дополнительные поля",
    94: "Скрыть дополнительные поля",
    95: "Дом",
    96: "Личное",
    97: "Бизнес",
    98: "Прочее",
    99: "Имя группы",
    100: "Группы",
    101: "Отображаемое имя",
    102: "Эл. почта",
    103: "Домашняя эл. почта",
    104: "Рабочая эл. почта",
    105: "Дополнительная эл. почта",
    106: "Телефон",
    107: "Личный телефон",
    108: "Рабочий телефон",
    109: "Мобильный",
    110: "Факс",
    111: "Адрес",
    112: "Домашний адрес",
    113: "Рабочий адрес",
    114: "Skype",
    115: "Facebook",
    116: "Имя",
    117: "Имя",
    118: "Фамилия",
    119: "Ник",
    120: "Улица",
    121: "Город",
    122: "Регион",
    123: "Страна",
    124: "Индекс",
    125: "Веб сайт",
    126: "Компания",
    127: "Отдел",
    128: "Должность",
    129: "Офис",
    130: "День рождения",
    131: "Заметки",
    132: "Редактировать контакт",
    133: "Отменить редактирование контакта",
    134: "Сохранить",
    135: "Добавить контакт",
    136: "Добавить группу",
    137: "Редактировать группу",
    138: "Эта группа является компанией",
    139: "Отменить редактирование группы",
    140: "Удалить контакт",
    141: "Вы действительно хотите удалить {contact}?",
    142: "Удалить группу",
    143:
        "Вы действительно хотите удалить {group}? Контакты этой группы удалены не будут.",
    144: "Настройки",
    145: "Общие",
    146: "24 часовой формат времени",
    147: "Язык",
    148: "Язык системы",
    149: "Тема",
    150: "Системная",
    151: "Тёмная",
    152: "Светлая",
    153: "Синхронизация",
    154: "Обновлять каждые",
    155: "отключено",
    156: "5 минут",
    157: "30 минут",
    158: "1 час",
    159: "два часа",
    160: "ежедневно",
    161: "ежемесячно",
    162: "Синхронизировать письма за",
    163: "все время",
    164: "1 месяц",
    165: "3 месяца",
    166: "6 месяцев",
    167: "1 год",
    168: "Управление аккаунтами",
    169: "Добавить новый аккаунт",
    170: "Войти в аккаунт",
    171: "Удалить аккаунт",
    172: "Вы действительно хотите выйти из аккаунта {account} и удалить его?",
    173: "О приложении",
    174: "Версия {version}",
    175: "Правила пользования",
    176: "Политика конфиденциальности",
    177: "Войти",
    178: "Удалить",
    179: "Показать светлый вариант письма",
    180: "Отмена",
    181: "Закрыть",
    182: "Спам",
    183: "Сохранить",
    184: "Сбросить",
    185: "Добавить аккаунт",
    186: "Показать все",
    187: "Введите домен",
    188: "Введите эл. почту",
    189: "Введите пароль",
    190:
        "Не удалось определить домен автоматически, пожалуйста, укажите его вручную.",
    191: "У данного пользователя нет почтовых аккаунтов",
    192: "Этот аккаунт уже находится в списке ваших аккаунтов.",
    193: "Укажите получателей",
    194: "Пожалуйста подождите пока загрузятся вложения",
    195: "Укажите имя",
    196: "Укажите эл. почту",
    199: "Это поле обязательно",
    198: "Отсутствует подключение к инетернету",
    203: "Неверный токен",
    204: "Неверный адрес электронной почты / пароль",
    205: "Неверный входной параметр",
    206: "Ошибка базы данных",
    207: "Проблема с лицензией",
    208: "Демо аккаунт",
    209: "Ошибка Captcha",
    210: "Доступ запрещён",
    211: "Неизвестный адрес электронной почты",
    212: "Пользователь не допущен",
    213: "Такой пользователь уже существует",
    214: "Система не настроена",
    215: "Модуль не найден",
    216: "Метод не найден",
    217: "Лимит лицензии",
    218: "Не удалось сохранить настройки",
    219: "Не удалось сменить пароль",
    220: "Неправильный старый пароль учетной записи",
    221: "Не удалось создать контакт",
    222: "Не удалось создать группу",
    223: "Не удается обновить контакт",
    224: "Не удается обновить группу",
    225: "Контактные данные были изменены другим приложением",
    226: "Не удалось получить контакт",
    227: "Не могу создать аккаунт",
    228: "Такой аккаунт уже существует",
    229: "Другая ошибка REST",
    230: "Остальные API отключены",
    231: "Неизвестный метод REST",
    232: "Неверные параметры REST",
    233: "Неверные учетные данные REST",
    234: "Недействительный токен REST",
    235: "Срок действия токена REST истек",
    236: "Не удалось найти аккаунт REST",
    237: "Не удалось найти тенант REST",
    238: "Календари не разрешены",
    239: "Файлы не разрешены",
    240: "Контакты не разрешены",
    241: "Пользователь службы поддержки уже существует",
    242: "Пользователь системы службы поддержки уже существует",
    243: "Невозможно создать пользователя службы поддержки",
    244: "Служба поддержки неизвестного пользователя",
    245: "Неактивированный пользователь службы поддержки",
    246: "Голос не разрешен",
    247: "Неверное расширение файла",
    248:
        "Вы достигли лимита места в облачном хранилище. Не могу загрузить файл.",
    249: "Такой файл уже существует",
    250: "Файл не найден",
    251: "Превышен лимит загрузки файлов",
    252: "Ошибка почтового сервера",
    253: "Неизвестная ошибка",
    254: "EEE, d MMM, yyyy, HH:mm",
    255: "EEE, d MMM, yyyy 'at' HH:mm",
    256: "d MMM, yyyy",
    257: "Вчера",
    258:
        "Ваш аккаунт защищён\nдвухфакторной аутентификацией.\nУкажите PIN код.",
    265: "OpenPGP",
    266: "Public keys",
    267: "Private keys",
    268: "Экспортировать все публичные ключи",
    269: "Импортировать ключ из текста",
    270: "Импортировать ключ из файла",
    273: "Создать ключи",
    274: "Создать",
    275: "Длина",
    276: "Скачать",
    277: "Поделиться",
    278: "Public key",
    279: "Private key",
    280: "Импорт ключей",
    281: "Импортировать выбранные",
    282: "Проверить ключи",
    283: "Ключи не найдены",
    284: "Все публичные ключи",
    285: "Скачать всё",
    286: "Отправить всё",
    287: "Загруженно в {path}",
    288: "Вы действительно хотите удалить OpenPGP key для {user}",
    289: "Sign/Encrypt",
    290: "Open PGP шифрование",
    291: "Open PGP дешифровка",
    292: "Подписать",
    293: "Зашифровать",
    294: "Дешифровать",
    295: "Неверный пароль",
    296: "Ключи для пользователя {users} не найдены",
    297: "Отменить PGP",
    298: "Сообщение успешно проверено.",
    299: "Сообщение не проверено.",
    300: "Сообщение успешно дешифровано и проверено.",
    301: "Сообщение успешно дешифровано, но не проверено.",
    302: "Неверный ключ либо пароль.",
    303: "Не удалось дешифровать.",
    304: "Чтобы зашифровать сообщение нужно указать хотя бы одного получателя.",
    305: "Проверить",
    306: "Ключи, которые уже есть в системе, выделены серым цветом.",
    197: "Не удалось установить соединение с сервером",
    200: "Неверный email",
    201: "Имя не может содержать \"/\\*?<>|:\"",
    202: "Такое имя уже записано",
    259: "PIN",
    260: "Подтвердите PIN",
    261: "Неверный PIN",
    262: "Готово",
    263: "Вы уверены что хотите выйти",
    264: "Выйти",
    307: "Искать в письмах",
    308: "Повторить",
    309: "Очистить Корзину",
    310: "Очистить Спам",
    311: "Вы уверены, что хотите удалить все сообщение в папке {folder}?",
    312: "Send a self-destructing secure email",
    313: "24 hours",
    314: "72 hours",
    315: "7 days",
    316: "Message lifetime",
    317: "Без имени",
    327: "Выберите получателя",
    331: "Ок",
    318: "Will not sign the data.",
    319: "Will sign the data with your private key.",
    320: "Password-based",
    321: "Key-based",
    322: "The Password-based encryption will be used.",
    323: "The Key-based encryption will be used.",
    324:
        "Selected recipient has PGP public key. The message can be encrypted using this key.",
    325:
        "Selected recipient has no PGP public key. The key-based encryption is not allowed",
    326: "Add digital signature",
    328:
        "Hello,\n{sender} user sent you a self-destructing secure email.\nYou can read it by the following link:\n{link}\n{message_password}The message will be accessible for {lifeTime} starting from {now}",
    329: "The message is password-protected. The password is: {password}\n",
    330: "The secure message was shared with you",
    332:
        "The self-descructing secure emails support plain text only. All the formatting will be removed. Also, attachments cannot be encrypted and will be removed from the message.",
    333:
        "The password must be sent using a different channel.\n  Store the password somewhere. You will not be able to recover it otherwise.",
    334: "Self-destructing",
    335: "Пароль скопирован",
    271: "Импортировать из текста",
    272: "Импортировать из файла",
    336: "Mobile apps are not allowed in your account.",
    337: "Back to login",
    338: "Pgp ключ не будет действительным",
    339: "Импортировать заного",
    340: "Удалить ключ",
    341: "Выберите ключ",
    342: "Эти ключи будут экспортированны в контакты",
    343: "Для этих ключей будут созданны контакты",
    344: "Ваши ключи",
    345: "Публичные ключи контактов",
    346: "Переместить в: ",
    347: "Move",
    348: "Переместить в папку",
    349: "Расширенный поиск",
    351: "Текст",
    352: "От",
    353: "До",
    354: "Предупреждение",
    355:
        "You are going to share you private PGP key. The key must be kept from the 3-thd party. Do you want to continue?",
    358: "Заголовки письма",
    350: "Advanced search",
    356: "Import",
    357: "Import contact from vcf?",
    361: "Это пользователь уже авторизирован",
    362: "Unread",
    363: "Read",
    364: "Show details",
    365: "Hide details",
    366: "Notifications",
    367: "Device identifier",
    368: "Token storing status",
    369: "Resend Push Token",
    370: "Successful",
    371: "Failed",
    374: "Contacts imported successfully",
    359: "Forward as attachment",
    360: "No name",
    372: "Device id copied to clipboard",
    373: "Discard not saved changes?",
    375: "Encrypt",
    376:
        "If you want messages to this contact to be automatically encrypted and/or signed, check the boxes below. Please note that these messages will be converted to plain text. Attachments will not be encrypted.",
    377: "Delete all",
    378: "Record log in background",
    379: "Show debug view",
    380: "Are you sure you want to delete all logs",
    381: "Counter of uploaded message",
    382: "No PGP public key was found",
    383: "PGP Settings",
    384:
        "The message will be automatically encrypted and/or signed for contacts with OpenPgp keys.\n OpenPGP supports plain text only. All the formatting will be removed before encryption.",
    385: "Not spam",
    386: "password is empty",
    387: "Required password for PGP key",
    407: "Are you sure you want to delete file {name}",
    389: "Can't connect to the server",
  };
  String get(int id) => _map[id];
}
