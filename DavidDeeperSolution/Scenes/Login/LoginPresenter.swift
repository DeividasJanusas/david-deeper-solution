import Foundation

protocol LoginPresenterInput {
    func present(state: Login.Data.State)
    func presentScanList()
}

final class LoginPresenter {
    weak var viewController: LoginViewControllerInput?
}

extension LoginPresenter: LoginPresenterInput {
    func present(state: Login.Data.State) {
        DispatchQueue.main.async {
            self.viewController?.display(state: state)
        }
    }
    func presentScanList() {
        DispatchQueue.main.async {
            self.viewController?.displayScanList()
        }
    }
}
