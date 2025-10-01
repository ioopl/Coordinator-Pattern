import UIKit

final class MainCoordinator: BaseCoordinator {
    
    var onLogout: (() -> Void)?

    override func start() {
        
        let home = HomeViewController()
        
        /// Sets the closure onDetails to self?.showDetails() to call DetailsViewController
        /// https://chatgpt.com/s/t_68dc6754197c819180ce346f11515086
        /// https://chatgpt.com/s/t_68dc6b4fb4448191af27ae687fef65f9
        /// We are calling a closure from HomeViewController that runs in MainCoordinator?
        /// Anonymous closure assigned to a named property
        home.onDetails = { [weak self] in
            self?.showDetails()
        }
        
        home.onSettings = { [weak self] in
            self?.showSettings()
        }
        
        home.onLogout = { [weak self] in
            self?.onLogout?()
        }
        
        navigationController.setViewControllers([home], animated: true)
    }

    private func showDetails() {
        let vc = DetailsViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    private func showSettings() {
        let vc = SettingsViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
