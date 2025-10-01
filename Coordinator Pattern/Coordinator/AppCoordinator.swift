import UIKit

/// Start of coordinator: AppCoordinator (created by SceneDelegate).
/// Start screen: LoginViewController if logged out, HomeViewController if logged in.

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private var isAuthenticated: Bool

    init(window: UIWindow, isAuthenticated: Bool = false) {
        self.window = window
        self.isAuthenticated = isAuthenticated
        super.init(navigationController: UINavigationController())
        self.navigationController.navigationBar.prefersLargeTitles = true
    }

    override func start() {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        route()
    }

    private func route() {
        if isAuthenticated {
            showMain()
        } else {
            showAuth()
        }
    }

    private func showAuth() {
        navigationController.setViewControllers([], animated: false)

        let auth = AuthCoordinator(navigationController: navigationController)
        
        auth.onFinish = { [weak self, weak auth] result in
        
            guard let self else { return }
            
            if let auth { self.remove(child: auth) }

            switch result {
                
            case .LoginSuccess:
                self.isAuthenticated = true
                self.showMain()

            case .LoginCancelled:
                // Stay on auth in this sample
                break
            }
        }
        add(child: auth)
        auth.start()
    }

    private func showMain() {
        navigationController.setViewControllers([], animated: false)

        let main = MainCoordinator(navigationController: navigationController)

        main.onLogout = { [weak self, weak main] in

            guard let self else { return }

            if let main { self.remove(child: main) }

            self.isAuthenticated = false

            self.showAuth()
        }
        
        add(child: main)
        main.start()
    }
}
