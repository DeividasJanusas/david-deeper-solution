import UIKit

protocol LoginViewControllerInput: AnyObject {
    func display(state: Login.Data.State)
    func displayLoginSuccess()
}

final class LoginViewController: UIViewController {
    var interactor: LoginInteractorInput!
    var router: LoginRoutingLogic!

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.text = "deeperangler@gmail.com"
        textField.autocapitalizationType = .none
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "Deeper10899"
        textField.isSecureTextEntry = true
        return textField
    }()

    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.addTarget(
            self,
            action: #selector(didTapLogin),
            for: .touchUpInside
        )
        return btn
    }()

    private let activity = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        let stack = UIStackView(
            arrangedSubviews: [
                emailTextField,
                passwordTextField,
                loginButton,
                activity
            ]
        )
        stack.axis = .vertical
        stack.spacing = 20

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    @objc private func didTapLogin() {
        interactor.login(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
}

extension LoginViewController: LoginViewControllerInput {
    func display(state: Login.Data.State) {
        DispatchQueue.main.async {
            if state.isLoading {
                self.activity.startAnimating()
                self.loginButton.isEnabled = false
            } else {
                self.activity.stopAnimating()
                self.loginButton.isEnabled = true
            }

            if let msg = state.errorMessage {
                let alert = UIAlertController(
                    title: "Error",
                    message: msg,
                    preferredStyle: .alert
                )
                alert.addAction(
                    UIAlertAction(title: "OK", style: .default)
                )
                self.present(alert, animated: true)
            }
        }
    }

    func displayLoginSuccess() {
        router.routeToMain()
    }
}
