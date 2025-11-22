import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import './buttons/hb_secondary_button.dart';

class HBMediaUpload extends StatelessWidget {
  const HBMediaUpload({
    super.key,
    required this.mediaUrl,
    required this.onPickImage,
    required this.onPickVideo,
    required this.onClearMedia,
  });

  final String mediaUrl;
  final VoidCallback onPickImage;
  final VoidCallback onPickVideo;
  final VoidCallback onClearMedia;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Media',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryBlurple.withOpacity(0.3),
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          child: mediaUrl.isNotEmpty
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(mediaUrl, fit: BoxFit.cover, width: double.infinity),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.darkText.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.white,
                            size: 20,
                          ),
                          onPressed: onClearMedia,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      size: 48,
                      color: AppColors.primaryBlurple,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Upload media',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.mediumText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HBSecondaryButton(
                          text: 'Choose Image',
                          onPressed: onPickImage,
                        ),
                        HBSecondaryButton(
                          text: 'Choose Video',
                          onPressed: onPickVideo,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}