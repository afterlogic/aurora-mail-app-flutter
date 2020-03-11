import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_type_ahead.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentitySelector extends StatefulWidget {
  final String label;
  final TextEditingController textCtrl;
  final bool enable;
  final EdgeInsets padding;
  final Function(AliasOrIdentity identity) onIdentity;

  const IdentitySelector({
    Key key,
    this.label,
    this.enable,
    this.padding,
    this.onIdentity,
    this.textCtrl,
  }) : super(key: key);

  @override
  _IdentitySelectorState createState() => _IdentitySelectorState();
}

class _IdentitySelectorState extends BState<IdentitySelector> {
  final focusNode = FocusNode();

  Future<List<AliasOrIdentity>> _buildSuggestions(String _) async {
    final bloc = BlocProvider.of<AuthBloc>(context);

    return await bloc.getAliasesAndIdentities();
  }

  Widget _identityItem(AliasOrIdentity entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (entity.name.isNotEmpty)
          Text(
            entity.name,
            maxLines: 1,
          ),
        if (entity.mail.isNotEmpty)
          Text(
            entity.mail,
            maxLines: 1,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final dropDownWidth = screenWidth / 1.25;
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.enable ? null : theme.disabledColor.withAlpha(20),
      ),
      child: InkWell(
        onTap: widget.enable ? focusNode.requestFocus : null,
        child: ComposeTypeAheadField<AliasOrIdentity>(
          textFieldConfiguration: TextFieldConfiguration(
            focusNode: focusNode,
            enabled: widget.enable,
            controller: widget.textCtrl,
          ),
          animationDuration: Duration.zero,
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: theme.cardColor,
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
            return widget.onIdentity(item);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Text(
                    widget.label,
                    style: theme.textTheme.subhead,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    focusNode: focusNode,
                    controller: widget.textCtrl,
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
