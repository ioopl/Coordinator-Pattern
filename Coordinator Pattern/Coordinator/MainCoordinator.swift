import UIKit

final class MainCoordinator: BaseCoordinator {
    
    var onLogout: (() -> Void)?
    
    override func start() {

        let homeViewModel = HomeViewModel()
        
        // Wire VM outputs to Coordinator navigation
        homeViewModel.onDetails  = { [weak self] in
            self?.showDetails()
        }
      
        homeViewModel.onSettings = { [weak self] in
            self?.showSettings()
        }
        
        homeViewModel.onLogout = { [weak self] in
            self?.onLogout?()
        }
        
        let home = HomeViewController(viewModel: homeViewModel)
        navigationController.setViewControllers([home], animated: true)
    }

       private func showDetails() {
           let detailsVM = StaticScreenViewModel(model: .init(title: "Details", message: "Details Screen"))
           let vc = StaticScreenViewController(viewModel: detailsVM)
           navigationController.pushViewController(vc, animated: true)
       }

       private func showSettings() {
           let settingsVM = StaticScreenViewModel(model: .init(title: "Settings", message: "Settings Screen"))
           let vc = StaticScreenViewController(viewModel: settingsVM)
           navigationController.pushViewController(vc, animated: true)
       }
}


/*
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
 */
