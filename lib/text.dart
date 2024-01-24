import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TextDisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String scannedText =
        ModalRoute.of(context)!.settings.arguments as String;

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
            icon: Icon(Icons.share),
            onPressed: () {
              if (scannedText.isNotEmpty) {
                // Implement share functionality here
                // You can use the share package or any other method to share the text
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

// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';

// class TextDisplayPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final String scannedText =
//         ModalRoute.of(context)!.settings.arguments as String;

//     return Scaffold(
//        backgroundColor: Color(0xFF5FFFA3),
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text("Scanned Text"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.copy),
//             onPressed: () {
//               if (scannedText.isNotEmpty) {
//                 // Copy the scanned text to the clipboard
//                 Clipboard.setData(ClipboardData(text: scannedText));

//                 // Show a snackbar indicating successful copy
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Text copied to clipboard'),
//                   ),
//                 );
//               } else {
//                 // Show a snackbar if there's no text to copy
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('No text to copy'),
//                   ),
//                 );
//               }
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {
//               if (scannedText.isNotEmpty) {
//                 // Implement share functionality here
//                 // You can use the share package or any other method to share the text
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('No text to share'),
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//               Container(
//                 child: Text(
//                   scannedText,
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
