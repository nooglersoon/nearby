import UIKit

final class SignUpViewController: UIViewController {
    
    weak var coordinator: SignUpCoordinator?
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign Up"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .white
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        coordinator?.childDidFinish(coordinator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(pageTitle)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 100)
        ])
        
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
    }
    
    @objc private func signUpTapped() {
        coordinator?.goToLogin()
    }
    
}
