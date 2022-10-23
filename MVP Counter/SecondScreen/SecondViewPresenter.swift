protocol SecondViewPresenterProtocol {
    func setText()
}

class SecondViewPresenter: SecondViewPresenterProtocol {

    // MARK: Public
    
    unowned var view: SecondViewController

    // MARK: - Lifecycle
    
    init(view: SecondViewController) {
        self.view = view
    }

    // MARK: - API
    
    func setText() {
        view.setText(text: "")
    }
}
