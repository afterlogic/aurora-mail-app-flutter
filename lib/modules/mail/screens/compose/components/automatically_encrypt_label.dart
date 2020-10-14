import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

class AutomaticallyEncryptLabel extends StatefulWidget {
  final List<String> emails;
  final bool value;
  final Function(bool) onChanged;
  final ComposeBloc bloc;

  const AutomaticallyEncryptLabel({
    this.value,
    this.onChanged,
    this.emails,
    this.bloc,
  });

  @override
  _AutomaticallyEncryptLabelState createState() =>
      _AutomaticallyEncryptLabelState();
}

class _AutomaticallyEncryptLabelState extends State<AutomaticallyEncryptLabel> {
  Future<bool> future;
  bool previousResult = false;
  @override
  void didUpdateWidget(covariant AutomaticallyEncryptLabel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.emails.toString() != oldWidget.emails.toString()) {
      future = hasAutomaticallyEncrypt();
    }
  }

  @override
  initState() {
    super.initState();
    future = hasAutomaticallyEncrypt();
  }

  Future<bool> hasAutomaticallyEncrypt() async {
    final emails = widget.emails;
    if (emails.isEmpty) {
      return false;
    }
    for (var emailWithName in emails) {
      String email;
      final match = RegExp("<(.*)?>").firstMatch(emailWithName);
      if (match != null && match.groupCount > 0) {
        email = match.group(1);
      } else {
        email = emailWithName;
      }
      final contacts = await widget.bloc.getContacts(email);

      if (contacts.isNotEmpty) {
        final contact = contacts.firstWhere(
          (element) => element.storage == "personal",
          orElse: () => contacts.first,
        );
        if (contact?.pgpPublicKey != null) {
          if (contact.autoEncrypt || contact.autoSign) {
            return true;
          }
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: future,
      builder: (context, result) {
        if (result.hasData) {
          previousResult = result.data;
        }
        if (previousResult) {
          return _buildLabel();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLabel() {
    final Widget control = Checkbox(
      value: widget.value,
      onChanged: widget.onChanged,
      activeColor: Colors.white,
      checkColor: Color(0xff97C772),
      focusColor: Colors.white,
      hoverColor: Colors.white,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      autofocus: false,
      tristate: false,
    );
    return Container(
      color: Color(0xff97C772),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(unselectedWidgetColor: Colors.white),
                child: control,
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              i18n(context, S.hint_pgp_message_automatically_encrypt),
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
