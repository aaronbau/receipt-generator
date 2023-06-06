import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:html' as html;
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:nanoid/nanoid.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto/widgets/rt_text.dart';
import 'package:pluto/widgets/rt_text_button.dart';

class Model extends ChangeNotifier {
  Model() {
    final randomizer = new Random();
    for (final year in years) {
      for (final month in months) {
        for (var day = 1; day < 28; day++) {
          for (final name in names) {
            final shouldGenerate = randomizer.nextInt(2);
            final lguNumber = randomizer.nextInt(4);

            LGU lgu;
            if (lguNumber == 1)
              lgu = LGU.one;
            else if (lguNumber == 2)
              lgu = LGU.two;
            else if (lguNumber == 3)
              lgu = LGU.three;
            else
              lgu = LGU.four;

            if (shouldGenerate == 1)
              receipts.add(
                Receipt(
                  id: customAlphabet('1234567890', 10),
                  name: name,
                  month: month,
                  year: year,
                  day: day.toString(),
                  lgu: lgu,
                ),
              );
          }
        }
      }
    }
  }

  List<String> years = [
    '2020',
    '2021',
  ];

  List<Month> months = [
    Month.january,
    Month.february,
    Month.march,
    Month.april,
    Month.may,
    Month.june,
    Month.july,
    Month.august,
    Month.september,
    Month.october,
    Month.november,
    Month.december,
  ];

  List<String> names = [
    'Juan Cruz',
    'Blanca Durgan',
    'Constance Lehner',
    'Enrico Schultz',
    'Retta Hintz',
    'Aurelie Maggio',
    'Neal Zieme',
    'Doug Oberbrunner',
    'Seamus Runolfsdottir',
    'Juvenal Barton',
    'Cullen Treutel',
  ];

  List<LGU> lgus = [
    LGU.one,
    LGU.two,
    LGU.three,
    LGU.four,
  ];

  List<Receipt> receipts = [];

  List<String> selectedReceipts = [];
  void selectReceipt(String id) {
    selectedReceipts.add(id);
    notifyListeners();
  }

  void unselectReceipt(String id) {
    selectedReceipts.remove(id);
    notifyListeners();
  }

  var lguFilter = LGU.one;
  void setLguFilter(LGU lgu) {
    lguFilter = lgu;
    selectedReceipts = [];
    notifyListeners();
  }

  var yearFilter = '2021';
  void setYearFilter(String year) {
    yearFilter = year;
    selectedReceipts = [];
    notifyListeners();
  }

  var monthFilter = Month.december;
  void setMonthFilter(Month month) {
    monthFilter = month;
    selectedReceipts = [];
    notifyListeners();
  }

  final msgList = <dynamic>[
    {
      'field': 'Transaction Type',
      'value': 'Real Property Tax Payment',
    },
    {
      'field': 'Settlement Reference Number',
      'value': 'TR-1234',
    },
    {
      'field': 'Amount',
      'value': 'Php 1,000,000.00',
    },
    {
      'field': 'Asset Code/Property Index Number/Tax Declaration Number',
      'value': 'BIR19425',
    },
    {
      'field': 'LGU Code',
      'value': 'LGU2537',
    },
    {
      'field': 'BSP Reference Number',
      'value': 'BSP67513',
    },
  ];

  void downloadFiles(bool isBir) {
    for (final id in selectedReceipts) {
      final receipt = receipts.firstWhere((element) => element.id == id);
      final name = isBir
          ? 'EOR-${receipt.year}-${receipt.month.name}-${receipt.day}-${receipt.name.split(' ')[1]}.pdf'
          : 'EOR-${receipt.year}-${receipt.month.name}-${receipt.day}.pdf';
      downloadFile(name, receipt);
    }

    selectedReceipts = [];
    notifyListeners();
  }

  Future<void> downloadFile(String name, Receipt receipt) async {
    var anchor;
    final pdf = pw.Document();
    final font = await rootBundle.load('assets/TimesNewRoman-Regular.ttf');
    final ttf = pw.Font.ttf(font);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      <String>['Official Receipt Number', 'OR${receipt.id}'],
                      <String>['Date', '${receipt.month.name} ${receipt.day}, ${receipt.year}'],
                    ],
                    border: pw.TableBorder.all(width: 0),
                  ),
                ],
              ),

              pw.SizedBox(height: 24),

              // TITLE
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'OFFICIAL RECEIPT',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 40,
                    ),
                  )
                ],
              ),

              pw.SizedBox(height: 24),

              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Field', 'Value'],
                  <String>['Timestamp', '${receipt.year}-${receipt.day.padLeft(2, '0')}-${receipt.month.number} 10:16:05'],
                  <String>['Taxpayer Name', receipt.name],
                  ...msgList.map((msg) => [msg['field'], msg['value']])
                ],
              ),
            ],
          );
        },
      ),
    );

    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = name;
    html.document.body!.children.add(anchor);
    anchor.click();
  }
}

class Receipt {
  final String id;
  final String name;
  final Month month;
  final String year;
  final String day;
  final LGU lgu;

  Receipt({
    required this.id,
    required this.name,
    required this.month,
    required this.year,
    required this.day,
    required this.lgu,
  });

  @override
  String toString() {
    return '$id-${lgu.name}-$name-$year-${month.name}-$day';
  }
}

enum LGU { one, two, three, four }

extension LGUExtension on LGU {
  String get name {
    switch (this) {
      case LGU.one:
        return 'Barangay 1';
      case LGU.two:
        return 'Barangay 2';
      case LGU.three:
        return 'Barangay 3';
      case LGU.four:
        return 'Barangay 4';
      default:
        return 'Unknown LGU';
    }
  }
}

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

extension MonthExtension on Month {
  String get name {
    switch (this) {
      case Month.january:
        return 'January';
      case Month.february:
        return 'February';
      case Month.march:
        return 'March';
      case Month.april:
        return 'April';
      case Month.may:
        return 'May';
      case Month.june:
        return 'June';
      case Month.july:
        return 'July';
      case Month.august:
        return 'August';
      case Month.september:
        return 'September';
      case Month.october:
        return 'October';
      case Month.november:
        return 'November';
      case Month.december:
        return 'December';
      default:
        return 'Unknown month';
    }
  }

  String get number {
    switch (this) {
      case Month.january:
        return '01';
      case Month.february:
        return '02';
      case Month.march:
        return '03';
      case Month.april:
        return '04';
      case Month.may:
        return '05';
      case Month.june:
        return '06';
      case Month.july:
        return '07';
      case Month.august:
        return '08';
      case Month.september:
        return '09';
      case Month.october:
        return '10';
      case Month.november:
        return '11';
      case Month.december:
        return '12';
      default:
        return 'Unknown month';
    }
  }
}
