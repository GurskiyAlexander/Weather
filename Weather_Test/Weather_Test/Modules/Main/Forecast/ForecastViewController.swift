import UIKit
import SnapKit

// MARK: - ForecastBarViewControllerInterface

protocol ForecastViewControllerInterface: RootViewControllerProtocol {
    var isActivateLoader: Bool { get set }

    func reloadData()
}

// MARK: - ForecastViewController

final class ForecastViewController: RootViewController<ForecastViewModelInterface> {
    var isActivateLoader: Bool {
        get { loader.isAnimating }
        set { newValue ? loader.startAnimating() : loader.stopAnimating() }
    }

    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textAlignment = .center
        label.text = "Weather for a week"
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    private let loader = UIActivityIndicatorView(style: .large)
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(class: DayCell.self)
        tableView.backgroundColor = .systemMint.withAlphaComponent(0.2)
        tableView.layer.cornerRadius = 24
        return tableView
    }()

    private lazy var backgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemOrange.cgColor
        ]
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConctraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        backgroundLayer.frame = view.bounds
    }

    private func setupUI() {
        view.overrideUserInterfaceStyle = .light
        view.layer.addSublayer(backgroundLayer)
        view.add(subviews: weatherLabel, tableView, loader)
    }

    private func setupConctraints() {
        loader.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        weatherLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
        }

        tableView.snp.makeConstraints {
            $0.height.equalTo(330)
            $0.top.equalTo(weatherLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
    }
}

// MARK: - ForecastViewControllerInterface

extension ForecastViewController: ForecastViewControllerInterface {
    func reloadData() {
        tableView.reloadData()
    }
}

extension ForecastViewController: UITableViewDelegate {}
extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: DayCell.self)
        cell.configure(with: viewModel.dataSource[indexPath.row])
        return cell
    }
}
