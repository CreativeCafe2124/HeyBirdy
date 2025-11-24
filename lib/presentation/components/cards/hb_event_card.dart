import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../buttons/hb_primary_button.dart';

/// Event card component for live events
class HBEventCard extends StatelessWidget {
  final String title;
  final String? description;
  final String imageUrl;
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? location;
  final int? attendees;
  final int? maxAttendees;
  final bool isLive;
  final bool isRegistered;
  final bool isFeatured;
  final String? price;
  final List<String> tags;
  final VoidCallback? onTap;
  final VoidCallback? onRegisterTap;
  final VoidCallback? onShareTap;

  const HBEventCard({
    super.key,
    required this.title,
    this.description,
    required this.imageUrl,
    required this.date,
    this.startTime,
    this.endTime,
    this.location,
    this.attendees,
    this.maxAttendees,
    this.isLive = false,
    this.isRegistered = false,
    this.isFeatured = false,
    this.price,
    this.tags = const [],
    this.onTap,
    this.onRegisterTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: isFeatured
            ? Border.all(color: AppColors.primaryBlurple, width: 2)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with live indicator
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: AppColors.offWhite,
                          child: const Icon(
                            Icons.event,
                            size: 48,
                            color: AppColors.mediumText,
                          ),
                        );
                      },
                    ),
                  ),
                  if (isLive)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 8,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isFeatured)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star,
                          color: AppColors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  if (price != null)
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          price!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.mediumText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Event details
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppColors.mediumText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(date),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.mediumText,
                          ),
                        ),
                        if (startTime != null) ...[
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppColors.mediumText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(startTime!),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mediumText,
                            ),
                          ),
                        ],
                      ],
                    ),

                    if (location != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.mediumText,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.mediumText,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    if (attendees != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.people,
                            size: 16,
                            color: AppColors.mediumText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$attendees${maxAttendees != null ? '/$maxAttendees' : ''} attending',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mediumText,
                            ),
                          ),
                          if (maxAttendees != null) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: attendees! / maxAttendees!,
                                backgroundColor: AppColors.offWhite,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryBlurple),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],

                    // Tags
                    if (tags.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: tags
                            .take(3)
                            .map((tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlurple
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primaryBlurple,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],

                    // Actions
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: HBPrimaryButton(
                            text: isRegistered ? 'Registered' : 'Register',
                            onPressed: isRegistered ? null : onRegisterTap,
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (onShareTap != null)
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.offWhite,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.share,
                                  color: AppColors.mediumText),
                              onPressed: onShareTap,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(date.year, date.month, date.day);

    if (eventDate == today) {
      return 'Today';
    } else if (eventDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (eventDate.isBefore(today.add(const Duration(days: 7)))) {
      return '${date.day}/${date.month}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}
