/*
 * Copyright (c) 2021-2022 Larry Aasen. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

/// A widget to display the upgrade dialog.
class UpgradeAlert extends UpgradeBase {
  /// The [child] contained by the widget.
  final Widget? child;
  final bool showForDebug;
  final Future<void> Function({
    required BuildContext context,
    required String? title,
    required String message,
    required String? releaseNotes,
    required bool canDismissDialog,
    required void Function()? onUserLater,
    required void Function()? onUserDownload,
    required void Function()? onUserIgnore,
  })? overLayBuilder;

  /// Creates a new [UpgradeAlert].
  UpgradeAlert({
    Key? key,
    Upgrader? upgrader,
    this.child,
    this.overLayBuilder,
    this.showForDebug = false,
  }) : super(upgrader ?? Upgrader.sharedInstance, key: key);

  /// Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context, UpgradeBaseState state) {
    if (upgrader.debugLogging) {
      print('upgrader: build UpgradeAlert');
    }

    return FutureBuilder(
        future: state.initialized,
        builder: (BuildContext context, AsyncSnapshot<bool> processed) {
          if (processed.connectionState == ConnectionState.done &&
              processed.data != null &&
              processed.data!) {
            upgrader.checkVersion(
              showForDebug: showForDebug,
              context: context,
              overLayBuilder: overLayBuilder,
            );
          }
          return child ?? Container();
        });
  }
}
