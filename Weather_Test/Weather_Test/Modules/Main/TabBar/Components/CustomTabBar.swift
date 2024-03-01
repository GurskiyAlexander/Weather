import UIKit

final class CustomTabBar: UIView {
    var itemTapped: ((Int) -> Void)?

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var customItemViews: [CustomItemView] = [mainItem, forecastItem]

    private let mainItem: CustomItemView = {
        let view = CustomItemView(with: .main, index: 0)
        view.layer.cornerRadius = 45
        view.isSelected = true
        return view
    }()

    private let forecastItem: CustomItemView = {
        let view = CustomItemView(with: .forecast, index: 1)
        view.isSelected = false
        view.layer.cornerRadius = 30
        return view
    }()

    init() {
        super.init(frame: .zero)

        setup()
        setupConstraints()
        selectItem(index: 0)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(backView)
        backView.addSubview(forecastItem)
        addSubview(mainItem)


        customItemViews.forEach { item in
            item.completion = { [weak self] in
                guard let self else { return }
                self.selectItem(index: item.index)
            }
        }
    }

    private func setupConstraints() {
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        mainItem.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(90)
        }

        forecastItem.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(36)
            $0.leading.greaterThanOrEqualTo(mainItem.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(60)
        }
    }

    func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTapped?(index)
    }
}
