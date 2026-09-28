# Altrue Product Audit: Mobile vs Web vs Landing Page

## Executive Summary
The Flutter mobile app has **significantly more features** than both the web dashboard and landing page represent. This audit identifies gaps across three areas:
1. **Mobile → Web Dashboard** (features donors/companies need on web)
2. **Mobile → Landing Page** (product aspects not marketed)
3. **Incomplete Features** (started but not finished in mobile)

---

## Part 1: MAJOR FEATURES MISSING FROM WEB DASHBOARD

### 🔴 CRITICAL GAPS

| Feature | Mobile Status | Web Status | Impact |
|---------|--------------|------------|--------|
| **Shirt/Merchandise Store** | ✅ Full e-commerce with variants, sizes, colors, ratings | ❌ Completely missing | HIGH - Revenue stream |
| **Quiz System** | ✅ Educational quizzes with points | ❌ Missing | HIGH - Engagement |
| **Leaderboards** | ✅ Top 100 + All Users ranking | ❌ Missing | MEDIUM - Gamification |
| **Social Feed/Posts** | ✅ Activity feed + user posts | ❌ Missing | MEDIUM - Community |
| **Friends/Following** | ✅ Find friends, follow users, invite | ❌ Missing | MEDIUM - Viral growth |
| **Altrue Actions** | ✅ Gamified tasks with points | ❌ Missing | HIGH - Retention |
| **Point Promotions** | ✅ Multiplier events, bonuses | ❌ Missing | MEDIUM - Marketing |
| **QR Code Donations** | ✅ Personal QR for donations | ❌ Missing | HIGH - Offline acquisition |
| **Altrue Levels** | ✅ Level-up system | ❌ Missing | MEDIUM - Engagement |
| **Atrocities** | ✅ Constant non partisan updates about different atrocities going on around the globe and which nonprofits are doing the most to combat them  | ❌ Missing | MEDIUM - Viral growth |
### 🟡 MODERATE GAPS

| Feature | Mobile | Web | Notes |
|---------|--------|-----|-------|
| **Ratings/Reviews** | ✅ Shirts, nonprofits, projects, companies | ❌ Missing | Social proof missing |
| **Crypto Wallet** | ✅ Create/connect wallet (ETH) | ❌ Missing | Web3 future |
| **Links/Curation** | ✅ Share articles related to causes | ❌ Missing | Content marketing |
| **Shirt Groups** | ✅ Curated shirt collections | ❌ Missing | Discovery feature |

---

## Part 2: PRODUCT ASPECTS MISSING FROM LANDING PAGE

### 🎯 Core Value Props Not Mentioned

1. **Gamification Layer**
   - "Complete actions, earn points, level up"
   - "Compete on leaderboards"
   - "Unlock achievements"
   - *None of this is on the landing page*

2. **Social Layer**
   - "Follow friends and see their impact"
   - "Share your giving journey"
   - "Build a following around causes you care about"
   - *Social features are completely unmentioned*

3. **Educational Layer**
   - "Learn about causes through interactive quizzes"
   - "Get educated, get points, give smarter"
   - *Quizzes are a differentiator not mentioned*

4. **Merchandise/Commerce**
   - "Wear your impact" (QR shirts mentioned but not the store)
   - "Shop cause-aligned apparel"
   - "Earn points on every purchase"
   - *No mention of the e-commerce engine*

5. **Crypto/Web3**
   - "Connect your Web3 wallet"
   - "Blockchain-verified donations"
   - *Future-proofing not mentioned*

6. **QR Code Network Effect**
   - "Your personal donation QR code"
   - "Friends scan, donate, you both get points"
   - *The viral loop mechanic isn't explained*

### 📱 Mobile-Only Features That Should Be Marketed

| Feature | Why It Matters | Landing Page Gap |
|---------|---------------|------------------|
| **Altrue Wallet** | Central hub for rewards | Only mentioned in passing |
| **User Rewards** | Company perks for donors | Not mentioned |
| **Point Economy** | Engagement + retention driver | Completely absent |
| **Activity Feed** | Social proof + discovery | Not mentioned |

---

## Part 3: INCOMPLETE FEATURES IN MOBILE

### 🚧 Placeholder Screens (Need Completion)

| Screen | Current State | Completion % |
|--------|--------------|--------------|
| `altrue_actions_screen.dart` | Empty scaffold with title | ~10% |
| `create_link.dart` | Empty scaffold | ~5% |
| `connect_wallet.dart` | Placeholder widget | ~5% |
| `user_actions_screen.dart` | Empty or minimal | ~15% |

### 🔧 Partial Implementations

| Feature | What's Working | What's Missing |
|---------|---------------|----------------|
| **Crypto Wallet** | Create wallet with mnemonic | WalletConnect, transactions, balance display |
| **Company Matching** | View matches | Create/edit matches (web only?) |
| **Links** | Model exists | Full UI for creating/sharing |

---

## Part 4: FEATURE MATRIX

### Complete Feature Inventory

| Category | Feature | Mobile | Web Dashboard | Landing Page |
|----------|---------|--------|---------------|--------------|
| **Core** | Donations | ✅ | ✅ | ✅ |
| **Core** | Nonprofit Profiles | ✅ | ✅ | ✅ |
| **Core** | Company Profiles | ✅ | ✅ | ✅ |
| **Core** | User Profiles | ✅ | ✅ | ❌ |
| **Core** | Causes/Atrocities | ✅ | ✅ | ✅ |
| **Core** | Projects | ✅ | ✅ | ✅ |
| **Commerce** | Shirt Store | ✅ | ❌ | Partial |
| **Commerce** | Shirt Variants | ✅ | ❌ | ❌ |
| **Commerce** | Cart/Checkout | ✅ | ❌ | ❌ |
| **Commerce** | Ratings/Reviews | ✅ | ❌ | ❌ |
| **Gamification** | Points System | ✅ | ❌ | ❌ |
| **Gamification** | Levels | ✅ | ❌ | ❌ |
| **Gamification** | Altrue Actions | Partial | ❌ | ❌ |
| **Gamification** | Quizzes | ✅ | ❌ | ❌ |
| **Gamification** | Leaderboards | ✅ | ❌ | ❌ |
| **Gamification** | Promotions | ✅ | ❌ | ❌ |
| **Social** | Activity Feed | ✅ | ❌ | ❌ |
| **Social** | Posts | ✅ | ❌ | ❌ |
| **Social** | Friends/Following | ✅ | ❌ | ❌ |
| **Social** | Find Friends | ✅ | ❌ | ❌ |
| **Social** | QR Codes | ✅ | ❌ | Partial |
| **Crypto** | Wallet Creation | Partial | ❌ | ❌ |
| **Crypto** | WalletConnect | ❌ | ❌ | ❌ |
| **Company** | Matching Rules | ✅ | ✅ | ✅ |
| **Company** | Campaigns | ✅ | ✅ | ✅ |
| **Company** | Dashboard | ✅ | ✅ | ❌ |
| **Company** | Rewards | ✅ | ✅ | Partial |
| **User** | Wallet/Rewards | ✅ | ❌ | Partial |
| **User** | Impact Tracking | ✅ | Partial | ❌ |
| **Content** | Links/Curation | Partial | ❌ | ❌ |
| **Admin** | User Management | ❌ | ✅ | N/A |
| **Admin** | Nonprofit Verification | ❌ | ✅ | N/A |
| **Admin** | Order Management | Partial | ✅ | N/A |

---

## Part 5: RECOMMENDATIONS

### Immediate Priority (High Impact, Low Effort)

1. **Landing Page - Add Gamification Hook**
   ```
   "Turn giving into a game. Earn points, level up, 
    compete with friends, and unlock exclusive rewards."
   ```

2. **Landing Page - Add Social Proof Section**
   ```
   "Join 15,000+ donors building a community of impact. 
    Follow friends, share your journey, inspire others."
   ```

3. **Landing Page - Explain QR Codes Better**
   ```
   "Wear your impact. Get a personalized QR code that 
    lets anyone donate to your favorite causes instantly."
   ```

### Short-Term Priority (1-2 Sprints)

4. **Web Dashboard - Add Shirt Store**
   - Donors browse shirts on web
   - Mobile checkout (or Stripe web checkout)

5. **Web Dashboard - Add Leaderboard**
   - Simple read-only view
   - Good for social proof

6. **Complete Altrue Actions Screen**
   - Gamification is core to retention
   - Should work mobile + web

### Medium-Term Priority (1-2 Months)

7. **Web Dashboard - Social Features**
   - Activity feed read-only
   - Friend discovery

8. **Web Dashboard - Quiz Access**
   - Educational content drives engagement

9. **Mobile - Complete Crypto Flow**
   - WalletConnect integration
   - Donation via crypto

### Long-Term Priority (Roadmap)

10. **Unified Wallet Across Platforms**
    - Same Altrue Wallet on mobile + web
    - Shared rewards state

11. **Full Social Layer on Web**
    - Posts, comments, likes
    - Following/followers

12. **Content Platform (Links)**
    - Curated news about causes
    - User-generated content

---

## Part 6: HIDDEN GEMS TO MARKET

These features are built but not highlighted:

1. **"The More You Give, The More You Get"**
   - Point multiplier events
   - Level-based perks
   - Exclusive rewards

2. **"Learn While You Give"**
   - Quizzes educate about causes
   - Points for learning
   - Smarter donors = better retention

3. **"Your Personal QR Code"**
   - Unique to each user
   - Share anywhere
   - Offline → online donations

4. **"Wear Your Impact"**
   - Physical shirts with QR codes
   - Walking billboards for causes
   - Fashion meets philanthropy

5. **"Compete for Good"**
   - Leaderboards
   - Monthly challenges
   - Company leaderboards

---

## Summary Stats

- **Total Mobile Screens**: 65+
- **Total Models**: 75+
- **Features on Mobile Only**: ~15
- **Features on Web Only**: ~3 (admin)
- **Landing Page Coverage**: ~40% of product features

**The mobile app is the full product. The web dashboard is currently an admin tool. The landing page undersells the platform.**
