import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

stylesheet(role) {
  return MarkdownStyleSheet(
      listBullet: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      blockquote: TextStyle(
          color: role == 'user' ? Colors.black : Colors.white, fontSize: 16),
      code: const TextStyle(
          backgroundColor: Colors.transparent,
          overflow: TextOverflow.ellipsis,
          color: Colors.black,
          fontSize: 16),
      codeblockDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.grey.shade400),
      a: TextStyle(
          color: role == 'user' ? Colors.black : Colors.white, fontSize: 16),
      p: TextStyle(
          color: role == 'user' ? Colors.black : Colors.white, fontSize: 16),
      h2: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500));
}
