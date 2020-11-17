import 'dart:io';
import 'package:aurora_mail/logger/logger.dart';
import 'package:aurora_mail/modules/app_config/app_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_local_storage.dart';
import 'package:aurora_mail/modules/settings/screens/debug/log_screen/log_route.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugSetting extends StatefulWidget {
  @override
  _DebugSettingState createState() => _DebugSettingState();
}

class _DebugSettingState extends BState<DebugSetting> {
  final _storage = DebugLocalStorage();
  bool _debug;
  bool _messageCounter;
  bool _backgroundRecord;
  List<Widget> _logs;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.wait([
      _storage.getDebug(),
      _storage.getBackgroundRecord(),
      _storage.getEnableCounter(),
      logger.logDir().then((value) => getLogs(value))
    ]).then((value) {
      _debug = (value[0] ?? false) as bool;
      _backgroundRecord = (value[1] ?? false) as bool;
      _messageCounter = (value[2] ?? false) as bool;
      _logs = (value[3] ?? []) as List<Widget>;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text("Debug"),
            ),
      body: _debug == null
          ? SizedBox.shrink()
          : Column(
              children: <Widget>[
                ListTile(
                  title: Text("Host: " +
                      BlocProvider.of<AuthBloc>(context).currentUser.hostname),
                ),
                CheckboxListTile(
                  value: _debug,
                  title: Text(i18n(context, S.label_show_debug_view)),
                  onChanged: (bool value) {
                    _debug = value;
                    _storage.setDebug(value);
                    setState(() {});
                    logger.enable = value;
                  },
                ),
                CheckboxListTile(
                  value: _messageCounter,
                  title: Text(
                      i18n(context, S.label_enable_uploaded_message_counter)),
                  onChanged: (bool value) {
                    _messageCounter = value;
                    _storage.setEnableCounter(value);
                    setState(() {});
                  },
                ),
                CheckboxListTile(
                  value: _backgroundRecord,
                  title: Text(i18n(context, S.label_record_log_in_background)),
                  onChanged: (bool value) {
                    _backgroundRecord = value;
                    _storage.setBackgroundRecord(value);
                    setState(() {});
                  },
                ),
                FlatButton(
                  child: Text(i18n(context, S.btn_log_delete_all)),
                  onPressed: () async {
                    final result = await AMConfirmationDialog.show(
                      context,
                      null,
                      i18n(context, S.hint_log_delete_all),
                      i18n(context, S.btn_delete),
                      i18n(context, S.btn_cancel),
                    );
                    if (result == true) {
                      deleteAll();
                    }
                  },
                ),
                Expanded(
                  child: ListView(
                    children: _logs,
                  ),
                )
              ],
            ),
    );
  }

  Future<List<Widget>> getLogs(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      return [];
    }
    var files = (await (await dir.list()).toList());
    Map<FileSystemEntity, FileStat> statMap = {};
    for (var file in files) {
      final stat = await file.stat();
      statMap[file] = stat;
    }
    files.sort((a, b) =>
        a is Directory ? 0 : statMap[a].changed.compareTo(statMap[b].changed));
    final widgets = <Widget>[];
    for (var value in files) {
      if (value is Directory) {
        final children = await getLogs(value.path);
        widgets.add(FolderLogWidget(value, children));
      } else if (value is File) {
        widgets.add(FileLogWidget(value, delete));
      }
    }
    return widgets;
  }

  deleteAll() async {
    final dir = Directory(await logger.logDir());
    await _delete(dir);
    init();
  }

  Future _delete(FileSystemEntity entity) async {
    if (entity is Directory) {
      final children = await entity.list().toList();
      for (var item in children) {
        await _delete(item);
      }
    } else if (entity is File) {
      await entity.delete();
    }
  }

  delete(File file) async {
    await file.delete();
    init();
  }
}

class FileLogWidget extends StatelessWidget {
  final File value;
  final Function(File) onDelete;

  FileLogWidget(this.value, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.insert_drive_file),
      title: Text(value.path.split(Platform.pathSeparator).last),
      onTap: () => open(context),
    );
  }

  open(BuildContext context) async {
    final content = await value.readAsString();
    Navigator.pushNamed(
      context,
      LogRoute.name,
      arguments: LogRouteArg(
        value,
        content,
        onDelete,
      ),
    );
  }
}

class FolderLogWidget extends StatefulWidget {
  final Directory value;
  final List<Widget> children;

  FolderLogWidget(this.value, this.children);

  @override
  _FolderLogWidgetState createState() => _FolderLogWidgetState();
}

class _FolderLogWidgetState extends State<FolderLogWidget> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.folder),
          title: Text(widget.value.path.split(Platform.pathSeparator).last),
          onTap: () => setState(() => expand = !expand),
        ),
        if (expand)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.children,
            ),
          )
      ],
    );
  }
}
