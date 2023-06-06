import 'package:flutter/material.dart';
import 'package:pluto/cards/files_card.dart';
import 'package:pluto/cards/filters_card.dart';

class BIRContent extends StatefulWidget {
  const BIRContent({Key? key}) : super(key: key);

  @override
  _BIRContentState createState() => _BIRContentState();
}

class _BIRContentState extends State<BIRContent> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    if (queryData.size.width < 960) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FiltersCard(isBir: true),
              FilesCard(isBir: true),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FiltersCard(isBir: true),
          FilesCard(isBir: true),
        ],
      ),
    );
  }
}
