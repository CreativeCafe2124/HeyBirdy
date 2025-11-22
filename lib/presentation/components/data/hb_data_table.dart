import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../buttons/hb_icon_button.dart';

/// Custom data table with HeyBirdy styling
class HBDataTable<T> extends StatelessWidget {
  final List<HBDataColumn<T>> columns;
  final List<HBDataRow<T>> rows;
  final String? title;
  final Widget? subtitle;
  final VoidCallback? onRefresh;
  final bool showBorders;
  final double? rowHeight;
  final EdgeInsets? padding;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final bool isLoading;
  final Color? headerColor;
  final Color? rowColor;

  const HBDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.title,
    this.subtitle,
    this.onRefresh,
    this.showBorders = true,
    this.rowHeight,
    this.padding,
    this.emptyWidget,
    this.loadingWidget,
    this.isLoading = false,
    this.headerColor,
    this.rowColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    if (rows.isEmpty) {
      return emptyWidget ?? _buildEmptyState();
    }

    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || onRefresh != null) ...[
            Row(
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
                if (onRefresh != null)
                  HBIconButton(
                    icon: Icons.refresh,
                    size: 32,
                    iconColor: AppColors.primaryBlurple,
                    backgroundColor: AppColors.offWhite,
                    onPressed: onRefresh,
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          // Header
          Container(
            decoration: BoxDecoration(
              color: headerColor ?? AppColors.offWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children:
                  columns.map((column) => _buildHeaderCell(column)).toList(),
            ),
          ),
          // Rows
          ...rows
              .asMap()
              .entries
              .map((entry) => _buildDataRow(entry.key, entry.value)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(HBDataColumn<T> column) {
    return Expanded(
      flex: column.flex ?? 1,
      child: Container(
        height: rowHeight ?? 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: showBorders
              ? const Border(
                  right: BorderSide(color: AppColors.borderColor, width: 1),
                )
              : null,
        ),
        child: Row(
          children: [
            if (column.icon != null) ...[
              Icon(
                column.icon,
                size: 20,
                color: column.iconColor ?? AppColors.mediumText,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                column.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: column.textColor ?? AppColors.darkText,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (column.sortable) ...[
              const SizedBox(width: 8),
              Icon(
                column.sortAscending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                size: 16,
                color: AppColors.mediumText,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(int index, HBDataRow<T> row) {
    final isEven = index % 2 == 0;

    return Container(
      height: rowHeight ?? 56,
      decoration: BoxDecoration(
        color: rowColor ?? (isEven ? AppColors.white : AppColors.offWhite),
        border: showBorders
            ? Border(
                top: const BorderSide(color: AppColors.borderColor, width: 1),
                bottom: BorderSide(
                  color: AppColors.borderColor,
                  width: index == rows.length - 1 ? 1 : 0,
                ),
              )
            : null,
      ),
      child: Row(
        children: columns.asMap().entries.map((entry) {
          final columnIndex = entry.key;
          final column = entry.value;
          final cellData = row.cells[columnIndex];

          return Expanded(
            flex: column.flex ?? 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: showBorders && columnIndex < columns.length - 1
                    ? const Border(
                        right:
                            BorderSide(color: AppColors.borderColor, width: 1),
                      )
                    : null,
              ),
              child: cellData,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.table_chart_outlined,
            size: 64,
            color: AppColors.lightText,
          ),
          SizedBox(height: 16),
          Text(
            'No data available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.mediumText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'There are no records to display at the moment.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }
}

/// Data column definition
class HBDataColumn<T> {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final int? flex;
  final bool sortable;
  final bool sortAscending;
  final ValueChanged<bool>? onSort;

  HBDataColumn({
    required this.title,
    this.icon,
    this.iconColor,
    this.textColor,
    this.flex,
    this.sortable = false,
    this.sortAscending = true,
    this.onSort,
  });
}

/// Data row definition
class HBDataRow<T> {
  final T data;
  final List<Widget> cells;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  HBDataRow({
    required this.data,
    required this.cells,
    this.backgroundColor,
    this.onTap,
  });
}

/// Pre-built cell widgets
class HBDataCells {
  /// Text cell
  static Widget text(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      style: style ??
          const TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Amount cell (formatted currency)
  static Widget amount(
    double amount, {
    String currencySymbol = '\$',
    TextStyle? style,
    bool showColor = true,
  }) {
    final isNegative = amount < 0;
    final color = showColor
        ? (isNegative ? AppColors.accentRed : AppColors.accentGreen)
        : AppColors.darkText;

    return Text(
      '$currencySymbol${amount.abs().toStringAsFixed(2)}',
      style: (style ??
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ))
          .copyWith(color: color),
    );
  }

  /// Status cell with badge
  static Widget status(
    String status, {
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryBlurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: textStyle ??
            TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor ?? AppColors.primaryBlurple,
            ),
      ),
    );
  }

  /// Avatar cell
  static Widget avatar(
    String? imageUrl, {
    String? fallbackText,
    double size = 32,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: size / 2,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
        backgroundColor: AppColors.offWhite,
        child: imageUrl == null
            ? Text(
                fallbackText?.substring(0, 2).toUpperCase() ?? '?',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlurple,
                ),
              )
            : null,
      ),
    );
  }

  /// Icon cell
  static Widget icon(
    IconData icon, {
    Color? color,
    double size = 20,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: color ?? AppColors.mediumText,
        size: size,
      ),
    );
  }

  /// Date cell
  static Widget date(
    DateTime date, {
    String? format,
    TextStyle? style,
  }) {
    final formatted = format != null
        ? '${date.day}/${date.month}/${date.year}'
        : '${date.day}/${date.month}/${date.year}';

    return Text(
      formatted,
      style: style ??
          const TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
          ),
    );
  }

  /// Action buttons cell
  static Widget actions(List<Widget> actions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: actions,
    );
  }
}
