import UIKit

public enum TabBarItem: String, CaseIterable {
    case main
    case forecast

    var icon: UIImage? {
        switch self {
            case .main:
                return UIImage(systemName: "house")

            case .forecast:
                return UIImage(systemName: "thermometer.medium")
        }
    }
}

extension TabBarItem {
    var name: String {
        rawValue.capitalized
    }
}
