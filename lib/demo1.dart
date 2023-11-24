// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import './material_demo_types.dart';

class BottomNavigationDemo extends StatefulWidget {
  const BottomNavigationDemo({
    super.key,
    required this.restorationId,
    required this.type,
  });

  final String restorationId;
  final BottomNavigationDemoType type;

  @override
  State<BottomNavigationDemo> createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with RestorationMixin {
  final RestorableInt _currentIndex = RestorableInt(0);
  final List<Widget> _pages = [
    const Text("第一页"),
    const Text("第2页"),
    const Text("第3页"),
    const Text("第4页"),
    const Text("第5页"),
  ];
  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'bottom_navigation_tab_index');
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  String _title(BuildContext context) {
    final localizations = '标题';
    switch (widget.type) {
      case BottomNavigationDemoType.withLabels:
        return localizations;
      case BottomNavigationDemoType.withoutLabels:
        return localizations;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // final localizations = "测试";

    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_comment),
        label: "添加",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: "详细",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: "我的1",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.alarm_on),
        label: "我的2",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.camera_enhance),
        label: "我的3",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_title(context)),
      ),
      body: _pages[_currentIndex.value], // 根据当前索引显示对应页面
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels:
            widget.type == BottomNavigationDemoType.withLabels,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: textTheme.bodySmall!.fontSize!,
        unselectedFontSize: textTheme.bodySmall!.fontSize!,
        onTap: (index) {
          setState(() {
            _currentIndex.value = index;
          });
        },
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
        backgroundColor: colorScheme.primary,
      ),
    );
  }
}
