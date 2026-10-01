import 'package:flutter/material.dart';

/// Exercise 5: working examples of fixes for common Flutter UI mistakes.
class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo> {
  int _counter = 0;
  DateTime? _date;

  Future<void> _showPicker() async {
    // Calling from the button callback provides a valid BuildContext.
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && mounted) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const movies = ['Movie A', 'Movie B', 'Movie C', 'Movie D'];

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 - Common UI Fixes')),
      // SingleChildScrollView prevents the complete page from overflowing on
      // short screens or when the device is rotated.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '1. ListView inside Column using Expanded',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 230,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Text('Expanded supplies a bounded list height.'),
                      const SizedBox(height: 4),
                      Expanded(
                        child: ListView.builder(
                          itemCount: movies.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(Icons.movie),
                            title: Text(movies[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '2. State update using setState()',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Text('Button pressed $_counter time(s)'),
                trailing: FilledButton(
                  onPressed: () {
                    // setState tells Flutter to rebuild with the new value.
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Text('Update'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '3. DatePicker with a valid context',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _showPicker,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _date == null
                    ? 'Choose a date'
                    : '${_date!.day}/${_date!.month}/${_date!.year}',
              ),
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'The whole page is wrapped in SingleChildScrollView, so '
                  'these sections remain accessible on small screens.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
