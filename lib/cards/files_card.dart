import 'package:flutter/material.dart';
import 'package:pluto/model.dart';
import 'package:pluto/widgets/rt_text.dart';
import 'package:provider/provider.dart';

class FilesCard extends StatelessWidget {
  const FilesCard({
    Key? key,
    this.isBir = false,
  }) : super(key: key);

  final bool isBir;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    final filteredList = isBir
        ? model.receipts.where((receipt) => receipt.lgu == model.lguFilter && receipt.month == model.monthFilter && receipt.year == model.yearFilter).toList()
        : model.receipts
            .where((receipt) => receipt.name == model.names.first && receipt.month == model.monthFilter && receipt.year == model.yearFilter)
            .toList();
    return Flexible(
      child: Card(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.folder),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isBir)
                        RtText(
                          text: model.lguFilter.name,
                          isSubHeading: true,
                        ),
                      RtText(
                        text: '${model.monthFilter.name} ${model.yearFilter}',
                        isSubHeading: true,
                      ),
                    ],
                  ),
                  trailing: TextButton.icon(
                    icon: Text('Download'),
                    label: Icon(Icons.download_for_offline_outlined),
                    onPressed: () => model.downloadFiles(isBir),
                  ),
                ),
                Divider(),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      final fileName = isBir
                          ? 'EOR-${item.year}-${item.month.name}-${item.day}-${item.name.split(' ')[1]}.pdf'
                          : 'EOR-${item.year}-${item.month.name}-${item.day}.pdf';

                      return CheckboxListTile(
                        dense: true,
                        value: model.selectedReceipts.contains(item.id),
                        secondary: Icon(Icons.picture_as_pdf_outlined),
                        title: RtText(text: fileName),
                        onChanged: (value) => value == true ? model.selectReceipt(item.id) : model.unselectReceipt(item.id),
                      );
                    },
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: filteredList.length,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
