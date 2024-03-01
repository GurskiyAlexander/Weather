import UIKit
import SnapKit

// MARK: - HomeBarViewControllerInterface

protocol HomeViewControllerInterface: RootViewControllerProtocol {
    var isActivateLoader: Bool { get set }

    func configure(with model: WeatherModel)
}

// MARK: - HomeViewController

final class HomeViewController: RootViewController<HomeViewModelInterface> {
    var isActivateLoader: Bool {
        get { loader.isAnimating }
        set { newValue ? loader.startAnimating() : loader.stopAnimating() }
    }
    private lazy var backgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemOrange.cgColor
        ]
        return layer
    }()
    private let loader = UIActivityIndicatorView(style: .large)
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private lazy var notLacationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enable location tracking", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
        return button
    }()

    private lazy var discriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 68, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var searchField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.backgroundColor = .white
        field.layer.cornerRadius = 16
        field.textAlignment = .center
        field.layer.masksToBounds = true
        return field
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
        return button
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
        hideKeyboardWhenTappedAround()
        view.layer.addSublayer(backgroundLayer)
        view.add(subviews: mainStack, searchButton, searchField, loader)
        mainStack.addArrangedSubviews(imageView, weatherLabel, cityLabel, notLacationButton, discriptionLabel)
        view.backgroundColor = .white
        mainStack.setCustomSpacing(26, after: weatherLabel)
        mainStack.setCustomSpacing(0, after: imageView)
        setupPlaceholder()
    }

    private func setupConctraints() {
        searchButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            $0.trailing.equalTo(searchField.snp.leading).inset(-8)
        }

        searchField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            $0.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(32)
            $0.width.equalTo(150)
        }

        loader.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        mainStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }

        notLacationButton.snp.makeConstraints {
            $0.height.equalTo(16)
        }

        imageView.snp.makeConstraints {
            $0.size.equalTo(120)
        }
    }

    private func setupPlaceholder() {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(
            string: "Search City",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        searchField.attributedPlaceholder = attributedPlaceholder
    }

    @objc
    private func buttonTaped(sender: UIButton) {
        sender.animateClick {
            switch sender {
                case self.notLacationButton:
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)")
                        })
                    }
                case self.searchButton:
                    self.viewModel.serchWeather(with: self.searchField.text)

                default:
                    break
            }
        }
    }
}

// MARK: - HomeViewControllerInterface

extension HomeViewController: HomeViewControllerInterface {
    func configure(with model: WeatherModel) {
        cityLabel.text = model.cityName
        notLacationButton.isHidden = !model.isLocationsCanceled
        discriptionLabel.text = model.description
        weatherLabel.text = "\(model.temperatureString)˚"
        guard let url = model.imageUrl else { return }
        imageView.load(url: url)
    }
}

extension HomeViewController: UITextFieldDelegate {

}
