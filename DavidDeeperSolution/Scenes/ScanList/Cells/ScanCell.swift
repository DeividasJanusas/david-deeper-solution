import UIKit

final class ScanCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()

    private let stack: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.distribution = .fillEqually
        return s
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(timeLabel)

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(name: String, date: String, time: String) {
        nameLabel.text = name
        dateLabel.text = date
        timeLabel.text = time
    }
}
