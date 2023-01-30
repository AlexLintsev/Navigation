import UIKit

class ProfileViewController: UIViewController {

    private let postData = Post.make()

    private let headerView = ProfileHeaderView()

    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private enum CellReuseID: String {
        case post = "PostTableViewCell_ReuseID"
        case photos = "PhotosTableViewCell_ReuseID"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubViews()
        setupConstraints()
        tuneTableView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: "profile")
        tabBarItem.imageInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        tabBarItem.title = "Profile"
        self.tabBarItem = tabBarItem
    }

    private func addSubViews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
        ])
    }

    private func tuneTableView() {
        tableView.estimatedRowHeight = 1500
        tableView.setAndLayout(headerView: headerView)
        tableView.tableFooterView = UIView()

        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.photos.rawValue
        )

        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.post.rawValue
        )

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        section == 0 ? 1 : postData.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.photos.rawValue,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("Could not dequeueReusableCell")
            }

            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.post.rawValue,
                for: indexPath
            ) as? PostTableViewCell else {
                fatalError("Could not dequeueReusableCell")
            }

            cell.update(postData[indexPath.row])

            return cell
        }
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate {

}
