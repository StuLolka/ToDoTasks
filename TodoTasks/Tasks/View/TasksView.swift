import UIKit
import SnapKit

class TasksView: UIView {

    private var tasks: [TasksCollectionViewCellData] = []
    private var doneButtonAction: ((Int) -> ())?

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let addNewTaskButton = UIButton()
    private let allFilterButton = FilterButton()
    private let separatedView = UIView()
    private let openFilterButton = FilterButton()
    private let closedFilterButton = FilterButton()
    private let stackView = UIStackView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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

    func reloadTasks(_ tasks: [TasksCollectionViewCellData]) {
        self.tasks = tasks
        collectionView.reloadData()
    }
    
    func setData(_ data: TaskViewData, _ doneButtonAction: @escaping ((Int) -> ())) {
        self.doneButtonAction = doneButtonAction
        titleLabel.text = data.title
        dateLabel.text = data.date
        addNewTaskButton.setTitle(data.buttonTitle, for: .normal)
        allFilterButton.actionDelegate = self
        allFilterButton.setTitle(data.allButtonTitle.title)
        allFilterButton.setNumber(data.allButtonTitle.number)
        allFilterButton.isSelected = data.allButtonTitle.isSelected
        openFilterButton.actionDelegate = self
        openFilterButton.setTitle(data.openButtonTitle.title)
        openFilterButton.setNumber(data.openButtonTitle.number)
        openFilterButton.isSelected = data.openButtonTitle.isSelected
        closedFilterButton.actionDelegate = self
        closedFilterButton.setTitle(data.closedButtonTitle.title)
        closedFilterButton.setNumber(data.closedButtonTitle.number)
        closedFilterButton.isSelected = data.closedButtonTitle.isSelected
    }
    
}

//MARK: - FilterButtonDelegate
extension TasksView: FilterButtonDelegate {
    
    func buttonTapped(_ button: FilterButton) {
        for i in [allFilterButton, openFilterButton, closedFilterButton] {
            i.isSelected = i == button
        }
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
        
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TasksCollectionViewCell.self, forCellWithReuseIdentifier: TasksCollectionViewCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell.self")
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
