import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/generate_key_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_from_text_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/key_request_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_key_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_keys_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_navigator.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PgpSettings extends StatefulWidget {
  final PgpSettingsBloc pgpSettingsBloc;

  const PgpSettings(this.pgpSettingsBloc);

  @override
  _PgpSettingsState createState() => _PgpSettingsState();
}

class _PgpSettingsState extends BState<PgpSettings> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  PgpSettingsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.pgpSettingsBloc;
    bloc.add(LoadKeys());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      key: _scaffoldKey,
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text(i18n(context, S.label_pgp_settings)),
            ),
      body: BlocListener<PgpSettingsBloc, PgpSettingsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SelectKeyForImport) {
            _importKey(state.userKeys, state.contactKeys);
            return;
          }
          if (state is ErrorState) {
            showErrorSnack(
              context: context,
              scaffoldState: Scaffold.of(context),
              msg: state.message,
            );
            return;
          }
          if (state is CompleteDownload) {
            showSnack(
              isError: false,
              context: context,
              scaffoldState: Scaffold.of(context),
              message: i18n(context, S.label_pgp_downloading_to,
                  {"path": state.filePath}),
            );
            return;
          }
        },
        child: BlocBuilder<PgpSettingsBloc, PgpSettingsState>(
          bloc: bloc,
          condition: (current, next) {
            return next is ProgressState || next is LoadedState;
          },
          builder: (BuildContext context, PgpSettingsState state) {
            if (state is ProgressState) {
              return _progress();
            }
            final loadedState = state as LoadedState;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _keys(
                    context,
                    loadedState.myPublic,
                    loadedState.myPrivate,
                    loadedState.contactPublic,
                    loadedState.keyProgress,
                  ),
                ),
                _buttons(context, loadedState),
              ],
            );
          },
        ),
      ),
    );
  }

  _generateKey(LoadedState state) async {
    final exist = <String>{};
    exist.addAll(state.myPrivate.map((item) => item.mail));
    exist.addAll(state.myPublic.map((item) => item.mail));

    final authBloc = BlocProvider.of<AuthBloc>(context);
    var aliasesOrIdentities = await authBloc.getAliasesAndIdentities(true);
    var current = AliasOrIdentity(null, authBloc.currentIdentity);

    var notExist = aliasesOrIdentities.where((item) {
      return !exist.contains(item.mail);
    }).toList();
    if (exist.contains(current.mail)) {
      if (notExist.isEmpty) {
        current = null;
        showSnack(
            isError: false,
            context: context,
            scaffoldState: _scaffoldKey.currentState,
            message: i18n(context, S.already_have_key));
        return;
      } else {
        current = notExist.first;
      }
    }

    final result = await showDialog(
      context: context,
      builder: (_) => GenerateKeyDialog(notExist, current),
    );
    if (result is GenerateKeyDialogResult) {
      bloc.add(GenerateKeys(
        result.alias.name,
        result.alias.mail,
        result.length,
        result.password,
      ));
    }
  }

  _openKey(
    BuildContext context,
    PgpKey key, [
    bool needPassword = false,
  ]) async {
    if (needPassword) {
      final password = await KeyRequestDialog.request(context, key.key);
      if (password == null) {
        return;
      }
    }
    SettingsNavigatorWidget.of(context).pushNamed(
      PgpKeyRoute.name,
      arguments: PgpKeyRouteArg(key, null, false, bloc),
    );
  }

  _importKey(Map<PgpKey, bool> userKeys,
      Map<PgpKeyWithContact, bool> contactKeys) async {
    await showDialog(
      context: context,
      builder: (_) => ImportKeyDialog(userKeys, contactKeys, bloc),
    );
  }

  _importFromText() async {
    final result = await showDialog(
      context: context,
      builder: (_) => ImportFromTextDialog(),
    );
    if (result is String) {
      bloc.add(ParseKey(result));
    }
  }

  _importFromFile() async {
    bloc.add(ImportFromFile());
  }

  _exportAllPublicKeys(List<PgpKey> keys) {
    SettingsNavigatorWidget.of(context).pushNamed(
      PgpKeysRoute.name,
      arguments: PgpKeysRouteArg(keys, bloc),
    );
  }

  Widget _progress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _keys(
    BuildContext context,
    List<PgpKey> public,
    List<PgpKey> private,
    List<PgpKey> contactPublic,
    String keyProgress,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        if (public.isNotEmpty || keyProgress != null)
          Text(
            i18n(context, S.label_pgp_public_keys),
            style: theme.textTheme.headline6,
          ),
        keysGroup(
          context,
          public,
          keyProgress,
        ),
        SizedBox(height: 10),
        if (private.isNotEmpty || keyProgress != null)
          Text(
            i18n(context, S.label_pgp_private_keys),
            style: theme.textTheme.headline6,
          ),
        keysGroup(
          context,
          private,
          keyProgress,
          true,
        ),
        if (!BuildProperty.legacyPgpKey) ...[
          SizedBox(height: 10),
          if (contactPublic.isNotEmpty)
            Text(
              i18n(context, S.label_pgp_contact_public_keys),
              style: theme.textTheme.headline6,
            ),
          keysGroup(
            context,
            contactPublic,
            null,
          ),
        ]
      ],
    );
  }

  Widget keysGroup(
    BuildContext context,
    List<PgpKey> keys,
    String keyProgress, [
    bool needPassword = false,
  ]) {
    final List<Widget> widgets = keys
        .map<Widget>(
          (key) => InkWell(
            onTap: () => _openKey(context, key, needPassword),
            child: _key(
              key.formatName(),
              false,
            ),
          ),
        )
        .toList();
    if (keyProgress != null) {
      widgets.insert(0, _key(keyProgress, true));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _key(String text, bool isProgress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(text),
              ),
              isProgress
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context, LoadedState state) {
    final isTablet = LayoutConfig.of(context).isTablet;
    final space = isTablet
        ? SizedBox.shrink()
        : SizedBox(
            height: 10.0,
            width: 10,
          );
    final children = <Widget>[
      if (state.contactPublic.isNotEmpty)
        AMButton(
          child: Text(i18n(context, S.btn_pgp_export_all_public_keys)),
          onPressed: () => _exportAllPublicKeys(state.contactPublic),
        ),
      space,
      AMButton(
        child: Text(i18n(context, S.btn_pgp_import_keys_from_text)),
        onPressed: _importFromText,
      ),
      space,
      AMButton(
        child: Text(i18n(context, S.btn_pgp_import_keys_from_file)),
        onPressed: _importFromFile,
      ),
      space,
      AMButton(
        child: Text(i18n(context, S.btn_pgp_generate_keys)),
        onPressed: () => _generateKey(state),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: isTablet
          ? Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: children,
              ),
            )
          : SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children),
            ),
    );
  }
}
