import 'package:flutter/material.dart';

/// Exercise 2: interactive controls require a StatefulWidget because their
/// values change while the application is running.
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _rating = 50;
  bool _isActive = false;
  String? _selectedGenre;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    // This State's context belongs to a mounted widget in the active tree.
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null && mounted) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  String get _dateLabel {
    final date = _selectedDate;
    if (date == null) return 'No date selected';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 - Input Controls')),
      // ListView allows all controls to remain reachable on a small screen.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Rating (Slider)',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Slider(
            value: _rating,
            min: 0,
            max: 100,
            divisions: 100,
            label: _rating.round().toString(),
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          Text('Current value: ${_rating.round()}'),
          const SizedBox(height: 24),
          Text(
            'Active (Switch)',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Is movie active?'),
            value: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value;
              });
            },
          ),
          Text('Status: ${_isActive ? 'Active' : 'Inactive'}'),
          const SizedBox(height: 24),
          Text(
            'Genre (RadioListTile)',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          RadioGroup<String>(
            groupValue: _selectedGenre,
            onChanged: (value) {
              setState(() {
                _selectedGenre = value;
              });
            },
            child: const Column(
              children: [
                RadioListTile<String>(title: Text('Action'), value: 'Action'),
                RadioListTile<String>(title: Text('Comedy'), value: 'Comedy'),
              ],
            ),
          ),
          Text('Selected genre: ${_selectedGenre ?? 'None'}'),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month),
            label: const Text('Open Date Picker'),
          ),
          const SizedBox(height: 12),
          Center(child: Text(_dateLabel)),
        ],
      ),
    );
  }
}
