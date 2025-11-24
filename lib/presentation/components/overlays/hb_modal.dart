import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../buttons/hb_icon_button.dart';

/// Custom modal component with HeyBirdy styling
class HBModal extends StatelessWidget {
  final String? title;
  final Widget? subtitle;
  final Widget content;
  final List<Widget>? actions;
  final VoidCallback? onClose;
  final bool showCloseButton;
  final double? width;
  final double? maxHeight;
  final EdgeInsets? contentPadding;
  final EdgeInsets? titlePadding;
  final ShapeBorder? shape;
  final Color? backgroundColor;

  const HBModal({
    super.key,
    this.title,
    this.subtitle,
    required this.content,
    this.actions,
    this.onClose,
    this.showCloseButton = true,
    this.width,
    this.maxHeight,
    this.contentPadding,
    this.titlePadding,
    this.shape,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor ?? AppColors.white,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width ?? 400,
          maxHeight: maxHeight ?? 600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            if (title != null || showCloseButton)
              Container(
                padding: titlePadding ?? const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.borderColor, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    if (title != null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                            ),
                            if (subtitle != null) ...[
                              const SizedBox(height: 4),
                              subtitle!,
                            ],
                          ],
                        ),
                      ),
                    if (showCloseButton)
                      HBIconButton(
                        icon: Icons.close,
                        size: 32,
                        iconColor: AppColors.mediumText,
                        backgroundColor: AppColors.offWhite,
                        onPressed: onClose ?? () => Navigator.of(context).pop(),
                      ),
                  ],
                ),
              ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: contentPadding ?? const EdgeInsets.all(20),
                child: content,
              ),
            ),

            // Actions
            if (actions != null && actions!.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.borderColor, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Modal with confirm/cancel actions
class HBConfirmModal extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isLoading;
  final Color? confirmColor;
  final Widget? content;

  const HBConfirmModal({
    super.key,
    required this.title,
    this.subtitle,
    this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.isLoading = false,
    this.confirmColor,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return HBModal(
      title: title,
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.mediumText,
              ),
            )
          : null,
      content: content ?? Container(),
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: isLoading
                ? null
                : (onCancel ?? () => Navigator.of(context).pop()),
            child: Text(cancelText!),
          ),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  onConfirm();
                  if (!isLoading) Navigator.of(context).pop();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor ?? AppColors.primaryBlurple,
            foregroundColor: AppColors.white,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : Text(confirmText ?? 'Confirm'),
        ),
      ],
    );
  }
}

/// Info modal with just an OK button
class HBInfoModal extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Widget? content;
  final IconData? icon;
  final Color? iconColor;

  const HBInfoModal({
    super.key,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.content,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return HBModal(
      title: title,
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.mediumText,
              ),
            )
          : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primaryBlurple).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: iconColor ?? AppColors.primaryBlurple,
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (content != null) content!,
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: onButtonPressed ?? () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlurple,
            foregroundColor: AppColors.white,
            minimumSize: const Size(120, 40),
          ),
          child: Text(buttonText ?? 'OK'),
        ),
      ],
    );
  }
}
