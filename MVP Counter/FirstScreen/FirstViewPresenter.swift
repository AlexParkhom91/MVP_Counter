import Foundation
import UIKit
protocol FirstViewPresenterProtocol {
    var counter: Int { get }
    func incrementCounter()
    func decrementCounter()
    func showSecondViewController()
}

final class FirstViewPresenter: FirstViewPresenterProtocol {

    // MARK: Public
    
    unowned var view: FirstViewController

    var counter = 0

    // MARK: - Lifecycle
    
    init(view: FirstViewController) {
        self.view = view
    }

    // MARK: - API
    
    func incrementCounter() {
        counter += 1
        view.updateLabel(text: "\(counter)")
    }

    func decrementCounter() {
        counter -= 1
        view.updateLabel(text: "\(counter)")
    }

    func showSecondViewController() {
        view.builderSecondModule()
    }
}
