import UIKit

protocol HomeViewModeling {
    var detailsTitle: String  { get }
    var settingsTitle: String { get }
    var logoutTitle: String   { get }

    // Outputs to Coordinator
    var onDetails:  (() -> Void)? { get set }
    var onSettings: (() -> Void)? { get set }
    var onLogout:   (() -> Void)? { get set }

    // Intents from View
    func detailsTapped()
    func settingsTapped()
    func logoutTapped()
}

final class HomeViewModel: HomeViewModeling {
    private let model: HomeModel
    init(model: HomeModel = HomeModel()) { self.model = model }

    var onDetails:  (() -> Void)?
    var onSettings: (() -> Void)?
    var onLogout:   (() -> Void)?

    var detailsTitle:  String {
        model.detailsTitle
    }
    
    var settingsTitle: String {
        model.settingsTitle
    }
    var logoutTitle: String {
        model.logoutTitle
    }

    func detailsTapped() {
        onDetails?()
    }
    func settingsTapped() {
        onSettings?()
    }
    func logoutTapped()   {
        onLogout?()
    }
}
