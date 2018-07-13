import UIKit
import RxSwift
import RxDataSources

class CustomViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfPerson>(configureCell: configureCell, titleForHeaderInSection: titleForHeaderInSection)
    
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SectionOfPerson>.ConfigureCell = { [weak self] (dataSource, tableView, indexPath, person) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = person.name
        return cell
    }
    
    private lazy var titleForHeaderInSection: RxTableViewSectionedReloadDataSource<SectionOfPerson>.TitleForHeaderInSection = { [weak self] (dataSource, indexPath) in
        return dataSource.sectionModels[indexPath].header
    }

    private var viewModel: CustomViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        setupViewModel()
    }
}

extension CustomViewController {
    private func setupViewController() {
        self.title = "タイトル"
    }
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func setupViewModel() {
        viewModel = CustomViewModel()
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.updateItem()
    }
}
