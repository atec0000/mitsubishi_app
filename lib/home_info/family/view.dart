import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/model/family.dart';

import 'controller.dart';


class FamilyView extends StatelessWidget {
  final FamilyController familyController = Get.put(FamilyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Members'),
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: familyController.families.length,
          itemBuilder: (context, index) {
            Home family = familyController.families[index];
            return buildFamilyCard(family);
          },
        ),
      ),
    );
  }


  Widget buildFamilyCard(Home family) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${family.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'ID: ${family.id}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Members: ${family.members.join(", ")}',
              style: TextStyle(fontSize: 16),
            ),
            // Add more details or customize as needed
          ],
        ),
      ),
    );
  }
}