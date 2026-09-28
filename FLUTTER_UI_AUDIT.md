# Flutter UI Glassmorphism Audit - Altrue Global
**Date:** 2026-02-27  
**Project:** Altrue Mobile App UI Overhaul  
**Style:** Glassmorphism + Modern Polish  
**Color Palette:** Gold (#D4AF37), Dark Theme (#121212, #1e1e1e)

---

## 📊 EXECUTIVE SUMMARY

**Total Widgets/Screens to Update:** 67 items

| Category | Count | Priority |
|----------|-------|----------|
| 🟢 Modern (Keep/Minor Polish) | 8 | Low |
| 🟡 Needs Work (Moderate Updates) | 23 | Medium |
| 🔴 Outdated (Full Redesign) | 36 | High |

**Estimated Agent Tasks:** 15-20 spawn requests  
**Estimated Budget:** $8-12 (mostly Local LLM for boilerplate)

---

## 🟢 TIER 1: MODERN - Minor Polish Only (8 items)

These are already well-designed with gradients, gold accents, and good structure. Just need minor glassmorphism enhancements.

### Screens
| # | Screen | File Path | Notes |
|---|--------|-----------|-------|
| 1 | **UserLevelHeroCard** | `Widgets/altrueLevelProfileCard.dart` | ✅ Already modern - just add glass effect |
| 2 | **CumulativeStatsHeroCard** | `Widgets/AltrueStatsCard.dart` | ✅ Good structure - enhance shadows |
| 3 | **NpProjectCard** | `Widgets/np_project_card.dart` | ✅ Modern card - glass overlay on image |
| 4 | **SignUpScreen** | `Screens/signup_screen.dart` | ✅ Good dark theme - polish inputs |

### Widgets
| # | Widget | File Path | Notes |
|---|--------|-----------|-------|
| 5 | **AltrueActionCard** | `Widgets/company_dashboard/altrue_action_card.dart` | ✅ Unique shape - add glass border |
| 6 | **CompanyDetailPage** | `Widgets/company/company_detail_page.dart` | ✅ Clean - enhance with glass |
| 7 | **WaterView** | `Widgets/company_dashboard/water_view.dart` | ✅ Already has wave - keep |
| 8 | **MediterraneanDietView** | `Widgets/company_dashboard/mediteranein_diet.dart` | ✅ Good visual - minor polish |

---

## 🟡 TIER 2: NEEDS WORK - Moderate Updates (23 items)

These have some design elements but need significant glassmorphism updates, better spacing, typography, or color consistency.

### Screens - High Traffic (Update First)
| # | Screen | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 9 | **HomeScreen** | `Screens/home_screen.dart` | Cluttered layout, needs glass cards | Medium |
| 10 | **UserProfileScreen** | `Screens/user_profile_screen.dart` | White gradient bg, outdated layout | Medium |
| 11 | **RewardsHome** | `Screens/rewardsHome.dart` | Needs cohesive card design | Medium |
| 12 | **LeaderboardScreen** | `Screens/leaderboard_screen.dart` | Basic list, needs glass cards | Medium |
| 13 | **NonProfitDetail** | `Screens/non_profit_detail.dart` | Information overload, needs tabs | High |
| 14 | **AtrocityDetails** | `Screens/atrocity_details.dart` | Needs glass overlay effects | Medium |
| 15 | **CompanyDashboard** | `Screens/company_dashboard.dart` | Mix of styles, needs consistency | High |

### Core Widgets
| # | Widget | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 16 | **PaymentScreen** | `Widgets/payment_sheet.dart` | White background, needs dark glass | Medium |
| 17 | **ProfileDrawer** | `Widgets/profile_drawer.dart` | Needs glassmorphism background | Low |
| 18 | **FeaturedShirts** | `Widgets/Featured_Shirts.dart` | Basic carousel, needs glass cards | Medium |
| 19 | **WeeklyFeaturedShirts** | `Widgets/weekly_featured_shirts.dart` | Same as above | Medium |
| 20 | **ShirtGroupCard** | `Widgets/Shirt_Group_Card.dart` | Plain design, needs elevation | Medium |
| 21 | **ShirtGroupShirtCard** | `Widgets/ShirtgroupShirtCard.dart` | Needs consistent card style | Medium |
| 22 | **CardForAllProjectsList** | `Widgets/card_for_all_projectsList.dart` | Basic list item, needs glass | Low |
| 23 | **ProjectsFollowingCard** | `Widgets/myNpProjects_card.dart` | Inconsistent height/spacing | Medium |

### Company Ecosystem
| # | Widget | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 24 | **CompanyOwnerDashboard** | `Screens/company_owner_dashboard.dart` | Needs full glass redesign | High |
| 25 | **CompanyDetailTabs** | `Widgets/company/CompanyDetailTabs/company_detail_tabs.dart` | Plain tabs, needs glass | Medium |
| 26 | **CompanyMatchingInfo** | `Widgets/company/CompanyDetailTabs/company_matching_info.dart` | Basic cards, needs polish | Medium |
| 27 | **CompanyCouponCard** | `Widgets/company/CompanyDetailTabs/company_coupon_card.dart` | Needs glass effect | Low |

### Navigation & Actions
| # | Widget | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 28 | **AltrueWalletScreen** | `Screens/altrue_wallet_screen.dart` | Needs glass card design | Medium |
| 29 | **FindFriendsScreen** | `Screens/find_friends_screen.dart` | List needs glass cards | Medium |
| 30 | **UserActionsScreen** | `Screens/user_actions_screen.dart` | Plain buttons, needs glass | Medium |
| 31 | **AltrueActionsScreen** | `Screens/altrue_actions_screen.dart` | Same as above | Medium |

---

## 🔴 TIER 3: OUTDATED - Full Redesign Needed (36 items)

These are using old design patterns, inconsistent colors, or need complete glassmorphism rebuilds.

### Critical Screens
| # | Screen | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 32 | **LoginScreen** | `Forms/login_form.dart` | Needs complete glass redesign | High |
| 33 | **UserLoginForm** | `Forms/user_login_form.dart` | Outdated, needs modern auth UI | High |
| 34 | **EmailVerification** | `Screens/email_verification_screen.dart` | Plain white, needs dark glass | Medium |
| 35 | **SplashPage** | `Screens/splash_page.dart` | Basic, needs premium feel | Medium |
| 36 | **MainScreen** | `Screens/main_screen.dart` | Navigation needs glass styling | Medium |

### Nonprofit & Causes
| # | Screen/Widget | File Path | Issue | Effort |
|---|---------------|-----------|-------|--------|
| 37 | **NonProfitListScreen** | `Screens/nonprofit_list_screen.dart` | Basic list, needs glass cards | Medium |
| 38 | **NonprofitListBox** | `Widgets/nonprofit_list_box.dart` | Doesn't exist or outdated | High |
| 39 | **NonprofitSignup** | `Screens/nonprofit_signup.dart` | Form needs glass styling | Medium |
| 40 | **MyNonprofitScreen** | `Screens/mynonprofit_screen.dart` | Needs full redesign | High |
| 41 | **CauseDetails** | `Screens/cause_details.dart` | Needs glass overlay | Medium |
| 42 | **CauseList** | `Screens/cause_list.dart` | Basic list view | Medium |
| 43 | **AtrocityList** | `Screens/atrocity_list.dart` | Needs glass cards | Medium |
| 44 | **AtrocityListBox** | `Widgets/atrocity_list_box.dart` | Outdated VelocityX styling | High |

### Cards & Lists (High Priority)
| # | Widget | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 45 | **CardWidget** (Featured Atrocities) | `Widgets/hompage/Featured_Atrocities/card_widget.dart` | Uses VelocityX, needs glass | High |
| 46 | **Swiper** | `Widgets/hompage/Featured_Atrocities/swiper.dart` | Basic implementation | Medium |
| 47 | **LeaderboardWidget** | `Widgets/leaderboard_list.dart` | Needs glass cards | Medium |
| 48 | **LeaderboardProfileCard** | `Widgets/leaderboard_profile_card.dart` | Plain design | Low |
| 49 | **PromotedActionsList** | `Widgets/promoted_actions_list.dart` | Needs glass cards | Medium |
| 50 | **MatchingDisplayWidget** | `Widgets/matching_display_widget.dart` | Plain text display | Low |
| 51 | **NPDonationBottomSheet** | `Widgets/npdonation_bottomsheet.dart` | White background | Medium |

### Forms & Inputs
| # | Widget | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 52 | **AddressForm** | `Widgets/address_form.dart` | Plain form, needs glass inputs | Medium |
| 53 | **CreditCardStorage** | `Widgets/credit_card_storage.dart` | Needs glass card design | Medium |
| 54 | **CreditCardPage** | `Screens/credit_card_page.dart` | Basic layout | Medium |
| 55 | **MaximumAmountField** | `Widgets/company_match_screen/maximum_amount_field.dart` | Basic text field | Low |
| 56 | **CompanyDonationForm** | `Widgets/company_dontation_form.dart` | Needs glass styling | Medium |

### Project & Shirt Ordering
| # | Widget | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 57 | **NPProjectDonateModal** | `Widgets/np_project_donate_modal.dart` | Plain white modal | Medium |
| 58 | **ShirtOrderWidget** | `Widgets/shirt_order/shirt_order_widget.dart` | Needs glass styling | Medium |
| 59 | **ShirtSizePicker** | `Widgets/shirt_order/shirt_size_picker.dart` | Basic buttons | Low |
| 60 | **ColorPicker** | `Widgets/shirt_order/color_picker.dart` | Needs glass circles | Low |
| 61 | **ProjectPicker** | `Widgets/shirt_order/project_picker.dart` | Needs glass cards | Medium |
| 62 | **ShirtCounter** | `Widgets/shirt_order/shirt_couter.dart` | Basic counter | Low |
| 63 | **EditOrderDialogue** | `Widgets/edit_order_diallogue.dart` | Needs glass modal | Medium |

### Misc Components
| # | Widget | File Path | Issue | Effort |
|---|--------|-----------|-------|--------|
| 64 | **IntroSlider** | `Widgets/Intro_Slider/intro_slider.dart` | Needs glass slides | Medium |
| 65 | **CartBottomScreen** | `Widgets/cart_bottom_screen.dart` | Needs glass styling | Medium |
| 66 | **CartIcon** | `Widgets/cart_icon.dart` | Basic badge, needs glass | Low |
| 67 | **AdvancedDrawerListTile** | `Widgets/advancedDrawer_list_tile.dart` | Needs glass styling | Low |

---

## 🎯 RECOMMENDED IMPLEMENTATION ORDER

### Phase 1: Foundation (Week 1)
**Focus:** Core user flows - Login, Home, Profile

1. **Login/Signup Screens** (32, 33, 4)
   - Create reusable glassmorphism input fields
   - Dark gradient backgrounds
   - Gold accent buttons

2. **HomeScreen** (9)
   - Redesign 5-button layout with glass cards
   - Featured atrocities swiper with glass overlay

3. **UserProfileScreen** (10)
   - Remove white gradient
   - Glass card layout for stats

### Phase 2: Core Features (Week 2)
**Focus:** Nonprofits, Projects, Donations

4. **NonProfitDetail** (13)
   - Tab-based layout with glass panels
   - Glass donation modal

5. **NpProjectCard** (3) - Polish
6. **PaymentScreen** (16) - Dark glass redesign
7. **AltrueWalletScreen** (28)

### Phase 3: Community & Company (Week 3)
**Focus:** Social features, Company ecosystem

8. **LeaderboardScreen** (12)
9. **RewardsHome** (11)
10. **CompanyOwnerDashboard** (24)
11. **FindFriendsScreen** (29)

### Phase 4: Polish & Consistency (Week 4)
**Focus:** Remaining widgets, design system documentation

12. All Tier 2 items (23 widgets)
13. Forms and inputs (52-56)
14. Shirt ordering flow (57-63)

---

## 🎨 GLASSMORPHISM DESIGN SPEC

### Core Effects
```dart
// Standard Glass Card
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.05),
      ],
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 20,
        spreadRadius: 5,
      ),
    ],
  ),
  backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
)
```

### Color Palette
| Element | Color | Usage |
|---------|-------|-------|
| Primary Gold | `#D4AF37` | CTAs, accents, progress bars |
| Dark Background | `#121212` | Main app background |
| Elevated Dark | `#1e1e1e` | Cards, surfaces |
| Glass White | `rgba(255,255,255,0.1)` | Glass surfaces |
| Glass Border | `rgba(255,255,255,0.2)` | Glass borders |
| Text Primary | `#FFFFFF` | Headlines |
| Text Secondary | `#B3B3B3` | Body text |
| Text Muted | `#808080` | Captions |

### Typography Scale
| Level | Size | Weight | Usage |
|-------|------|--------|-------|
| Hero | 32px | Bold | User name, large stats |
| H1 | 24px | Bold | Screen titles |
| H2 | 20px | SemiBold | Card titles |
| H3 | 16px | SemiBold | Section headers |
| Body | 14px | Regular | General text |
| Caption | 12px | Regular | Labels, hints |

### Spacing System
| Token | Value | Usage |
|-------|-------|-------|
| xs | 4px | Tight spacing |
| sm | 8px | Icon padding |
| md | 16px | Card padding |
| lg | 24px | Section spacing |
| xl | 32px | Screen padding |

---

## 🤖 AGENT SPAWN STRATEGY

### Task Breakdown for Agents

**Agent 1: Design System Foundation (Local LLM - FREE)**
- Create `glassmorphism_theme.dart` with all reusable effects
- Define color constants, typography, spacing
- Create `GlassCard`, `GlassButton`, `GlassInput` widgets

**Agent 2: Auth Screens (Kimi K2.5 - ~$1)**
- Redesign Login/Signup with glassmorphism
- Create reusable glass input components

**Agent 3: Home & Profile (Kimi K2.5 - ~$1.50)**
- Redesign HomeScreen layout
- Redesign UserProfileScreen

**Agent 4: Core Cards (Local LLM - FREE)**
- Update NpProjectCard, AltrueActionCard
- Create glass donation modal

**Agent 5: Nonprofit Flow (Kimi K2.5 - ~$1)**
- NonProfitDetail redesign
- Nonprofit list items

**Agent 6: Payment & Wallet (Kimi K2.5 - ~$1)**
- PaymentScreen dark glass redesign
- AltrueWalletScreen

**Agent 7: Company & Social (Kimi K2.5 - ~$1.50)**
- CompanyOwnerDashboard
- LeaderboardScreen
- RewardsHome

**Total Estimated Cost: $6-8** (well within budget)

---

## ✅ CHECKLIST FOR EACH WIDGET

When updating each widget, ensure:

- [ ] Uses glassmorphism `Container` with blur
- [ ] Has gold (#D4AF37) accent somewhere
- [ ] Dark background (#121212 or #1e1e1e)
- [ ] Proper border radius (16-24px)
- [ ] Subtle shadow for elevation
- [ ] White text with proper contrast
- [ ] Consistent spacing (8px, 16px, 24px)
- [ ] Image error handling (grey placeholder + icon)
- [ ] Responsive layout
- [ ] Accessibility labels where needed

---

## 📁 FILES REFERENCE

**Project Root:** `~/Documents/altrue/FRONTEND_FLUTTER/lovelovelove-master/lib/`

**Screens:** `Presentation Layer/Screens/`
**Widgets:** `Presentation Layer/Widgets/`
**Models:** `Data Layer/Models/`
**Blocs:** `Data Layer/Blocs/`

---

**Next Step:** Spawn Agent 1 to create the design system foundation with Local LLM (free)
