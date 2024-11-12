import 'package:flutter/cupertino.dart';


class CustomTimePicker extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(DateTime) onDateTimeChanged;

  const CustomTimePicker({
    super.key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late bool isAm;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialDateTime.hour % 12 == 0
        ? 12
        : widget.initialDateTime.hour % 12;
    selectedMinute = widget.initialDateTime.minute;
    isAm = widget.initialDateTime.hour < 12;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPickerColumn(
          itemCount: 12,
          itemBuilder: (index) => Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 24),
          ),
          onSelectedItemChanged: (index) {
            setState(() {
              selectedHour = index + 1;
              _notifyTimeChanged();
            });
          },
          initialItem: selectedHour - 1,
        ),
        _buildPickerColumn(
          itemCount: 60,
          itemBuilder: (index) => Text(
            index.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 24),
          ),
          onSelectedItemChanged: (index) {
            setState(() {
              selectedMinute = index;
              _notifyTimeChanged();
            });
          },
          initialItem: selectedMinute,
        ),
        _buildPickerColumn(
          itemCount: 2,
          itemBuilder: (index) => Text(
            index == 0 ? 'AM' : 'PM',
            style: const TextStyle(fontSize: 24),
          ),
          onSelectedItemChanged: (index) {
            setState(() {
              isAm = index == 0;
              _notifyTimeChanged();
            });
          },
          initialItem: isAm ? 0 : 1,
        ),
      ],
    );
  }

  Widget _buildPickerColumn({
    required int itemCount,
    required Widget Function(int) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    required int initialItem,
  }) {
    return Expanded(
      child: CupertinoPicker(
        diameterRatio: 1.5, // Adjust the diameter ratio here
        itemExtent: 32.0,   // Height of each item
        onSelectedItemChanged: onSelectedItemChanged,
        scrollController: FixedExtentScrollController(initialItem: initialItem),
        children: List<Widget>.generate(itemCount, itemBuilder),
      ),
    );
  }

  void _notifyTimeChanged() {
    final int hour = isAm
        ? (selectedHour == 12 ? 0 : selectedHour)
        : (selectedHour == 12 ? 12 : selectedHour + 12);
    final DateTime updatedTime = DateTime(
      widget.initialDateTime.year,
      widget.initialDateTime.month,
      widget.initialDateTime.day,
      hour,
      selectedMinute,
    );
    widget.onDateTimeChanged(updatedTime);
  }
}
