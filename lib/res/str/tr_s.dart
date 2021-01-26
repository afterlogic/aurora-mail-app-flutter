import "s.dart";

class TrS extends S {
  final _map = <int, String>{
    S.app_title: "E-posta Okuyucu",
    S.login_input_host: "Sunucu",
    S.login_input_email: "E-posta",
    S.login_input_password: "Şifre",
    S.login_to_continue: "Devam etmek için giriş yapın",
    S.folders_empty: "Klasör yok",
    S.folders_inbox: "Gelen Kutusu",
    S.folders_starred: "Yıldızlı",
    S.folders_sent: "Gönderilen",
    S.folders_drafts: "Taslaklar",
    S.folders_spam: "Spam",
    S.folders_trash: "Çöp Kutusu",
    S.messages_reply: "Yanıtla",
    S.messages_reply_all: "Tümünü yanıtla",
    S.messages_forward: "Yönlendir",
    S.messages_empty: "İleti yok",
    S.messages_filter_unread: "Okunmamış iletiler:",
    S.messages_delete_title: "İletiyi sil",
    S.messages_delete_desc_with_subject:
        "{subject} silmek istediğinize emin misiniz?",
    S.messages_delete_desc: "Bu iletiyi silmek istediğinden emin misin?",
    S.messages_list_app_bar_Mail: "E-posta",
    S.messages_list_app_bar_contacts: "Kişiler",
    S.messages_list_app_bar_settings: "Ayarlar",
    S.messages_list_app_bar_logout: "Oturumu kapat",
    S.messages_list_app_bar_search: "Ara",
    S.messages_list_app_bar_loading_folders: "Klasörler yükleniyor...",
    S.messages_show_details: "Detayları göster",
    S.messages_images_security_alert:
        "Bu iletideki görseller güvenliğiniz sebebiyle engellendi. ",
    S.messages_show_images: "Görselleri göster.",
    S.messages_always_show_images: "Görselleri her zaman göster.",
    S.messages_view_tab_attachments: "Ekler",
    S.messages_view_tab_message_body: "İleti metni",
    S.messages_to: "Alıcı",
    S.messages_from: "Gönderen",
    S.messages_cc: "CC",
    S.messages_bcc: "BCC",
    S.messages_subject: "Konu",
    S.messages_no_subject: "Konu yok",
    S.messages_to_me: "Bana",
    S.messages_no_receivers: "Alıcı yok",
    S.messages_unknown_sender: "Gönderen yok",
    S.messages_unknown_recipient: "Alıcı yok",
    S.messages_sending: "İleti gönderiliyor...",
    S.messages_saved_in_drafts: "İleti taslaklara kaydedildi",
    S.messages_attachments_empty: "Ek yok",
    S.messages_attachment_delete: "Eki sil",
    S.messages_attachment_download: "Eki indir",
    S.messages_attachment_downloading: "{fileName} indiriliyor ...",
    S.messages_attachment_download_failed: "İndirme işlemi başarısız",
    S.messages_attachment_download_cancel: "İndirmeyi iptal et",
    S.messages_attachment_download_success: "Dosya şuraya indirildi: {path}",
    S.messages_attachment_upload: "Dosya yükle",
    S.messages_attachment_uploading: "{fileName} yükleniyor ...",
    S.messages_attachment_upload_failed: "Yükleme işlemi başarısız",
    S.messages_attachment_upload_cancel: "Yüklemeyi iptal et",
    S.messages_attachment_upload_success: "Dosya şuraya yüklendi: {path}",
    S.compose_body_placeholder: "İleti metni...",
    S.compose_forward_body_original_message: "---- Orijinal İleti ----",
    S.compose_forward_from: "Gönderen: {emails}",
    S.compose_forward_to: "Alıcı: {emails}",
    S.compose_forward_cc: "CC: {emails}",
    S.compose_forward_bcc: "BCC: {emails}",
    S.compose_forward_sent: "Gönderildi: {date}",
    S.compose_forward_subject: "Konu: {subject}",
    S.compose_reply_body_title: "{time},tarihinde {from} yazdı:",
    S.compose_discard_save_dialog_title: "Değişiklikleri iptal et",
    S.compose_discard_save_dialog_description:
        "Değişiklikleri taslak olarak kaydetmek ister misiniz?",
    S.contacts: "Kişiler",
    S.contacts_list_app_bar_view_group: "Grubu görüntüle",
    S.contacts_list_app_bar_all_contacts: "Tüm kişiler",
    S.contacts_list_its_me_flag: "Sizin hesabınız",
    S.contacts_empty: "Kişi yok",
    S.contacts_groups_empty: "Grup yok",
    S.contacts_email_empty: "E-posta adresi yok",
    S.contacts_drawer_section_storages: "Depolama",
    S.contacts_drawer_storage_all: "Tümü",
    S.contacts_drawer_storage_personal: "Kişisel",
    S.contacts_drawer_storage_team: "Ekip",
    S.contacts_drawer_storage_shared: "Herkesle paylaşıldı",
    S.contacts_drawer_section_groups: "Gruplar",
    S.contacts_view_app_bar_share: "Paylaş",
    S.contacts_view_app_bar_unshare: "Paylaşma",
    S.contacts_view_app_bar_attach: "Gönder",
    S.contacts_view_app_bar_send_message: "Bu kişiye e-posta gönder",
    S.contacts_view_app_bar_search_messages: "İletilerde ara",
    S.contacts_view_app_bar_edit_contact: "Düzenle",
    S.contacts_view_app_bar_delete_contact: "Sil",
    S.contacts_shared_message:
        "{contact} kişisi birazdan {storage} alanında görünür olacak. ",
    S.contacts_group_view_app_bar_send_message:
        "Gruptaki kişilere e-posta gönder",
    S.contacts_group_view_app_bar_delete: "Bu grubu sil",
    S.contacts_group_view_app_bar_edit: "Grubu güncelle",
    S.contacts_view_show_additional_fields: "Ek alanları göster",
    S.contacts_view_hide_additional_fields: "Ek alanları gizle",
    S.contacts_view_section_home: "Ana Sayfa",
    S.contacts_view_section_personal: "Kişisel",
    S.contacts_view_section_business: "Şirket",
    S.contacts_view_section_other_info: "Diğer",
    S.contacts_view_section_group_name: "Grup Adı",
    S.contacts_view_section_groups: "Gruplar",
    S.contacts_view_display_name: "Görünen ad",
    S.contacts_view_email: "E-posta",
    S.contacts_view_personal_email: "Kişisel e-posta",
    S.contacts_view_business_email: "Şirket e-postası",
    S.contacts_view_other_email: "Diğer e-posta",
    S.contacts_view_phone: "Telefon",
    S.contacts_view_personal_phone: "Kişisel Telefon",
    S.contacts_view_business_phone: "İş Telefonu",
    S.contacts_view_mobile: "Cep Telefonu",
    S.contacts_view_fax: "Faks",
    S.contacts_view_address: "Adres",
    S.contacts_view_personal_address: "Kişisel Adres",
    S.contacts_view_business_address: "İş Adresi",
    S.contacts_view_skype: "Skype",
    S.contacts_view_facebook: "Facebook",
    S.contacts_view_name: "İsim",
    S.contacts_view_first_name: "İsim",
    S.contacts_view_last_name: "Soyisim",
    S.contacts_view_nickname: "Takma İsim",
    S.contacts_view_street_address: "Sokak",
    S.contacts_view_city: "Şehir",
    S.contacts_view_province: "Eyalet",
    S.contacts_view_country: "Ülke",
    S.contacts_view_zip: "Posta Kodu",
    S.contacts_view_web_page: "Web Sayfası",
    S.contacts_view_company: "Şirket",
    S.contacts_view_department: "Departman",
    S.contacts_view_job_title: "Ünvan",
    S.contacts_view_office: "Ofis",
    S.contacts_view_birthday: "Doğum günü",
    S.contacts_view_notes: "Notlar",
    S.contacts_edit: "Kişiyi düzenle",
    S.contacts_edit_cancel: "Kişiyi düzenlemekten vazgeç",
    S.contacts_edit_save: "Değişiklikleri kaydet",
    S.contacts_add: "Kişi ekle",
    S.contacts_group_add: "Grup ekle",
    S.contacts_group_edit: "Grubu düzenle",
    S.contacts_group_edit_is_organization: "Bu grup bir şirket",
    S.contacts_group_edit_cancel: "Grubu düzenlemekten vazgeç",
    S.contacts_delete_title: "Kişiyi sil",
    S.contacts_delete_desc_with_name:
        "{contact} silmek istediğinize emin misiniz?",
    S.contacts_group_delete_title: "Grubu sil",
    S.contacts_group_delete_desc_with_name:
        " {group} silmek istediğinize emin misiniz? Gruptaki kişiler silinmeyecektir.",
    S.settings: "Ayarlar",
    S.settings_common: "Genel",
    S.settings_24_time_format: "24 saat formatı",
    S.settings_language: "Dil",
    S.settings_language_system: "Sistem dili",
    S.settings_dark_theme: "Tema",
    S.settings_dark_theme_system: "Sistem teması",
    S.settings_dark_theme_dark: "Koyu",
    S.settings_dark_theme_light: "Açık",
    S.settings_sync: "Senkronizasyon",
    S.settings_sync_frequency: "Senkronizasyon sıklığı",
    S.settings_sync_frequency_never: "hiçbir zaman",
    S.settings_sync_frequency_minutes5: "5 dakika",
    S.settings_sync_frequency_minutes30: "30 dakika",
    S.settings_sync_frequency_hours1: "1 saat",
    S.settings_sync_frequency_hours2: "2 saat",
    S.settings_sync_frequency_daily: "günlük",
    S.settings_sync_frequency_monthly: "aylık",
    S.settings_sync_period: "Senkronizasyon periyodu",
    S.settings_sync_period_all_time: "her zaman",
    S.settings_sync_period_months1: "1 ay",
    S.settings_sync_period_months3: "3 ay",
    S.settings_sync_period_months6: "6 ay",
    S.settings_sync_period_years1: "1 yıl",
    S.settings_accounts_manage: "Hesapları yönet",
    S.settings_accounts_add: "Yeni hesap ekle",
    S.settings_accounts_relogin: "Hesaba tekrar giriş yap",
    S.settings_accounts_delete: "Hesabı sil",
    S.settings_accounts_delete_description:
        " {account} hesabını silmek istediğinize emin misiniz?",
    S.settings_about: "Hakkında",
    S.settings_about_app_version: " {version} versiyonu",
    S.settings_about_terms_of_service: "Hizmet Şartları",
    S.settings_about_privacy_policy: "Gizlilik Politikası",
    S.btn_login: "Oturum aç",
    S.btn_delete: "Sil",
    S.btn_show_email_in_light_theme: "E-postayı açık temada göster",
    S.btn_cancel: "Iptal",
    S.btn_close: "Kapat",
    S.btn_to_spam: "Spam'e taşı",
    S.btn_save: "Kaydet",
    S.btn_discard: "Çöpe at",
    S.btn_add_account: "Hesap ekle",
    S.btn_show_all: "Hepsini göster",
    S.error_contacts_save_name_empty: "Lütfen isim girin",
    S.error_contacts_email_empty: "Lütfen bir e-posta girin",
    S.error_connection_offline: "Çevrimdışısınız",
    S.error_login_input_hostname: "Lütfen mobil uygulama sunucu URL'sini girin",
    S.error_login_input_email: "Lütfen e-posta adresini girin",
    S.error_login_input_password: "Lütfen şifrenizi girin",
    S.error_login_auto_discover:
        "Bu e-postada alan adı tespit edilemedi, lütfen sunucunuzun URL'sini manuel olarak belirtin.",
    S.error_login_no_accounts: "Bu kullanıcının e-posta hesabı yok",
    S.error_login_account_exists: "Bu hesap hesaplar listenizde zaten var.",
    S.error_compose_no_receivers: "Lütfen alıcı ekleyin",
    S.error_compose_wait_attachments:
        "Lütfen eklerin yüklenmesi tamamlanıncaya kadar bekleyin",
    S.error_connection: "Sunucuya bağlanılamadı",
    S.error_input_validation_empty: "Bu alanı doldurmak zorunludur",
    S.error_input_validation_email: "E-posta geçerli değil",
    S.error_input_validation_name_illegal_symbol:
        "İsim, \"/\\*?<>|:\" karakterleri içeremez",
    S.error_input_validation_unique_name: "Bu isim zaten var",
    S.error_server_invalid_token: "Geçersiz anahtar (token)",
    S.error_server_auth_error: "Geçersiz e-posta/şifre",
    S.error_server_invalid_input_parameter: "Geçersiz giriş parametresi",
    S.error_server_data_base_error: "Veri tabanı hatası",
    S.error_server_license_problem: "Lisans sorunu",
    S.error_server_demo_account: "Demo hesabı",
    S.error_server_captcha_error: "CAPTCHA hatası",
    S.error_server_access_denied: "Erişim engellendi",
    S.error_server_unknown_email: "Bilinmeyen e-posta",
    S.error_server_user_not_allowed: "Kullanıcıya izin verilmiyor",
    S.error_server_user_already_exists: "Böyle bir kullanıcı zaten var",
    S.error_server_system_not_configured: "Sistem yapılandırılmamış",
    S.error_server_module_not_found: "Modül bulunamadı",
    S.error_server_method_not_found: "Yöntem bulunamadı",
    S.error_server_license_limit: "Lisans limiti",
    S.error_server_can_not_save_settings: "Ayarlar kaydedilemiyor",
    S.error_server_can_not_change_password: "Şifre değiştirilemiyor",
    S.error_server_account_old_password_not_correct:
        "Hesabın eski şifresi doğru değil",
    S.error_server_can_not_create_contact: "Kişi oluşturulamıyor",
    S.error_server_can_not_create_group: "Grup oluşturulamıyor",
    S.error_server_can_not_update_contact: "Kişi güncellenemiyor",
    S.error_server_can_not_update_group: "Grup güncellenemiyor",
    S.error_server_contact_data_has_been_modified_by_another_application:
        "Kişi verileri başka bir uygulama tarafından değiştirildi",
    S.error_server_can_not_get_contact: "Kişi verileri alınamıyor",
    S.error_server_can_not_create_account: "Hesap oluşturulamıyor",
    S.error_server_account_exists: "Böyle bir hesap zaten var",
    S.error_server_rest_other_error: "Diğer REST hatası",
    S.error_server_rest_api_disabled: "REST API devre dışı",
    S.error_server_rest_unknown_method: "REST bilinmeyen yöntem",
    S.error_server_rest_invalid_parameters: "REST geçersiz parametre",
    S.error_server_rest_invalid_credentials: "REST geçersiz kimlik bilgileri",
    S.error_server_rest_invalid_token: "REST geçersiz anahtar",
    S.error_server_rest_token_expired: "REST anahtar süresi doldu",
    S.error_server_rest_account_find_failed: "REST hesap bulma başarısız",
    S.error_server_rest_tenant_find_failed:
        "REST kullanıcı bulma başarısız oldu",
    S.error_server_calendars_not_allowed: "Takvimlere izin verilmiyor",
    S.error_server_files_not_allowed: "Dosyalara izin verilmiyor",
    S.error_server_contacts_not_allowed: "Kişilere izin verilmiyor",
    S.error_server_helpdesk_user_already_exists:
        "Yardım masası kullanıcısı zaten var",
    S.error_server_helpdesk_system_user_exists:
        "Yardım masası sistemi kullanıcısı zaten var",
    S.error_server_can_not_create_helpdesk_user:
        "Yardım masası kullanıcısı oluşturulamıyor",
    S.error_server_helpdesk_unknown_user:
        "Bilinmeyen yardım masası kullanıcısı",
    S.error_server_helpdesk_unactivated_user:
        "Etkin olmayan Yardım masası kullanıcısı",
    S.error_server_voice_not_allowed: "Ses'e izin verilmiyor",
    S.error_server_incorrect_file_extension: "Yanlış dosya uzantısı",
    S.error_server_can_not_upload_file_quota:
        "Bulut depolama alanı limitinize ulaştınız. Dosya yüklenemiyor.",
    S.error_server_file_already_exists: "Böyle bir dosya zaten var",
    S.error_server_file_not_found: "Dosya bulunamadı",
    S.error_server_can_not_upload_file_limit:
        "Dosya yüklenemiyor: dosya limiti",
    S.error_server_mail_server_error: "E-posta sunucusu hatası",
    S.error_unknown: "Bilinmeyen hata",
    S.format_compose_forward_date: "EEE, d MMM yyyy, HH:mm",
    S.format_compose_reply_date: "EEE, d MMM yyyy, HH:mm",
    S.format_contacts_birth_date: "d MMM yyyy",
    S.label_message_yesterday: "Dün",
    S.hint_2fa:
        "Hesabınız iki faktörlü kimlik doğrulamayla korunuyor. \nLütfen PIN kodu girin.",
    S.input_2fa_pin: "PIN",
    S.btn_verify_pin: "PIN'i doğrula",
    S.error_invalid_pin: "Geçersiz PIN",
    S.btn_done: "Tamam",
    S.hint_confirm_exit: "Çıkmak istediğinize emin misiniz?",
    S.btn_exit: "Çıkış",
    S.label_pgp_settings: "OpenPGP",
    S.label_pgp_public_keys: "Ortak anahtarlar",
    S.label_pgp_private_keys: "Özel anahtarlar",
    S.btn_pgp_export_all_public_keys: "Tüm ortak anahtarları dışa aktar",
    S.btn_pgp_import_keys_from_text: "Anahtarları metinden içe aktar",
    S.btn_pgp_import_keys_from_file: "Anahtarları dosyadan içe aktar",
    S.btn_pgp_generate_keys: "Anahtar oluştur",
    S.btn_pgp_generate: "Oluştur",
    S.label_length: "Uzunluk",
    S.btn_download: "İndir",
    S.btn_share: "Paylaş",
    S.label_pgp_public_key: "Ortak anahtar",
    S.label_pgp_private_key: "Özel anahtar",
    S.label_pgp_import_key: "Anahtarları içe aktar",
    S.btn_pgp_import_selected_key: "Seçili anahtarları içe aktar",
    S.btn_pgp_check_keys: "Anahtarları kontrol et",
    S.error_pgp_keys_not_found: "Anahtarlar bulunamadı",
    S.label_pgp_all_public_key: "Tüm ortak anahtarlar",
    S.btn_pgp_download_all: "Tümünü indir",
    S.btn_php_send_all: "Tümünü gönder",
    S.label_pgp_downloading_to: "İndiriliyor: {path}",
    S.hint_pgp_delete_user_key_confirm:
        "{user} kullanıcısı için OpenPGP anahtarını silmek istediğinize emin misiniz?",
    S.btn_pgp_sign_or_encrypt: "İmzala/Şifrele",
    S.label_pgp_sign_or_encrypt: "Open PGP İmzala/Şifrele",
    S.label_pgp_decrypt: "Open PGP Şifresini Çöz",
    S.label_pgp_sign: "İmzala",
    S.btn_pgp_encrypt: "Şifrele",
    S.error_pgp_invalid_password: "Geçersiz şifre",
    S.error_pgp_not_found_keys_for:
        "{users} kullanıcısı için özel anahtar bulunamadı.",
    S.label_pgp_decrypted_and_verified:
        "İletinin şifresi başarıyla çözüldü ve doğrulandı.",
    S.label_pgp_decrypted_but_not_verified:
        "İletinin şifresi başarıyla çözüldü ancak doğrulanmadı.",
    S.error_pgp_invalid_key_or_password: "Geçersiz anahtar ya da şifre.",
    S.error_pgp_can_not_decrypt: "İletinin şifresi çözülemiyor.",
    S.error_pgp_need_contact_for_encrypt:
        "İletinizi şifrelemek için en az bir alıcı belirtmeniz gerekli.",
    S.button_pgp_verify_sign: "Doğrula",
    S.hint_pgp_already_have_keys:
        "Sistemde zaten bulunan anahtarlar gri işaretlenmiştir.",
    S.btn_contact_find_in_email: "E-postada bul",
    S.btn_ok: "Tamam",
    S.messages_delete_title_with_count: "İletileri sil",
    S.messages_delete_desc_with_count:
        "Bu iletiyi silmek istediğinize emin misiniz?",
    S.btn_pgp_import_from_text: "Metinden içe aktar",
    S.btn_pgp_import_from_file: "Dosyadan içe aktar",
    S.btn_pgp_undo_pgp: "PGP'yi geri al",
    S.btn_message_resend: "Tekrar gönder",
    S.btn_message_empty_trash_folder: "Çöp kutusunu boşalt",
    S.btn_message_empty_spam_folder: "Spam'i boşalt",
    S.hint_message_empty_folder:
        " {folder} dosyasındaki tüm iletileri silmek istediğinize emin misiniz?",
    S.label_self_destructing: "Kendini yok eden güvenli bir e-posta gönder",
    S.self_destructing_life_time_day: "24 saat",
    S.self_destructing_life_time_days_3: "72 saat",
    S.self_destructing_life_time_days_7: "7 gün",
    S.message_lifetime: "İleti yaşam süresi",
    S.label_pgp_key_with_not_name: "İsim yok",
    S.label_self_destructing_not_sign_data: "Veri imzalanmayacak.",
    S.label_self_destructing_sign_data: "Veri özel anahtarınızla imzalanacak.",
    S.input_self_destructing_password_based_encryption: "Şifre bazlı",
    S.input_self_destructing_key_based_encryption: "Anahtar bazlı",
    S.label_self_destructing_password_based_encryption_used:
        "Şifre bazlı şifreleme kullanılacak.",
    S.label_self_destructing_key_based_encryption_used:
        "Anahtar bazlı şifreleme kullanılacak.",
    S.hint_self_destructing_encrypt_with_key:
        "Seçili alıcının RGP ortak anahtarı mevcut. Bu ileti bu anahtar kullanılarak şifrelenebilir.",
    S.hint_self_destructing_encrypt_with_not_key:
        "Seçili alıcının PGP ortak anahtarı yok. Anahtar bazlı şifrelemeye izin verilmez",
    S.input_self_destructing_add_digital_signature: "Dijital imza ekle",
    S.error_pgp_select_recipient: "Alıcı seç",
    S.template_self_destructing_message:
        "Merhaba,\n{sender} kullanıcısı size kendini yok eden güvenli bir e-posta gönderdi.\nLink üzerinden okuyabilirsiniz:\n{link}\n{message_password} İleti {now} itibariyle {lifeTime} süre için erişilebilir olacaktır",
    S.template_self_destructing_message_password:
        "Bu ileti şifre korumalıdır. \nŞifre: {password}",
    S.template_self_destructing_message_title:
        "Güvenli ileti sizinle paylaşıldı",
    S.hint_self_destructing_supports_plain_text_only:
        "Kendini yok eden güvenli iletiler yalnızca düz metni destekler. Tüm biçimlendirme kaldırılacaktır. Ayrıca, ekler şifrelenemez ve iletiden kaldırılır.",
    S.hint_self_destructing_sent_password_using_different_channel:
        "Şifre farklı bir kanal üzerinden gönderilmelidir. \n  Şifreyi bir yerde saklayın. Aksi takdirde şifreyi kurtaramazsınız.",
    S.btn_self_destructing: "Kendini yok etme",
    S.hint_self_destructing_password_coppied_to_clipboard:
        "Şifre panoya kopyalandı",
    S.hint_login_upgrade_your_plan:
        "Faturalandırma planınızda mobil uygulamalara izin verilmiyor.",
    S.btn_login_back_to_login: "Giriş ekranına geri dön",
    S.error_contact_pgp_key_will_not_be_valid: "PGP anahtarı geçerli olmayacak",
    S.btn_contact_key_re_import: "Tekrar içe aktar",
    S.btn_contact_delete_key: "Anahtarı Sil",
    S.label_contact_select_key: "Anahtar Seç",
    S.hint_pgp_keys_will_be_import_to_contacts:
        "Bu anahtarlar kişilere aktarılacak",
    S.hint_pgp_keys_contacts_will_be_created:
        "Bu anahtarlar için kişiler oluşturulacak.",
    S.hint_pgp_your_keys: "Anahtarlarınız",
    S.label_pgp_contact_public_keys: "Ortak anahtar bağlantısı",
    S.label_message_move_to: "Taşı: ",
    S.btn_message_move: "Move",
    S.label_message_move_to_folder: "Klasöre taşı",
    S.btn_message_advanced_search: "Gelişmiş arama",
    S.label_message_advanced_search: "Gelişmiş arama",
    S.input_message_search_text: "Metin",
    S.input_message_search_since: "İtibaren",
    S.input_message_search_till: "Kadar",
    S.label_pgp_share_warning: "Uyarı",
    S.hint_pgp_share_warning:
        "Özel PGP anahtarınızı paylaşacaksınız. Anahtar 3. taraflar ile paylaşılmamalıdır. Devam etmek istiyor musunuz?",
    S.btn_vcf_import: "İçe aktar",
    S.hint_vcf_import: " {name} kişiyi vcf'den içe aktar?",
    S.label_message_headers: "İleti başlıkları",
    S.btn_pgp_decrypt: "Decrypt",
    S.label_pgp_verified: "Message was successfully verified.",
    S.label_pgp_not_verified: "Message wasn't verified.",
    S.error_user_already_logged: "This user is already logged in",
    S.btn_unread: "Unread",
    S.btn_read: "Read",
    S.btn_show_details: "Show details",
    S.btn_hide_details: "Hide details",
    S.label_notifications_settings: "Notifications",
    S.label_device_identifier: "Device identifier",
    S.label_token_storing_status: "Token storing status",
    S.btn_resend_push_token: "Resend Push Token",
    S.label_token_successful: "Successful",
    S.label_token_failed: "Failed",
    S.label_contacts_were_imported_successfully:
        "Contacts imported successfully",
    S.label_forward_as_attachment: "Forward as attachment",
    S.label_contact_with_not_name: "No name",
    S.label_device_id_copied_to_clip_board: "Device id copied to clipboard",
    S.label_discard_not_saved_changes: "Discard not saved changes?",
    S.label_pgp_encrypt: "Encrypt",
    S.hint_auto_encrypt_messages:
        "If you want messages to this contact to be automatically encrypted and/or signed, check the boxes below. Please note that these messages will be converted to plain text. Attachments will not be encrypted.",
    S.btn_log_delete_all: "Delete all",
    S.label_record_log_in_background: "Record log in background",
    S.label_show_debug_view: "Show debug view",
    S.hint_log_delete_all: "Are you sure you want to delete all logs",
    S.label_enable_uploaded_message_counter: "Counter of uploaded message",
    S.error_no_pgp_key: "No PGP public key was found",
    S.label_contact_pgp_settings: "PGP Settings",
    S.hint_pgp_message_automatically_encrypt:
        "The message will be automatically encrypted and/or signed for contacts with OpenPgp keys.\n OpenPGP supports plain text only. All the formatting will be removed before encryption.",
    S.btn_not_spam: "Not spam",
    S.error_password_is_empty: "password is empty",
    S.label_encryption_password_for_pgp_key: "Required password for PGP key",
    S.hint_log_delete_record: "Are you sure you want to delete file {name}",
    S.error_timeout: "Can't connect to the server",
  };
  String get(int id) => _map[id];
}
