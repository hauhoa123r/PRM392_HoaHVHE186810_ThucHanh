import 'package:flutter/material.dart';

import '../models/password_strength.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.strength});

  final PasswordStrength strength;

  @override
  Widget build(BuildContext context) {
    final (label, color, activeBars) = switch (strength) {
      PasswordStrength.none => ('Enter a password', Colors.grey, 0),
      PasswordStrength.weak => ('Weak', Colors.red, 1),
      PasswordStrength.medium => ('Medium', Colors.orange, 2),
      PasswordStrength.strong => ('Strong', Colors.green, 3),
    };

    return Semantics(
      label: 'Password strength: $label',
      child: Row(
        children: [
          for (var index = 0; index < 3; index++) ...[
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 5,
                decoration: BoxDecoration(
                  color: index < activeBars ? color : const Color(0xFFE4E4EC),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            if (index < 2) const SizedBox(width: 6),
          ],
          const SizedBox(width: 12),
          SizedBox(
            width: 106,
            child: Text(
              label,
              key: const Key('passwordStrength'),
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
