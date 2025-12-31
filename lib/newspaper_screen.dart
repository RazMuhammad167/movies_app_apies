import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'NewsPaperModel.dart';

class NewspaperScreen extends StatefulWidget {
  const NewspaperScreen({super.key});

  @override
  State<NewspaperScreen> createState() => _NewspaperScreenState();
}

class _NewspaperScreenState extends State<NewspaperScreen> {
  // Corrected method name
  Future<List<Newspapers>> getNewspapers() async {
    final response = await http.get(
      Uri.parse('https://chroniclingamerica.loc.gov/newspapers.json'),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      NewsPaperModel model = NewsPaperModel.fromJson(jsonResponse);
      return model.newspapers ?? [];
    } else {
      throw Exception('Failed to load newspapers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newspapers'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Newspapers>>(
        future: getNewspapers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final newspaper = snapshot.data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newspaper.title ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text("State: ${newspaper.state ?? 'N/A'}"),
                        Text("LCCN: ${newspaper.lccn ?? 'N/A'}"),
                        Text("URL: ${newspaper.url ?? 'N/A'}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
