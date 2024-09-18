import UIKit
import SnapKit

class TasksCollectionViewCellView: UIView {
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var separatedView = UIView()
    private var dateLabel = UILabel()
    private var doneButton = UIButton()

    private var delegate: TasksPresenterDelegateProtocol?
    private var id: UUID?
    private var isDone = false
    private var titleText = ""
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: TaskModel, _ delegate: TasksPresenterDelegateProtocol?) {
        self.delegate = delegate
        self.id = data.id
        titleText = data.title!
        subtitleLabel.text = data.subtitle!
        dateLabel.text = data.date!
        isDone = data.isComplited
        setButtonImage()
        setLabelAttribute()
    }
    
}

//MARK: - private
private extension TasksCollectionViewCellView {
    
    func setupView() {
        addSubviews(titleLabel, subtitleLabel, separatedView, dateLabel, doneButton)
        setupConstraints()

        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .cellViewBackground()
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .title()
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .date()
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .date()
        separatedView.backgroundColor = .separatedViewBackground()
        doneButton.layer.cornerRadius = 15
        doneButton.clipsToBounds = true
        doneButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        doneButton.imageView?.contentMode = .scaleAspectFill

        setLabelAttribute()
        setButtonImage()
    }
    
    func setupConstraints() {
        snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(doneButton.snp.leading).offset(8)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(doneButton.snp.leading).offset(8)
        }
        
        separatedView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(2)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(separatedView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(30)
        }
    }
    
    func setButtonImage() {
        let imageName = isDone ? "checkmark.circle.fill" : "circle"
        let tintColor: UIColor = isDone ? .doneButtonTint() : .notDoneButtonTint()

        doneButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
        doneButton.tintColor = tintColor
    }
    
    func setLabelAttribute() {
        let attributeString =  NSMutableAttributedString(string: titleText)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        
        let removedAttributeString = NSMutableAttributedString(string: titleText)
        removedAttributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))

        titleLabel.attributedText = isDone ? attributeString : removedAttributeString
    }

    @objc func buttonTapped() {
        delegate?.sendEvent(.done(id!))
    }

}
