import 'package:flutter/material.dart';

class BuddyModel {
  final String id;          // backend id later
  final String name;        // display name
  final String avatarAsset; // for now asset, later can be network url
  final Color bgColor;

  const BuddyModel({
    required this.id,
    required this.name,
    required this.avatarAsset,
    required this.bgColor,
  });

  // ✅ future ready (backend)
  factory BuddyModel.fromJson(Map<String, dynamic> json, {required Color bgColor}) {
    return BuddyModel(
      id: json['id'].toString(),
      name: (json['name'] ?? '').toString(),
      avatarAsset: (json['avatar'] ?? '').toString(), // later: url
      bgColor: bgColor,
    );
  }
}
