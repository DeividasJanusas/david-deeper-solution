import Foundation

protocol ScanListPresenterInput {
    func present(scans: [Scan])
    func presentScanDetails(_ scan: Scan)
}

final class ScanListPresenter {
    weak var viewController: ScanListViewControllerInput?

    private static let dayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()

    private static let timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()
}

extension ScanListPresenter: ScanListPresenterInput {
    func present(scans: [Scan]) {
        let models = scans.map {
            ScanList.Data.ScanModel(
                id: $0.id,
                name: $0.name ?? "No name",
                dateString: $0.date.map { Self.dayFormatter.string(from: $0) } ?? "-",
                timeString: $0.date.map { Self.timeFormatter.string(from: $0) } ?? "-"
            )
        }

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.display(scans: models)
        }
    }

    func presentScanDetails(_ scan: Scan) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayScanDetails(scan)
        }
    }
}
