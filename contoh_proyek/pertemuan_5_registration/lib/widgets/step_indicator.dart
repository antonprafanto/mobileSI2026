import 'package:flutter/material.dart';

/// Widget Step Indicator - menampilkan progress multi-step form
class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;
  final Color activeColor;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
    this.activeColor = const Color(0xFF6C63FF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: activeColor,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
      child: Row(
        children: List.generate(steps.length, (i) {
          final isActive = i == currentStep;
          final isDone = i < currentStep;

          return Expanded(
            child: Row(
              children: [
                if (i > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isDone
                          ? Colors.greenAccent.shade200
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? Colors.green
                            : isActive
                                ? Colors.white
                                : Colors.white.withOpacity(0.25),
                        border: isActive
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: isDone
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: isActive ? activeColor : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[i],
                      style: TextStyle(
                        color: isActive
                            ? Colors.white
                            : Colors.white.withOpacity(0.65),
                        fontSize: 10,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                if (i < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: i < currentStep
                          ? Colors.greenAccent.shade200
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
