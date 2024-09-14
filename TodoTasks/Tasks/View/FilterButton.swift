import UIKit
import SnapKit

class FilterButton: UIView {
    var isSelected: Bool = false {
        didSet {
            isSelected ? setToSelectedColor() : setUnselectedColor()
        }
    }

    private let titleLabel = UILabel()
    private let numberLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ text: String) {
        titleLabel.text = text
    }

    func setNumber(_ text: String) {
        numberLabel.text = text
    }

}

//MARK: - private
private extension FilterButton {

    func setupViews() {
        addSubviews(titleLabel, numberLabel)

        numberLabel.font = .systemFont(ofSize: 16)
        numberLabel.layer.cornerRadius = 8
        numberLabel.clipsToBounds = true
        numberLabel.textAlignment = .center

        titleLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }

        numberLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.height.equalTo(18)
            $0.width.equalTo(25)
        }
    }

    func setUnselectedColor() {
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .filterButtonUnselectedTitle()
        numberLabel.textColor = .filterButtonUnselectedNumber()
        numberLabel.backgroundColor = .filterButtonUnselectedNumberBackground()
    }

    func setToSelectedColor() {
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .filterButtonSelectedTitle()
        numberLabel.textColor = .filterButtonSelectedNumber()
        numberLabel.backgroundColor = .filterButtonSelectedNumberBackground()
    }

}

//MARK: - FilterButtonDataSource
struct FilterButtonDataSource {
    let title: String
    let number: String
    let isSelected: Bool
}
