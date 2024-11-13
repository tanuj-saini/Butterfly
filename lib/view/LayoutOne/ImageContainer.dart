import 'dart:io';
import 'package:email_app/viewModel/ButterFlyC/ButterflyController.dart';
import 'package:email_app/viewModel/UserC/UserProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class PickImageScreen extends StatefulWidget {
  @override
  _PickImageScreenState createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  final UserProfileController userProfile = Get.put(UserProfileController());
  final ButterflyController butterflyController =
      Get.put(ButterflyController());
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.photo_library, color: Colors.purple),
                    ),
                    title: Text('Gallery',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Select from your photo library'),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.purple),
                    ),
                    title: Text('Camera',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Take a new photo'),
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDetailsDialog() {
    final nameController =
        TextEditingController(text: butterflyController.butterflyName.value);
    final scientificNameController =
        TextEditingController(text: butterflyController.scientificName.value);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Butterfly Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showPickerOptions(),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.purple.withOpacity(0.3)),
                  ),
                  child: Obx(() => butterflyController.imageFile.value == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate,
                                size: 40, color: Colors.purple),
                            SizedBox(height: 10),
                            Text('Add Photo',
                                style: TextStyle(color: Colors.purple)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(
                            butterflyController.imageFile.value!,
                            fit: BoxFit.cover,
                          ),
                        )),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Butterfly Name',
                  prefixIcon: Icon(Icons.pets, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: scientificNameController,
                decoration: InputDecoration(
                  labelText: 'Scientific Name',
                  prefixIcon: Icon(Icons.science, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (butterflyController.imageFile.value == null) {
                        Get.snackbar(
                          'Error',
                          'Please select an image',
                          backgroundColor: Colors.red.withOpacity(0.7),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      butterflyController.setDetails(
                        nameController.text,
                        scientificNameController.text,
                      );
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Butterfly details saved successfully',
                        backgroundColor: Colors.green.withOpacity(0.7),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.person, size: 40, color: Colors.purple),
              ),
              accountName: Text(
                userProfile.userModelU.value.name ?? "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(
                userProfile.userModelU.value.email ?? "Email",
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.pink.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Expanded(child: Container()), // Spacer to push logout to bottom
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout'),
              onTap: () {
                // Handle logout action
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Butterfly Detection'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade50,
              Colors.pink.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Obx(() => GestureDetector(
                          onTap: _showDetailsDialog,
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(maxWidth: 400),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.purple.withOpacity(0.2),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(23),
                              child: butterflyController.imageFile.value == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Colors.purple.shade50,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 40,
                                            color: Colors.purple,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Tap to add butterfly details',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.file(
                                          butterflyController.imageFile.value!,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() => Text(
                                                      butterflyController
                                                              .butterflyName
                                                              .value
                                                              .isEmpty
                                                          ? 'Tap to add details'
                                                          : butterflyController
                                                              .butterflyName
                                                              .value,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                if (butterflyController
                                                    .scientificName
                                                    .value
                                                    .isNotEmpty)
                                                  Obx(() => Text(
                                                        butterflyController
                                                            .scientificName
                                                            .value,
                                                        style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 14,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        )),
                  ),
                ),
                // Keep existing tips section
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tips for best results:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTip(
                          Icons.wb_sunny_outlined, 'Ensure good lighting'),
                      _buildTip(
                          Icons.center_focus_strong, 'Keep butterfly in focus'),
                      _buildTip(Icons.photo_size_select_actual,
                          'Capture full wing pattern'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text("+")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (butterflyController.butterflyName.value.isEmpty ||
              butterflyController.scientificName.value.isEmpty) {
            Get.snackbar(
              'Warning',
              'Please add complete butterfly details first',
              backgroundColor: Colors.orange.withOpacity(0.7),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          butterflyController.uploadButterflyData();
        },
        icon: Icon(Icons.cloud_upload),
        label: Text('Upload'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Widget _buildTip(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.purple),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}
