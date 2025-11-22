import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

/// Secondary outlined button for secondary actions
class HBSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? borderColor;

  const HBSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height! / 2),
        border: Border.all(
          color: borderColor ?? AppColors.primaryBlurple,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(height! / 2),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          borderColor ?? AppColors.primaryBlurple),
                    ),
                  )
                : child ??
                    Text(
                      text,
                      style: TextStyle(
                        color: borderColor ?? AppColors.primaryBlurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
