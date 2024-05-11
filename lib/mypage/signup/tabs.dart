import 'package:flutter/material.dart';

class TabInfo {
  // final IconData icon;
  final String label;

  const TabInfo({
    // required this.icon,
    required this.label,
  });
}

const TABS = [
  TabInfo(label: '거래내역'),
  TabInfo(label: '요모조모'),
  TabInfo(label: '체크리스트'),
  TabInfo(label: '관심'),
  TabInfo(label: '가계부'),
];
