import EasyAutolayout
import UIKit
import Combine

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
    private let multiplyButton = UIButton()
    private let showSecondViewButton = UIButton()
    
    private let incrementSubject = PassthroughSubject<Void, Never>()
    private let decrementSubject = PassthroughSubject<Void, Never>()
    private let multiplySubject = PassthroughSubject<Void, Never>()
    private let showSecondScreenSubject = PassthroughSubject<Void, Never>()
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubwiews()
        setupConstraints()
        configureUI()
        setupBehavior()
        setupBindings()
        
    }

    // MARK: - Setups

    private func setupSubwiews() {
        [counterLabel,
         incrementButton,
         decrementButton,
         multiplyButton,
         showSecondViewButton].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        counterLabel.pin
            .width(to: 250)
            .center(in: view)

        incrementButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: counterLabel, offset: 30)
            .centerX(in: view)

        decrementButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: incrementButton, offset: 30)
            .centerX(in: view)
        
        multiplyButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: decrementButton, offset: 30)
            .centerX(in: view)
        

        showSecondViewButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: multiplyButton, offset: 40)
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
        
        multiplyButton.backgroundColor = .systemGray
        multiplyButton.setTitle("Multilly(X2)", for: .normal)

        showSecondViewButton.backgroundColor = .systemCyan
        showSecondViewButton.setTitle("Next screen", for: .normal)
    }

    private func setupBehavior() {
        incrementButton.addTarget(self, action: #selector(incrementButtonDidTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementButtonDidTapped), for: .touchUpInside)
        multiplyButton.addTarget(self, action: #selector(multiplyButtonDidTapped), for: .touchUpInside)
        showSecondViewButton.addTarget(self, action: #selector(showSecondViewButtonDidTapped), for: .touchUpInside)
    }
    
    private func setupBindings() {
        incrementSubject.sink { [weak self] in
            self?.presenter?.incrementCounter()
        }.store(in: &cancellables)
        
        decrementSubject.sink { [weak self] in
            self?.presenter?.decrementCounter()
        }.store(in: &cancellables)
        
        multiplySubject.sink { [weak self] in
            self?.presenter?.multiplyCounter()
        }.store(in: &cancellables)
        
        showSecondScreenSubject.sink { [weak self] in
            self?.presenter?.showSecondViewController()
        }.store(in: &cancellables)
    }

    // MARK: - Helpers
    
    @objc private func incrementButtonDidTapped() {
        incrementSubject.send()
    }

    @objc private func decrementButtonDidTapped() {
        decrementSubject.send()
    }
    
    @objc private func multiplyButtonDidTapped() {
        multiplySubject.send()
    }
    @objc private func showSecondViewButtonDidTapped() {
        showSecondScreenSubject.send()
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
