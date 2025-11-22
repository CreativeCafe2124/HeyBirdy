import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../buttons/hb_icon_button.dart';

/// Custom bottom sheet component with HeyBirdy styling
class HBBottomSheet extends StatelessWidget {
  final String? title;
  final Widget? subtitle;
  final Widget content;
  final List<Widget>? actions;
  final VoidCallback? onClose;
  final bool showCloseButton;
  final double? maxHeight;
  final EdgeInsets? contentPadding;
  final EdgeInsets? titlePadding;
  final bool isDraggable;
  final bool isScrollControlled;

  const HBBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    required this.content,
    this.actions,
    this.onClose,
    this.showCloseButton = true,
    this.maxHeight,
    this.contentPadding,
    this.titlePadding,
    this.isDraggable = true,
    this.isScrollControlled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          if (isDraggable)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

          // Header
          if (title != null || showCloseButton)
            Container(
              padding: titlePadding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
    );
  }
}

/// Selection bottom sheet with list of options
class HBSelectionBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<HBSelectionItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T?>? onSelectionChanged;
  final VoidCallback? onClose;
  final bool showSearch;
  final String? searchHint;

  const HBSelectionBottomSheet({
    super.key,
    required this.title,
    required this.items,
    this.selectedValue,
    this.onSelectionChanged,
    this.onClose,
    this.showSearch = false,
    this.searchHint,
  });

  @override
  Widget build(BuildContext context) {
    return HBBottomSheet(
      title: title,
      onClose: onClose,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showSearch)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: searchHint ?? 'Search...',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.mediumText),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ...items.map((item) => _buildItem(context, item)),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, HBSelectionItem<T> item) {
    final isSelected = item.value == selectedValue;

    return InkWell(
      onTap: () {
        onSelectionChanged?.call(item.value);
        if (onClose != null) {
          onClose!();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            if (item.icon != null) ...[
              Icon(
                item.icon,
                color: isSelected
                    ? AppColors.primaryBlurple
                    : AppColors.mediumText,
                size: 24,
              ),
              const SizedBox(width: 12),
            ],
            if (item.avatar != null) ...[
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(item.avatar!),
                backgroundColor: AppColors.offWhite,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? AppColors.primaryBlurple
                          : AppColors.darkText,
                    ),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.mediumText,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primaryBlurple,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

/// Data class for selection items
class HBSelectionItem<T> {
  final T value;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? avatar;

  HBSelectionItem({
    required this.value,
    required this.title,
    this.subtitle,
    this.icon,
    this.avatar,
  });
}

/// Action bottom sheet with list of actions
class HBActionBottomSheet extends StatelessWidget {
  final String? title;
  final List<HBActionItem> actions;
  final VoidCallback? onClose;
  final Widget? footer;

  const HBActionBottomSheet({
    super.key,
    this.title,
    required this.actions,
    this.onClose,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return HBBottomSheet(
      title: title,
      onClose: onClose,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actions.map((action) => _buildAction(context, action)),
          if (footer != null) ...[
            const SizedBox(height: 16),
            footer!,
          ],
        ],
      ),
    );
  }

  Widget _buildAction(BuildContext context, HBActionItem action) {
    return InkWell(
      onTap: () {
        action.onTap();
        if (onClose != null) {
          onClose!();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: Row(
          children: [
            if (action.icon != null) ...[
              Icon(
                action.icon,
                color: action.iconColor ?? AppColors.mediumText,
                size: 24,
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                action.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: action.textColor ?? AppColors.darkText,
                ),
              ),
            ),
            if (action.trailing != null) action.trailing!,
          ],
        ),
      ),
    );
  }
}

/// Data class for action items
class HBActionItem {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final Widget? trailing;
  final VoidCallback onTap;

  HBActionItem({
    required this.title,
    this.icon,
    this.iconColor,
    this.textColor,
    this.trailing,
    required this.onTap,
  });
}
