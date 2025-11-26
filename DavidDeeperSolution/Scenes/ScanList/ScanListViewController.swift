import UIKit

protocol ScanListViewControllerInput: AnyObject {
    func display(scans: [ScanList.Data.ScanModel])
    func displayScanDetails(_ scan: Scan)
}

final class ScanListViewController: UIViewController {
    var interactor: ScanListInteractorInput!
    var router: ScanListRouterLogic!

    private var scans: [ScanList.Data.ScanModel] = []

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupTable()
        interactor.loadScans()
    }

    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ScanCell.self, forCellReuseIdentifier: "ScanCell")

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ScanListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scans.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let scan = scans[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ScanCell",
            for: indexPath
        ) as! ScanCell
        cell.configure(
            name: scan.name,
            date: scan.dateString,
            time: scan.timeString
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectScan(at: indexPath.row)
    }
}

extension ScanListViewController: ScanListViewControllerInput {
    func display(scans: [ScanList.Data.ScanModel]) {
        self.scans = scans
        tableView.reloadData()
    }

    func displayScanDetails(_ scan: Scan) {
        router.routeToDetails(scan: scan)
    }
}
