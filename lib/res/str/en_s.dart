// //@dart=2.9
// import "s.dart";
//
// class EnS extends S {
//   final _map = <int, String>{
//     S.app_title: "Mail Client",
//     S.login_input_host: "Host",
//     S.login_input_email: "Email",
//     S.login_input_password: "Password",
//     S.login_to_continue: "Log in to continue",
//     S.folders_empty: "No folders",
//     S.folders_inbox: "Inbox",
//     S.folders_starred: "Starred",
//     S.folders_sent: "Sent",
//     S.folders_drafts: "Drafts",
//     S.folders_spam: "Spam",
//     S.folders_trash: "Trash",
//     S.messages_reply: "Reply",
//     S.messages_reply_all: "Reply to all",
//     S.messages_forward: "Forward",
//     S.messages_empty: "No messages",
//     S.messages_filter_unread: "Unread messages:",
//     S.messages_delete_title: "Delete message",
//     S.messages_delete_title_with_count: "Delete messages",
//     S.messages_delete_desc_with_subject:
//         "Are you sure you want to delete {subject}?",
//     S.messages_delete_desc: "Are you sure you want to delete this message?",
//     S.messages_delete_desc_with_count:
//         "Are you sure you want to delete these messages?",
//     S.messages_list_app_bar_mail: "Mail",
//     S.messages_list_app_bar_contacts: "Contacts",
//     S.messages_list_app_bar_settings: "Settings",
//     S.messages_list_app_bar_logout: "Log out",
//     S.messages_list_app_bar_search: "Search",
//     S.messages_list_app_bar_loading_folders: "Loading folders...",
//     S.messages_show_details: "Show details",
//     S.messages_images_security_alert:
//         "Pictures in this message have been blocked for your safety.",
//     S.messages_show_images: "Show pictures.",
//     S.messages_always_show_images:
//         "Always show pictures in messages from this sender.",
//     S.messages_view_tab_attachments: "Attachments",
//     S.messages_view_tab_message_body: "Message body",
//     S.messages_to: "To",
//     S.messages_from: "From",
//     S.messages_cc: "CC",
//     S.messages_bcc: "BCC",
//     S.messages_subject: "Subject",
//     S.messages_no_subject: "No subject",
//     S.messages_to_me: "To me",
//     S.messages_no_receivers: "No recipients",
//     S.messages_unknown_sender: "No sender",
//     S.messages_unknown_recipient: "No recipient",
//     S.messages_sending: "Sending message...",
//     S.messages_saved_in_drafts: "Message saved in drafts",
//     S.messages_attachments_empty: "No attachments",
//     S.messages_attachment_delete: "Delete attachment",
//     S.messages_attachment_download: "Download attachment",
//     S.messages_attachment_downloading: "Downloading {fileName}...",
//     S.messages_attachment_download_failed: "Download failed",
//     S.messages_attachment_download_cancel: "Cancel download",
//     S.messages_attachment_download_success: "File downloaded into: {path}",
//     S.messages_attachment_upload: "Upload attachment",
//     S.messages_attachment_uploading: "Uploading {fileName}...",
//     S.messages_attachment_upload_failed: "Upload failed",
//     S.messages_attachment_upload_cancel: "Cancel upload",
//     S.messages_attachment_upload_success: "File uploaded into: {path}",
//     S.compose_body_placeholder: "Message text...",
//     S.compose_forward_body_original_message: "---- Original Message ----",
//     S.compose_forward_from: "From: {emails}",
//     S.compose_forward_to: "To: {emails}",
//     S.compose_forward_cc: "CC: {emails}",
//     S.compose_forward_bcc: "BCC: {emails}",
//     S.compose_forward_sent: "Sent: {date}",
//     S.compose_forward_subject: "Subject: {subject}",
//     S.compose_reply_body_title: "On {time}, {from} wrote:",
//     S.compose_discard_save_dialog_title: "Discard changes",
//     S.compose_discard_save_dialog_description: "Save changes in drafts?",
//     S.contacts: "Contacts",
//     S.contacts_list_app_bar_view_group: "View group",
//     S.contacts_list_app_bar_all_contacts: "All contacts",
//     S.contacts_list_its_me_flag: "It's me!",
//     S.contacts_empty: "No contacts",
//     S.contacts_groups_empty: "No groups",
//     S.contacts_email_empty: "No email address",
//     S.contacts_drawer_section_storages: "Storages",
//     S.contacts_drawer_storage_all: "All",
//     S.contacts_drawer_storage_personal: "Personal",
//     S.contacts_drawer_storage_team: "Team",
//     S.contacts_drawer_storage_shared: "Shared with all",
//     S.contacts_drawer_section_groups: "Groups",
//     S.contacts_view_app_bar_share: "Share",
//     S.contacts_view_app_bar_unshare: "Unshare",
//     S.contacts_view_app_bar_attach: "Send",
//     S.contacts_view_app_bar_send_message: "Email to this contact",
//     S.contacts_view_app_bar_search_messages: "Search messages",
//     S.contacts_view_app_bar_edit_contact: "Edit",
//     S.contacts_view_app_bar_delete_contact: "Delete",
//     S.contacts_shared_message:
//         "{contact} will soon appear in {storage} storage",
//     S.contacts_group_view_app_bar_send_message:
//         "Email to the contacts in this group",
//     S.contacts_group_view_app_bar_delete: "Delete this group",
//     S.contacts_group_view_app_bar_edit: "Edit group",
//     S.contacts_view_show_additional_fields: "Show additional fields",
//     S.contacts_view_hide_additional_fields: "Hide additional fields",
//     S.contacts_view_section_home: "Home",
//     S.contacts_view_section_personal: "Personal",
//     S.contacts_view_section_business: "Business",
//     S.contacts_view_section_other_info: "Other",
//     S.contacts_view_section_group_name: "Group Name",
//     S.contacts_view_section_groups: "Groups",
//     S.contacts_view_display_name: "Display name",
//     S.contacts_view_email: "Email",
//     S.contacts_view_personal_email: "Personal email",
//     S.contacts_view_business_email: "Business email",
//     S.contacts_view_other_email: "Other email",
//     S.contacts_view_phone: "Phone",
//     S.contacts_view_personal_phone: "Personal Phone",
//     S.contacts_view_business_phone: "Business Phone",
//     S.contacts_view_mobile: "Mobile",
//     S.contacts_view_fax: "Fax",
//     S.contacts_view_address: "Address",
//     S.contacts_view_personal_address: "Personal Address",
//     S.contacts_view_business_address: "Business Address",
//     S.contacts_view_skype: "Skype",
//     S.contacts_view_facebook: "Facebook",
//     S.contacts_view_name: "Name",
//     S.contacts_view_first_name: "First name",
//     S.contacts_view_last_name: "Last name",
//     S.contacts_view_nickname: "Nickname",
//     S.contacts_view_street_address: "Street",
//     S.contacts_view_city: "City",
//     S.contacts_view_province: "State/Province",
//     S.contacts_view_country: "Country/Region",
//     S.contacts_view_zip: "Zip Code",
//     S.contacts_view_web_page: "Web Page",
//     S.contacts_view_company: "Company",
//     S.contacts_view_department: "Department",
//     S.contacts_view_job_title: "Job Title",
//     S.contacts_view_office: "Office",
//     S.contacts_view_birthday: "Birthday",
//     S.contacts_view_notes: "Notes",
//     S.contacts_edit: "Edit contact",
//     S.contacts_edit_cancel: "Cancel editing contact",
//     S.contacts_edit_save: "Save changes",
//     S.contacts_add: "Add contact",
//     S.contacts_group_add: "Add group",
//     S.contacts_group_edit: "Edit group",
//     S.contacts_group_edit_is_organization: "This group is a Company",
//     S.contacts_group_edit_cancel: "Cancel editing group",
//     S.contacts_delete_title: "Delete contact",
//     S.contacts_delete_desc_with_name:
//         "Are you sure you want to delete {contact}?",
//     S.contacts_group_delete_title: "Delete group",
//     S.contacts_group_delete_desc_with_name:
//         "Are you sure you want to delete {group}? The contacts of this group will not be deleted.",
//     S.settings: "Settings",
//     S.settings_common: "Common",
//     S.settings_24_time_format: "24 hour format",
//     S.settings_language: "Language",
//     S.settings_language_system: "System language",
//     S.settings_dark_theme: "App theme",
//     S.settings_dark_theme_system: "System theme",
//     S.settings_dark_theme_dark: "Dark",
//     S.settings_dark_theme_light: "Light",
//     S.settings_sync: "Sync",
//     S.settings_sync_frequency: "Sync frequency",
//     S.settings_sync_frequency_never: "never",
//     S.settings_sync_frequency_minutes5: "5 minutes",
//     S.settings_sync_frequency_minutes30: "30 minutes",
//     S.settings_sync_frequency_hours1: "1 hour",
//     S.settings_sync_frequency_hours2: "2 hours",
//     S.settings_sync_frequency_daily: "daily",
//     S.settings_sync_frequency_monthly: "monthly",
//     S.settings_sync_period: "Sync period",
//     S.settings_sync_period_all_time: "all time",
//     S.settings_sync_period_months1: "1 month",
//     S.settings_sync_period_months3: "3 months",
//     S.settings_sync_period_months6: "6 months",
//     S.settings_sync_period_years1: "1 year",
//     S.settings_accounts_manage: "Manage accounts",
//     S.settings_accounts_add: "Add new account",
//     S.settings_accounts_relogin: "Relogin to account",
//     S.settings_accounts_delete: "Delete account",
//     S.settings_accounts_delete_description:
//         "Are you sure you want to logout and delete {account}?",
//     S.settings_about: "About",
//     S.settings_about_app_version: "Version {version}",
//     S.settings_about_terms_of_service: "Terms of Service",
//     S.settings_about_privacy_policy: "Privacy policy",
//     S.btn_login: "Login",
//     S.btn_delete: "Delete",
//     S.btn_show_email_in_light_theme: "Show email in light theme",
//     S.btn_cancel: "Cancel",
//     S.btn_close: "Close",
//     S.btn_to_spam: "To spam",
//     S.btn_save: "Save",
//     S.btn_discard: "Discard",
//     S.btn_add_account: "Add account",
//     S.btn_show_all: "Show all",
//     S.error_login_input_hostname: "Please enter hostname",
//     S.error_login_input_email: "Please enter email",
//     S.error_login_input_password: "Please enter password",
//     S.error_login_auto_discover:
//         "Could not detect domain from this email, please specify your server URL manually.",
//     S.error_login_no_accounts: "This user doesn't have mail accounts",
//     S.error_login_account_exists:
//         "This account already exists in your accounts list.",
//     S.error_compose_no_receivers: "Please provide recipients",
//     S.error_compose_wait_attachments:
//         "Please wait until attachments are uploaded",
//     S.error_contacts_save_name_empty: "Please specify the name",
//     S.error_contacts_email_empty: "Please specify an email",
//     S.error_connection: "Could not connect to the server",
//     S.error_connection_offline: "You're offline",
//     S.error_input_validation_empty: "This field is required",
//     S.error_input_validation_email: "The email is not valid",
//     S.error_input_validation_name_illegal_symbol:
//         "The name cannot contain \"/\\*?<>|:\"",
//     S.error_input_validation_unique_name: "This name already exists",
//     S.error_server_invalid_token: "Invalid token",
//     S.error_server_auth_error: "Invalid email/password",
//     S.error_server_invalid_input_parameter: "Invalid input parameter",
//     S.error_server_data_base_error: "Database error",
//     S.error_server_license_problem: "License problem",
//     S.error_server_demo_account: "Demo account",
//     S.error_server_captcha_error: "Captcha error",
//     S.error_server_access_denied: "Access denied",
//     S.error_server_unknown_email: "Unknown email",
//     S.error_server_user_not_allowed: "User is not allowed",
//     S.error_server_user_already_exists: "Such user already exists",
//     S.error_server_system_not_configured: "System is not configured",
//     S.error_server_module_not_found: "Module not found",
//     S.error_server_method_not_found: "Method not found",
//     S.error_server_license_limit: "License limit",
//     S.error_server_can_not_save_settings: "Cannot save settings",
//     S.error_server_can_not_change_password: "Cannot change password",
//     S.error_server_account_old_password_not_correct:
//         "Account's old password is not correct",
//     S.error_server_can_not_create_contact: "Cannot create contact",
//     S.error_server_can_not_create_group: "Cannot create group",
//     S.error_server_can_not_update_contact: "Cannot update contact",
//     S.error_server_can_not_update_group: "Cannot update group",
//     S.error_server_contact_data_has_been_modified_by_another_application:
//         "Contact data has been modified by another application",
//     S.error_server_can_not_get_contact: "Cannot get contact",
//     S.error_server_can_not_create_account: "Cannot create account",
//     S.error_server_account_exists: "Such account already exists",
//     S.error_server_rest_other_error: "Rest other error",
//     S.error_server_rest_api_disabled: "Rest api disabled",
//     S.error_server_rest_unknown_method: "Rest unknown method",
//     S.error_server_rest_invalid_parameters: "Rest invalid parameters",
//     S.error_server_rest_invalid_credentials: "Rest invalid credentials",
//     S.error_server_rest_invalid_token: "Rest invalid token",
//     S.error_server_rest_token_expired: "Rest token expired",
//     S.error_server_rest_account_find_failed: "Rest account lookup failed",
//     S.error_server_rest_tenant_find_failed: "Rest tenant lookup failed",
//     S.error_server_calendars_not_allowed: "Calendars not allowed",
//     S.error_server_files_not_allowed: "Files not allowed",
//     S.error_server_contacts_not_allowed: "Contacts not allowed",
//     S.error_server_helpdesk_user_already_exists: "Helpdesk user already exists",
//     S.error_server_helpdesk_system_user_exists:
//         "Helpdesk system user already exists",
//     S.error_server_can_not_create_helpdesk_user: "Cannot create helpdesk user",
//     S.error_server_helpdesk_unknown_user: "Helpdesk unknown user",
//     S.error_server_helpdesk_unactivated_user: "Helpdesk deactivated user",
//     S.error_server_voice_not_allowed: "Voice not allowed",
//     S.error_server_incorrect_file_extension: "Incorrect file extension",
//     S.error_server_can_not_upload_file_quota:
//         "You have reached your cloud storage space limit. Can't upload file.",
//     S.error_server_file_already_exists: "Such file already exists",
//     S.error_server_file_not_found: "File not found",
//     S.error_server_can_not_upload_file_limit: "Cannot upload due to file limit",
//     S.error_server_mail_server_error: "Mail server error",
//     S.error_unknown: "Unknown error",
//     S.format_compose_forward_date: "EEE, MMM d, yyyy, HH:mm",
//     S.format_compose_reply_date: "EEE, MMM d, yyyy 'at' HH:mm",
//     S.format_contacts_birth_date: "MMM d, yyyy",
//     S.label_message_yesterday: "Yesterday",
//     S.hint_2fa:
//         "Your account is protected with\nTwo Factor Authentication.\nPlease provide the PIN code.",
//     S.input_2fa_pin: "Verification code",
//     S.btn_verify_pin: "Verify",
//     S.error_invalid_pin: "Invalid code",
//     S.btn_done: "Done",
//     S.hint_confirm_exit: "Are you sure want to exit?",
//     S.btn_exit: "Exit",
//     S.label_pgp_settings: "OpenPGP",
//     S.label_pgp_public_keys: "Public keys",
//     S.label_pgp_private_keys: "Private keys",
//     S.btn_pgp_export_all_public_keys: "Export all public keys",
//     S.btn_pgp_import_keys_from_text: "Import keys from text",
//     S.btn_pgp_import_keys_from_file: "Import keys from file",
//     S.btn_pgp_import_from_text: "Import from text",
//     S.btn_pgp_import_from_file: "Import from file",
//     S.btn_pgp_generate_keys: "Generate keys",
//     S.btn_pgp_generate: "Generate",
//     S.label_length: "Length",
//     S.btn_download: "Download",
//     S.btn_share: "Share",
//     S.label_pgp_public_key: "Public key",
//     S.label_pgp_private_key: "Private key",
//     S.label_pgp_import_key: "Import keys",
//     S.btn_pgp_import_selected_key: "Import selected keys",
//     S.btn_pgp_check_keys: "Check keys",
//     S.error_pgp_keys_not_found: "Keys not found",
//     S.label_pgp_all_public_key: "All public keys",
//     S.btn_pgp_download_all: "Download all",
//     S.btn_php_send_all: "Send all",
//     S.label_pgp_downloading_to: "Downloading to {path}",
//     S.hint_pgp_delete_user_key_confirm:
//         "Are you sure you want to delete OpenPGP key for {user}?",
//     S.btn_pgp_sign_or_encrypt: "Sign/Encrypt",
//     S.label_pgp_sign_or_encrypt: "Open PGP Sign/Encrypt",
//     S.label_pgp_decrypt: "Open PGP Decrypt",
//     S.label_pgp_sign: "Sign",
//     S.btn_pgp_encrypt: "Encrypt",
//     S.btn_pgp_decrypt: "Decrypt",
//     S.error_pgp_invalid_password: "invalid password",
//     S.error_pgp_not_found_keys_for: "No private key found for {users} user.",
//     S.btn_pgp_undo_pgp: "Undo PGP",
//     S.label_pgp_verified: "Message was successfully verified.",
//     S.label_pgp_not_verified: "Message wasn't verified.",
//     S.label_pgp_decrypted_and_verified:
//         "Message was successfully decrypted and verified.",
//     S.label_pgp_decrypted_but_not_verified:
//         "Message was successfully decrypted but wasn't verified.",
//     S.error_pgp_invalid_key_or_password: "Invalid key or password.",
//     S.error_pgp_can_not_decrypt: "Cannot decrypt message.",
//     S.error_pgp_need_contact_for_encrypt:
//         "To encrypt your message you need to specify at least one recipient.",
//     S.button_pgp_verify_sign: "Verify",
//     S.hint_pgp_already_have_keys:
//         "Keys which are already in the system are greyed out.",
//     S.btn_contact_find_in_email: "Find in email",
//     S.btn_message_resend: "Resend",
//     S.btn_message_empty_trash_folder: "Empty Trash",
//     S.btn_message_empty_spam_folder: "Empty Spam",
//     S.hint_message_empty_folder:
//         "Are you sure you want to delete all messages in folder {folder}?",
//     S.label_self_destructing: "Send a self-destructing secure email",
//     S.self_destructing_life_time_day: "24 hours",
//     S.self_destructing_life_time_days_3: "72 hours",
//     S.self_destructing_life_time_days_7: "7 days",
//     S.message_lifetime: "Message lifetime",
//     S.label_pgp_key_with_not_name: "No name",
//     S.label_self_destructing_not_sign_data: "Will not sign the data.",
//     S.label_self_destructing_sign_data:
//         "Will sign the data with your private key.",
//     S.input_self_destructing_password_based_encryption: "Password-based",
//     S.input_self_destructing_key_based_encryption: "Key-based",
//     S.label_self_destructing_password_based_encryption_used:
//         "The Password-based encryption will be used.",
//     S.label_self_destructing_key_based_encryption_used:
//         "The Key-based encryption will be used.",
//     S.hint_self_destructing_encrypt_with_key:
//         "Selected recipient has PGP public key. The message can be encrypted using this key.",
//     S.hint_self_destructing_encrypt_with_not_key:
//         "Selected recipient has no PGP public key. The key-based encryption is not allowed",
//     S.input_self_destructing_add_digital_signature: "Add digital signature",
//     S.error_pgp_select_recipient: "Select recipient",
//     S.template_self_destructing_message:
//         "Hello,\n{sender} user sent you a self-destructing secure email.\nYou can read it using the following link:\n{link}\n{message_password}The message will be accessible for {lifeTime} starting from {now}",
//     S.template_self_destructing_message_password:
//         "The message is password-protected. The password is: {password}\n",
//     S.template_self_destructing_message_title:
//         "The secure message was shared with you",
//     S.btn_ok: "Ok",
//     S.hint_self_destructing_supports_plain_text_only:
//         "The self-descructing secure emails support plain text only. All the formatting will be removed. Also, attachments cannot be encrypted and will be removed from the message.",
//     S.hint_self_destructing_sent_password_using_different_channel:
//         "The password must be sent using a different channel.\n  Store the password somewhere. You will not be able to recover it otherwise.",
//     S.btn_self_destructing: "Self-destructing",
//     S.hint_self_destructing_password_coppied_to_clipboard:
//         "Password coppied to clipboard",
//     S.hint_login_upgrade_your_plan:
//         "Mobile apps are not allowed in your account.",
//     S.btn_login_back_to_login: "Back to login",
//     S.error_contact_pgp_key_will_not_be_valid: "The PGP key will not be valid",
//     S.btn_contact_key_re_import: "Re import",
//     S.btn_contact_delete_key: "Delete Key",
//     S.label_contact_select_key: "Select key",
//     S.hint_pgp_keys_will_be_import_to_contacts:
//         "The keys will be imported to contacts",
//     S.hint_pgp_keys_contacts_will_be_created:
//         "For these keys contacts will be created",
//     S.hint_pgp_your_keys: "Your keys",
//     S.label_pgp_contact_public_keys: "External public keys",
//     S.label_message_move_to: "Move to: ",
//     S.btn_message_move: "Move",
//     S.label_message_move_to_folder: "Move to folder",
//     S.btn_message_advanced_search: "Advanced search",
//     S.label_message_advanced_search: "Advanced search",
//     S.input_message_search_text: "Text",
//     S.input_message_search_since: "Since",
//     S.input_message_search_till: "Till",
//     S.label_pgp_share_warning: "Warning",
//     S.hint_pgp_share_warning:
//         "You are going to share your private PGP key. The key must be kept from the 3rd parties. Do you want to continue?",
//     S.btn_vcf_import: "Import",
//     S.hint_vcf_import: "Import contact from vcf?",
//     S.label_message_headers: "View message headers",
//     S.label_forward_as_attachment: "Forward as attachment",
//     S.label_contact_with_not_name: "No name",
//     S.error_user_already_logged: "This user is already logged in",
//     S.btn_unread: "Unread",
//     S.btn_read: "Read",
//     S.btn_show_details: "Show details",
//     S.btn_hide_details: "Hide details",
//     S.label_notifications_settings: "Notifications",
//     S.label_device_identifier: "Device identifier",
//     S.label_token_storing_status: "Token storing status",
//     S.btn_resend_push_token: "Resend Push Token",
//     S.label_token_successful: "Successful",
//     S.label_token_failed: "Failed",
//     S.label_device_id_copied_to_clip_board: "Device id copied to clipboard",
//     S.label_discard_not_saved_changes: "Discard unsaved changes?",
//     S.label_contacts_were_imported_successfully:
//         "Contacts imported successfully",
//     S.label_pgp_encrypt: "Encrypt",
//     S.hint_auto_encrypt_messages:
//         "If you want messages to this contact to be automatically encrypted and/or signed, check the boxes below. Please note that these messages will be converted to plain text. Attachments will not be encrypted.",
//     S.btn_log_delete_all: "Delete all",
//     S.label_record_log_in_background: "Record log in background",
//     S.label_show_debug_view: "Show debug view",
//     S.hint_log_delete_all: "Are you sure you want to delete all logs?",
//     S.label_enable_uploaded_message_counter: "Counter of uploaded message",
//     S.error_no_pgp_key: "No PGP public key was found",
//     S.label_contact_pgp_settings: "PGP Settings",
//     S.hint_pgp_message_automatically_encrypt:
//         "The message will be automatically encrypted and/or signed for contacts with OpenPgp keys.\n OpenPGP supports plain text only. All the formatting will be removed before encryption.",
//     S.btn_not_spam: "Not spam",
//     S.error_password_is_empty: "password is empty",
//     S.label_encryption_password_for_pgp_key: "Required password for PGP key",
//     S.debug_hint_log_delete_record: "Are you sure you want to delete the file?",
//     S.error_timeout: "Can't connect to the server",
//     S.fido_error_invalid_key: "Invalid security key",
//     S.tfa_label: "Two Factor Verification",
//     S.tfa_hint_step:
//         "This extra step is intended to confirm it’s really you trying to sign in",
//     S.fido_btn_use_key: "Use security key",
//     S.fido_label_connect_your_key:
//         "Please scan your security key or insert it to the device",
//     S.fido_label_success: "Success",
//     S.tfa_btn_other_options: "Other options",
//     S.tfa_btn_use_backup_code: "Use Backup code",
//     S.tfa_btn_use_auth_app: "Use Authenticator app",
//     S.tfa_btn_use_security_key: "Use your Security key",
//     S.tfa_label_hint_security_options: "Security options available",
//     S.fido_label_touch_your_key: "Touch you security key",
//     S.fido_hint_follow_the_instructions:
//         "Please follow the instructions in the popup dialog",
//     S.fido_error_title: "There was a problem",
//     S.fido_error_hint:
//         "Try using your security key again or try another way to verify it's you",
//     S.fido_btn_try_again: "Try again",
//     S.tfa_input_hint_code_from_app:
//         "Specify verification code from the Authenticator app",
//     S.tfa_error_invalid_backup_code: "Invalid backup code",
//     S.tfa_label_enter_backup_code: "Enter one of your 8-character backup codes",
//     S.tfa_input_backup_code: "Backup code",
//     S.tfa_label_trust_device: "You're all set",
//     S.tfa_check_box_trust_device:
//         "Don't ask again on this device for {daysCount} days",
//     S.tfa_button_continue: "Continue",
//     S.btn_back: "Back",
//     S.error_message_not_found: "Message not found",
//     S.clear_cache_during_logout: "Delete cached data and keys",
//     S.no_permission_to_local_storage:
//         "No permission to access the local storage. Check your device settings.",
//     S.already_have_key: "You already have a public or private key",
//     S.hint_pgp_keys_for_import: "Keys that are available for import",
//     S.hint_pgp_existed_keys:
//         "Keys that are already in the system will not be imported",
//     S.hint_pgp_external_private_keys:
//         "External private keys are not supported and will not be imported",
//   };
//   String get(int id) => _map[id];
// }
