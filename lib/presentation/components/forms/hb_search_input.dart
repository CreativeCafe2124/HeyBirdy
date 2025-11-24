import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../buttons/hb_icon_button.dart';

/// Search input field with filter options
class HBSearchInput extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onFilterTap;
  final bool showFilterButton;
  final bool showClearButton;
  final TextEditingController? controller;
  final Widget? trailing;
  final EdgeInsets? padding;

  const HBSearchInput({
    super.key,
    this.hintText = 'Search...',
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.showFilterButton = true,
    this.showClearButton = true,
    this.controller,
    this.trailing,
    this.padding,
  });

  @override
  State<HBSearchInput> createState() => _HBSearchInputState();
}

class _HBSearchInputState extends State<HBSearchInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
      _hasText = widget.initialValue!.isNotEmpty;
    }

    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onTextChanged);
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  void _onClear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onSubmitted: widget.onSubmitted,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.darkText,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppColors.lightText,
              fontSize: 16,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.mediumText,
              size: 20,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showClearButton && _hasText)
                  HBIconButton(
                    icon: Icons.clear,
                    size: 32,
                    iconColor: AppColors.mediumText,
                    backgroundColor: Colors.transparent,
                    onPressed: _onClear,
                  ),
                if (widget.showFilterButton)
                  HBIconButton(
                    icon: Icons.tune,
                    size: 32,
                    iconColor: AppColors.primaryBlurple,
                    backgroundColor: Colors.transparent,
                    onPressed: widget.onFilterTap,
                  ),
                if (widget.trailing != null) widget.trailing!,
              ],
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}
