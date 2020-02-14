import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/generate_key_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_from_text_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_key_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_keys_route.dart';
import 'package:aurora_mail/shared_ui/app_button.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PgpSettings extends StatefulWidget {
  @override
  _PgpSettingsState createState() => _PgpSettingsState();
}

class _PgpSettingsState extends State<PgpSettings> {
  PgpSettingsBloc bloc = AppInjector.instance.pgpSettingsBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(LoadKeys());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(i18n(context, "pgp_settings"))),
      body: BlocListener<PgpSettingsBloc, PgpSettingsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SelectKeyForImport) {
            _importKey(state.keys);
            return;
          }
          if (state is ErrorState) {
            showSnack(
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
              msg: "downloading_to",
              suffix: state.filePath,
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

            return ListView(
              children: <Widget>[
                _keys(
                  context,
                  loadedState.public,
                  loadedState.private,
                  loadedState.keyProgress,
                ),
                _button(context, loadedState.public),
              ],
            );
          },
        ),
      ),
    );
  }

  _generateKey() async {
    final email = BlocProvider.of<AuthBloc>(context).currentAccount.email;

    final result = await showDialog(
      context: context,
      builder: (_) => GenerateKeyDialog(email),
    );
    if (result is GenerateKeyDialogResult) {
      bloc.add(GenerateKeys(result.mail, result.length, result.password));
    }
  }

  _openKey(BuildContext context, PgpKey key) {
    Navigator.pushNamed(
      context,
      PgpKeyRoute.name,
      arguments: PgpKeyRouteArg(key, bloc),
    );
  }

  _importKey(Map<PgpKey, bool> keys) async {
    final result = await showDialog(
      context: context,
      builder: (_) => ImportKeyDialog(keys),
    );

    if (result is Map<PgpKey, bool>) {
      bloc.add(ImportKey(result));
    }
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
    Navigator.pushNamed(
      context,
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
    String keyProgress,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (public.isNotEmpty || keyProgress != null)
            Text(
              i18n(context, "public_keys"),
              style: theme.textTheme.title,
            ),
          keysGroup(
            context,
            public,
            keyProgress,
          ),
          SizedBox(height: 10),
          if (private.isNotEmpty || keyProgress != null)
            Text(
              i18n(context, "private_keys"),
              style: theme.textTheme.title,
            ),
          keysGroup(
            context,
            private,
            keyProgress,
          ),
        ],
      ),
    );
  }

  Widget keysGroup(
    BuildContext context,
    List<PgpKey> keys,
    String keyProgress,
  ) {
    final List<Widget> widgets = keys
        .map<Widget>(
          (key) => GestureDetector(
            onTap: () => _openKey(context, key),
            child: _key(
              (key.name ?? "") +
                  (key.name?.isNotEmpty == true ? " " : "") +
                  key.mail,
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
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text),
            if (isProgress)
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _button(BuildContext context, List<PgpKey> publicKeys) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: <Widget>[
          if (publicKeys.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: i18n(context, "export_all_public_keys"),
                onPressed: () => _exportAllPublicKeys(publicKeys),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: i18n(context, "import_keys_from_text"),
              onPressed: _importFromText,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: i18n(context, "import_keys_from_file"),
              onPressed: _importFromFile,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: i18n(context, "generate_keys"),
              onPressed: _generateKey,
            ),
          )
        ],
      ),
    );
  }
}
