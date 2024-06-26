import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'pdf_viewer_widget.dart';

class PDFListPage extends StatefulWidget {
  @override
  _PDFListPageState createState() => _PDFListPageState();
}

class _PDFListPageState extends State<PDFListPage> {
  late Future<List<String>> _futurePDFs;

  @override
  void initState() {
    super.initState();
    _futurePDFs = _fetchPDFs();
  }

  Future<List<String>> _fetchPDFs() async {
    final pdfDir = 'assets/pdfs/';
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final pdfPaths = manifestMap.keys
        .where((String key) => key.startsWith(pdfDir) && key.endsWith('.pdf'))
        .toList();
    return pdfPaths;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Files'),
      ),
      body: FutureBuilder<List<String>>(
        future: _futurePDFs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No PDFs found',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                ),
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.map((pdfPath) {
                final pdfName = path.basename(pdfPath);
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(pdfName),
                    trailing: Icon(Icons.picture_as_pdf),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFViewerWidget(pdfPath: pdfPath),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
