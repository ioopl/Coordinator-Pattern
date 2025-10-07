import UIKit
import Foundation

// IMP discussions (see below also): https://chatgpt.com/s/t_68e27500df988191a6dc5d7b69134710

// MARK: - Result passed from child to parent
enum AuthResult {
    case success
    case cancelled
}

// MARK: - Minimal Coordinators
protocol Coordinator {
    func start()
}

final class AuthCoordinator: Coordinator {
    // The closure the PARENT sets; the CHILD calls.
    // AuthResult is the input type — what the closure receives when it’s called. In our case it’s an enum .success or .cancelled.
    // This means “I can hold a closure (callback) that accepts one AuthResult value (like .success or .cancelled) and returns nothing.”
    // At this point, onFinish is empty — no one has given it a closure yet.
    // Step 1 — Define what onFinish is
    var onFinish: ((AuthResult) -> Void)?

    func start() {
        print("AuthCoordinator.start(): show login screen")
        // In a real app you’d present a Login VC.
    }

    // Simulate user actions:
    func simulateUserTappedLogin() {
        print("AuthCoordinator: user tapped Log In ➜ finishing with .success")
        // Step 3 — Child (AuthCoordinator) calls the closure
        // When something happens inside AuthCoordinator (say, user taps “Log In”), we run:
        // “If my onFinish closure has been set, call it now, and give it the value .success as its input.”
        // Think of this as PUBLISHING the event with the payload.
        // Invokes (calls) that particular closure now, passing the value .success.
        // It says: “I’m done; here’s my result.”
        onFinish?(.success) // <-- CHILD calls the closure, passing data which is the enum .success upward
    }

    func simulateUserTappedCancel() {
        print("AuthCoordinator: user tapped Cancel ➜ finishing with .cancelled")
        onFinish?(.cancelled)
    }

    deinit { print("AuthCoordinator.deinit") }
}

final class AppCoordinator: Coordinator {
    // Keep a strong ref while the child flow is active
    private var authCoordinator: AuthCoordinator?

    func start() {
        print("AppCoordinator.start()")
        showAuth()
    }

    private func showAuth() {
        print("AppCoordinator: presenting Auth flow")
        // Parent AppCoordinator creates child AuthCoordinator
        let auth = AuthCoordinator()

        // PARENT sets the child's callback (closure).
        // The child will CALL this later.
        // Step 2 — Parent (AppCoordinator) sets the closure
        // Think of this as SUBSCRIBING to an event and specifying what to do when it fires.
        // Assigns/defines the closure (the handler) that will run later.
        // What happens when we write [weak self] That means: “Inside this closure, if I reference self, capture it weakly (don’t increase its retain count).” So if the AppCoordinator (the self here) is deallocated, the closure won’t keep it alive and cause a memory leak. ✅ That protects against this retain cycle.
        // Why do we also add [weak auth]? Because inside the closure, we also reference the child coordinator (auth) here: if let auth ...
        // So if we didn’t make auth weak, then this closure (which belongs to the parent) would strongly capture the child again — creating another cycle : That would prevent AuthCoordinator from ever deallocating, even after we remove it from the child array. https://chatgpt.com/s/t_68e3bb351e2c8191bf0c7e35a74db466
        
        auth.onFinish = { [weak self, weak auth] result in
            guard let self else { return }
            print("AppCoordinator: received Auth result = \(result)")

            // Clean up child (so it can deallocate)
            if let auth { print("AppCoordinator: removing child \(auth)") }
            self.authCoordinator = nil

            switch result {
            case .success:
                self.showMain()
            case .cancelled:
                print("AppCoordinator: staying on auth (cancelled)")
            }
        }

        // Keep strong reference while active
        self.authCoordinator = auth
        auth.start()
    }

    private func showMain() {
        print("AppCoordinator: ✅ routed to Main flow")
        // In a real app you'd push/present the main UI here.
    }

    deinit { print("AppCoordinator.deinit") }
}

// MARK: - Drive it like a test

print("=== Scenario 1: Success ===")
do {
    let app = AppCoordinator()
    app.start()

    // Reach into the auth coordinator to simulate user input.
    // (In a real app, taps would come from the UI; this is Playground-only.)
    // We use Mirror just to peek the private property for demo purposes.
    if let auth = Mirror(reflecting: app).children
        .first(where: { $0.label == "authCoordinator" })?.value as? AuthCoordinator {
        auth.simulateUserTappedLogin()
    }

    // When auth finishes with success, AppCoordinator clears its child,
    // so you should see AuthCoordinator.deinit soon after.
}

print("\n=== Scenario 2: Cancel ===")
do {
    let app = AppCoordinator()
    app.start()
    if let auth = Mirror(reflecting: app).children
        .first(where: { $0.label == "authCoordinator" })?.value as? AuthCoordinator {
        auth.simulateUserTappedCancel()
    }
}

/*
 Q: So parent AppCoordinator is setting child AuthCoordinator but then using it below value as well, i.e. inside closure like so:
 switch result {
             case .success:
                 self.showMain()
 So its not just Setting it, its using it as well, which is same as calling it from Child AuthCoordinator like so:
 onFinish?(.success) // <-- CHILD calls the closure, passing data which is the enum .success upward
 So what exactly is the difference between the two ? one is case .success in Parent AppCoordinator and one is onFinish?(.success) in Child AuthCoordinator?
 */
