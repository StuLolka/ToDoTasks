import UIKit
import SnapKit

class TasksView: UIView {

    var doneButtonAction: ((Int) -> ())?
    var filterAction: ((TaskFilterType) -> ())?
    var removeTaskAction: ((Int) -> ())?

    private var tasks: [TasksCollectionViewCellData] = []

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let addNewTaskButton = UIButton()
    private let allFilterButton = FilterButton(type: .all)
    private let separatedView = UIView()
    private let openFilterButton = FilterButton(type: .open)
    private let closedFilterButton = FilterButton(type: .closed)
    private let stackView = UIStackView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TasksView: TasksViewProtocol {

    func setTitle(_ text: String) {
        titleLabel.text = text
    }

    func setDate(_ text: String) {
        dateLabel.text = text
    }

    func setAddNewTaskButton(_ text: String) {
        addNewTaskButton.setTitle(text, for: .normal)
    }

    func reloadTasks(_ tasks: [TasksCollectionViewCellData]) {
        self.tasks = tasks
        collectionView.reloadData()
    }


    func setButtonsData(allButtonData: FilterButtonData, openButtonData: FilterButtonData, closedButtonData: FilterButtonData) {
        allFilterButton.setTitle(allButtonData.title)
        allFilterButton.setNumber(allButtonData.number)
        allFilterButton.isSelected = allButtonData.isSelected
        openFilterButton.setTitle(openButtonData.title)
        openFilterButton.setNumber(openButtonData.number)
        openFilterButton.isSelected = openButtonData.isSelected
        closedFilterButton.setTitle(closedButtonData.title)
        closedFilterButton.setNumber(closedButtonData.number)
        closedFilterButton.isSelected = closedButtonData.isSelected
    }
    
}

//MARK: - FilterButtonDelegate
extension TasksView: FilterButtonDelegate {
    
    func buttonTapped(_ type: TaskFilterType) {
        filterAction?(type)
    }
    
}

//MARK: - private
private extension TasksView {
    
    func setupViews() {
        backgroundColor = .mainViewBackground()
        stackView.addArrangedSubviews(allFilterButton, separatedView, openFilterButton, closedFilterButton)
        stackView.spacing = 16
        addSubviews(titleLabel, dateLabel, addNewTaskButton,
                    stackView, collectionView)
        setupConstraints()
        setupCollectionView()
        
        titleLabel.textColor = .title()
        titleLabel.font = .boldSystemFont(ofSize: 25)
        dateLabel.font = .systemFont(ofSize: 18)
        dateLabel.textColor = .date()
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 8
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return outgoing
        }
        addNewTaskButton.configuration = configuration
        addNewTaskButton.layer.cornerRadius = 15
        addNewTaskButton.clipsToBounds = true
        addNewTaskButton.backgroundColor = .addNewTaskButtonBackground()
        addNewTaskButton.setTitleColor(.addNewTaskButtonTitle(), for: .normal)
        addNewTaskButton.setImage(.init(systemName: "plus"), for: .normal)
        addNewTaskButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        separatedView.backgroundColor = .separatedViewFilterButtonsBackground()
        separatedView.layer.cornerRadius = 5
        separatedView.clipsToBounds = true
        allFilterButton.actionDelegate = self
        openFilterButton.actionDelegate = self
        closedFilterButton.actionDelegate = self
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TasksCollectionViewCell.self, forCellWithReuseIdentifier: TasksCollectionViewCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell.self")

        var listConfig = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        listConfig.trailingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
          let actionHandler: UIContextualAction.Handler = { action, view, completion in
              self.removeTaskAction!(indexPath.row)
              completion(true)
          }

          let action = UIContextualAction(style: .normal, title: "Delete", handler: actionHandler)
          action.backgroundColor = .red

          return UISwipeActionsConfiguration(actions: [action])
        }

        listConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfig)
        collectionView.setCollectionViewLayout(listLayout, animated: false)
    }
    
    func setupConstraints() {
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
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(32)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        separatedView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.width.equalTo(2)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(32)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
    
}

//MARK: - UICollectionViewDataSource
extension TasksView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = defaultCell(collectionView, indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TasksCollectionViewCell.id, for: indexPath) as? TasksCollectionViewCell else { return defaultCell
        }
        cell.setData(tasks[indexPath.row], doneButtonAction!)
        return cell
    }
    
    func defaultCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell.self", for: indexPath)
    }

}
