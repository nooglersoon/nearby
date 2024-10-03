import UIKit

final class LoginViewController: UIViewController {
    
    weak var coordinator: LoginCoordinator?
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pageTitle)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 100)
        ])
        
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        
    }
    
    deinit {
        coordinator?.childDidFinish(coordinator)
    }
    
    @objc private func forgotPasswordTapped() {
        coordinator?.goToForgotPassword()
    }
    
}
