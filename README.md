Approach & Design Decisions
This project was implemented as a focused MVP with emphasis on correctness, clarity, and real-world data flow rather than UI complexity.

Key design choices:
One question per day
Instead of random questions, the app uses the current date (yyyy-MM-dd) as the document ID in Firestore.
This guarantees:
  1)all users see the same question each day
  2)questions are automatically “locked” by date
  3)no extra backend logic is required

Submit-to-unlock logic
The solution is not shown by default.
A user must submit an answer first, which is stored under:
users/{uid}/attempts/{date} 

Once an attempt exists, the UI switches to show:
  1)the user’s submitted answer
  2)the official solution

Separation of concerns
AuthScreen handles authentication only
HomeScreen handles question fetching, submission, and display
Firebase Auth is used only for identity
Firestore is used only for content + attempts

Minimal but realistic UI
No unnecessary animations or heavy widgets
Clear text, form inputs, and feedback
Designed for daily use and readability

What I Would Implement Next (Given More Time)

If extended beyond the MVP, the next steps would be:
  1) Streak Tracking
  2)Count consecutive days attempted
  3)Track missed days
  4)Store streak metadata per user
  5)Analytics Screen
  6)Days attempted vs missed
  7)Weekly consistency view
  8)Simple charts for engagement
  9)Offline Support
  10)Cache the daily question locally
  11)Allow writing answers offline
  12)Sync when network is available
  13)Notifications
  14)Daily reminder notification
  15)Configurable reminder time
  16)Improved Content Rendering
  17)Syntax-highlighted code blocks
  18)Markdown support for problems/solutions
  19)Security Hardening
  20)Proper Firestore rules
  21)Read-only public questions
  22) Write access limited to authenticated users

Why This MVP

The goal was to demonstrate core engineering concepts:
authentication, async data fetching,conditional UI rendering,state handling,backend integration,rather than build a fully polished product.
