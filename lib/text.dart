import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:share/share.dart';

class TextDisplayPage extends StatefulWidget {
  const TextDisplayPage({Key? key}) : super(key: key);

  @override
  State<TextDisplayPage> createState() => _TextDisplayPageState();
}

class _TextDisplayPageState extends State<TextDisplayPage> {
  static Future<String?> translateText(String scannedText) async {
    try {
      final LanguageIdentify = LanguageIdentifier(confidenceThreshold: 0.5);
      final languageCode = await LanguageIdentify.identifyLanguage(scannedText);
      LanguageIdentify.close();
      final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.values
            .firstWhere((element) => element.bcpCode == languageCode),
        targetLanguage: TranslateLanguage.english,
      );
      final translatedText = await translator.translateText(scannedText);
      translator.close();
      return translatedText;
    } catch (e) {
      return null;
    }
  }

  void showTranslationPopup(String translatedText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Translated Text'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(translatedText, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: translatedText));
                      Navigator.of(context).pop();
                    },
                    child: Text('Copy'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String scannedText = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Color(0xFF5FFFA3),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Scanned Text"),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              if (scannedText.isNotEmpty) {
                Clipboard.setData(ClipboardData(text: scannedText));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Text copied to clipboard'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No text to copy'),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: () async {
              final translatedText = await translateText(scannedText);
              if (translatedText != null) {
                showTranslationPopup(translatedText);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Text translated'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Translation failed'),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              if (scannedText.isNotEmpty) {
                Share.share(scannedText);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No text to share'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    scannedText,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
