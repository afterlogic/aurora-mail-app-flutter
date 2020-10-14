import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

extension WebMailApiErrorUtil on WebMailApiError {
  ErrorToShow toShow() {
    if (code != null) {
      return ErrorToShow.code(getErrMsgFromCode(code));
    } else if (message != null) {
      return ErrorToShow.message(message);
    } else {
      return ErrorToShow.code(S.error_unknown);
    }
  }
}

int getErrMsgFromCode(int code) {
  switch (code) {
    case 101:
      return S.error_server_invalid_token;
    case 102:
      return S.error_server_auth_error;
    case 103:
      return S.error_server_invalid_input_parameter;
    case 104:
      return S.error_server_data_base_error;
    case 105:
      return S.error_server_license_problem;
    case 106:
      return S.error_server_demo_account;
    case 107:
      return S.error_server_captcha_error;
    case 108:
      return S.error_server_access_denied;
    case 109:
      return S.error_server_unknown_email;
    case 110:
      return S.error_server_user_not_allowed;
    case 111:
      return S.error_server_user_already_exists;
    case 112:
      return S.error_server_system_not_configured;
    case 113:
      return S.error_server_module_not_found;
    case 114:
      return S.error_server_method_not_found;
    case 115:
      return S.error_server_license_limit;
    case 501:
      return S.error_server_can_not_save_settings;
    case 502:
      return S.error_server_can_not_change_password;
    case 503:
      return S.error_server_account_old_password_not_correct;
    case 601:
      return S.error_server_can_not_create_contact;
    case 602:
      return S.error_server_can_not_create_group;
    case 603:
      return S.error_server_can_not_update_contact;
    case 604:
      return S.error_server_can_not_update_group;
    case 605:
      return S
          .error_server_contact_data_has_been_modified_by_another_application;
    case 607:
      return S.error_server_can_not_get_contact;
    case 701:
      return S.error_server_can_not_create_account;
    case 704:
      return S.error_server_account_exists;
    case 710:
      return S.error_server_rest_other_error;
    case 711:
      return S.error_server_rest_api_disabled;
    case 712:
      return S.error_server_rest_unknown_method;
    case 713:
      return S.error_server_rest_invalid_parameters;
    case 714:
      return S.error_server_rest_invalid_credentials;
    case 715:
      return S.error_server_rest_invalid_token;
    case 716:
      return S.error_server_rest_token_expired;
    case 717:
      return S.error_server_rest_account_find_failed;
    case 719:
      return S.error_server_rest_tenant_find_failed;
    case 801:
      return S.error_server_calendars_not_allowed;
    case 802:
      return S.error_server_files_not_allowed;
    case 803:
      return S.error_server_contacts_not_allowed;
    case 804:
      return S.error_server_helpdesk_user_already_exists;
    case 805:
      return S.error_server_helpdesk_system_user_exists;
    case 806:
      return S.error_server_can_not_create_helpdesk_user;
    case 807:
      return S.error_server_helpdesk_unknown_user;
    case 808:
      return S.error_server_helpdesk_unactivated_user;
    case 810:
      return S.error_server_voice_not_allowed;
    case 811:
      return S.error_server_incorrect_file_extension;
    case 812:
      return S.error_server_can_not_upload_file_quota;
    case 813:
      return S.error_server_file_already_exists;
    case 814:
      return S.error_server_file_not_found;
    case 815:
      return S.error_server_can_not_upload_file_limit;
    case 901:
      return S.error_server_mail_server_error;
    case 999:
      return S.error_unknown;
    default:
      print("ATTENTION! could not get error message for server code: $code");
      return S.error_unknown;
  }
}
