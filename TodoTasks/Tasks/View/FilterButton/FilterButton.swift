import UIKit
import SnapKit

class FilterButton: UIView {

    weak var actionDelegate: FilterButtonDelegate?
    var isSelected: Bool = false {
        didSet {
            isSelected ? setToSelectedColor() : setUnselectedColor()
        }
    }

    private let type: TaskFilterType
    private let titleLabel = UILabel()
    private let numberLabel = UILabel()

    init(type: TaskFilterType) {
        self.type = type
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
        setGestureRecognizer()

        numberLabel.font = .systemFont(ofSize: 15)
        numberLabel.layer.cornerRadius = 8
        numberLabel.clipsToBounds = true
        numberLabel.textAlignment = .center

        titleLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }

        numberLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.height.equalTo(18)
            $0.width.equalTo(23)
        }
    }

    func setGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        addGestureRecognizer(tap)
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

    @objc func buttonTapped() {
        actionDelegate?.buttonTapped(type)
    }

}
