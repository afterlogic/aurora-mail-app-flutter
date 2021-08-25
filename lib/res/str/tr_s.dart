import "s.dart";

class TrS extends S {
  final _map = <int, String>{
    0: "E-posta Okuyucu",
    1: "Sunucu",
    2: "E-posta",
    3: "Şifre",
    4: "Devam etmek için giriş yapın",
    5: "Klasör yok",
    6: "Gelen Kutusu",
    7: "Yıldızlı",
    8: "Gönderilen",
    9: "Taslaklar",
    10: "Spam",
    11: "Çöp Kutusu",
    12: "Yanıtla",
    13: "Tümünü yanıtla",
    14: "Yönlendir",
    15: "İleti yok",
    16: "Okunmamış iletiler:",
    17: "İletiyi sil",
    18: "{subject} silmek istediğinize emin misiniz?",
    19: "Bu iletiyi silmek istediğinden emin misin?",
    20: "E-posta",
    21: "Kişiler",
    22: "Ayarlar",
    23: "Oturumu kapat",
    24: "Ara",
    25: "Klasörler yükleniyor...",
    26: "Detayları göster",
    27: "Bu iletideki görseller güvenliğiniz sebebiyle engellendi. ",
    28: "Görselleri göster.",
    29: "Görselleri her zaman göster.",
    30: "Ekler",
    31: "İleti metni",
    32: "Alıcı",
    33: "Gönderen",
    34: "CC",
    35: "BCC",
    36: "Konu",
    37: "Konu yok",
    38: "Bana",
    39: "Alıcı yok",
    40: "Gönderen yok",
    41: "Alıcı yok",
    42: "İleti gönderiliyor...",
    43: "İleti taslaklara kaydedildi",
    44: "Ek yok",
    45: "Eki sil",
    46: "Eki indir",
    47: "{fileName} indiriliyor ...",
    48: "İndirme işlemi başarısız",
    49: "İndirmeyi iptal et",
    50: "Dosya şuraya indirildi: {path}",
    51: "Dosya yükle",
    52: "{fileName} yükleniyor ...",
    53: "Yükleme işlemi başarısız",
    54: "Yüklemeyi iptal et",
    55: "Dosya şuraya yüklendi: {path}",
    56: "İleti metni...",
    57: "---- Orijinal İleti ----",
    58: "Gönderen: {emails}",
    59: "Alıcı: {emails}",
    60: "CC: {emails}",
    61: "BCC: {emails}",
    62: "Gönderildi: {date}",
    63: "Konu: {subject}",
    64: "{time},tarihinde {from} yazdı:",
    65: "Değişiklikleri iptal et",
    66: "Değişiklikleri taslak olarak kaydetmek ister misiniz?",
    67: "Kişiler",
    68: "Grubu görüntüle",
    69: "Tüm kişiler",
    70: "Sizin hesabınız",
    71: "Kişi yok",
    72: "Grup yok",
    73: "E-posta adresi yok",
    74: "Depolama",
    75: "Tümü",
    76: "Kişisel",
    77: "Ekip",
    78: "Herkesle paylaşıldı",
    79: "Gruplar",
    80: "Paylaş",
    81: "Paylaşma",
    82: "Gönder",
    83: "Bu kişiye e-posta gönder",
    84: "İletilerde ara",
    85: "Düzenle",
    86: "Sil",
    87: "{contact} kişisi birazdan {storage} alanında görünür olacak. ",
    88: "Gruptaki kişilere e-posta gönder",
    89: "Bu grubu sil",
    90: "Grubu güncelle",
    91: "Ek alanları göster",
    92: "Ek alanları gizle",
    93: "Ana Sayfa",
    94: "Kişisel",
    95: "Şirket",
    96: "Diğer",
    97: "Grup Adı",
    98: "Gruplar",
    99: "Görünen ad",
    100: "E-posta",
    101: "Kişisel e-posta",
    102: "Şirket e-postası",
    103: "Diğer e-posta",
    104: "Telefon",
    105: "Kişisel Telefon",
    106: "İş Telefonu",
    107: "Cep Telefonu",
    108: "Faks",
    109: "Adres",
    110: "Kişisel Adres",
    111: "İş Adresi",
    112: "Skype",
    113: "Facebook",
    114: "İsim",
    115: "İsim",
    116: "Soyisim",
    117: "Takma İsim",
    118: "Sokak",
    119: "Şehir",
    120: "Eyalet",
    121: "Ülke",
    122: "Posta Kodu",
    123: "Web Sayfası",
    124: "Şirket",
    125: "Departman",
    126: "Ünvan",
    127: "Ofis",
    128: "Doğum günü",
    129: "Notlar",
    130: "Kişiyi düzenle",
    131: "Kişiyi düzenlemekten vazgeç",
    132: "Değişiklikleri kaydet",
    133: "Kişi ekle",
    134: "Grup ekle",
    135: "Grubu düzenle",
    136: "Bu grup bir şirket",
    137: "Grubu düzenlemekten vazgeç",
    138: "Kişiyi sil",
    139: "{contact} silmek istediğinize emin misiniz?",
    140: "Grubu sil",
    141:
        " {group} silmek istediğinize emin misiniz? Gruptaki kişiler silinmeyecektir.",
    142: "Ayarlar",
    143: "Genel",
    144: "24 saat formatı",
    145: "Dil",
    146: "Sistem dili",
    147: "Tema",
    148: "Sistem teması",
    149: "Koyu",
    150: "Açık",
    151: "Senkronizasyon",
    152: "Senkronizasyon sıklığı",
    153: "hiçbir zaman",
    154: "5 dakika",
    155: "30 dakika",
    156: "1 saat",
    157: "2 saat",
    158: "günlük",
    159: "aylık",
    160: "Senkronizasyon periyodu",
    161: "her zaman",
    162: "1 ay",
    163: "3 ay",
    164: "6 ay",
    165: "1 yıl",
    166: "Hesapları yönet",
    167: "Yeni hesap ekle",
    168: "Hesaba tekrar giriş yap",
    169: "Hesabı sil",
    170: " {account} hesabını silmek istediğinize emin misiniz?",
    171: "Hakkında",
    172: " {version} versiyonu",
    173: "Hizmet Şartları",
    174: "Gizlilik Politikası",
    175: "Oturum aç",
    176: "Sil",
    177: "E-postayı açık temada göster",
    178: "Iptal",
    179: "Kapat",
    180: "Spam'e taşı",
    181: "Kaydet",
    182: "Çöpe at",
    183: "Hesap ekle",
    184: "Hepsini göster",
    185: "Lütfen isim girin",
    186: "Lütfen bir e-posta girin",
    187: "Çevrimdışısınız",
    188: "Lütfen mobil uygulama sunucu URL'sini girin",
    189: "Lütfen e-posta adresini girin",
    190: "Lütfen şifrenizi girin",
    191:
        "Bu e-postada alan adı tespit edilemedi, lütfen sunucunuzun URL'sini manuel olarak belirtin.",
    192: "Bu kullanıcının e-posta hesabı yok",
    193: "Bu hesap hesaplar listenizde zaten var.",
    194: "Lütfen alıcı ekleyin",
    195: "Lütfen eklerin yüklenmesi tamamlanıncaya kadar bekleyin",
    196: "Sunucuya bağlanılamadı",
    197: "Bu alanı doldurmak zorunludur",
    198: "E-posta geçerli değil",
    199: "İsim, \"/\\*?<>|:\" karakterleri içeremez",
    200: "Bu isim zaten var",
    201: "Geçersiz anahtar (token)",
    202: "Geçersiz e-posta/şifre",
    203: "Geçersiz giriş parametresi",
    204: "Veri tabanı hatası",
    205: "Lisans sorunu",
    206: "Demo hesabı",
    207: "CAPTCHA hatası",
    208: "Erişim engellendi",
    209: "Bilinmeyen e-posta",
    210: "Kullanıcıya izin verilmiyor",
    211: "Böyle bir kullanıcı zaten var",
    212: "Sistem yapılandırılmamış",
    213: "Modül bulunamadı",
    214: "Yöntem bulunamadı",
    215: "Lisans limiti",
    216: "Ayarlar kaydedilemiyor",
    217: "Şifre değiştirilemiyor",
    218: "Hesabın eski şifresi doğru değil",
    219: "Kişi oluşturulamıyor",
    220: "Grup oluşturulamıyor",
    221: "Kişi güncellenemiyor",
    222: "Grup güncellenemiyor",
    223: "Kişi verileri başka bir uygulama tarafından değiştirildi",
    224: "Kişi verileri alınamıyor",
    225: "Hesap oluşturulamıyor",
    226: "Böyle bir hesap zaten var",
    227: "Diğer REST hatası",
    228: "REST API devre dışı",
    229: "REST bilinmeyen yöntem",
    230: "REST geçersiz parametre",
    231: "REST geçersiz kimlik bilgileri",
    232: "REST geçersiz anahtar",
    233: "REST anahtar süresi doldu",
    234: "REST hesap bulma başarısız",
    235: "REST kullanıcı bulma başarısız oldu",
    236: "Takvimlere izin verilmiyor",
    237: "Dosyalara izin verilmiyor",
    238: "Kişilere izin verilmiyor",
    239: "Yardım masası kullanıcısı zaten var",
    240: "Yardım masası sistemi kullanıcısı zaten var",
    241: "Yardım masası kullanıcısı oluşturulamıyor",
    242: "Bilinmeyen yardım masası kullanıcısı",
    243: "Etkin olmayan Yardım masası kullanıcısı",
    244: "Ses'e izin verilmiyor",
    245: "Yanlış dosya uzantısı",
    246: "Bulut depolama alanı limitinize ulaştınız. Dosya yüklenemiyor.",
    247: "Böyle bir dosya zaten var",
    248: "Dosya bulunamadı",
    249: "Dosya yüklenemiyor: dosya limiti",
    250: "E-posta sunucusu hatası",
    251: "Bilinmeyen hata",
    252: "EEE, d MMM yyyy, HH:mm",
    253: "EEE, d MMM yyyy, HH:mm",
    254: "d MMM yyyy",
    255: "Dün",
    256:
        "Hesabınız iki faktörlü kimlik doğrulamayla korunuyor. \nLütfen PIN kodu girin.",
    257: "PIN",
    258: "PIN'i doğrula",
    259: "Geçersiz PIN",
    260: "Tamam",
    261: "Çıkmak istediğinize emin misiniz?",
    262: "Çıkış",
    263: "OpenPGP",
    264: "Ortak anahtarlar",
    265: "Özel anahtarlar",
    266: "Tüm ortak anahtarları dışa aktar",
    267: "Anahtarları metinden içe aktar",
    268: "Anahtarları dosyadan içe aktar",
    269: "Anahtar oluştur",
    270: "Oluştur",
    271: "Uzunluk",
    272: "İndir",
    273: "Paylaş",
    274: "Ortak anahtar",
    275: "Özel anahtar",
    276: "Anahtarları içe aktar",
    277: "Seçili anahtarları içe aktar",
    278: "Anahtarları kontrol et",
    279: "Anahtarlar bulunamadı",
    280: "Tüm ortak anahtarlar",
    281: "Tümünü indir",
    282: "Tümünü gönder",
    283: "İndiriliyor: {path}",
    284:
        "{user} kullanıcısı için OpenPGP anahtarını silmek istediğinize emin misiniz?",
    285: "İmzala/Şifrele",
    286: "Open PGP İmzala/Şifrele",
    287: "Open PGP Şifresini Çöz",
    288: "İmzala",
    289: "Şifrele",
    290: "Geçersiz şifre",
    291: "{users} kullanıcısı için özel anahtar bulunamadı.",
    292: "İletinin şifresi başarıyla çözüldü ve doğrulandı.",
    293: "İletinin şifresi başarıyla çözüldü ancak doğrulanmadı.",
    294: "Geçersiz anahtar ya da şifre.",
    295: "İletinin şifresi çözülemiyor.",
    296: "İletinizi şifrelemek için en az bir alıcı belirtmeniz gerekli.",
    297: "Doğrula",
    298: "Sistemde zaten bulunan anahtarlar gri işaretlenmiştir.",
    299: "E-postada bul",
    300: "Tamam",
    301: "İletileri sil",
    302: "Bu iletiyi silmek istediğinize emin misiniz?",
    303: "Metinden içe aktar",
    304: "Dosyadan içe aktar",
    305: "PGP'yi geri al",
    306: "Tekrar gönder",
    307: "Çöp kutusunu boşalt",
    308: "Spam'i boşalt",
    309:
        " {folder} dosyasındaki tüm iletileri silmek istediğinize emin misiniz?",
    310: "Kendini yok eden güvenli bir e-posta gönder",
    311: "24 saat",
    312: "72 saat",
    313: "7 gün",
    314: "İleti yaşam süresi",
    315: "İsim yok",
    316: "Veri imzalanmayacak.",
    317: "Veri özel anahtarınızla imzalanacak.",
    318: "Şifre bazlı",
    319: "Anahtar bazlı",
    320: "Şifre bazlı şifreleme kullanılacak.",
    321: "Anahtar bazlı şifreleme kullanılacak.",
    322:
        "Seçili alıcının RGP ortak anahtarı mevcut. Bu ileti bu anahtar kullanılarak şifrelenebilir.",
    323:
        "Seçili alıcının PGP ortak anahtarı yok. Anahtar bazlı şifrelemeye izin verilmez",
    324: "Dijital imza ekle",
    325: "Alıcı seç",
    326:
        "Merhaba,\n{sender} kullanıcısı size kendini yok eden güvenli bir e-posta gönderdi.\nLink üzerinden okuyabilirsiniz:\n{link}\n{message_password} İleti {now} itibariyle {lifeTime} süre için erişilebilir olacaktır",
    327: "Bu ileti şifre korumalıdır. \nŞifre: {password}",
    328: "Güvenli ileti sizinle paylaşıldı",
    329:
        "Kendini yok eden güvenli iletiler yalnızca düz metni destekler. Tüm biçimlendirme kaldırılacaktır. Ayrıca, ekler şifrelenemez ve iletiden kaldırılır.",
    330:
        "Şifre farklı bir kanal üzerinden gönderilmelidir. \n  Şifreyi bir yerde saklayın. Aksi takdirde şifreyi kurtaramazsınız.",
    331: "Kendini yok etme",
    332: "Şifre panoya kopyalandı",
    333: "Faturalandırma planınızda mobil uygulamalara izin verilmiyor.",
    334: "Giriş ekranına geri dön",
    335: "PGP anahtarı geçerli olmayacak",
    336: "Tekrar içe aktar",
    337: "Anahtarı Sil",
    338: "Anahtar Seç",
    339: "Bu anahtarlar kişilere aktarılacak",
    340: "Bu anahtarlar için kişiler oluşturulacak.",
    341: "Anahtarlarınız",
    342: "Ortak anahtar bağlantısı",
    343: "Taşı: ",
    344: "Move",
    345: "Klasöre taşı",
    346: "Gelişmiş arama",
    347: "Gelişmiş arama",
    348: "Metin",
    349: "İtibaren",
    350: "Kadar",
    351: "Uyarı",
    352:
        "Özel PGP anahtarınızı paylaşacaksınız. Anahtar 3. taraflar ile paylaşılmamalıdır. Devam etmek istiyor musunuz?",
    353: "İçe aktar",
    354: " {name} kişiyi vcf'den içe aktar?",
    355: "İleti başlıkları",
    356: "Decrypt",
    357: "Message was successfully verified.",
    358: "Message wasn't verified.",
    359: "This user is already logged in",
    360: "Unread",
    361: "Read",
    362: "Show details",
    363: "Hide details",
    364: "Notifications",
    365: "Device identifier",
    366: "Token storing status",
    367: "Resend Push Token",
    368: "Successful",
    369: "Failed",
    370: "Contacts imported successfully",
    371: "Forward as attachment",
    372: "No name",
    373: "Device id copied to clipboard",
    374: "Discard not saved changes?",
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
    388: "Are you sure you want to delete file {name}",
    389: "Can't connect to the server",
    390: "Yerel önbelleği ve kayıtlı anahtarları Temizle",
  };
  String get(int id) => _map[id];
}
