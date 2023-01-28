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
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.post.rawValue
        )

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        postData.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

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

extension ProfileViewController: UITableViewDelegate {

}
