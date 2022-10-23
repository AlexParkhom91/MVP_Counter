import EasyAutolayout
import UIKit

protocol FirstViewProtocol: AnyObject {
    func updateLabel(text: String)
    func builderSecondModule()
}

final class FirstViewController: UIViewController {
  
    // MARK: Public
    
    var presenter: FirstViewPresenterProtocol!

    // MARK: Private
    
    private let counterLabel = UILabel()
    private let incrementButton = UIButton()
    private let decrementButton = UIButton()
    private let showSecondViewButton = UIButton()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubwiews()
        setupConstraints()
        configureUI()
        setupBehavior()
    }

    // MARK: - Setups

    private func setupSubwiews() {
        [counterLabel,
         incrementButton,
         decrementButton,
         showSecondViewButton].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        counterLabel.pin
            .width(to: 150)
            .center(in: view)

        incrementButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: counterLabel, offset: 30)
            .centerX(in: view)

        decrementButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: incrementButton, offset: 30)
            .centerX(in: view)

        showSecondViewButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: decrementButton, offset: 40)
            .centerX(in: view)
    }

    private func configureUI() {
        view.backgroundColor = .black

        counterLabel.backgroundColor = .white
        counterLabel.textColor = .black
        counterLabel.font = UIFont.systemFont(ofSize: 32)
        counterLabel.textAlignment = .center

        incrementButton.backgroundColor = .systemGray
        incrementButton.setTitle("Increment(+)", for: .normal)

        decrementButton.backgroundColor = .systemGray
        decrementButton.setTitle("Decrement(-)", for: .normal)

        showSecondViewButton.backgroundColor = .systemCyan
        showSecondViewButton.setTitle("Next screen", for: .normal)
    }

    private func setupBehavior() {
        incrementButton.addTarget(self, action: #selector(incrementButtonDidTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementButtonDidTapped), for: .touchUpInside)
        showSecondViewButton.addTarget(self, action: #selector(showSecondViewButtonDidTapped), for: .touchUpInside)
    }

    // MARK: - Helpers
    
    @objc private func incrementButtonDidTapped() {
        presenter.incrementCounter()
    }

    @objc private func decrementButtonDidTapped() {
        presenter.decrementCounter()
    }

    @objc private func showSecondViewButtonDidTapped() {
        presenter.showSecondViewController()
    }
}

extension FirstViewController: FirstViewProtocol {
    func updateLabel(text: String) {
        counterLabel.text = text
    }

    func builderSecondModule() {
        let secondViewController = SecondViewController()
        let presenter = SecondViewPresenter(view: secondViewController)
        secondViewController.presenter = presenter
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
