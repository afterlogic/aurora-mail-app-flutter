import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_type_ahead.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentitySelector extends StatefulWidget {
  final String label;
  final String email;
  final bool enable;
  final EdgeInsets padding;
  final Function(AccountIdentityDb identity) onIdentity;

  const IdentitySelector({
    Key key,
    this.label,
    this.email,
    this.enable,
    this.padding,
    this.onIdentity,
  }) : super(key: key);

  @override
  _IdentitySelectorState createState() => _IdentitySelectorState();
}

class _IdentitySelectorState extends State<IdentitySelector> {
  final textCtrl = TextEditingController();
  final focusNode = FocusNode();

  @override
  initState() {
    super.initState();
    if (widget.email != null) {
      textCtrl.text = widget.email;
    } else {
      _setIdentity(BlocProvider.of<AuthBloc>(context).currentIdentity);
    }
  }

  Future<List<AccountIdentityDb>> _buildSuggestions(String _) async {
    final bloc = BlocProvider.of<AuthBloc>(context);
    final contacts = await bloc.getAccountIdentities();

    return contacts;
  }

  Widget _identityItem(AccountIdentityDb entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (entity.friendlyName.isNotEmpty)
          Text(
            entity.friendlyName,
            maxLines: 1,
          ),
        if (entity.email.isNotEmpty)
          Text(
            entity.email,
            maxLines: 1,
          ),
      ],
    );
  }

  _setIdentity(AccountIdentityDb identity) {
    textCtrl.text = identityViewName(identity.friendlyName, identity.email);
    widget.onIdentity(identity);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final dropDownWidth = screenWidth / 1.25;
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.enable ? null : theme.disabledColor.withAlpha(20),
      ),
      child: InkWell(
        onTap: widget.enable ? focusNode.requestFocus : null,
        child: ComposeTypeAheadField<AccountIdentityDb>(
          textFieldConfiguration: TextFieldConfiguration(
            focusNode: focusNode,
            enabled: widget.enable,
            controller: textCtrl,
          ),
          animationDuration: Duration.zero,
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: Theme.of(context).cardColor,
            constraints: BoxConstraints(
              minWidth: dropDownWidth,
              maxWidth: dropDownWidth,
            ),
          ),
          suggestionsBoxVerticalOffset: 0.0,
          suggestionsBoxHorizontalOffset: screenWidth - dropDownWidth - 16 * 2,
          autoFlipDirection: true,
          hideOnLoading: true,
          keepSuggestionsOnLoading: true,
          getImmediateSuggestions: true,
          noItemsFoundBuilder: (_) => SizedBox(),
          suggestionsCallback: _buildSuggestions,
          itemBuilder: (_, c) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: _identityItem(c),
            );
          },
          onSuggestionSelected: (item) {
            return _setIdentity(item);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    focusNode: focusNode,
                    controller: textCtrl,
                    decoration: InputDecoration.collapsed(
                      hintText: null,
                    ),
                    onEditingComplete: focusNode.unfocus,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
