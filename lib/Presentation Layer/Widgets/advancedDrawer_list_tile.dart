import 'package:flutter/material.dart';

ListTile _buildDrawerItem({
  required IconData icon,
  required String text,
  required Color color,
  required BuildContext context,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    onTap: onTap,
  );
}

