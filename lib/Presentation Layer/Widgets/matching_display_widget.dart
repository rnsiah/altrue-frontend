import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/matching_bloc/matching_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';

class MatchingDisplayWidget extends StatelessWidget {
  final double donationAmount;
  final int? causeId;
  final int? nonprofitId;

  const MatchingDisplayWidget({
    super.key,
    required this.donationAmount,
    this.causeId,
    this.nonprofitId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchingBloc, MatchingState>(
      builder: (context, state) {
        if (state.status == MatchingStatus.loading) {
          return _buildLoadingState();
        }

        if (state.status == MatchingStatus.failure) {
          return _buildErrorState();
        }

        if (state.matches.isEmpty) {
          return const SizedBox.shrink();
        }

        return _buildMatchingDisplay(context, state);
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.amber,
              strokeWidth: 2,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Finding matching companies...',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red),
          SizedBox(width: 8),
          Text(
            'Could not load matches',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchingDisplay(BuildContext context, MatchingState state) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade900, Colors.amber.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Companies Ready to Match!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Company Logos Row
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.matches.length,
              itemBuilder: (context, index) {
                final match = state.matches[index];
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: match.company.logo != null
                            ? ClipOval(
                                child: Image.network(
                                  match.company.logo!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : const Icon(
                                Icons.business,
                                color: Colors.grey,
                              ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          match.isCampaignMatch
                              ? '${match.matchMultiplier?.toStringAsFixed(0)}x'
                              : '${match.matchPercentage.toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Match Details
          ...state.matches.take(3).map((match) => _buildMatchDetail(match)),
          
          if (state.matches.length > 3)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '+${state.matches.length - 3} more companies matching',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          
          const Divider(color: Colors.white24, height: 24),
          
          // Impact Summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your \$${state.userDonation.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+ \$${state.totalMatchAmount.toStringAsFixed(0)} matched',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '= \$${state.totalImpact.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchDetail(MatchOffer match) {
    String matchText;
    if (match.isCampaignMatch && match.campaignName != null) {
      matchText = '${match.company.name} is running ${match.campaignName}!';
    } else if (match.matchMultiplier != null && match.matchMultiplier! > 1) {
      matchText = '${match.company.name} will match ${match.matchMultiplier!.toStringAsFixed(0)}x!';
    } else {
      matchText = '${match.company.name} will match ${match.matchPercentage.toInt()}%';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            match.isCampaignMatch ? Icons.star : Icons.check_circle,
            color: Colors.white70,
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              matchText,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Compact version for smaller spaces
class CompactMatchingDisplay extends StatelessWidget {
  final double donationAmount;

  const CompactMatchingDisplay({
    super.key,
    required this.donationAmount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchingBloc, MatchingState>(
      builder: (context, state) {
        if (state.status != MatchingStatus.success || state.matches.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.amber,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${state.matches.length} compan${state.matches.length == 1 ? 'y' : 'ies'} will match!',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '\$${donationAmount.toStringAsFixed(0)} → \$${state.totalImpact.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
