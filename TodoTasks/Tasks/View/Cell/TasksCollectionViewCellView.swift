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
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: TasksCollectionViewCellData, _ delegate: TasksPresenterDelegateProtocol?) {
        self.delegate = delegate
        self.id = data.id
        titleLabel.attributedText = data.attributeString
        subtitleLabel.text = data.subtitle
        dateLabel.text = data.date
        doneButton.setBackgroundImage(data.doneButtonImage, for: .normal)
        doneButton.tintColor = data.tintColorButton
    }
    
}

//MARK: - private
private extension TasksCollectionViewCellView {
    
    func setupView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .cellViewBackground()
        setGestureRecognizer()

        addSubviews(titleLabel, subtitleLabel, separatedView, dateLabel, doneButton)
        setupConstraints()
        
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
    }
    
    func setupConstraints() {
        snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(doneButton.snp.leading).offset(-8)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(doneButton.snp.leading).inset(16)
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
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(12)
            $0.height.width.equalTo(30)
        }
    }

    func setGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellSeleceted))
        addGestureRecognizer(tap)
    }

    @objc func buttonTapped() {
        delegate?.sendEvent(.done(id!))
    }

    @objc func cellSeleceted() {
        delegate?.sendEvent(.taskSelected(id!))
    }

}
