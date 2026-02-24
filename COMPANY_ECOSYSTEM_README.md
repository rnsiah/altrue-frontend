# Company Ecosystem Phase 1 - Implementation Guide

## Overview
This implementation adds comprehensive company-related features to the Altrue mobile app while maintaining the constraint that companies CANNOT sign up or onboard via mobile - mobile is user-facing + company read-only analytics.

## New Features Implemented

### 1. Enhanced Company Profile View
**File:** `lib/Presentation Layer/Screens/company_home.dart`

**Enhancements:**
- Hero section with company logo and "Supporting since YYYY"
- Active matching badge (if applicable)
- Mission & Description section
- Causes Supported (chips)
- Active Campaigns Section with progress bars
- Rewards Available Section
- Impact Stats (total matched, donors reached)
- "View Dashboard" button for company owners

### 2. Company Matching Display (Donation Flow)
**Files:**
- `lib/Presentation Layer/Widgets/matching_display_widget.dart`
- `lib/Data Layer/Blocs/matching_bloc/`

**Features:**
- Real-time match calculation when user enters amount
- Shows company logos that will match
- Impact preview: "Your $50 → $100 total impact"
- Support for base matches + campaign matches
- Compact and expanded display variants

### 3. Company Discovery/Browse
**File:** `lib/Presentation Layer/Screens/companies_list.dart`

**Enhancements:**
- Search bar for companies
- Filter chips: "All", "Active Matching", "Has Campaign"
- Category/cause filter
- Badges: "Matching 100%", "2x Campaign"
- Enhanced company cards with cause chips

### 4. Altrue Wallet - Rewards Tab
**File:** `lib/Presentation Layer/Screens/altrue_wallet_screen.dart`

**Features:**
- Tabbed interface: New | Ready | Claimed | History
- Reward cards with states (locked/unlocked/claimed)
- Digital rewards: Show code, copy button
- Physical rewards: Track shipping status
- Full lifecycle: unlocked → viewed → claimed → redeemed

### 5. User Impact Tracking
**Files:**
- `lib/Presentation Layer/Screens/user_impact_screen.dart`

**Features:**
- "Companies matched $X for you" display
- Breakdown by company
- Recent matches list
- Share impact functionality
- Summary card for profile screen

### 6. Company Owner Read-Only Dashboard
**File:** `lib/Presentation Layer/Screens/company_owner_dashboard.dart`

**Features:**
- "View-Only Mode" banner
- Stats: Matched this month, budget, unique donors
- Active campaigns list with progress bars
- Wallet status (view only)
- Recent matches feed
- Fixed footer: "Manage on Web" link

## New Models Created

### 1. Company Campaign Model
**File:** `lib/Data Layer/Models/company_campaign_model.dart`

```dart
class CompanyCampaign {
  int id;
  String name;
  double matchMultiplier;
  double budgetCap;
  double amountMatched;
  DateTime startDate;
  DateTime endDate;
  bool isActive;
  // ... helper methods
}

class MatchOffer {
  ForProfitCompany company;
  double matchPercentage;
  bool isBaseMatch;
  bool isCampaignMatch;
  String? campaignName;
  double? maxMatchAmount;
  // ... match calculation
}
```

### 2. User Reward Model
**File:** `lib/Data Layer/Models/user_reward_model.dart`

```dart
class UserReward {
  int id;
  CompanyReward reward;
  String status; // unlocked, viewed, claimed, redeemed, expired
  DateTime unlockedAt;
  DateTime? viewedAt;
  DateTime? claimedAt;
  DateTime? redeemedAt;
  String? code;
  String? shippingStatus;
  // ... status helpers
}

class CompanyReward {
  int id;
  ForProfitCompany company;
  String name;
  String description;
  String rewardType; // digital, physical, experience
  // ...
}

class WalletSummary {
  int pointsBalance;
  int activeRewardsCount;
  int newUnlocksCount;
  // ...
}
```

### 3. User Company Impact Model
**File:** `lib/Data Layer/Models/user_company_impact_model.dart`

```dart
class UserCompanyImpact {
  double totalMatched;
  int totalDonations;
  List<CompanyMatchSummary> byCompany;
  List<RecentMatch> recentMatches;
}

class CompanyMatchSummary {
  ForProfitCompany company;
  double totalMatched;
  int donationCount;
  DateTime? lastMatchedAt;
}
```

### 4. Company Dashboard Model
**File:** `lib/Data Layer/Models/company_dashboard_model.dart`

```dart
class CompanyDashboard {
  double matchedThisMonth;
  double budgetRemaining;
  double monthlyBudget;
  int uniqueDonors;
  int totalDonors;
  List<CompanyCampaign> activeCampaigns;
  double walletBalance;
  bool autoRefillEnabled;
  List<RecentMatch> recentMatches;
  CompanyImpactStats impactStats;
  bool isOwner;
}
```

## New BLoCs Created

### 1. Company Campaigns BLoC
**Location:** `lib/Data Layer/Blocs/company_campaigns_bloc/`

**Events:**
- `FetchCompanyCampaigns` - Load campaigns for a company
- `FetchCampaignDetail` - Load specific campaign details
- `RefreshCampaigns` - Refresh campaigns list

### 2. Matching BLoC
**Location:** `lib/Data Layer/Blocs/matching_bloc/`

**Events:**
- `FetchAvailableMatches` - Get available matches for donation
- `UpdateDonationAmount` - Update amount and recalculate
- `UpdateSelectedCause` - Update cause and recalculate
- `ClearMatches` - Reset matches

### 3. User Rewards BLoC
**Location:** `lib/Data Layer/Blocs/user_rewards_bloc/`

**Events:**
- `FetchWalletSummary` - Load wallet summary
- `FetchUserRewards` - Load all rewards
- `FetchRewardsByStatus` - Load filtered rewards
- `ViewReward` - Mark reward as viewed
- `ClaimReward` - Claim a reward
- `MarkRewardRedeemed` - Mark reward as used
- `CopyRewardCode` - Copy code to clipboard

### 4. Company Impact BLoC
**Location:** `lib/Data Layer/Blocs/company_impact_bloc/`

**Events:**
- `FetchUserImpactStats` - Load user's impact stats
- `FetchCompanyDashboard` - Load company dashboard
- `RefreshImpactData` - Refresh all impact data

## New Repositories Created

### 1. Company Campaign Repository
**File:** `lib/Data Layer/Repositories/company_campaign_repository.dart`

**Methods:**
- `getCompanyCampaigns()` - GET /api/companies/{id}/campaigns/
- `getCampaignDetail()` - GET /api/campaigns/{id}/
- `getActiveCampaigns()` - GET /api/campaigns/active/

### 2. Matching Repository
**File:** `lib/Data Layer/Repositories/matching_repository.dart`

**Methods:**
- `getAvailableMatches()` - GET /api/matches/available/
- `applyMatchToDonation()` - POST /api/donations/{id}/match/

### 3. Wallet Repository
**File:** `lib/Data Layer/Repositories/wallet_repository.dart`

**Methods:**
- `getWalletSummary()` - GET /api/wallet/
- `getUserRewards()` - GET /api/wallet/rewards/
- `claimReward()` - POST /api/rewards/{id}/claim/
- `markRewardAsViewed()` - POST /api/wallet/rewards/{id}/view/
- `markRewardAsRedeemed()` - POST /api/wallet/rewards/{id}/redeem/

### 4. Company Impact Repository
**File:** `lib/Data Layer/Repositories/company_impact_repository.dart`

**Methods:**
- `getUserImpactStats()` - GET /api/user/company-impact-stats/
- `getCompanyDashboard()` - GET /api/companies/{id}/dashboard/

## API Endpoints Used

| Feature | Endpoint | Method |
|---------|----------|--------|
| Company Profile | /api/companies/{slug}/ | GET |
| Company Campaigns | /api/companies/{slug}/campaigns/ | GET |
| Available Matches | /api/matches/available/ | GET |
| User Wallet | /api/wallet/ | GET |
| User Rewards | /api/wallet/rewards/ | GET |
| Claim Reward | /api/rewards/{id}/claim/ | POST |
| View Reward | /api/wallet/rewards/{id}/view/ | POST |
| Redeem Reward | /api/wallet/rewards/{id}/redeem/ | POST |
| User Impact | /api/user/company-impact-stats/ | GET |
| Company Dashboard | /api/companies/{id}/dashboard/ | GET |

## Integration Steps

### 1. Add Routes to Router

In your main router file, import and add the new routes:

```dart
import 'package:lovelovelove/Presentation%20Layer/Routers/company_ecosystem_routes.dart';

// In your GoRouter configuration, add:
routes: [
  ...yourExistingRoutes,
  ...getCompanyEcosystemRoutes(),
]
```

### 2. Wrap Company Home with BLoCs

When navigating to company home, wrap with the required BLoCs:

```dart
import 'package:lovelovelove/Presentation%20Layer/Routers/company_ecosystem_routes.dart';

// In your navigation:
GoRoute(
  path: '/companyDetails',
  builder: (context, state) {
    final company = state.extra as ForProfitCompany;
    return wrapCompanyHomeWithBlocs(
      child: MyCompanyHome(
        profile: profile,
        company: company,
      ),
      company: company,
    );
  },
),
```

### 3. Add Matching Display to Donation Screen

Import and use the matching display widget:

```dart
import 'package:lovelovelove/Presentation%20Layer/Widgets/matching_display_widget.dart';

// In your donation screen:
MatchingDisplayWidget(
  donationAmount: _selectedAmount,
  causeId: _selectedCauseId,
  nonprofitId: _selectedNonprofitId,
)
```

### 4. Add User Impact to Profile Screen

Import and add the impact summary card:

```dart
import 'package:lovelovelove/Presentation%20Layer/Screens/user_impact_screen.dart';

// In your profile screen:
UserImpactSummaryCard(profile: widget.profile)
```

### 5. Generate JSON Serializable Code

Run the build runner to generate model serialization code:

```bash
cd /Users/robert_/Documents/Altrue/FRONTEND_FLUTTER/lovelovelove-master
flutter pub run build_runner build
```

## Testing

### Unit Tests
Create tests for:
- BLoC event/state transformations
- Repository API calls
- Model serialization/deserialization

### Widget Tests
Create tests for:
- Company profile screen rendering
- Wallet screen tab navigation
- Reward state transitions
- Matching calculation display

### Integration Tests
Create tests for:
- Complete donation flow with matching
- Reward claim and redemption flow
- Company dashboard data loading

## UI/UX Guidelines Followed

### Company Owner Indicators
- "Your Company" badge on company profile (amber outline chip)
- "View-Only Mode" banner on dashboard (full-width amber)
- "Manage on Web" call-to-action (fixed footer button)

### Reward States
- Locked: Grey background, lock icon
- Unlocked: Amber border, "NEW" badge, gift icon
- Claimed: Green badge, checkmark
- Redeemed: Blue badge, checkmark
- Expired: Red badge, X icon

### Matching Display
- Company logos prominently displayed
- Impact math clearly shown
- Multiple companies shown with scrollable row
- Gradient background to highlight importance

## Security Considerations

### Read-Only Enforcement
- Company dashboard explicitly marked as "View-Only"
- No edit/create/delete actions in mobile app
- All management links redirect to web dashboard
- API calls use GET only for company owner data

### Authentication
- All BLoCs verify user authentication before API calls
- User token required for all impact/wallet endpoints
- Company ownership verified server-side

## Dependencies Added

The following dependencies are already in pubspec.yaml and used:
- `share_plus` - For sharing impact
- `url_launcher` - For web dashboard links
- `intl` - For date/number formatting

## Next Steps

1. Run code generation: `flutter pub run build_runner build`
2. Add routes to your router configuration
3. Test on emulator/device
4. Verify API endpoints are live on backend
5. Add analytics tracking for reward interactions

## Support

For questions or issues:
1. Check API endpoint availability
2. Verify user authentication is working
3. Check BLoC state transitions in DevTools
4. Review model field mappings with backend
