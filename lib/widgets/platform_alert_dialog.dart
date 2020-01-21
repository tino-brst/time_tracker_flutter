import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_alert_dialog_action.dart';
import 'stateless_platform_widget.dart';

class PlatformAlertDialog extends StatelessPlatformWidget {
  final String title;
  final String content;
  final String cancelActionText;
  final String primaryActionText;

  PlatformAlertDialog({
    this.title,
    this.content,
    this.cancelActionText,
    this.primaryActionText,
  });

  Widget get _titleWidget => title != null ? Text(title) : null;
  Widget get _contentWidget => content != null ? Text(content) : null;

  Future<bool> show(BuildContext context) {
    if (Platform.isAndroid) {
      return showDialog<bool>(
        context: context,
        builder: (_) => this,
      );
    } else {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (_) => this,
      );
    }
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: _titleWidget,
      content: _contentWidget,
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: _titleWidget,
      content: _contentWidget,
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];

    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelActionText),
        ),
      );
    }

    if (primaryActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(primaryActionText),
        ),
      );
    }

    return actions;
  }
}
