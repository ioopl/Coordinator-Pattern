protocol StaticScreenViewModeling {
    var title: String { get }
    var message: String { get }
}

struct StaticScreenViewModel: StaticScreenViewModeling {
    let title: String
    let message: String

    init(model: StaticScreenModel) {
        self.title = model.title
        self.message = model.message
    }
}
