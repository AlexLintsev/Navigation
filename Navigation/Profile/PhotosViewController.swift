import UIKit

class PhotosViewController: UIViewController {

    private let imageList: [UIImage] = {
        (1...20)
            .compactMap { UIImage(named: String($0)) }
            .map { UIImage.cropToSquare($0) }
    }()

    private enum Constants {
        static let padding: CGFloat = 8.0
    }

    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .null,
            collectionViewLayout: viewLayout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(
            ProfileCell.self,
            forCellWithReuseIdentifier: ProfileCell.ID
        )

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()
        setupLayouts()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Photo gallery"
    }

    private func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupLayouts() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        imageList.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCell.ID,
            for: indexPath
        ) as! ProfileCell

        let image = imageList[indexPath.row]
        cell.update(with: image)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    private func getItemSize() -> CGFloat {
        (view.frame.width - Constants.padding * 4) / 3
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: getItemSize(),
            height: getItemSize()
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: Constants.padding,
            left: Constants.padding,
            bottom: Constants.padding,
            right: Constants.padding
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.padding
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.padding
    }
}

