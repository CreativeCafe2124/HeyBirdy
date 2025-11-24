import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/colors.dart';
import '../buttons/hb_icon_button.dart';

/// Amount input field with currency formatting
class HBAmountInput extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? currencySymbol;
  final String? helperText;
  final String? errorText;
  final double? initialValue;
  final double? minAmount;
  final double? maxAmount;
  final bool enabled;
  final bool allowDecimals;
  final int decimalPlaces;
  final void Function(double)? onChanged;
  final void Function(double)? onSubmitted;
  final String? Function(double?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const HBAmountInput({
    super.key,
    this.labelText,
    this.hintText = '0.00',
    this.currencySymbol = '\$',
    this.helperText,
    this.errorText,
    this.initialValue,
    this.minAmount,
    this.maxAmount,
    this.enabled = true,
    this.allowDecimals = true,
    this.decimalPlaces = 2,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.controller,
    this.focusNode,
  });

  @override
  State<HBAmountInput> createState() => _HBAmountInputState();
}

class _HBAmountInputState extends State<HBAmountInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null) {
      _controller.text = _formatAmount(widget.initialValue!);
    }

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String _formatAmount(double amount) {
    final formatted =
        amount.toStringAsFixed(widget.allowDecimals ? widget.decimalPlaces : 0);
    return formatted;
  }

  bool get allowDecimals => widget.allowDecimals;

  double? _parseAmount(String text) {
    if (text.isEmpty) return null;
    try {
      return double.parse(text.replaceAll(RegExp(r'[^0-9.]'), ''));
    } catch (e) {
      return null;
    }
  }

  void _onChanged(String value) {
    final amount = _parseAmount(value);
    if (amount != null) {
      // Apply min/max constraints
      final constrainedAmount = amount;
      if (widget.minAmount != null && constrainedAmount < widget.minAmount!) {
        return;
      }
      if (widget.maxAmount != null && constrainedAmount > widget.maxAmount!) {
        return;
      }

      widget.onChanged?.call(constrainedAmount);
    }
  }

  void _onSubmitted(String value) {
    final amount = _parseAmount(value);
    if (amount != null) {
      widget.onSubmitted?.call(amount);
    }
  }

  void _incrementAmount() {
    final current = _parseAmount(_controller.text) ?? 0.0;
    final increment = widget.allowDecimals ? 0.01 : 1.0;
    final newAmount = current + increment;

    if (widget.maxAmount == null || newAmount <= widget.maxAmount!) {
      _controller.text = _formatAmount(newAmount);
      _onChanged(_controller.text);
    }
  }

  void _decrementAmount() {
    final current = _parseAmount(_controller.text) ?? 0.0;
    final decrement = widget.allowDecimals ? 0.01 : 1.0;
    final newAmount = (current - decrement).clamp(0.0, double.infinity);

    if (widget.minAmount == null || newAmount >= widget.minAmount!) {
      _controller.text = _formatAmount(newAmount);
      _onChanged(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: widget.enabled
                ? AppColors.offWhite
                : AppColors.borderColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.errorText != null
                  ? AppColors.accentRed
                  : _isFocused
                      ? AppColors.primaryBlurple
                      : AppColors.borderColor,
              width: widget.errorText != null || _isFocused ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Currency symbol
              if (widget.currencySymbol != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.currencySymbol!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlurple,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.borderColor,
                ),
              ],

              // Amount input
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        widget.allowDecimals ? r'^\d+\.?\d{0,2}$' : r'^\d+$')),
                  ],
                  onChanged: _onChanged,
                  onSubmitted: _onSubmitted,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: AppColors.lightText,
                      fontWeight: FontWeight.normal,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              // Increment/Decrement buttons
              if (widget.enabled) ...[
                HBIconButton(
                  icon: Icons.remove,
                  size: 32,
                  iconColor: AppColors.primaryBlurple,
                  backgroundColor: Colors.transparent,
                  onPressed: _decrementAmount,
                ),
                HBIconButton(
                  icon: Icons.add,
                  size: 32,
                  iconColor: AppColors.primaryBlurple,
                  backgroundColor: Colors.transparent,
                  onPressed: _incrementAmount,
                ),
              ],
            ],
          ),
        ),
        if (widget.helperText != null || widget.errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText ?? widget.helperText!,
            style: TextStyle(
              fontSize: 12,
              color: widget.errorText != null
                  ? AppColors.accentRed
                  : AppColors.mediumText,
            ),
          ),
        ],
      ],
    );
  }
}
