import UIKit

final class DayCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConctraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        isUserInteractionEnabled = false
        backgroundColor = .clear
        contentView.add(subviews: titleLabel, subtitleLabel)
    }

    private func setupConctraints() {
        contentView.snp.makeConstraints {
            $0.height.equalTo(46)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(36)
        }
        subtitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
//            $0.trailing.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(40)
        }
    }
}

extension DayCell: ConfigurableView {
    struct Model {
        var title: String
        var subtitle: String
    }

    func configure(with model: Model) {
        titleLabel.text = "\(model.title):"
        subtitleLabel.text = "\(model.subtitle)˚"
    }
}
