import 'package:email_app/Models/ButterflyModel.dart';
import 'package:email_app/view/WebView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ButterflyDetailScreen extends StatelessWidget {
  final Butterfly butterfly;

  ButterflyDetailScreen({required this.butterfly});

  Future<void> _launchWikipedia(BuildContext context) async {
    final commonName =
        butterfly.name?.replaceAll(' ', '_') ?? 'Unknown_Butterfly';
    final scientificName = butterfly.scientificName ?? 'Unknown';
    final url = 'https://en.wikipedia.org/wiki/${commonName}_($scientificName)';

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => WikipediaWebViewScreen(url: url),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Details'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade400, Colors.pink.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (butterfly.imageURL != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    butterfly.imageURL!,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image,
                          size: 100, color: Colors.purple.shade400);
                    },
                  ),
                )
              else
                Icon(Icons.broken_image,
                    size: 100, color: Colors.purple.shade400),
              SizedBox(height: 20),
              Text(
                butterfly.name ?? 'Unknown Butterfly',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade400),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                butterfly.scientificName ?? 'Scientific name not available',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final commonName = butterfly.name?.replaceAll(' ', '_') ??
                      'Unknown_Butterfly';
                  final scientificName = butterfly.scientificName ?? 'Unknown';
                  final url = 'https://en.wikipedia.org/wiki/$scientificName';

                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    // Handle error if the URL cannot be launched
                    throw 'Could not launch $url';
                  }
                },
                child: Text('Know More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
