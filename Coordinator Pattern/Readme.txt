What each piece is doing (and why)
Coordinator (protocol): a tiny interface so all coordinators expose start() and hold a UINavigationController. That’s it.
BaseCoordinator (optional): just avoids copy-pasting child-coordinator bookkeeping (childCoordinators, add/remove). You can delete it if you don’t need multiple nested flows.
AuthCoordinator.onFinish: this is the output of the auth flow. The parent (AppCoordinator) needs to know “login succeeded/cancelled” to switch to Main. We use a callback so Auth doesn’t call parent APIs directly (decoupling + easy to unit test).
Bridge: LoginViewController.onLogin → AuthCoordinator.onFinish(.success) → AppCoordinator swaps to Main.
MainCoordinator.onLogout: the mirror of the above. “User wants out,” bubble that up to the parent so it can swap back to Auth.
Bridge: HomeViewController.onLogout → MainCoordinator.onLogout() → AppCoordinator shows Auth.
Think of VC closures as intent signals (“user tapped X”), and coordinator closures as flow outputs (“this flow is done”). That separation keeps VCs dumb and flows testable.

Ref: https://chatgpt.com/s/t_68dc6754197c819180ce346f11515086


--------------------------------------------------------------------------------------------------------------------------

1)
         ┌───────────────┐
         │  Coordinator  │  (protocol)
         └───────┬───────┘
                 │
        conforms │
                 ▼
         ┌──────────────────┐
         │  BaseCoordinator │  (concrete, child mgmt)
         └───┬─────────┬───┘
             │         │
             │         │
   ┌─────────▼───┐  ┌──▼──────────┐
   │AppCoordinator│  │AuthCoordinator│
   └──────────────┘  └───────┬──────┘
                              │
                          ┌───▼─────────┐
                          │MainCoordinator│
                          └──────────────┘


2)
SceneDelegate
   │ creates
   ▼
AppCoordinator (root)
   │ holds strong refs to child coordinators
   ├── AuthCoordinator  ── presents → LoginViewController
   └── MainCoordinator  ── shows     → HomeViewController
                                   ├─ push → DetailsViewController
                                   └─ push → SettingsViewController


3)
[App/Scene launch]
   └─> SceneDelegate makes UIWindow + UINavigationController
         └─> creates AppCoordinator(nav), calls start()
               └─> decides by auth state:

                 if NOT authenticated:
                    AppCoordinator → starts AuthCoordinator
                    AuthCoordinator → shows LoginViewController  ← (start screen)

                 if authenticated:
                    AppCoordinator → starts MainCoordinator
                    MainCoordinator → shows HomeViewController   ← (start screen)


4)
User taps "Log In" on LoginViewController
   └─ LoginVC calls onLogin?()
        └─ AuthCoordinator invokes onFinish(.success)
             └─ AppCoordinator removes Auth, starts Main
                  └─ MainCoordinator shows HomeViewController





"Details"  button → HomeVC.onDetails?()   → MainCoordinator.showDetails()   → push DetailsVC
"Settings" button → HomeVC.onSettings?()  → MainCoordinator.showSettings()  → push SettingsVC
"Log out"  button → HomeVC.onLogout?()    → MainCoordinator.onLogout?()     → AppCoordinator shows Auth again


Ref: https://chatgpt.com/s/t_68dc5be2dc248191aeea8d9c5bd57864

