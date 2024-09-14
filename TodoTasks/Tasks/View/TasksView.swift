import UIKit
import SnapKit

class TasksView: UIView {

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let addNewTaskButton = UIButton()
    private let allFilterButton = FilterButton()
    private let separatedView = UIView()
    private let openFilterButton = FilterButton()
    private let closedFilterButton = FilterButton()

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TasksView: TasksViewProtocol {

    func setData(_ data: TaskViewDataSource) {
        titleLabel.text = data.title
        dateLabel.text = data.date
        addNewTaskButton.setTitle(data.buttonTitle, for: .normal)
        allFilterButton.setTitle(data.allButtonTitle.title)
        allFilterButton.setNumber(data.allButtonTitle.number)
        allFilterButton.isSelected = data.allButtonTitle.isSelected
        openFilterButton.setTitle(data.openButtonTitle.title)
        openFilterButton.setNumber(data.openButtonTitle.number)
        openFilterButton.isSelected = data.openButtonTitle.isSelected
        closedFilterButton.setTitle(data.closedButtonTitle.title)
        closedFilterButton.setNumber(data.closedButtonTitle.number)
        closedFilterButton.isSelected = data.closedButtonTitle.isSelected
    }

}

//MARK: - private
private extension TasksView {

    func setupViews() {
        backgroundColor = .systemBackground
        addSubviews(titleLabel, dateLabel, addNewTaskButton, allFilterButton, separatedView, openFilterButton, closedFilterButton)

        titleLabel.textColor = .title()
        titleLabel.font = .boldSystemFont(ofSize: 25)
        dateLabel.font = .systemFont(ofSize: 18)
        dateLabel.textColor = .date()
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 8
        addNewTaskButton.configuration = configuration
        addNewTaskButton.layer.cornerRadius = 15
        addNewTaskButton.clipsToBounds = true
        addNewTaskButton.backgroundColor = .addNewTaskButtonBackground()
        addNewTaskButton.setTitleColor(.addNewTaskButtonTitle(), for: .normal)
        addNewTaskButton.setImage(.init(systemName: "plus"), for: .normal)
        separatedView.backgroundColor = .separatedViewBackground()
        separatedView.layer.cornerRadius = 5
        separatedView.clipsToBounds = true

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        addNewTaskButton.snp.makeConstraints {
            $0.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(45)
            $0.width.equalTo(140)
        }

        allFilterButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(dateLabel.snp.bottom).offset(32)
        }

        separatedView.snp.makeConstraints {
            $0.leading.equalTo(allFilterButton.snp.trailing).offset(16)
            $0.centerY.equalTo(allFilterButton)
            $0.height.equalTo(25)
            $0.width.equalTo(2)
        }

        openFilterButton.snp.makeConstraints {
            $0.leading.equalTo(separatedView.snp.trailing).offset(16)
            $0.top.equalTo(allFilterButton)
        }

        closedFilterButton.snp.makeConstraints {
            $0.leading.equalTo(openFilterButton.snp.trailing).offset(16)
            $0.top.equalTo(allFilterButton)
        }
    }

}

//MARK: - TaskViewDataSource
struct TaskViewDataSource {
    let title: String
    let date: String
    let buttonTitle: String
    let allButtonTitle: FilterButtonDataSource
    let openButtonTitle: FilterButtonDataSource
    let closedButtonTitle: FilterButtonDataSource
}
