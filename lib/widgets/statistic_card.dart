import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;
  final String? subtitle;

  const StatisticCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppTheme.primaryColor;
    final iColor = iconColor ?? Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: bgColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: bgColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: bgColor,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Value
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: bgColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // Subtitle
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
