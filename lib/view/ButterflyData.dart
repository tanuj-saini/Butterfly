import 'package:email_app/Repositry/ButterflyRepositry.dart';
import 'package:email_app/view/ButterItem.dart';
import 'package:email_app/viewModel/ButterFlyC/DisplayButterflyController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButterflyListPage extends StatelessWidget {
  final DisplayButterflyController controller =
      Get.put(DisplayButterflyController(ButterflyRepository()));

  @override
  Widget build(BuildContext context) {
    controller.updateSearchQuery('');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Butterflies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.shade500,
                Colors.pink.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(controller: controller),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.filteredButterflies.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.filteredButterflies.isEmpty &&
            controller.searchQuery.value.isNotEmpty) {
          return Center(
            child: Text(
                'No butterflies found matching "${controller.searchQuery.value}"'),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                scrollNotification.metrics.extentAfter == 0 &&
                !controller.isLoading.value &&
                controller.hasMore.value &&
                controller.searchQuery.value.isEmpty) {
              controller.fetchButterflies();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: controller.filteredButterflies.length,
            itemBuilder: (context, index) {
              final butterfly = controller.filteredButterflies[index];
              return ButterflyListItem(butterfly: butterfly);
            },
          ),
        );
      }),
    );
  }
}

class SearchBar extends StatelessWidget {
  final DisplayButterflyController controller;

  const SearchBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search butterflies...',
        prefixIcon: Icon(Icons.search),
        suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  controller.updateSearchQuery('');
                  FocusScope.of(context).unfocus();
                },
              )
            : SizedBox.shrink()),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: controller.updateSearchQuery,
    );
  }
}
