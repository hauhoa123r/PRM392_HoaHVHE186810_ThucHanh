import 'package:flutter/material.dart';

class TermsAcceptanceTile extends StatelessWidget {
  const TermsAcceptanceTile({
    super.key,
    required this.value,
    required this.showError,
    required this.onChanged,
  });

  final bool value;
  final bool showError;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CheckboxListTile(
          key: const Key('termsCheckbox'),
          value: value,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text(
            'I agree to the Terms & Conditions',
            style: TextStyle(fontSize: 14),
          ),
          onChanged: onChanged,
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              'Please accept the Terms & Conditions',
              key: const Key('termsError'),
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
