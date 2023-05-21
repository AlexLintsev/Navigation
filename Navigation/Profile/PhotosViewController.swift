import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    private let imageList: [UIImage] = {
        (1...20)
            .compactMap { UIImage(named: String($0)) }
            .map { UIImage.cropToSquare($0) }
    }()

    private var updatedImagelist: [UIImage] = []
    private var imageProcessor = ImageProcessor()

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

        let startTime = Date().timeIntervalSince1970
        imageProcessor.processImagesOnThread(
            sourceImages: imageList,
            filter: .colorInvert,
            qos: .background,
            completion: { updatedImage in
                self.updatedImagelist = updatedImage.map { UIImage(cgImage: $0!) }
            }
        )
        while (updatedImagelist.isEmpty) { }
        getLeadTime(startTime)
        collectionView.reloadData()

        /*
         Qos: .userInitiated, время выполнения: 841 ms
         Qos: .userInteractive, время выполнения: 837 ms
         Qos: .default, время выполнения: 821 ms
         Qos: .background, время выполнения: 3403 ms
         */
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
        updatedImagelist.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCell.ID,
            for: indexPath
        ) as! ProfileCell

        let image = updatedImagelist[indexPath.row]
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

    private func getLeadTime(_ startTime: TimeInterval) {
        let timeSpent = Date().timeIntervalSince1970 - startTime
        print("Time spent: \(timeSpent * 1000) ms")
    }
}
