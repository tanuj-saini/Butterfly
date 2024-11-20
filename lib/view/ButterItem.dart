import 'dart:convert';

import 'package:email_app/Models/ButterflyModel.dart';
import 'package:email_app/view/DiplayButteryDetails.dart';
import 'package:email_app/viewModel/ButterFlyC/ButterflyController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButterflyListItem extends StatelessWidget {
  final Butterfly butterfly;

  const ButterflyListItem({Key? key, required this.butterfly})
      : super(key: key);

  Future<void> _saveButterflyToLocalStorage(Butterfly butterfly) async {
    final prefs = await SharedPreferences.getInstance();
    final butterflyJson = jsonEncode(butterfly.toJson());
    await prefs.setString('butterfly_${butterfly.id}', butterflyJson);

    // Directly add the butterfly to the butterflyHistory list
    final butterflyController = Get.find<ButterflyController>();
    butterflyController.butterflyHistory.add(butterfly);

    // Optionally, refresh the list if you want to reload from storage
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          butterfly.name ?? "Name",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(butterfly.scientificName ?? "Scientific Name"),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            butterfly.imageURL ?? "Image",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: Icon(Icons.bug_report, color: Colors.grey[600]),
              );
            },
          ),
        ),
        onTap: () async {
          await _saveButterflyToLocalStorage(butterfly);
          Get.to(ButterflyDetailScreen(butterfly: butterfly));
        },
      ),
    );
  }
}
