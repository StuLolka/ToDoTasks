import UIKit

extension UIStackView {

    func addArrangedSubviews(_ view: UIView ...) {
        view.forEach {
            addArrangedSubview($0)
        }
    }

}
