import 'package:localizator_interface/localizator_interface.dart';

abstract class S extends SInterface {
  static const app_title = 0;
  static const login_input_host = 1;
  static const login_input_email = 2;
  static const login_input_password = 3;
  static const login_to_continue = 4;
  static const folders_empty = 5;
  static const folders_inbox = 6;
  static const folders_starred = 7;
  static const folders_sent = 8;
  static const folders_drafts = 9;
  static const folders_spam = 10;
  static const folders_trash = 11;
  static const messages_reply = 12;
  static const messages_reply_all = 13;
  static const messages_forward = 14;
  static const messages_empty = 15;
  static const messages_filter_unread = 16;
  static const messages_delete_title = 17;
  static const messages_delete_title_with_count = 18;
  static const messages_delete_desc_with_subject = 19;
  static const messages_delete_desc = 20;
  static const messages_delete_desc_with_count = 21;
  static const messages_list_app_bar_mail = 22;
  static const messages_list_app_bar_contacts = 23;
  static const messages_list_app_bar_settings = 24;
  static const messages_list_app_bar_logout = 25;
  static const messages_list_app_bar_search = 26;
  static const messages_list_app_bar_loading_folders = 27;
  static const messages_show_details = 28;
  static const messages_images_security_alert = 29;
  static const messages_show_images = 30;
  static const messages_always_show_images = 31;
  static const messages_view_tab_attachments = 32;
  static const messages_view_tab_message_body = 33;
  static const messages_to = 34;
  static const messages_from = 35;
  static const messages_cc = 36;
  static const messages_bcc = 37;
  static const messages_subject = 38;
  static const messages_no_subject = 39;
  static const messages_to_me = 40;
  static const messages_no_receivers = 41;
  static const messages_unknown_sender = 42;
  static const messages_unknown_recipient = 43;
  static const messages_sending = 44;
  static const messages_saved_in_drafts = 45;
  static const messages_attachments_empty = 46;
  static const messages_attachment_delete = 47;
  static const messages_attachment_download = 48;
  static const messages_attachment_downloading = 49;
  static const messages_attachment_download_failed = 50;
  static const messages_attachment_download_cancel = 51;
  static const messages_attachment_download_success = 52;
  static const messages_attachment_upload = 53;
  static const messages_attachment_uploading = 54;
  static const messages_attachment_upload_failed = 55;
  static const messages_attachment_upload_cancel = 56;
  static const messages_attachment_upload_success = 57;
  static const compose_body_placeholder = 58;
  static const compose_forward_body_original_message = 59;
  static const compose_forward_from = 60;
  static const compose_forward_to = 61;
  static const compose_forward_cc = 62;
  static const compose_forward_bcc = 63;
  static const compose_forward_sent = 64;
  static const compose_forward_subject = 65;
  static const compose_reply_body_title = 66;
  static const compose_discard_save_dialog_title = 67;
  static const compose_discard_save_dialog_description = 68;
  static const contacts = 69;
  static const contacts_list_app_bar_view_group = 70;
  static const contacts_list_app_bar_all_contacts = 71;
  static const contacts_list_its_me_flag = 72;
  static const contacts_empty = 73;
  static const contacts_groups_empty = 74;
  static const contacts_email_empty = 75;
  static const contacts_drawer_section_storages = 76;
  static const contacts_drawer_storage_all = 77;
  static const contacts_drawer_storage_personal = 78;
  static const contacts_drawer_storage_team = 79;
  static const contacts_drawer_storage_shared = 80;
  static const contacts_drawer_section_groups = 81;
  static const contacts_view_app_bar_share = 82;
  static const contacts_view_app_bar_unshare = 83;
  static const contacts_view_app_bar_attach = 84;
  static const contacts_view_app_bar_send_message = 85;
  static const contacts_view_app_bar_search_messages = 86;
  static const contacts_view_app_bar_edit_contact = 87;
  static const contacts_view_app_bar_delete_contact = 88;
  static const contacts_shared_message = 89;
  static const contacts_group_view_app_bar_send_message = 90;
  static const contacts_group_view_app_bar_delete = 91;
  static const contacts_group_view_app_bar_edit = 92;
  static const contacts_view_show_additional_fields = 93;
  static const contacts_view_hide_additional_fields = 94;
  static const contacts_view_section_home = 95;
  static const contacts_view_section_personal = 96;
  static const contacts_view_section_business = 97;
  static const contacts_view_section_other_info = 98;
  static const contacts_view_section_group_name = 99;
  static const contacts_view_section_groups = 100;
  static const contacts_view_display_name = 101;
  static const contacts_view_email = 102;
  static const contacts_view_personal_email = 103;
  static const contacts_view_business_email = 104;
  static const contacts_view_other_email = 105;
  static const contacts_view_phone = 106;
  static const contacts_view_personal_phone = 107;
  static const contacts_view_business_phone = 108;
  static const contacts_view_mobile = 109;
  static const contacts_view_fax = 110;
  static const contacts_view_address = 111;
  static const contacts_view_personal_address = 112;
  static const contacts_view_business_address = 113;
  static const contacts_view_skype = 114;
  static const contacts_view_facebook = 115;
  static const contacts_view_name = 116;
  static const contacts_view_first_name = 117;
  static const contacts_view_last_name = 118;
  static const contacts_view_nickname = 119;
  static const contacts_view_street_address = 120;
  static const contacts_view_city = 121;
  static const contacts_view_province = 122;
  static const contacts_view_country = 123;
  static const contacts_view_zip = 124;
  static const contacts_view_web_page = 125;
  static const contacts_view_company = 126;
  static const contacts_view_department = 127;
  static const contacts_view_job_title = 128;
  static const contacts_view_office = 129;
  static const contacts_view_birthday = 130;
  static const contacts_view_notes = 131;
  static const contacts_edit = 132;
  static const contacts_edit_cancel = 133;
  static const contacts_edit_save = 134;
  static const contacts_add = 135;
  static const contacts_group_add = 136;
  static const contacts_group_edit = 137;
  static const contacts_group_edit_is_organization = 138;
  static const contacts_group_edit_cancel = 139;
  static const contacts_delete_title = 140;
  static const contacts_delete_desc_with_name = 141;
  static const contacts_group_delete_title = 142;
  static const contacts_group_delete_desc_with_name = 143;
  static const settings = 144;
  static const settings_common = 145;
  static const settings_24_time_format = 146;
  static const settings_language = 147;
  static const settings_language_system = 148;
  static const settings_dark_theme = 149;
  static const settings_dark_theme_system = 150;
  static const settings_dark_theme_dark = 151;
  static const settings_dark_theme_light = 152;
  static const settings_sync = 153;
  static const settings_sync_frequency = 154;
  static const settings_sync_frequency_never = 155;
  static const settings_sync_frequency_minutes5 = 156;
  static const settings_sync_frequency_minutes30 = 157;
  static const settings_sync_frequency_hours1 = 158;
  static const settings_sync_frequency_hours2 = 159;
  static const settings_sync_frequency_daily = 160;
  static const settings_sync_frequency_monthly = 161;
  static const settings_sync_period = 162;
  static const settings_sync_period_all_time = 163;
  static const settings_sync_period_months1 = 164;
  static const settings_sync_period_months3 = 165;
  static const settings_sync_period_months6 = 166;
  static const settings_sync_period_years1 = 167;
  static const settings_accounts_manage = 168;
  static const settings_accounts_add = 169;
  static const settings_accounts_relogin = 170;
  static const settings_accounts_delete = 171;
  static const settings_accounts_delete_description = 172;
  static const settings_about = 173;
  static const settings_about_app_version = 174;
  static const settings_about_terms_of_service = 175;
  static const settings_about_privacy_policy = 176;
  static const btn_login = 177;
  static const btn_delete = 178;
  static const btn_show_email_in_light_theme = 179;
  static const btn_cancel = 180;
  static const btn_close = 181;
  static const btn_to_spam = 182;
  static const btn_save = 183;
  static const btn_discard = 184;
  static const btn_add_account = 185;
  static const btn_show_all = 186;
  static const error_login_input_hostname = 187;
  static const error_login_input_email = 188;
  static const error_login_input_password = 189;
  static const error_login_auto_discover = 190;
  static const error_login_no_accounts = 191;
  static const error_login_account_exists = 192;
  static const error_compose_no_receivers = 193;
  static const error_compose_wait_attachments = 194;
  static const error_contacts_save_name_empty = 195;
  static const error_contacts_email_empty = 196;
  static const error_connection = 197;
  static const error_connection_offline = 198;
  static const error_input_validation_empty = 199;
  static const error_input_validation_email = 200;
  static const error_input_validation_name_illegal_symbol = 201;
  static const error_input_validation_unique_name = 202;
  static const error_server_invalid_token = 203;
  static const error_server_auth_error = 204;
  static const error_server_invalid_input_parameter = 205;
  static const error_server_data_base_error = 206;
  static const error_server_license_problem = 207;
  static const error_server_demo_account = 208;
  static const error_server_captcha_error = 209;
  static const error_server_access_denied = 210;
  static const error_server_unknown_email = 211;
  static const error_server_user_not_allowed = 212;
  static const error_server_user_already_exists = 213;
  static const error_server_system_not_configured = 214;
  static const error_server_module_not_found = 215;
  static const error_server_method_not_found = 216;
  static const error_server_license_limit = 217;
  static const error_server_can_not_save_settings = 218;
  static const error_server_can_not_change_password = 219;
  static const error_server_account_old_password_not_correct = 220;
  static const error_server_can_not_create_contact = 221;
  static const error_server_can_not_create_group = 222;
  static const error_server_can_not_update_contact = 223;
  static const error_server_can_not_update_group = 224;
  static const error_server_contact_data_has_been_modified_by_another_application =
      225;
  static const error_server_can_not_get_contact = 226;
  static const error_server_can_not_create_account = 227;
  static const error_server_account_exists = 228;
  static const error_server_rest_other_error = 229;
  static const error_server_rest_api_disabled = 230;
  static const error_server_rest_unknown_method = 231;
  static const error_server_rest_invalid_parameters = 232;
  static const error_server_rest_invalid_credentials = 233;
  static const error_server_rest_invalid_token = 234;
  static const error_server_rest_token_expired = 235;
  static const error_server_rest_account_find_failed = 236;
  static const error_server_rest_tenant_find_failed = 237;
  static const error_server_calendars_not_allowed = 238;
  static const error_server_files_not_allowed = 239;
  static const error_server_contacts_not_allowed = 240;
  static const error_server_helpdesk_user_already_exists = 241;
  static const error_server_helpdesk_system_user_exists = 242;
  static const error_server_can_not_create_helpdesk_user = 243;
  static const error_server_helpdesk_unknown_user = 244;
  static const error_server_helpdesk_unactivated_user = 245;
  static const error_server_voice_not_allowed = 246;
  static const error_server_incorrect_file_extension = 247;
  static const error_server_can_not_upload_file_quota = 248;
  static const error_server_file_already_exists = 249;
  static const error_server_file_not_found = 250;
  static const error_server_can_not_upload_file_limit = 251;
  static const error_server_mail_server_error = 252;
  static const error_unknown = 253;
  static const format_compose_forward_date = 254;
  static const format_compose_reply_date = 255;
  static const format_contacts_birth_date = 256;
  static const label_message_yesterday = 257;
  static const hint_2fa = 258;
  static const input_2fa_pin = 259;
  static const btn_verify_pin = 260;
  static const error_invalid_pin = 261;
  static const btn_done = 262;
  static const hint_confirm_exit = 263;
  static const btn_exit = 264;
  static const label_pgp_settings = 265;
  static const label_pgp_public_keys = 266;
  static const label_pgp_private_keys = 267;
  static const btn_pgp_export_all_public_keys = 268;
  static const btn_pgp_import_keys_from_text = 269;
  static const btn_pgp_import_keys_from_file = 270;
  static const btn_pgp_import_from_text = 271;
  static const btn_pgp_import_from_file = 272;
  static const btn_pgp_generate_keys = 273;
  static const btn_pgp_generate = 274;
  static const label_length = 275;
  static const btn_download = 276;
  static const btn_share = 277;
  static const label_pgp_public_key = 278;
  static const label_pgp_private_key = 279;
  static const label_pgp_import_key = 280;
  static const btn_pgp_import_selected_key = 281;
  static const btn_pgp_check_keys = 282;
  static const error_pgp_keys_not_found = 283;
  static const label_pgp_all_public_key = 284;
  static const btn_pgp_download_all = 285;
  static const btn_php_send_all = 286;
  static const label_pgp_downloading_to = 287;
  static const hint_pgp_delete_user_key_confirm = 288;
  static const btn_pgp_sign_or_encrypt = 289;
  static const label_pgp_sign_or_encrypt = 290;
  static const label_pgp_decrypt = 291;
  static const label_pgp_sign = 292;
  static const btn_pgp_encrypt = 293;
  static const btn_pgp_decrypt = 294;
  static const error_pgp_invalid_password = 295;
  static const error_pgp_not_found_keys_for = 296;
  static const btn_pgp_undo_pgp = 297;
  static const label_pgp_verified = 298;
  static const label_pgp_not_verified = 299;
  static const label_pgp_decrypted_and_verified = 300;
  static const label_pgp_decrypted_but_not_verified = 301;
  static const error_pgp_invalid_key_or_password = 302;
  static const error_pgp_can_not_decrypt = 303;
  static const error_pgp_need_contact_for_encrypt = 304;
  static const button_pgp_verify_sign = 305;
  static const hint_pgp_already_have_keys = 306;
  static const btn_contact_find_in_email = 307;
  static const btn_message_resend = 308;
  static const btn_message_empty_trash_folder = 309;
  static const btn_message_empty_spam_folder = 310;
  static const hint_message_empty_folder = 311;
  static const label_self_destructing = 312;
  static const self_destructing_life_time_day = 313;
  static const self_destructing_life_time_days_3 = 314;
  static const self_destructing_life_time_days_7 = 315;
  static const message_lifetime = 316;
  static const label_pgp_key_with_not_name = 317;
  static const label_self_destructing_not_sign_data = 318;
  static const label_self_destructing_sign_data = 319;
  static const input_self_destructing_password_based_encryption = 320;
  static const input_self_destructing_key_based_encryption = 321;
  static const label_self_destructing_password_based_encryption_used = 322;
  static const label_self_destructing_key_based_encryption_used = 323;
  static const hint_self_destructing_encrypt_with_key = 324;
  static const hint_self_destructing_encrypt_with_not_key = 325;
  static const input_self_destructing_add_digital_signature = 326;
  static const error_pgp_select_recipient = 327;
  static const template_self_destructing_message = 328;
  static const template_self_destructing_message_password = 329;
  static const template_self_destructing_message_title = 330;
  static const btn_ok = 331;
  static const hint_self_destructing_supports_plain_text_only = 332;
  static const hint_self_destructing_sent_password_using_different_channel =
      333;
  static const btn_self_destructing = 334;
  static const hint_self_destructing_password_coppied_to_clipboard = 335;
  static const hint_login_upgrade_your_plan = 336;
  static const btn_login_back_to_login = 337;
  static const error_contact_pgp_key_will_not_be_valid = 338;
  static const btn_contact_key_re_import = 339;
  static const btn_contact_delete_key = 340;
  static const label_contact_select_key = 341;
  static const hint_pgp_keys_will_be_import_to_contacts = 342;
  static const hint_pgp_keys_contacts_will_be_created = 343;
  static const hint_pgp_your_keys = 344;
  static const label_pgp_contact_public_keys = 345;
  static const label_message_move_to = 346;
  static const btn_message_move = 347;
  static const label_message_move_to_folder = 348;
  static const btn_message_advanced_search = 349;
  static const label_message_advanced_search = 350;
  static const input_message_search_text = 351;
  static const input_message_search_since = 352;
  static const input_message_search_till = 353;
  static const label_pgp_share_warning = 354;
  static const hint_pgp_share_warning = 355;
  static const btn_vcf_import = 356;
  static const hint_vcf_import = 357;
  static const label_message_headers = 358;
  static const label_forward_as_attachment = 359;
  static const label_contact_with_not_name = 360;
  static const error_user_already_logged = 361;
  static const btn_unread = 362;
  static const btn_read = 363;
  static const btn_show_details = 364;
  static const btn_hide_details = 365;
  static const label_notifications_settings = 366;
  static const label_device_identifier = 367;
  static const label_token_storing_status = 368;
  static const btn_resend_push_token = 369;
  static const label_token_successful = 370;
  static const label_token_failed = 371;
  static const label_device_id_copied_to_clip_board = 372;
  static const label_discard_not_saved_changes = 373;
  static const label_contacts_were_imported_successfully = 374;
  static const label_pgp_encrypt = 375;
  static const hint_auto_encrypt_messages = 376;
  static const btn_log_delete_all = 377;
  static const label_record_log_in_background = 378;
  static const label_show_debug_view = 379;
  static const hint_log_delete_all = 380;
  static const label_enable_uploaded_message_counter = 381;
  static const error_no_pgp_key = 382;
  static const label_contact_pgp_settings = 383;
  static const hint_pgp_message_automatically_encrypt = 384;
  static const btn_not_spam = 385;
  static const error_password_is_empty = 386;
  static const label_encryption_password_for_pgp_key = 387;
  static const debug_hint_log_delete_record = 388;
  static const error_timeout = 389;
  static const fido_error_invalid_key = 390;
  static const tfa_label = 391;
  static const tfa_hint_step = 392;
  static const fido_btn_use_key = 393;
  static const fido_label_connect_your_key = 394;
  static const fido_label_success = 395;
  static const tfa_btn_other_options = 396;
  static const tfa_btn_use_backup_code = 397;
  static const tfa_btn_use_auth_app = 398;
  static const tfa_btn_use_security_key = 399;
  static const tfa_label_hint_security_options = 400;
  static const fido_label_touch_your_key = 401;
  static const fido_hint_follow_the_instructions = 402;
  static const fido_error_title = 403;
  static const fido_error_hint = 404;
  static const fido_btn_try_again = 405;
  static const tfa_input_hint_code_from_app = 406;
  static const tfa_error_invalid_backup_code = 407;
  static const tfa_label_enter_backup_code = 408;
  static const tfa_input_backup_code = 409;
  static const tfa_label_trust_device = 410;
  static const tfa_check_box_trust_device = 411;
  static const tfa_button_continue = 412;
  static const btn_back = 413;
  static const error_message_not_found = 414;
  static const clear_cache_during_logout = 415;
  static const no_permission_to_local_storage = 416;
  static const already_have_key = 417;
  static const hint_log_delete_record = 418;
  static const messages_list_app_bar_Mail = 419;
  String get(int id);
}
