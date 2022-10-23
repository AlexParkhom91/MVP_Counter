import EasyAutolayout
import Foundation
import UIKit

protocol SecondViewProtocol: AnyObject {
    func setText(text: String)
}

class SecondViewController: UIViewController {
  
    // MARK: Public
    
    var presenter: SecondViewPresenterProtocol!

    // MARK: Private
    
    private let textLabel = UILabel()
    private let textTextField = UITextField()
    private let saveTextButton = UIButton()

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
        [textLabel,
         textTextField,
         saveTextButton].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        textLabel.pin
            .width(to: 250)
            .center(in: view)
    
        textTextField.pin
            .size(to: CGSize(width: 250, height: 40))
            .below(of: textLabel, offset: 40)
            .centerX(in: view)
        
        saveTextButton.pin
            .size(to: CGSize(width: 120, height: 40))
            .below(of: textTextField, offset: 40)
            .centerX(in: view)
    }

    private func configureUI() {
        view.backgroundColor = .black
        textLabel.backgroundColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 32)
        textLabel.textAlignment = .center
        textLabel.textColor = .black

        textTextField.backgroundColor = .darkGray
        textTextField.textColor = .black
        textTextField.textAlignment = .center
        textTextField.placeholder = "Please enter text"
        textTextField.font = UIFont.systemFont(ofSize: 20)

        saveTextButton.backgroundColor = .systemGreen
        saveTextButton.setTitle("Save text", for: .normal)
    }

    private func setupBehavior() {
        saveTextButton.addTarget(self, action: #selector(saveTextButtonDidTapped), for: .touchUpInside)
    }

    // MARK: - Helpers
    
    @objc private func saveTextButtonDidTapped() {
        presenter.setText()
    }
}

    // MARK: - Extensions

extension SecondViewController: SecondViewProtocol {
    func setText(text: String) {
        textLabel.text = textTextField.text
    }
}
