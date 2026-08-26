import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class LoadCard extends StatelessWidget {
  final String id;
  final String origin;
  final String destination;
  final double weight;
  final double price;
  final String status; // pending, accepted, in_transit, delivered
  final double? distance;
  final String? driverName;
  final double? driverRating;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const LoadCard({
    Key? key,
    required this.id,
    required this.origin,
    required this.destination,
    required this.weight,
    required this.price,
    required this.status,
    this.distance,
    this.driverName,
    this.driverRating,
    this.onTap,
    this.onAccept,
    this.onReject,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status) {
      case 'pending':
        return AppTheme.pendingStatusColor;
      case 'accepted':
        return AppTheme.acceptedStatusColor;
      case 'in_transit':
        return AppTheme.inTransitStatusColor;
      case 'delivered':
        return AppTheme.deliveredStatusColor;
      default:
        return AppTheme.mediumGrey;
    }
  }

  String _getStatusText() {
    switch (status) {
      case 'pending':
        return 'در انتظار راننده';
      case 'accepted':
        return 'راننده یافت شد';
      case 'in_transit':
        return 'در حال حمل';
      case 'delivered':
        return 'تحویل شده';
      default:
        return 'نامشخص';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        ),
        child: Column(
          children: [
            // Header with route and status
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مبدا',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              origin,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppTheme.primaryColor,
                        size: 24,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'مقصد',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              destination,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Status badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(),
                      style: TextStyle(
                        color: _getStatusColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: AppTheme.mediumGrey.withOpacity(0.3),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Weight, Price, Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _DetailItem(
                        icon: Icons.scale,
                        label: 'وزن',
                        value: '${weight.toStringAsFixed(0)} کیلوگرم',
                      ),
                      _DetailItem(
                        icon: Icons.attach_money,
                        label: 'کرایه',
                        value: '${(price / 1000).toStringAsFixed(0)}K تومان',
                      ),
                      if (distance != null)
                        _DetailItem(
                          icon: Icons.location_on,
                          label: 'فاصله',
                          value: '${distance!.toStringAsFixed(1)} کیلومتر',
                        ),
                    ],
                  ),
                  // Driver info (if accepted)
                  if (driverName != null) ...[
                    const SizedBox(height: 12),
                    Divider(
                      height: 1,
                      color: AppTheme.mediumGrey.withOpacity(0.3),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.primaryColor,
                          child: Text(
                            driverName![0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                driverName!,
                                style:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${driverRating?.toStringAsFixed(1) ?? '۰'} / ۵',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            // Action buttons
            if (onAccept != null || onReject != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    if (onReject != null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onReject,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.errorColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('رد'),
                        ),
                      ),
                    if (onReject != null && onAccept != null)
                      const SizedBox(width: 12),
                    if (onAccept != null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onAccept,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.successColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('قبول'),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
