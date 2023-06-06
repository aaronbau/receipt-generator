import 'package:flutter/material.dart';
import 'package:pluto/model.dart';
import 'package:pluto/widgets/rt_text.dart';
import 'package:provider/provider.dart';

class FiltersCard extends StatelessWidget {
  const FiltersCard({
    Key? key,
    this.isBir = false,
  }) : super(key: key);

  final bool isBir;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.filter_alt_outlined),
                title: RtText(
                  text: 'Filters',
                  isSubHeading: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isBir)
                      DropdownButtonFormField<LGU>(
                        decoration: InputDecoration(
                          labelText: 'LGU',
                          border: InputBorder.none,
                        ),
                        value: LGU.one,
                        hint: Text('LGU'),
                        onChanged: (value) => model.setLguFilter(value!),
                        items: model.lgus
                            .map((lgu) => DropdownMenuItem(
                                  value: lgu,
                                  child: Text(lgu.name),
                                ))
                            .toList(),
                      ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Year',
                        border: InputBorder.none,
                      ),
                      value: model.yearFilter,
                      hint: Text('Year'),
                      onChanged: (value) => model.setYearFilter(value!),
                      items: model.years
                          .map((year) => DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              ))
                          .toList(),
                    ),
                    DropdownButtonFormField<Month>(
                      decoration: InputDecoration(
                        labelText: 'Month',
                        border: InputBorder.none,
                      ),
                      value: model.monthFilter,
                      hint: Text('Month'),
                      onChanged: (value) => model.setMonthFilter(value!),
                      items: model.months
                          .map((month) => DropdownMenuItem(
                                value: month,
                                child: Text(month.name),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
