import UIKit

class CustomTabBarController: UITabBarController {
    var action: ((Int) -> Void)?

    private lazy var customTabBar: CustomTabBar = {
        let tabBar = CustomTabBar()
        tabBar.backgroundColor = .clear
        return tabBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    private func setup() {
        tabBar.barTintColor = .clear
        view.addSubview(customTabBar)
        customTabBar.itemTapped = { [weak self] in
            self?.selectTabWith(index: $0)
        }
    }

    private func setupConstraints() {
        customTabBar.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
    }

    private func setupUI() {
        selectedIndex = 0
    }

    private func selectTabWith(index: Int) {
        selectedIndex = index
        action?(index)
    }

    func setIndex(ind: Int) {
        customTabBar.selectItem(index: ind)
    }
}
