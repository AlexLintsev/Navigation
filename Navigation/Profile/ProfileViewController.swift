import UIKit
import StorageService

class ProfileViewController: UIViewController {

    // Добавить таймер в profileViewController для появления сообщения о том, что нужно
    // сделать перерыв на отдых от соц. сетей. Для удобства проверки функционала задать
    // период срабатывания 10 секунд

    private var timer: Timer?

    let user: User

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

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        timer = startTimer(interval: 10)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        #if DEBUG
        view.backgroundColor = .red
        #else
        view.backgroundColor = .green
        #endif
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
        headerView.statusLabel.text = user.status
        headerView.fullNameLabel.text = user.name
        headerView.avatarImageView.image = UIImage.cropToSquare(user.avatar)
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

    private func startTimer(interval: Double) -> Timer {
        Timer.scheduledTimer(timeInterval: interval,
                             target: self,
                             selector: #selector(timerDidFire),
                             userInfo: nil,
                             repeats: false)
    }

    @objc func timerDidFire() {
        timer?.invalidate()
        let alert = UIAlertController(
            title: "Нужен отдых",
            message: "Рекомендуется отдохнуть от социальных сетей",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("OK", comment: "Default action"),
            style: .default,
            handler: {_ in
                self.timer = self.startTimer(interval: 10)
            }
        ))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Отмена", comment: "Additional action"),
            style: .default,
            handler: {_ in
                let alert = UIAlertController(
                    title: "Еще 5 секунд",
                    message: "Выделено дополнительно 5 секунд перед перерывом",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(
                    title: NSLocalizedString("OK", comment: "Default action"),
                    style: .default,
                    handler: {_ in
                        self.timer = self.startTimer(interval: 5)
                    }
                ))
                self.present(alert, animated: true, completion: nil)
            }
        ))

        self.present(alert, animated: true, completion: nil)
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

extension Timer {
    static func start() -> Timer {
        Timer.scheduledTimer(timeInterval: 10,
                             target: self,
                             selector: #selector(ProfileViewController.timerDidFire),
                             userInfo: nil,
                             repeats: false)
    }
}
