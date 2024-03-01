import UIKit

final class CustomItemView: UIView {
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let index: Int
    var isSelected = false {
        willSet { imageView.tintColor = newValue ? .systemMint : .systemGray3 }
    }

    var completion: (() -> Void)?
    private let item: TabBarItem

    init(with item: TabBarItem, index: Int) {
        self.item = item
        self.index = index
        self.imageView.image = item.icon
        super.init(frame: .zero)

        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(imageView)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .systemGray5
        let gesture = UITapGestureRecognizer(target: self, action: #selector(taped))
        addGestureRecognizer(gesture)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    @objc
    private func taped() {
        animateClick {
            self.completion?()
        }
    }
}
