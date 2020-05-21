import 'dart:io';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/file_viewer.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFileDialog extends StatefulWidget {
  final MailAttachment attachment;
  final bool allowVideo;

  const DownloadFileDialog(this.attachment, this.allowVideo);

  @override
  State<StatefulWidget> createState() => _DownloadFileDialogState();
}

class _DownloadFileDialogState extends State<DownloadFileDialog> {
  String filePath;
  bool viewSupported;
  bool isAsc;
  bool isVcf;
  bool exist;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    isAsc = widget.attachment.fileName.endsWith(".asc") &&
        BuildProperty.cryptoEnable;
    isVcf = widget.attachment.fileName.endsWith(".vcf");
    filePath = (await getExternalStorageDirectories(
                type: StorageDirectory.downloads))[0]
            .path +
        (Platform.pathSeparator + widget.attachment.fileName);
    exist = await File(filePath).exists();
    viewSupported =
        FileViewer.isSupported(widget.attachment, widget.allowVideo, exist);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.attachment.fileName),
      content: SingleChildScrollView(
        child: exist == null
            ? SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (isVcf)
                    FlatButton(
                      child: Text(i18n(context, "btn_vcf_import_contact")),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          DownloadFileDialogResult(
                            FinishDownloadFileAction.Vcf,
                            exist,
                            filePath,
                          ),
                        );
                      },
                    ),
                  if (isAsc)
                    FlatButton(
                      child: Text(i18n(context, "btn_asc_import_key")),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          DownloadFileDialogResult(
                            FinishDownloadFileAction.Asc,
                            exist,
                            filePath,
                          ),
                        );
                      },
                    ),
                  if (!Platform.isIOS)
                    FlatButton(
                      child: Text(i18n(context, "btn_open_file")),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          DownloadFileDialogResult(
                            FinishDownloadFileAction.Open,
                            exist,
                            filePath,
                          ),
                        );
                      },
                    ),
                  if (viewSupported)
                    FlatButton(
                      child: Text(i18n(context, "btn_show_file")),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          DownloadFileDialogResult(
                            FinishDownloadFileAction.Show,
                            exist,
                            filePath,
                          ),
                        );
                      },
                    ),
                  FlatButton(
                    child: Text(i18n(context, "btn_download")),
                    onPressed: exist
                        ? null
                        : () {
                            Navigator.pop(
                              context,
                              DownloadFileDialogResult(
                                null,
                                exist,
                                filePath,
                              ),
                            );
                          },
                  ),
                ],
              ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context, null),
        ),
      ],
    );
  }
}

class DownloadFileDialogResult {
  final FinishDownloadFileAction onFinish;
  final bool exist;
  final String path;

  DownloadFileDialogResult(this.onFinish, this.exist, this.path);
}

enum FinishDownloadFileAction { Asc, Vcf, Open, Show }
