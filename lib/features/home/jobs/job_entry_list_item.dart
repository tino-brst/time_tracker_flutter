import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../entities/entry.dart';
import '../../../entities/job.dart';

class JobEntryListItem extends StatelessWidget {
  final Job job;
  final Entry entry;

  const JobEntryListItem(this.job, this.entry);

  @override
  Widget build(BuildContext context) {
    final dayOfTheWeek = DateFormat(DateFormat.WEEKDAY).format(entry.startTime);
    final date = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(entry.startTime);
    final startTime = DateFormat(DateFormat.HOUR24_MINUTE).format(entry.startTime);
    final endTime = DateFormat(DateFormat.HOUR24_MINUTE).format(entry.endTime);
    final duration = '${entry.duration.inHours.toString()}h';
    final income = job.ratePerHour * entry.duration.inHours;
    final formattedIncome = NumberFormat.compactCurrency(decimalDigits: 0, symbol: '\$').format(income);

    final chevronIcon = Icon(Icons.chevron_right, color: Colors.black38);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Text(dayOfTheWeek, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(date, style: TextStyle(fontSize: 16, color: Colors.black45)),
                ]),
                const SizedBox(height: 4),
                Row(children: <Widget>[
                  Text('$startTime - $endTime'),
                  const SizedBox(width: 8),
                  Text(duration, style: TextStyle(color: Colors.black45)),
                ]),
                const SizedBox(height: 2),
                if (entry.comment != null) Text(entry.comment),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            decoration: ShapeDecoration(
              color: Colors.green.shade500,
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(formattedIncome, style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 4),
          chevronIcon,
        ],
      ),
    );
  }
}
