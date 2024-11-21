import 'dart:io';
import 'package:email_app/Models/ButterflyModel.dart';
import 'package:email_app/view/ButterflyData.dart';
import 'package:email_app/view/DiplayButteryDetails.dart';
import 'package:email_app/view/LayoutOne/login.dart';
import 'package:email_app/viewModel/ButterFlyC/ButterflyController.dart';
import 'package:email_app/viewModel/UserC/UserProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PickImageScreen extends StatefulWidget {
  @override
  _PickImageScreenState createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  final UserProfileController userProfile = Get.put(UserProfileController());
  final ButterflyController butterflyController =
      Get.put(ButterflyController());

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      // Update both the local state and the controller
      final imageFile = File(pickedFile.path);
      butterflyController.imageFile.value = imageFile;
    }
  }

  List<Butterfly> butterflyHistory = [];

  @override
  void initState() {
    super.initState();
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.setString('jwtToken', "");

                Get.to(LoginUI());
                // Close the dialog
                // Perform logout action
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    (userProfile.userModelU.value.profileURL != null &&
                            userProfile.userModelU.value.profileURL!.isNotEmpty)
                        ? NetworkImage(userProfile.userModelU.value.profileURL!)
                        : null,
                child: (userProfile.userModelU.value.profileURL == null ||
                        userProfile.userModelU.value.profileURL!.isEmpty)
                    ? Icon(Icons.person, size: 40, color: Colors.purple)
                    : null,
              ),
              accountName: Text(
                userProfile.userModelU.value.name ?? "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(
                userProfile.userModelU.value.email ?? "userEmail",
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.pink.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade400, Colors.pink.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(Icons.list, color: Colors.white, size: 24),
              ),
              title: Text(
                'All Species',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Text(
                'View all the species in the app',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              onTap: () {
                Get.to(ButterflyListPage());
              },
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Colors.white,
              splashColor: Colors.grey[100],
              selectedColor: Colors.grey[200],
            ),
            Obx(() {
              return ExpansionTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(Icons.history, color: Colors.white, size: 24),
                ),
                title: Text(
                  'Butterfly History',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                subtitle: Text(
                  'View your past butterfly observations',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                children: [
                  SizedBox(
                    height: 200,
                    child: butterflyController.butterflyHistory.isNotEmpty
                        ? ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount:
                                butterflyController.butterflyHistory.length,
                            itemBuilder: (context, index) {
                              final butterfly =
                                  butterflyController.butterflyHistory[index];
                              return ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.purple.shade400,
                                        Colors.pink.shade400
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      butterfly.name?[0].toUpperCase() ?? "N",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  butterfly.name ?? "Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                subtitle: Text(
                                  butterfly.scientificName ?? "Scientific Name",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                onTap: () {
                                  Get.to(ButterflyDetailScreen(
                                      butterfly: butterfly));
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                tileColor: Colors.white,
                                splashColor: Colors.grey[100],
                                selectedColor: Colors.grey[200],
                              );
                            },
                          )
                        : ListTile(
                            title: Text("No history found"),
                          ),
                  ),
                ],
              );
            }),
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.red.shade400, Colors.red.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(Icons.logout, color: Colors.white, size: 24),
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Text(
                'Sign out of the app',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              onTap: () {
                showLogoutDialog(context);
              },
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Colors.white,
              splashColor: Colors.grey[100],
              selectedColor: Colors.grey[200],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade400, Colors.pink.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
                          onTap: _showPickerOptions,
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
                                  : Image.file(
                                      butterflyController.imageFile.value!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                            ),
                          ),
                        )),
                  ),
                ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          const url =
              'https://huggingface.co/spaces/sssdfcfdsf/deploy'; // Replace with your desired URL

          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            // Handle error if the URL cannot be launched
            throw 'Could not launch $url';
          }
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
