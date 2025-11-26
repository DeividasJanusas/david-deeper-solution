import Foundation

protocol LoginInteractorInput {
    func login(email: String, password: String)
}

final class LoginInteractor {
    var presenter: LoginPresenterInput?

    private let api: APIClient
    private let tokenStore: KeychainService
    private let storage: UserStorageProtocol
    private var state = Login.Data.State(isLoading: false, errorMessage: nil)

    init(
        api: APIClient,
        tokenStore: KeychainService,
        storage: UserStorageProtocol
    ) {
        self.api = api
        self.tokenStore = tokenStore
        self.storage = storage
    }
}

extension LoginInteractor: LoginInteractorInput {
    func login(email: String, password: String) {
        state.isLoading = true
        presenter?.present(state: state)

        Task {
            do {
                let dto: LoginResponseDTO = try await api.request(
                    .login(email: email, password: password)
                )

                storage.save(dto.scans)
                tokenStore.token = dto.login.token
                state.isLoading = false
                presenter?.presentScanList()
            } catch {
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                presenter?.present(state: state)
            }
        }
    }
}
