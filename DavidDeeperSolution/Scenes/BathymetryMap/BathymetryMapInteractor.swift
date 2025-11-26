import Foundation

protocol BathymetryMapInteractorInput {
    func loadBathymetryMap()
}

final class BathymetryMapInteractor {
    var presenter: BathymetryMapPresenterInput?

    private let scan: Scan
    private let api: APIClient
    private let tokenStore: KeychainService

    init(
        scan: Scan,
        api: APIClient,
        tokenStore: KeychainService
    ) {
        self.scan = scan
        self.api = api
        self.tokenStore = tokenStore
    }
}

extension BathymetryMapInteractor: BathymetryMapInteractorInput {
    func loadBathymetryMap() {
        guard let token = tokenStore.token else { return }
        presenter?.present(state: .init(isLoading: true))

        Task {
            do {
                let dto: BathymetryResponseDTO = try await api.request(
                    .getGeoData(scanId: scan.id, token: token)
                )
                presenter?.present(state: .init(isLoading: false))
                // TODO: - Map dto to domain
                presenter?.presentBathymetry(dto)

            } catch {
                presenter?.present(state: .init(
                    isLoading: false,
                    errorMessage: error.localizedDescription
                ))
            }
        }
    }
}
