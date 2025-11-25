protocol LoginPresenterInput {
    func present(state: Login.Data.State)
    func presentSuccess()
}

final class LoginPresenter {
    weak var viewController: LoginViewControllerInput?
}

extension LoginPresenter: LoginPresenterInput {
    func present(state: Login.Data.State) {
        viewController?.display(state: state)
    }
    func presentSuccess() {
        viewController?.displayLoginSuccess()
    }
}
