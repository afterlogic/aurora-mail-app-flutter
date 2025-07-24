// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
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
  String get localeName => 'tr';

  static String m1(organizer) => "Organizatör: ${organizer}";

  static String m3(emails) => "BCC: ${emails}";

  static String m4(emails) => "CC: ${emails}";

  static String m5(emails) => "Gönderen: ${emails}";

  static String m6(date) => "Gönderildi: ${date}";

  static String m7(subject) => "Konu: ${subject}";

  static String m8(emails) => "Alıcı: ${emails}";

  static String m9(time, from) => "${time},tarihinde ${from} yazdı:";

  static String m10(contact) => "${contact} silmek istediğinize emin misiniz?";

  static String m11(group) =>
      " ${group} silmek istediğinize emin misiniz? Gruptaki kişiler silinmeyecektir.";

  static String m12(contact, storage) =>
      "${contact} kişisi birazdan ${storage} alanında görünür olacak. ";

  static String m13(users) =>
      "${users} kullanıcısı için özel anahtar bulunamadı.";

  static String m14(name) =>
      "${name} dosyasını silmek istediğinize emin misiniz?";

  static String m15(folder) =>
      "${folder} dosyasındaki tüm iletileri silmek istediğinize emin misiniz?";

  static String m16(user) =>
      "${user} kullanıcısı için OpenPGP anahtarını silmek istediğinize emin misiniz?";

  static String m17(path) => "İndiriliyor: ${path}";

  static String m18(path) => "Dosya şuraya indirildi: ${path}";

  static String m19(fileName) => "${fileName} indiriliyor ...";

  static String m20(path) => "Dosya şuraya yüklendi: ${path}";

  static String m21(fileName) => "${fileName} yükleniyor ...";

  static String m22(subject) => "${subject} silmek istediğinize emin misiniz?";

  static String m23(version) => " ${version} versiyonu";

  static String m24(account) =>
      " ${account} hesabını silmek istediğinize emin misiniz?";

  static String m25(sender, link, message_password, lifeTime, now) =>
      "Merhaba,\n${sender} kullanıcısı size kendini yok eden güvenli bir e-posta gönderdi.\nLink üzerinden okuyabilirsiniz:\n${link}\n${message_password} İleti ${now} itibariyle ${lifeTime} süre için erişilebilir olacaktır";

  static String m26(password) =>
      "Bu ileti şifre korumalıdır. \nŞifre: ${password}";

  static String m27(daysCount) =>
      "Bu cihazda ${daysCount} gün boyunca tekrar sorma";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "already_have_key": MessageLookupByLibrary.simpleMessage(
            "Zaten bir genel veya özel anahtarınız var"),
        "app_title": MessageLookupByLibrary.simpleMessage("E-posta Okuyucu"),
        "btn_add_account": MessageLookupByLibrary.simpleMessage("Hesap ekle"),
        "btn_back": MessageLookupByLibrary.simpleMessage("Geri"),
        "btn_cancel": MessageLookupByLibrary.simpleMessage("Iptal"),
        "btn_close": MessageLookupByLibrary.simpleMessage("Kapat"),
        "btn_contact_delete_key":
            MessageLookupByLibrary.simpleMessage("Anahtarı Sil"),
        "btn_contact_find_in_email":
            MessageLookupByLibrary.simpleMessage("E-postada bul"),
        "btn_contact_key_re_import":
            MessageLookupByLibrary.simpleMessage("Tekrar içe aktar"),
        "btn_delete": MessageLookupByLibrary.simpleMessage("Sil"),
        "btn_discard": MessageLookupByLibrary.simpleMessage("Çöpe at"),
        "btn_done": MessageLookupByLibrary.simpleMessage("Tamam"),
        "btn_download": MessageLookupByLibrary.simpleMessage("İndir"),
        "btn_exit": MessageLookupByLibrary.simpleMessage("Çıkış"),
        "btn_hide_details":
            MessageLookupByLibrary.simpleMessage("Ayrıntıları gizle"),
        "btn_log_delete_all":
            MessageLookupByLibrary.simpleMessage("Tümünü sil"),
        "btn_login": MessageLookupByLibrary.simpleMessage("Oturum aç"),
        "btn_login_back_to_login":
            MessageLookupByLibrary.simpleMessage("Giriş ekranına geri dön"),
        "btn_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Gelişmiş arama"),
        "btn_message_empty_spam_folder":
            MessageLookupByLibrary.simpleMessage("Spam\'i boşalt"),
        "btn_message_empty_trash_folder":
            MessageLookupByLibrary.simpleMessage("Çöp kutusunu boşalt"),
        "btn_message_move": MessageLookupByLibrary.simpleMessage("Taşı"),
        "btn_message_resend":
            MessageLookupByLibrary.simpleMessage("Tekrar gönder"),
        "btn_not_spam": MessageLookupByLibrary.simpleMessage("Spam değil"),
        "btn_ok": MessageLookupByLibrary.simpleMessage("Tamam"),
        "btn_pgp_check_keys":
            MessageLookupByLibrary.simpleMessage("Anahtarları kontrol et"),
        "btn_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Şifresini Çöz"),
        "btn_pgp_download_all":
            MessageLookupByLibrary.simpleMessage("Tümünü indir"),
        "btn_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Şifrele"),
        "btn_pgp_export_all_public_keys": MessageLookupByLibrary.simpleMessage(
            "Tüm ortak anahtarları dışa aktar"),
        "btn_pgp_generate": MessageLookupByLibrary.simpleMessage("Oluştur"),
        "btn_pgp_generate_keys":
            MessageLookupByLibrary.simpleMessage("Anahtar oluştur"),
        "btn_pgp_import_from_file":
            MessageLookupByLibrary.simpleMessage("Dosyadan içe aktar"),
        "btn_pgp_import_from_text":
            MessageLookupByLibrary.simpleMessage("Metinden içe aktar"),
        "btn_pgp_import_keys_from_file": MessageLookupByLibrary.simpleMessage(
            "Anahtarları dosyadan içe aktar"),
        "btn_pgp_import_keys_from_text": MessageLookupByLibrary.simpleMessage(
            "Anahtarları metinden içe aktar"),
        "btn_pgp_import_selected_key": MessageLookupByLibrary.simpleMessage(
            "Seçili anahtarları içe aktar"),
        "btn_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("İmzala/Şifrele"),
        "btn_pgp_undo_pgp":
            MessageLookupByLibrary.simpleMessage("PGP\'yi geri al"),
        "btn_php_send_all":
            MessageLookupByLibrary.simpleMessage("Tümünü gönder"),
        "btn_read": MessageLookupByLibrary.simpleMessage("Okunmuş"),
        "btn_resend_push_token":
            MessageLookupByLibrary.simpleMessage("Push Token\'ı Tekrar Gönder"),
        "btn_save": MessageLookupByLibrary.simpleMessage("Kaydet"),
        "btn_self_destructing":
            MessageLookupByLibrary.simpleMessage("Kendini yok etme"),
        "btn_share": MessageLookupByLibrary.simpleMessage("Paylaş"),
        "btn_show_all": MessageLookupByLibrary.simpleMessage("Hepsini göster"),
        "btn_show_details":
            MessageLookupByLibrary.simpleMessage("Ayrıntıları göster"),
        "btn_show_email_in_light_theme": MessageLookupByLibrary.simpleMessage(
            "E-postayı açık temada göster"),
        "btn_to_spam": MessageLookupByLibrary.simpleMessage("Spam\'e taşı"),
        "btn_unread": MessageLookupByLibrary.simpleMessage("Okunmamış"),
        "btn_vcf_import": MessageLookupByLibrary.simpleMessage("İçe aktar"),
        "btn_verify_pin":
            MessageLookupByLibrary.simpleMessage("PIN\'i doğrula"),
        "button_pgp_verify_sign":
            MessageLookupByLibrary.simpleMessage("Doğrula"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "calendar_add_attendee_title":
            MessageLookupByLibrary.simpleMessage("Katılımcı ekle"),
        "calendar_always": MessageLookupByLibrary.simpleMessage("Her zaman"),
        "calendar_before": MessageLookupByLibrary.simpleMessage("önce"),
        "calendar_color_label": MessageLookupByLibrary.simpleMessage("Renk"),
        "calendar_create_event":
            MessageLookupByLibrary.simpleMessage("Etkinlik oluştur"),
        "calendar_create_event_title":
            MessageLookupByLibrary.simpleMessage("Etkinlik Oluştur"),
        "calendar_create_task":
            MessageLookupByLibrary.simpleMessage("Görev oluştur"),
        "calendar_create_task_title":
            MessageLookupByLibrary.simpleMessage("Görev Oluştur"),
        "calendar_create_title":
            MessageLookupByLibrary.simpleMessage("Takvim oluştur"),
        "calendar_delete_calendar":
            MessageLookupByLibrary.simpleMessage("Takvimi sil"),
        "calendar_delete_event_title":
            MessageLookupByLibrary.simpleMessage("Etkinliği sil"),
        "calendar_delete_task_title":
            MessageLookupByLibrary.simpleMessage("Görevi sil"),
        "calendar_description_label":
            MessageLookupByLibrary.simpleMessage("Açıklama"),
        "calendar_drawer_get_link":
            MessageLookupByLibrary.simpleMessage("Bağlantı al"),
        "calendar_drawer_my_calendars":
            MessageLookupByLibrary.simpleMessage("Takvimlerim"),
        "calendar_edit_event_title":
            MessageLookupByLibrary.simpleMessage("Etkinliği Düzenle"),
        "calendar_edit_task_title":
            MessageLookupByLibrary.simpleMessage("Görevi Düzenle"),
        "calendar_edit_title":
            MessageLookupByLibrary.simpleMessage("Takvimi düzenle"),
        "calendar_event_title":
            MessageLookupByLibrary.simpleMessage("Etkinlik"),
        "calendar_filter_all": MessageLookupByLibrary.simpleMessage("Tümü"),
        "calendar_filter_completed":
            MessageLookupByLibrary.simpleMessage("Tamamlanmış"),
        "calendar_filter_data": MessageLookupByLibrary.simpleMessage("Veri"),
        "calendar_filter_has_date":
            MessageLookupByLibrary.simpleMessage("Tarihi var"),
        "calendar_filter_task_status":
            MessageLookupByLibrary.simpleMessage("Görev durumu"),
        "calendar_filter_title": MessageLookupByLibrary.simpleMessage("Filtre"),
        "calendar_filter_uncompleted":
            MessageLookupByLibrary.simpleMessage("Tamamlanmamış"),
        "calendar_filter_without_date":
            MessageLookupByLibrary.simpleMessage("Tarihsiz"),
        "calendar_get_public_link": MessageLookupByLibrary.simpleMessage(
            "Takvim için genel bağlantı al"),
        "calendar_ical_url_label":
            MessageLookupByLibrary.simpleMessage("iCal URL"),
        "calendar_import_ics_file":
            MessageLookupByLibrary.simpleMessage("ICS dosyası içe aktar"),
        "calendar_input_all_day":
            MessageLookupByLibrary.simpleMessage("Tüm gün"),
        "calendar_input_attendees":
            MessageLookupByLibrary.simpleMessage("Katılımcılar"),
        "calendar_input_description":
            MessageLookupByLibrary.simpleMessage("Açıklama"),
        "calendar_input_location":
            MessageLookupByLibrary.simpleMessage("Konum"),
        "calendar_input_reminders":
            MessageLookupByLibrary.simpleMessage("Hatırlatıcılar"),
        "calendar_input_title": MessageLookupByLibrary.simpleMessage("Başlık"),
        "calendar_name_label":
            MessageLookupByLibrary.simpleMessage("Takvim adı"),
        "calendar_organizer_label": m1,
        "calendar_please_select_calendar":
            MessageLookupByLibrary.simpleMessage("Lütfen takvim seçin"),
        "calendar_read_permission":
            MessageLookupByLibrary.simpleMessage("okuma"),
        "calendar_select_calendar":
            MessageLookupByLibrary.simpleMessage("Takvim seçin"),
        "calendar_selected_calendar_not_found":
            MessageLookupByLibrary.simpleMessage("Seçilen takvim bulunamadı"),
        "calendar_shared_with_all":
            MessageLookupByLibrary.simpleMessage("Herkesle paylaşılan"),
        "calendar_shared_with_me":
            MessageLookupByLibrary.simpleMessage("Benimle paylaşılan"),
        "calendar_sharing_all": MessageLookupByLibrary.simpleMessage("Tümü"),
        "calendar_sharing_title":
            MessageLookupByLibrary.simpleMessage("Takvimi paylaş"),
        "calendar_subscribe_ical_feed":
            MessageLookupByLibrary.simpleMessage("iCal akışına abone ol"),
        "calendar_tab_day": MessageLookupByLibrary.simpleMessage("Gün"),
        "calendar_tab_month": MessageLookupByLibrary.simpleMessage("Ay"),
        "calendar_tab_tasks": MessageLookupByLibrary.simpleMessage("Görevler"),
        "calendar_tab_week": MessageLookupByLibrary.simpleMessage("Hafta"),
        "calendar_task_title": MessageLookupByLibrary.simpleMessage("Görev"),
        "calendar_unsubscribe":
            MessageLookupByLibrary.simpleMessage("Aboneliği iptal et"),
        "calendar_unsubscribe_from_calendar":
            MessageLookupByLibrary.simpleMessage("Takvim aboneliğini iptal et"),
        "calendar_until": MessageLookupByLibrary.simpleMessage("kadar"),
        "calendar_validation_enter_text":
            MessageLookupByLibrary.simpleMessage("Lütfen metin girin"),
        "clear_cache_during_logout": MessageLookupByLibrary.simpleMessage(
            "Yerel önbelleği ve kayıtlı anahtarları Temizle"),
        "compose_body_placeholder":
            MessageLookupByLibrary.simpleMessage("İleti metni"),
        "compose_discard_save_dialog_description":
            MessageLookupByLibrary.simpleMessage(
                "Değişiklikleri taslaklara Kaydet?"),
        "compose_discard_save_dialog_title":
            MessageLookupByLibrary.simpleMessage("Değişiklikleri iptal et"),
        "compose_forward_bcc": m3,
        "compose_forward_body_original_message":
            MessageLookupByLibrary.simpleMessage("---- Orijinal İleti ----"),
        "compose_forward_cc": m4,
        "compose_forward_from": m5,
        "compose_forward_sent": m6,
        "compose_forward_subject": m7,
        "compose_forward_to": m8,
        "compose_reply_body_title": m9,
        "contacts": MessageLookupByLibrary.simpleMessage("Kişiler"),
        "contacts_add": MessageLookupByLibrary.simpleMessage("Kişi ekle"),
        "contacts_delete_desc_with_name": m10,
        "contacts_delete_selected": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete selected contacts?"),
        "contacts_delete_title":
            MessageLookupByLibrary.simpleMessage("Kişiyi sil"),
        "contacts_delete_title_plural":
            MessageLookupByLibrary.simpleMessage("Delete contacts"),
        "contacts_drawer_section_groups":
            MessageLookupByLibrary.simpleMessage("Gruplar"),
        "contacts_drawer_section_storages":
            MessageLookupByLibrary.simpleMessage("Depolama"),
        "contacts_drawer_storage_all":
            MessageLookupByLibrary.simpleMessage("Tümü"),
        "contacts_drawer_storage_personal":
            MessageLookupByLibrary.simpleMessage("Kişisel"),
        "contacts_drawer_storage_shared":
            MessageLookupByLibrary.simpleMessage("Herkesle paylaşıldı"),
        "contacts_drawer_storage_team":
            MessageLookupByLibrary.simpleMessage("Ekip"),
        "contacts_edit": MessageLookupByLibrary.simpleMessage("Kişiyi düzenle"),
        "contacts_edit_cancel":
            MessageLookupByLibrary.simpleMessage("Kişiyi düzenlemekten vazgeç"),
        "contacts_edit_save":
            MessageLookupByLibrary.simpleMessage("Değişiklikleri kaydet"),
        "contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("E-posta adresi yok"),
        "contacts_empty": MessageLookupByLibrary.simpleMessage("Kişi yok"),
        "contacts_group_add": MessageLookupByLibrary.simpleMessage("Grup ekle"),
        "contacts_group_add_to_group":
            MessageLookupByLibrary.simpleMessage("Add to group"),
        "contacts_group_delete_desc_with_name": m11,
        "contacts_group_delete_title":
            MessageLookupByLibrary.simpleMessage("Grubu sil"),
        "contacts_group_edit":
            MessageLookupByLibrary.simpleMessage("Grubu düzenle"),
        "contacts_group_edit_cancel":
            MessageLookupByLibrary.simpleMessage("Grubu düzenlemekten vazgeç"),
        "contacts_group_edit_is_organization":
            MessageLookupByLibrary.simpleMessage("Bu grup bir şirket"),
        "contacts_group_view_app_bar_delete":
            MessageLookupByLibrary.simpleMessage("Bu grubu sil"),
        "contacts_group_view_app_bar_edit":
            MessageLookupByLibrary.simpleMessage("Grubu güncelle"),
        "contacts_group_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage(
                "Gruptaki kişilere e-posta gönder"),
        "contacts_groups_empty":
            MessageLookupByLibrary.simpleMessage("Grup yok"),
        "contacts_list_app_bar_all_contacts":
            MessageLookupByLibrary.simpleMessage("Tüm kişiler"),
        "contacts_list_app_bar_view_group":
            MessageLookupByLibrary.simpleMessage("Grubu görüntüle"),
        "contacts_list_its_me_flag":
            MessageLookupByLibrary.simpleMessage("Sizin hesabınız"),
        "contacts_remove_from_group":
            MessageLookupByLibrary.simpleMessage("Remove contacts from group"),
        "contacts_remove_selected": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to remove selected contacts from group?"),
        "contacts_shared_message": m12,
        "contacts_view_address": MessageLookupByLibrary.simpleMessage("Adres"),
        "contacts_view_app_bar_attach":
            MessageLookupByLibrary.simpleMessage("Gönder"),
        "contacts_view_app_bar_delete_contact":
            MessageLookupByLibrary.simpleMessage("Sil"),
        "contacts_view_app_bar_edit_contact":
            MessageLookupByLibrary.simpleMessage("Düzenle"),
        "contacts_view_app_bar_search_messages":
            MessageLookupByLibrary.simpleMessage("İletilerde ara"),
        "contacts_view_app_bar_send_message":
            MessageLookupByLibrary.simpleMessage("Bu kişiye e-posta gönder"),
        "contacts_view_app_bar_share":
            MessageLookupByLibrary.simpleMessage("Paylaş"),
        "contacts_view_app_bar_unshare":
            MessageLookupByLibrary.simpleMessage("Paylaşma"),
        "contacts_view_birthday":
            MessageLookupByLibrary.simpleMessage("Doğum günü"),
        "contacts_view_business_address":
            MessageLookupByLibrary.simpleMessage("İş Adresi"),
        "contacts_view_business_email":
            MessageLookupByLibrary.simpleMessage("Şirket e-postası"),
        "contacts_view_business_phone":
            MessageLookupByLibrary.simpleMessage("İş Telefonu"),
        "contacts_view_city": MessageLookupByLibrary.simpleMessage("Şehir"),
        "contacts_view_company": MessageLookupByLibrary.simpleMessage("Şirket"),
        "contacts_view_country": MessageLookupByLibrary.simpleMessage("Ülke"),
        "contacts_view_department":
            MessageLookupByLibrary.simpleMessage("Departman"),
        "contacts_view_display_name":
            MessageLookupByLibrary.simpleMessage("Görünen ad"),
        "contacts_view_email": MessageLookupByLibrary.simpleMessage("E-posta"),
        "contacts_view_facebook":
            MessageLookupByLibrary.simpleMessage("Facebook"),
        "contacts_view_fax": MessageLookupByLibrary.simpleMessage("Faks"),
        "contacts_view_first_name":
            MessageLookupByLibrary.simpleMessage("İsim"),
        "contacts_view_hide_additional_fields":
            MessageLookupByLibrary.simpleMessage("Ek alanları gizle"),
        "contacts_view_job_title":
            MessageLookupByLibrary.simpleMessage("Ünvan"),
        "contacts_view_last_name":
            MessageLookupByLibrary.simpleMessage("Soyisim"),
        "contacts_view_mobile":
            MessageLookupByLibrary.simpleMessage("Cep Telefonu"),
        "contacts_view_name": MessageLookupByLibrary.simpleMessage("İsim"),
        "contacts_view_nickname":
            MessageLookupByLibrary.simpleMessage("Takma İsim"),
        "contacts_view_notes": MessageLookupByLibrary.simpleMessage("Notlar"),
        "contacts_view_office": MessageLookupByLibrary.simpleMessage("Ofis"),
        "contacts_view_other_email":
            MessageLookupByLibrary.simpleMessage("Diğer e-posta"),
        "contacts_view_personal_address":
            MessageLookupByLibrary.simpleMessage("Kişisel Adres"),
        "contacts_view_personal_email":
            MessageLookupByLibrary.simpleMessage("Kişisel e-posta"),
        "contacts_view_personal_phone":
            MessageLookupByLibrary.simpleMessage("Kişisel Telefon"),
        "contacts_view_phone": MessageLookupByLibrary.simpleMessage("Telefon"),
        "contacts_view_province":
            MessageLookupByLibrary.simpleMessage("Eyalet"),
        "contacts_view_section_business":
            MessageLookupByLibrary.simpleMessage("Şirket"),
        "contacts_view_section_group_name":
            MessageLookupByLibrary.simpleMessage("Grup Adı"),
        "contacts_view_section_groups":
            MessageLookupByLibrary.simpleMessage("Gruplar"),
        "contacts_view_section_home":
            MessageLookupByLibrary.simpleMessage("Ana Sayfa"),
        "contacts_view_section_key":
            MessageLookupByLibrary.simpleMessage("Anahtar"),
        "contacts_view_section_other_info":
            MessageLookupByLibrary.simpleMessage("Diğer"),
        "contacts_view_section_personal":
            MessageLookupByLibrary.simpleMessage("Kişisel"),
        "contacts_view_show_additional_fields":
            MessageLookupByLibrary.simpleMessage("Ek alanları göster"),
        "contacts_view_skype": MessageLookupByLibrary.simpleMessage("Skype"),
        "contacts_view_street_address":
            MessageLookupByLibrary.simpleMessage("Sokak"),
        "contacts_view_web_page":
            MessageLookupByLibrary.simpleMessage("Web Sayfası"),
        "contacts_view_zip": MessageLookupByLibrary.simpleMessage("Posta Kodu"),
        "debug_hint_log_delete_record": MessageLookupByLibrary.simpleMessage(
            "Dosyayı silmek istediğinize emin misiniz?"),
        "error_compose_no_receivers":
            MessageLookupByLibrary.simpleMessage("Lütfen alıcı ekleyin"),
        "error_compose_wait_attachments": MessageLookupByLibrary.simpleMessage(
            "Lütfen eklerin yüklenmesi tamamlanıncaya kadar bekleyin"),
        "error_connection":
            MessageLookupByLibrary.simpleMessage("Sunucuya bağlanılamadı"),
        "error_connection_offline":
            MessageLookupByLibrary.simpleMessage("Çevrimdışısınız"),
        "error_contact_pgp_key_will_not_be_valid":
            MessageLookupByLibrary.simpleMessage(
                "PGP anahtarı geçerli olmayacak"),
        "error_contacts_email_empty":
            MessageLookupByLibrary.simpleMessage("Lütfen bir e-posta girin"),
        "error_contacts_save_name_empty":
            MessageLookupByLibrary.simpleMessage("Lütfen isim girin"),
        "error_input_validation_email":
            MessageLookupByLibrary.simpleMessage("E-posta geçerli değil"),
        "error_input_validation_empty": MessageLookupByLibrary.simpleMessage(
            "Bu alanı doldurmak zorunludur"),
        "error_input_validation_name_illegal_symbol":
            MessageLookupByLibrary.simpleMessage(
                "İsim, \"/\\*?<>|:\" karakterleri içeremez"),
        "error_input_validation_unique_name":
            MessageLookupByLibrary.simpleMessage("Bu isim zaten var"),
        "error_invalid_pin":
            MessageLookupByLibrary.simpleMessage("Geçersiz PIN"),
        "error_login_account_exists": MessageLookupByLibrary.simpleMessage(
            "Bu hesap hesaplar listenizde zaten var."),
        "error_login_auto_discover": MessageLookupByLibrary.simpleMessage(
            "Bu e-postada alan adı tespit edilemedi, lütfen sunucunuzun URL\'sini manuel olarak belirtin."),
        "error_login_input_email": MessageLookupByLibrary.simpleMessage(
            "Lütfen e-posta adresini girin"),
        "error_login_input_hostname": MessageLookupByLibrary.simpleMessage(
            "Lütfen mobil uygulama sunucu URL\'sini girin"),
        "error_login_input_password":
            MessageLookupByLibrary.simpleMessage("Lütfen şifrenizi girin"),
        "error_login_no_accounts": MessageLookupByLibrary.simpleMessage(
            "Bu kullanıcının e-posta hesabı yok"),
        "error_message_not_found":
            MessageLookupByLibrary.simpleMessage("İleti bulunamadı"),
        "error_no_pgp_key": MessageLookupByLibrary.simpleMessage(
            "PGP ortak anahtarı bulunamadı"),
        "error_password_is_empty":
            MessageLookupByLibrary.simpleMessage("şifre boş"),
        "error_pgp_can_not_decrypt": MessageLookupByLibrary.simpleMessage(
            "İletinin şifresi çözülemiyor."),
        "error_pgp_invalid_key_or_password":
            MessageLookupByLibrary.simpleMessage(
                "Geçersiz anahtar ya da şifre."),
        "error_pgp_invalid_password":
            MessageLookupByLibrary.simpleMessage("Geçersiz şifre"),
        "error_pgp_keys_not_found":
            MessageLookupByLibrary.simpleMessage("Anahtarlar bulunamadı"),
        "error_pgp_need_contact_for_encrypt":
            MessageLookupByLibrary.simpleMessage(
                "İletinizi şifrelemek için en az bir alıcı belirtmeniz gerekli."),
        "error_pgp_not_found_keys_for": m13,
        "error_pgp_select_recipient":
            MessageLookupByLibrary.simpleMessage("Alıcı seç"),
        "error_server_access_denied":
            MessageLookupByLibrary.simpleMessage("Erişim engellendi"),
        "error_server_account_exists":
            MessageLookupByLibrary.simpleMessage("Böyle bir hesap zaten var"),
        "error_server_account_old_password_not_correct":
            MessageLookupByLibrary.simpleMessage(
                "Hesabın eski şifresi doğru değil"),
        "error_server_auth_error":
            MessageLookupByLibrary.simpleMessage("Geçersiz e-posta/şifre"),
        "error_server_calendars_not_allowed":
            MessageLookupByLibrary.simpleMessage("Takvimlere izin verilmiyor"),
        "error_server_can_not_change_password":
            MessageLookupByLibrary.simpleMessage("Şifre değiştirilemiyor"),
        "error_server_can_not_create_account":
            MessageLookupByLibrary.simpleMessage("Hesap oluşturulamıyor"),
        "error_server_can_not_create_contact":
            MessageLookupByLibrary.simpleMessage("Kişi oluşturulamıyor"),
        "error_server_can_not_create_group":
            MessageLookupByLibrary.simpleMessage("Grup oluşturulamıyor"),
        "error_server_can_not_create_helpdesk_user":
            MessageLookupByLibrary.simpleMessage(
                "Yardım masası kullanıcısı oluşturulamıyor"),
        "error_server_can_not_get_contact":
            MessageLookupByLibrary.simpleMessage("Kişi verileri alınamıyor"),
        "error_server_can_not_save_settings":
            MessageLookupByLibrary.simpleMessage("Ayarlar kaydedilemiyor"),
        "error_server_can_not_update_contact":
            MessageLookupByLibrary.simpleMessage("Kişi güncellenemiyor"),
        "error_server_can_not_update_group":
            MessageLookupByLibrary.simpleMessage("Grup güncellenemiyor"),
        "error_server_can_not_upload_file_limit":
            MessageLookupByLibrary.simpleMessage(
                "Dosya yüklenemiyor: dosya limiti"),
        "error_server_can_not_upload_file_quota":
            MessageLookupByLibrary.simpleMessage(
                "Bulut depolama alanı limitinize ulaştınız. Dosya yüklenemiyor."),
        "error_server_captcha_error":
            MessageLookupByLibrary.simpleMessage("CAPTCHA hatası"),
        "error_server_contact_data_has_been_modified_by_another_application":
            MessageLookupByLibrary.simpleMessage(
                "Kişi verileri başka bir uygulama tarafından değiştirildi"),
        "error_server_contacts_not_allowed":
            MessageLookupByLibrary.simpleMessage("Kişilere izin verilmiyor"),
        "error_server_data_base_error":
            MessageLookupByLibrary.simpleMessage("Veri tabanı hatası"),
        "error_server_demo_account":
            MessageLookupByLibrary.simpleMessage("Demo hesabı"),
        "error_server_file_already_exists":
            MessageLookupByLibrary.simpleMessage("Böyle bir dosya zaten var"),
        "error_server_file_not_found":
            MessageLookupByLibrary.simpleMessage("Dosya bulunamadı"),
        "error_server_files_not_allowed":
            MessageLookupByLibrary.simpleMessage("Dosyalara izin verilmiyor"),
        "error_server_helpdesk_system_user_exists":
            MessageLookupByLibrary.simpleMessage(
                "Yardım masası sistemi kullanıcısı zaten var"),
        "error_server_helpdesk_unactivated_user":
            MessageLookupByLibrary.simpleMessage(
                "Etkin olmayan Yardım masası kullanıcısı"),
        "error_server_helpdesk_unknown_user":
            MessageLookupByLibrary.simpleMessage(
                "Bilinmeyen yardım masası kullanıcısı"),
        "error_server_helpdesk_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Yardım masası kullanıcısı zaten var"),
        "error_server_incorrect_file_extension":
            MessageLookupByLibrary.simpleMessage("Yanlış dosya uzantısı"),
        "error_server_invalid_input_parameter":
            MessageLookupByLibrary.simpleMessage("Geçersiz giriş parametresi"),
        "error_server_invalid_token":
            MessageLookupByLibrary.simpleMessage("Geçersiz anahtar (token)"),
        "error_server_license_limit":
            MessageLookupByLibrary.simpleMessage("Lisans limiti"),
        "error_server_license_problem":
            MessageLookupByLibrary.simpleMessage("Lisans sorunu"),
        "error_server_mail_server_error":
            MessageLookupByLibrary.simpleMessage("E-posta sunucusu hatası"),
        "error_server_method_not_found":
            MessageLookupByLibrary.simpleMessage("Yöntem bulunamadı"),
        "error_server_module_not_found":
            MessageLookupByLibrary.simpleMessage("Modül bulunamadı"),
        "error_server_rest_account_find_failed":
            MessageLookupByLibrary.simpleMessage("REST hesap bulma başarısız"),
        "error_server_rest_api_disabled":
            MessageLookupByLibrary.simpleMessage("REST API devre dışı"),
        "error_server_rest_invalid_credentials":
            MessageLookupByLibrary.simpleMessage(
                "REST geçersiz kimlik bilgileri"),
        "error_server_rest_invalid_parameters":
            MessageLookupByLibrary.simpleMessage("REST geçersiz parametre"),
        "error_server_rest_invalid_token":
            MessageLookupByLibrary.simpleMessage("REST geçersiz anahtar"),
        "error_server_rest_other_error":
            MessageLookupByLibrary.simpleMessage("Diğer REST hatası"),
        "error_server_rest_tenant_find_failed":
            MessageLookupByLibrary.simpleMessage(
                "REST kullanıcı bulma başarısız oldu"),
        "error_server_rest_token_expired":
            MessageLookupByLibrary.simpleMessage("REST anahtar süresi doldu"),
        "error_server_rest_unknown_method":
            MessageLookupByLibrary.simpleMessage("REST bilinmeyen yöntem"),
        "error_server_system_not_configured":
            MessageLookupByLibrary.simpleMessage("Sistem yapılandırılmamış"),
        "error_server_unknown_email":
            MessageLookupByLibrary.simpleMessage("Bilinmeyen e-posta"),
        "error_server_user_already_exists":
            MessageLookupByLibrary.simpleMessage(
                "Böyle bir kullanıcı zaten var"),
        "error_server_user_not_allowed":
            MessageLookupByLibrary.simpleMessage("Kullanıcıya izin verilmiyor"),
        "error_server_voice_not_allowed":
            MessageLookupByLibrary.simpleMessage("Ses\'e izin verilmiyor"),
        "error_timeout":
            MessageLookupByLibrary.simpleMessage("Sunucuya bağlanılamıyor"),
        "error_unknown":
            MessageLookupByLibrary.simpleMessage("Bilinmeyen hata"),
        "error_user_already_logged": MessageLookupByLibrary.simpleMessage(
            "Bu kullanıcı zaten giriş yapmış"),
        "fido_btn_try_again":
            MessageLookupByLibrary.simpleMessage("Tekrar dene"),
        "fido_btn_use_key":
            MessageLookupByLibrary.simpleMessage("Güvenlik anahtarını kullan"),
        "fido_error_hint": MessageLookupByLibrary.simpleMessage(
            "Güvenlik anahtarınızı tekrar kullanmayı deneyin veya kimliğinizi doğrulamanın başka bir yolunu deneyin"),
        "fido_error_invalid_key":
            MessageLookupByLibrary.simpleMessage("Geçersiz güvenlik anahtarı"),
        "fido_error_title":
            MessageLookupByLibrary.simpleMessage("Bir sorun oluştu"),
        "fido_hint_follow_the_instructions":
            MessageLookupByLibrary.simpleMessage(
                "Lütfen açılır penceredeki talimatları izleyin"),
        "fido_label_connect_your_key": MessageLookupByLibrary.simpleMessage(
            "Lütfen güvenlik anahtarınızı tarayın veya cihaza takın"),
        "fido_label_success": MessageLookupByLibrary.simpleMessage("Başarılı"),
        "fido_label_touch_your_key": MessageLookupByLibrary.simpleMessage(
            "Güvenlik anahtarınıza dokunun"),
        "folders_drafts": MessageLookupByLibrary.simpleMessage("Taslaklar"),
        "folders_empty": MessageLookupByLibrary.simpleMessage("Klasör yok"),
        "folders_inbox": MessageLookupByLibrary.simpleMessage("Gelen Kutusu"),
        "folders_notes": MessageLookupByLibrary.simpleMessage("Notlar"),
        "folders_sent": MessageLookupByLibrary.simpleMessage("Gönderilen"),
        "folders_spam": MessageLookupByLibrary.simpleMessage("Spam"),
        "folders_starred": MessageLookupByLibrary.simpleMessage("Yıldızlı"),
        "folders_trash": MessageLookupByLibrary.simpleMessage("Çöp Kutusu"),
        "format_compose_forward_date":
            MessageLookupByLibrary.simpleMessage("EEE, d MMM yyyy, HH:mm"),
        "format_compose_reply_date":
            MessageLookupByLibrary.simpleMessage("EEE, d MMM yyyy, HH:mm"),
        "format_contacts_birth_date":
            MessageLookupByLibrary.simpleMessage("d MMM yyyy"),
        "hint_2fa": MessageLookupByLibrary.simpleMessage(
            "Hesabınız iki faktörlü kimlik doğrulamayla korunuyor. \nLütfen PIN kodu girin."),
        "hint_auto_encrypt_messages": MessageLookupByLibrary.simpleMessage(
            "Bu kişiye gönderilen iletilerin otomatik olarak şifrelenmesini ve/veya imzalanmasını istiyorsanız, aşağıdaki kutuları işaretleyin. Bu iletilerin düz metne dönüştürüleceğini unutmayın. Ekler şifrelenmeyecektir."),
        "hint_confirm_exit": MessageLookupByLibrary.simpleMessage(
            "Çıkmak istediğinize emin misiniz?"),
        "hint_log_delete_all": MessageLookupByLibrary.simpleMessage(
            "Tüm günlükleri silmek istediğinize emin misiniz?"),
        "hint_log_delete_record": m14,
        "hint_login_upgrade_your_plan": MessageLookupByLibrary.simpleMessage(
            "Faturalandırma planınızda mobil uygulamalara izin verilmiyor."),
        "hint_message_empty_folder": m15,
        "hint_pgp_already_have_keys": MessageLookupByLibrary.simpleMessage(
            "Sistemde zaten bulunan anahtarlar gri işaretlenmiştir."),
        "hint_pgp_delete_user_key_confirm": m16,
        "hint_pgp_existed_keys": MessageLookupByLibrary.simpleMessage(
            "Zaten sistemde olan anahtarlar içe aktarılmayacak"),
        "hint_pgp_external_private_keys": MessageLookupByLibrary.simpleMessage(
            "Harici özel anahtarlar desteklenmez ve içe aktarılmaz"),
        "hint_pgp_keys_contacts_will_be_created":
            MessageLookupByLibrary.simpleMessage(
                "Bu anahtarlar için kişiler oluşturulacak."),
        "hint_pgp_keys_for_import": MessageLookupByLibrary.simpleMessage(
            "İçe aktarılabilecek anahtarlar"),
        "hint_pgp_keys_will_be_import_to_contacts":
            MessageLookupByLibrary.simpleMessage(
                "Bu anahtarlar kişilere aktarılacak"),
        "hint_pgp_message_automatically_encrypt":
            MessageLookupByLibrary.simpleMessage(
                "OpenPgp anahtarları olan kişiler için ileti otomatik olarak şifrelenecek ve/veya imzalanacaktır.\n OpenPGP yalnızca düz metni destekler. Tüm biçimlendirme şifrelemeden önce kaldırılacaktır."),
        "hint_pgp_share_warning": MessageLookupByLibrary.simpleMessage(
            "Özel PGP anahtarınızı paylaşacaksınız. Anahtar 3. taraflar ile paylaşılmamalıdır. Devam etmek istiyor musunuz?"),
        "hint_pgp_your_keys":
            MessageLookupByLibrary.simpleMessage("Anahtarlarınız"),
        "hint_self_destructing_encrypt_with_key":
            MessageLookupByLibrary.simpleMessage(
                "Seçili alıcının RGP ortak anahtarı mevcut. Bu ileti bu anahtar kullanılarak şifrelenebilir."),
        "hint_self_destructing_encrypt_with_not_key":
            MessageLookupByLibrary.simpleMessage(
                "Seçili alıcının PGP ortak anahtarı yok. Anahtar bazlı şifrelemeye izin verilmez"),
        "hint_self_destructing_password_coppied_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Şifre panoya kopyalandı"),
        "hint_self_destructing_sent_password_using_different_channel":
            MessageLookupByLibrary.simpleMessage(
                "Şifre farklı bir kanal üzerinden gönderilmelidir. \nŞifreyi bir yerde saklayın. Aksi takdirde şifreyi kurtaramazsınız."),
        "hint_self_destructing_supports_plain_text_only":
            MessageLookupByLibrary.simpleMessage(
                "Kendini yok eden güvenli iletiler yalnızca düz metni destekler. Tüm biçimlendirme kaldırılacaktır. Ayrıca, ekler şifrelenemez ve iletiden kaldırılır."),
        "hint_vcf_import": MessageLookupByLibrary.simpleMessage(
            "Kişi vcf\'den içe aktarılsın mı?"),
        "input_2fa_pin": MessageLookupByLibrary.simpleMessage("PIN"),
        "input_message_search_since":
            MessageLookupByLibrary.simpleMessage("İtibaren"),
        "input_message_search_text":
            MessageLookupByLibrary.simpleMessage("Metin"),
        "input_message_search_till":
            MessageLookupByLibrary.simpleMessage("Kadar"),
        "input_self_destructing_add_digital_signature":
            MessageLookupByLibrary.simpleMessage("Dijital imza ekle"),
        "input_self_destructing_key_based_encryption":
            MessageLookupByLibrary.simpleMessage("Anahtar bazlı"),
        "input_self_destructing_password_based_encryption":
            MessageLookupByLibrary.simpleMessage("Şifre bazlı"),
        "label_contact_pgp_settings":
            MessageLookupByLibrary.simpleMessage("PGP Ayarları"),
        "label_contact_select_key":
            MessageLookupByLibrary.simpleMessage("Anahtar Seç"),
        "label_contact_with_not_name":
            MessageLookupByLibrary.simpleMessage("İsim yok"),
        "label_contacts_were_imported_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Kişiler başarıyla içe aktarıldı"),
        "label_device_id_copied_to_clip_board":
            MessageLookupByLibrary.simpleMessage(
                "Cihaz kimliği panoya kopyalandı"),
        "label_device_identifier":
            MessageLookupByLibrary.simpleMessage("Cihaz tanımlayıcısı"),
        "label_discard_not_saved_changes": MessageLookupByLibrary.simpleMessage(
            "Kaydedilmemiş değişiklikler iptal edilsin mi?"),
        "label_enable_uploaded_message_counter":
            MessageLookupByLibrary.simpleMessage("Yüklenen ileti sayacı"),
        "label_encryption_password_for_pgp_key":
            MessageLookupByLibrary.simpleMessage(
                "PGP anahtarı için gerekli şifre"),
        "label_forward_as_attachment":
            MessageLookupByLibrary.simpleMessage("Ek olarak ilet"),
        "label_length": MessageLookupByLibrary.simpleMessage("Uzunluk"),
        "label_message_advanced_search":
            MessageLookupByLibrary.simpleMessage("Gelişmiş arama"),
        "label_message_headers":
            MessageLookupByLibrary.simpleMessage("İleti başlıkları"),
        "label_message_move_to": MessageLookupByLibrary.simpleMessage("Taşı: "),
        "label_message_move_to_folder":
            MessageLookupByLibrary.simpleMessage("Klasöre taşı"),
        "label_message_yesterday": MessageLookupByLibrary.simpleMessage("Dün"),
        "label_notifications_settings":
            MessageLookupByLibrary.simpleMessage("Bildirimler"),
        "label_pgp_all_public_key":
            MessageLookupByLibrary.simpleMessage("Tüm ortak anahtarlar"),
        "label_pgp_contact_public_keys":
            MessageLookupByLibrary.simpleMessage("Ortak anahtar bağlantısı"),
        "label_pgp_decrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP Şifresini Çöz"),
        "label_pgp_decrypted_and_verified":
            MessageLookupByLibrary.simpleMessage(
                "İletinin şifresi başarıyla çözüldü ve doğrulandı."),
        "label_pgp_decrypted_but_not_verified":
            MessageLookupByLibrary.simpleMessage(
                "İletinin şifresi başarıyla çözüldü ancak doğrulanmadı."),
        "label_pgp_downloading_to": m17,
        "label_pgp_encrypt": MessageLookupByLibrary.simpleMessage("Şifrele"),
        "label_pgp_import_key":
            MessageLookupByLibrary.simpleMessage("Anahtarları içe aktar"),
        "label_pgp_key_with_not_name":
            MessageLookupByLibrary.simpleMessage("İsim yok"),
        "label_pgp_not_verified":
            MessageLookupByLibrary.simpleMessage("İleti doğrulanmadı."),
        "label_pgp_private_key":
            MessageLookupByLibrary.simpleMessage("Özel anahtar"),
        "label_pgp_private_keys":
            MessageLookupByLibrary.simpleMessage("Özel anahtarlar"),
        "label_pgp_public_key":
            MessageLookupByLibrary.simpleMessage("Ortak anahtar"),
        "label_pgp_public_keys":
            MessageLookupByLibrary.simpleMessage("Ortak anahtarlar"),
        "label_pgp_settings": MessageLookupByLibrary.simpleMessage("OpenPGP"),
        "label_pgp_share_warning":
            MessageLookupByLibrary.simpleMessage("Uyarı"),
        "label_pgp_sign": MessageLookupByLibrary.simpleMessage("İmzala"),
        "label_pgp_sign_or_encrypt":
            MessageLookupByLibrary.simpleMessage("Open PGP İmzala/Şifrele"),
        "label_pgp_verified":
            MessageLookupByLibrary.simpleMessage("İleti başarıyla doğrulandı."),
        "label_record_log_in_background":
            MessageLookupByLibrary.simpleMessage("Arka planda günlük kaydet"),
        "label_self_destructing": MessageLookupByLibrary.simpleMessage(
            "Kendini yok eden güvenli bir e-posta gönder"),
        "label_self_destructing_key_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Anahtar bazlı şifreleme kullanılacak."),
        "label_self_destructing_not_sign_data":
            MessageLookupByLibrary.simpleMessage("Veri imzalanmayacak."),
        "label_self_destructing_password_based_encryption_used":
            MessageLookupByLibrary.simpleMessage(
                "Şifre bazlı şifreleme kullanılacak."),
        "label_self_destructing_sign_data":
            MessageLookupByLibrary.simpleMessage(
                "Veri özel anahtarınızla imzalanacak."),
        "label_show_debug_view": MessageLookupByLibrary.simpleMessage(
            "Hata ayıklama görünümünü göster"),
        "label_token_failed": MessageLookupByLibrary.simpleMessage("Başarısız"),
        "label_token_storing_status":
            MessageLookupByLibrary.simpleMessage("Token saklama durumu"),
        "label_token_successful":
            MessageLookupByLibrary.simpleMessage("Başarılı"),
        "login_input_email": MessageLookupByLibrary.simpleMessage("E-posta"),
        "login_input_host": MessageLookupByLibrary.simpleMessage("Sunucu"),
        "login_input_password": MessageLookupByLibrary.simpleMessage("Şifre"),
        "login_to_continue": MessageLookupByLibrary.simpleMessage(
            "Devam etmek için giriş yapın"),
        "message_lifetime":
            MessageLookupByLibrary.simpleMessage("İleti yaşam süresi"),
        "messages_always_show_images": MessageLookupByLibrary.simpleMessage(
            "Görselleri her zaman göster."),
        "messages_attachment_delete":
            MessageLookupByLibrary.simpleMessage("Eki sil"),
        "messages_attachment_download":
            MessageLookupByLibrary.simpleMessage("Eki indir"),
        "messages_attachment_download_cancel":
            MessageLookupByLibrary.simpleMessage("İndirmeyi iptal et"),
        "messages_attachment_download_failed":
            MessageLookupByLibrary.simpleMessage("İndirme işlemi başarısız"),
        "messages_attachment_download_success": m18,
        "messages_attachment_downloading": m19,
        "messages_attachment_upload":
            MessageLookupByLibrary.simpleMessage("Dosya yükle"),
        "messages_attachment_upload_cancel":
            MessageLookupByLibrary.simpleMessage("Yüklemeyi iptal et"),
        "messages_attachment_upload_failed":
            MessageLookupByLibrary.simpleMessage("Yükleme işlemi başarısız"),
        "messages_attachment_upload_success": m20,
        "messages_attachment_uploading": m21,
        "messages_attachments_empty":
            MessageLookupByLibrary.simpleMessage("Ek yok"),
        "messages_bcc": MessageLookupByLibrary.simpleMessage("BCC"),
        "messages_cc": MessageLookupByLibrary.simpleMessage("CC"),
        "messages_delete_desc": MessageLookupByLibrary.simpleMessage(
            "Bu iletiyi silmek istediğinden emin misin?"),
        "messages_delete_desc_with_count": MessageLookupByLibrary.simpleMessage(
            "Bu iletiyi silmek istediğinize emin misiniz?"),
        "messages_delete_desc_with_subject": m22,
        "messages_delete_title":
            MessageLookupByLibrary.simpleMessage("İletiyi sil"),
        "messages_delete_title_with_count":
            MessageLookupByLibrary.simpleMessage("İletileri sil"),
        "messages_empty": MessageLookupByLibrary.simpleMessage("İleti yok"),
        "messages_filter_unread":
            MessageLookupByLibrary.simpleMessage("Okunmamış iletiler:"),
        "messages_forward": MessageLookupByLibrary.simpleMessage("Yönlendir"),
        "messages_from": MessageLookupByLibrary.simpleMessage("Gönderen"),
        "messages_images_security_alert": MessageLookupByLibrary.simpleMessage(
            "Bu iletideki görseller güvenliğiniz sebebiyle engellendi. "),
        "messages_list_app_bar_contacts":
            MessageLookupByLibrary.simpleMessage("Kişiler"),
        "messages_list_app_bar_loading_folders":
            MessageLookupByLibrary.simpleMessage("Klasörler yükleniyor..."),
        "messages_list_app_bar_logout":
            MessageLookupByLibrary.simpleMessage("Oturumu kapat"),
        "messages_list_app_bar_mail":
            MessageLookupByLibrary.simpleMessage("E-posta"),
        "messages_list_app_bar_search":
            MessageLookupByLibrary.simpleMessage("Ara"),
        "messages_list_app_bar_settings":
            MessageLookupByLibrary.simpleMessage("Ayarlar"),
        "messages_no_receivers":
            MessageLookupByLibrary.simpleMessage("Alıcı yok"),
        "messages_no_subject": MessageLookupByLibrary.simpleMessage("Konu yok"),
        "messages_reply": MessageLookupByLibrary.simpleMessage("Yanıtla"),
        "messages_reply_all":
            MessageLookupByLibrary.simpleMessage("Tümünü yanıtla"),
        "messages_saved_in_drafts":
            MessageLookupByLibrary.simpleMessage("İleti taslaklara kaydedildi"),
        "messages_sending":
            MessageLookupByLibrary.simpleMessage("İleti gönderiliyor..."),
        "messages_show_details":
            MessageLookupByLibrary.simpleMessage("Detayları göster"),
        "messages_show_images":
            MessageLookupByLibrary.simpleMessage("Görselleri göster."),
        "messages_subject": MessageLookupByLibrary.simpleMessage("Konu"),
        "messages_to": MessageLookupByLibrary.simpleMessage("Alıcı"),
        "messages_to_me": MessageLookupByLibrary.simpleMessage("Bana"),
        "messages_unknown_recipient":
            MessageLookupByLibrary.simpleMessage("Alıcı yok"),
        "messages_unknown_sender":
            MessageLookupByLibrary.simpleMessage("Gönderen yok"),
        "messages_view_tab_attachments":
            MessageLookupByLibrary.simpleMessage("Ekler"),
        "messages_view_tab_message_body":
            MessageLookupByLibrary.simpleMessage("İleti metni"),
        "no_permission_to_local_storage": MessageLookupByLibrary.simpleMessage(
            "Yerel depolamaya erişim izni yok. Cihazınızın ayarlarını kontrol edin."),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "save": MessageLookupByLibrary.simpleMessage("Kaydet"),
        "save_changes_question":
            MessageLookupByLibrary.simpleMessage("Save changes?"),
        "self_destructing_life_time_day":
            MessageLookupByLibrary.simpleMessage("24 saat"),
        "self_destructing_life_time_days_3":
            MessageLookupByLibrary.simpleMessage("72 saat"),
        "self_destructing_life_time_days_7":
            MessageLookupByLibrary.simpleMessage("7 gün"),
        "settings": MessageLookupByLibrary.simpleMessage("Ayarlar"),
        "settings_24_time_format":
            MessageLookupByLibrary.simpleMessage("24 saat formatı"),
        "settings_about": MessageLookupByLibrary.simpleMessage("Hakkında"),
        "settings_about_app_version": m23,
        "settings_about_privacy_policy":
            MessageLookupByLibrary.simpleMessage("Gizlilik Politikası"),
        "settings_about_terms_of_service":
            MessageLookupByLibrary.simpleMessage("Hizmet Şartları"),
        "settings_accounts_add":
            MessageLookupByLibrary.simpleMessage("Yeni hesap ekle"),
        "settings_accounts_delete":
            MessageLookupByLibrary.simpleMessage("Hesabı sil"),
        "settings_accounts_delete_description": m24,
        "settings_accounts_manage":
            MessageLookupByLibrary.simpleMessage("Hesapları yönet"),
        "settings_accounts_relogin":
            MessageLookupByLibrary.simpleMessage("Hesaba tekrar giriş yap"),
        "settings_common": MessageLookupByLibrary.simpleMessage("Genel"),
        "settings_dark_theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "settings_dark_theme_dark":
            MessageLookupByLibrary.simpleMessage("Koyu"),
        "settings_dark_theme_light":
            MessageLookupByLibrary.simpleMessage("Açık"),
        "settings_dark_theme_system":
            MessageLookupByLibrary.simpleMessage("Sistem teması"),
        "settings_language": MessageLookupByLibrary.simpleMessage("Dil"),
        "settings_language_system":
            MessageLookupByLibrary.simpleMessage("Sistem dili"),
        "settings_sync": MessageLookupByLibrary.simpleMessage("Senkronizasyon"),
        "settings_sync_frequency":
            MessageLookupByLibrary.simpleMessage("Senkronizasyon sıklığı"),
        "settings_sync_frequency_daily":
            MessageLookupByLibrary.simpleMessage("günlük"),
        "settings_sync_frequency_hours1":
            MessageLookupByLibrary.simpleMessage("1 saat"),
        "settings_sync_frequency_hours2":
            MessageLookupByLibrary.simpleMessage("2 saat"),
        "settings_sync_frequency_minutes30":
            MessageLookupByLibrary.simpleMessage("30 dakika"),
        "settings_sync_frequency_minutes5":
            MessageLookupByLibrary.simpleMessage("5 dakika"),
        "settings_sync_frequency_monthly":
            MessageLookupByLibrary.simpleMessage("aylık"),
        "settings_sync_frequency_never":
            MessageLookupByLibrary.simpleMessage("hiçbir zaman"),
        "settings_sync_frequency_weekly":
            MessageLookupByLibrary.simpleMessage("weekly"),
        "settings_sync_frequency_yearly":
            MessageLookupByLibrary.simpleMessage("yearly"),
        "settings_sync_period":
            MessageLookupByLibrary.simpleMessage("Senkronizasyon periyodu"),
        "settings_sync_period_all_time":
            MessageLookupByLibrary.simpleMessage("her zaman"),
        "settings_sync_period_months1":
            MessageLookupByLibrary.simpleMessage("1 ay"),
        "settings_sync_period_months3":
            MessageLookupByLibrary.simpleMessage("3 ay"),
        "settings_sync_period_months6":
            MessageLookupByLibrary.simpleMessage("6 ay"),
        "settings_sync_period_years1":
            MessageLookupByLibrary.simpleMessage("1 yıl"),
        "template_self_destructing_message": m25,
        "template_self_destructing_message_password": m26,
        "template_self_destructing_message_title":
            MessageLookupByLibrary.simpleMessage(
                "Güvenli ileti sizinle paylaşıldı"),
        "tfa_btn_other_options":
            MessageLookupByLibrary.simpleMessage("Diğer seçenekler"),
        "tfa_btn_use_auth_app": MessageLookupByLibrary.simpleMessage(
            "Kimlik doğrulayıcı uygulamasını kullan"),
        "tfa_btn_use_backup_code":
            MessageLookupByLibrary.simpleMessage("Yedek kod kullan"),
        "tfa_btn_use_security_key": MessageLookupByLibrary.simpleMessage(
            "Güvenlik anahtarınızı kullanın"),
        "tfa_button_continue": MessageLookupByLibrary.simpleMessage("Devam et"),
        "tfa_check_box_trust_device": m27,
        "tfa_error_invalid_backup_code":
            MessageLookupByLibrary.simpleMessage("Geçersiz yedek kod"),
        "tfa_hint_step": MessageLookupByLibrary.simpleMessage(
            "Bu ek adım, giriş yapmaya çalışanın gerçekten siz olduğunuzu doğrulamak için tasarlanmıştır"),
        "tfa_input_backup_code":
            MessageLookupByLibrary.simpleMessage("Yedek kod"),
        "tfa_input_hint_code_from_app": MessageLookupByLibrary.simpleMessage(
            "Kimlik doğrulayıcı uygulamasından doğrulama kodunu belirtin"),
        "tfa_label":
            MessageLookupByLibrary.simpleMessage("İki Faktörlü Doğrulama"),
        "tfa_label_enter_backup_code": MessageLookupByLibrary.simpleMessage(
            "8 karakterli yedek kodlarınızdan birini girin"),
        "tfa_label_hint_security_options":
            MessageLookupByLibrary.simpleMessage("Mevcut güvenlik seçenekleri"),
        "tfa_label_trust_device":
            MessageLookupByLibrary.simpleMessage("Her şey hazır")
      };
}
