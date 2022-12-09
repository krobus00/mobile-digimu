import 'package:digium/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 30)),
        ).then((value) {
          setState(() {
            _dateTime = value;
          });

          print(_dateTime?.day ?? "nil");
          print(_dateTime);
        });
      },
      child: Row(
        children: [
          Text(
            _dateTime == null
                ? "Pilih tanggal"
                : DateFormat('d MMMM yyyy').format(_dateTime!),
            style: button1.copyWith(color: titleColor),
          ),
          const Icon(
            Icons.arrow_drop_down,
          )
        ],
      ),
    );
  }
}
