import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final List<String> labels;

  const StepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isOdd) {
          // Connector line
          final stepBefore = index ~/ 2;
          return Expanded(
            child: Container(
              height: 2,
              color: stepBefore < currentStep
                  ? colorScheme.primary
                  : Colors.grey.shade300,
            ),
          );
        }

        final stepIndex = index ~/ 2;
        final isCompleted = stepIndex < currentStep;
        final isActive = stepIndex == currentStep;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? colorScheme.primary
                    : isActive
                        ? colorScheme.primary
                        : Colors.grey.shade300,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : Text(
                        '${stepIndex + 1}',
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stepIndex < labels.length ? labels[stepIndex] : '',
              style: TextStyle(
                fontSize: 11,
                color: isActive || isCompleted
                    ? colorScheme.primary
                    : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      }),
    );
  }
}
