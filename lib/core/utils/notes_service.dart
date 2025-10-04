import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../data/model/note.dart';

class NoteActionsService {
  // Share note as plain text
  static Future<void> shareNote(Note note) async {
    try {
      final plainText = _getPlainTextFromQuill(note.quillContent ?? '');
      final shareText = '''
${note.title}

Category: ${note.category}
Created: ${DateFormat.yMMMMEEEEd().format(note.createdAt ?? DateTime.now())}
Updated: ${DateFormat.yMMMMEEEEd().format(note.updatedAt ?? DateTime.now())}

${plainText}
''';

      await Share.share(
        shareText,
        subject: note.title,
      );
    } catch (e) {
      print('Error sharing note: $e');
      rethrow;
    }
  }

  // Share note with files (can include images if needed)
  static Future<void> shareNoteWithOptions(Note note) async {
    try {
      final plainText = _getPlainTextFromQuill(note.quillContent ?? '');
      final shareText = '''
${note.title}

Category: ${note.category}
Created: ${DateFormat.yMMMMEEEEd().format(note.createdAt ?? DateTime.now())}
Updated: ${DateFormat.yMMMMEEEEd().format(note.updatedAt ?? DateTime.now())}

${plainText}
''';

      await Share.share(
        shareText,
        subject: note.title,
        sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100), // For iPad
      );
    } catch (e) {
      print('Error sharing note: $e');
      rethrow;
    }
  }

  // Export note as PDF
  static Future<File> exportNoteToPdf(Note note) async {
    try {
      final pdf = pw.Document();
      final plainText = _getPlainTextFromQuill(note.quillContent ?? '');

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Title
                pw.Text(
                  note.title ?? '',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),

                // Metadata
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(vertical: 8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColors.grey300,
                        width: 1,
                      ),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Category: ${note.category}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Created: ${DateFormat.yMMMMEEEEd().format(note.createdAt ?? DateTime.now())}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.Text(
                        'Updated: ${DateFormat.yMMMMEEEEd().format(note.updatedAt ?? DateTime.now())}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                // Content
                pw.Text(
                  plainText,
                  style: pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.left,
                ),
              ],
            );
          },
        ),
      );

      // Save PDF to temporary directory
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/${note.title}.pdf');
      await file.writeAsBytes(await pdf.save());

      return file;
    } catch (e) {
      print('Error exporting to PDF: $e');
      rethrow;
    }
  }

  // Export and share PDF
  static Future<void> exportAndSharePdf(Note note) async {
    try {
      final file = await exportNoteToPdf(note);
      
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: note.title,
        text: 'Sharing note: ${note.title}',
      );
    } catch (e) {
      print('Error exporting and sharing PDF: $e');
      rethrow;
    }
  }

  // Save PDF to downloads folder
  static Future<String> savePdfToDownloads(Note note) async {
    try {
      final pdf = await exportNoteToPdf(note);
      
      // Get downloads directory (Android)
      if (Platform.isAndroid) {
        final directory = Directory('/storage/emulated/0/Download');
        final fileName = '${note.title}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final savePath = '${directory.path}/$fileName';
        
        await pdf.copy(savePath);
        return savePath;
      } 
      // Get documents directory (iOS)
      else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = '${note.title}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final savePath = '${directory.path}/$fileName';
        
        await pdf.copy(savePath);
        return savePath;
      }
      
      return pdf.path;
    } catch (e) {
      print('Error saving PDF: $e');
      rethrow;
    }
  }

  // Print note
  static Future<void> printNote(Note note) async {
    try {
      final plainText = _getPlainTextFromQuill(note.quillContent ?? '');

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              pageFormat: format,
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      note.title ?? '',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 16),
                    pw.Text(plainText, style: pw.TextStyle(fontSize: 12)),
                  ],
                );
              },
            ),
          );

          return pdf.save();
        },
      );
    } catch (e) {
      print('Error printing note: $e');
      rethrow;
    }
  }

  static String _getPlainTextFromQuill(String quillJson) {
    try {
      final doc = quill.Document.fromJson(jsonDecode(quillJson));
      return doc.toPlainText();
    } catch (e) {
      return '';
    }
  }
}