import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_coupon_model.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

class CompanyCouponCard extends StatelessWidget {
  final CompanyCoupon coupon;
  const CompanyCouponCard({Key? key, required this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detect current theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: GlassmorphismTheme.sm),
      borderRadius: GlassmorphismTheme.radiusLg,
      hasGoldBorder: true,
      opacity: 0.12,
      onTap: () => _showCouponDetails(context),
      child: Padding(
        padding: const EdgeInsets.all(GlassmorphismTheme.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coupon image or icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: GlassmorphismTheme.goldGradient,
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusMd),
                boxShadow: GlassmorphismTheme.goldShadow,
              ),
              child: coupon.couponImage != null
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(GlassmorphismTheme.radiusMd),
                      child: Image.network(
                        coupon.couponImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildCouponIcon(),
                      ),
                    )
                  : _buildCouponIcon(),
            ),
            const SizedBox(width: GlassmorphismTheme.md),

            // Coupon details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon.name,
                    style: (isDark
                            ? GlassmorphismTheme.h3Style
                            : GlassmorphismTheme.h3Style)
                        .copyWith(
                      fontWeight: FontWeight.w600,
                      color: GlassmorphismTheme.gold,
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.xs),
                  if (coupon.description != null)
                    Text(
                      coupon.description!,
                      style: isDark
                          ? GlassmorphismTheme.bodyStyle
                          : GlassmorphismTheme.bodyStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: GlassmorphismTheme.sm),

                  // Coupon code and expiration
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GlassmorphismTheme.sm,
                          vertical: GlassmorphismTheme.xs,
                        ),
                        decoration: BoxDecoration(
                          gradient: GlassmorphismTheme.goldGradient,
                          borderRadius: BorderRadius.circular(
                              GlassmorphismTheme.radiusSm),
                        ),
                        child: Text(
                          coupon.couponCode ?? 'NO CODE',
                          style: GlassmorphismTheme.buttonStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (coupon.expirationDate != null) ...[
                        const SizedBox(width: GlassmorphismTheme.sm),
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: isDark
                              ? GlassmorphismTheme.textTertiary
                              : GlassmorphismTheme.textTertiary,
                        ),
                        const SizedBox(width: GlassmorphismTheme.xs),
                        Text(
                          _formatExpirationDate(coupon.expirationDate!),
                          style: isDark
                              ? GlassmorphismTheme.captionStyle
                              : GlassmorphismTheme.captionStyle,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Action arrow
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDark
                  ? GlassmorphismTheme.textTertiary
                  : GlassmorphismTheme.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponIcon() {
    return const Center(
      child: Icon(
        Icons.local_offer,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  String _formatExpirationDate(String date) {
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  void _showCouponDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Dialog(
          backgroundColor: Colors.transparent,
          child: GlassCard(
            borderRadius: GlassmorphismTheme.radius2Xl,
            hasGoldBorder: true,
            opacity: 0.15,
            child: Padding(
              padding: const EdgeInsets.all(GlassmorphismTheme.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    coupon.name,
                    style: (isDark
                            ? GlassmorphismTheme.h2Style
                            : GlassmorphismTheme.h2Style)
                        .copyWith(
                      color: GlassmorphismTheme.gold,
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.md),
                  if (coupon.description != null)
                    Text(
                      coupon.description!,
                      style: isDark
                          ? GlassmorphismTheme.bodyStyle
                          : GlassmorphismTheme.bodyStyle,
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: GlassmorphismTheme.lg),
                  Container(
                    padding: const EdgeInsets.all(GlassmorphismTheme.md),
                    decoration: BoxDecoration(
                      gradient: GlassmorphismTheme.goldGradient,
                      borderRadius:
                          BorderRadius.circular(GlassmorphismTheme.radiusLg),
                      boxShadow: GlassmorphismTheme.goldShadow,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Coupon Code',
                          style: GlassmorphismTheme.captionStyle.copyWith(
                            color: GlassmorphismTheme.darkPrimary,
                          ),
                        ),
                        const SizedBox(height: GlassmorphismTheme.xs),
                        Text(
                          coupon.couponCode ?? 'NO CODE',
                          style: GlassmorphismTheme.h2Style.copyWith(
                            color: GlassmorphismTheme.darkPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.lg),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlassmorphismTheme.gold,
                      foregroundColor: GlassmorphismTheme.darkPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(GlassmorphismTheme.radiusLg),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
