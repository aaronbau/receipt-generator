import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto/screens/bir_content.dart';
import 'package:pluto/widgets/rt_text.dart';

class BIRHomeScreen extends StatelessWidget {
  const BIRHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronic Official Receipt'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: RtText(
                text: 'BIR',
                isSubHeading: true,
                isWhite: true,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            TextButton.icon(
              icon: Icon(Icons.logout_rounded),
              label: RtText(text: 'Logout'),
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
            ),
          ],
        ),
      ),
      body: BIRContent(),
    );
  }
}
