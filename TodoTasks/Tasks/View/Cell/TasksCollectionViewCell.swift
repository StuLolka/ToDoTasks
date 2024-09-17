import UIKit
import SnapKit

class TasksCollectionViewCell: UICollectionViewCell {

    static var id = description()

    private let view = TasksCollectionViewCellView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(_ data: TasksCollectionViewCellData, _ action: @escaping ((Int) -> ())) {
        view.setData(data, action)
    }

}

//MARK: - TasksCollectionViewCell
private extension TasksCollectionViewCell {

    func setupView() {
        addSubview(view)

        layer.shadowOpacity = 0.18
        layer.shadowOffset = .zero
        layer.shadowRadius = 3

        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview()
        }
    }

}
