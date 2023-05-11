import UIKit

class PhotosTableViewCell: UITableViewCell {

    private enum Constants {
        static let verticalSpacing: CGFloat = 12
        static let horizontalSpacing: CGFloat = 12
        static let betweenSpacing: CGFloat = 8
    }

    private let imageList: [UIImage] = {
        (1...4)
            .compactMap { UIImage(named: String($0)) }
            .map { UIImage.cropToSquare($0) }
    }()

    private lazy var topSparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()

    private lazy var bottomSparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()

    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    private lazy var imageView1: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = imageList[0]
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private lazy var imageView2: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = imageList[1]
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private lazy var imageView3: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = imageList[2]
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private lazy var imageView4: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = imageList[3]
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pushButton"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        addSubvews()
        tuneView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubvews() {
        contentView.addSubview(topSparatorView)
        contentView.addSubview(bottomSparatorView)
        contentView.addSubview(photosLabel)
        contentView.addSubview(imageView1)
        contentView.addSubview(imageView2)
        contentView.addSubview(imageView3)
        contentView.addSubview(imageView4)
        contentView.addSubview(arrowImageView)
    }

    private func tuneView() {
        selectionStyle = .none
    }

    private func setupConstraints() {

        let displayWidth = contentView.frame.width
        let imageViewWidth = (displayWidth - 2 * Constants.horizontalSpacing - 3 * Constants.betweenSpacing) / 3

        NSLayoutConstraint.activate([
            topSparatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            topSparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            topSparatorView.heightAnchor.constraint(equalToConstant: 0.5),

            photosLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.verticalSpacing
            ),
            photosLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Constants.horizontalSpacing
            ),
            photosLabel.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: Constants.horizontalSpacing
            ),

            arrowImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Constants.horizontalSpacing
            ),

            imageView1.topAnchor.constraint(
                equalTo: photosLabel.bottomAnchor,
                constant: Constants.verticalSpacing
            ),
            imageView1.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Constants.horizontalSpacing
            ),
            imageView1.widthAnchor.constraint(equalToConstant: imageViewWidth),
            imageView1.heightAnchor.constraint(equalToConstant: imageViewWidth),

            imageView2.topAnchor.constraint(
                equalTo: photosLabel.bottomAnchor,
                constant: Constants.verticalSpacing
            ),
            imageView2.leftAnchor.constraint(
                equalTo: imageView1.rightAnchor,
                constant: Constants.betweenSpacing
            ),
            imageView2.widthAnchor.constraint(equalToConstant: imageViewWidth),
            imageView2.heightAnchor.constraint(equalToConstant: imageViewWidth),

            imageView3.topAnchor.constraint(
                equalTo: photosLabel.bottomAnchor,
                constant: Constants.verticalSpacing
            ),
            imageView3.leftAnchor.constraint(
                equalTo: imageView2.rightAnchor,
                constant: Constants.betweenSpacing
            ),
            imageView3.widthAnchor.constraint(equalToConstant: imageViewWidth),
            imageView3.heightAnchor.constraint(equalToConstant: imageViewWidth),

            imageView4.topAnchor.constraint(
                equalTo: photosLabel.bottomAnchor,
                constant: Constants.verticalSpacing
            ),
            imageView4.leftAnchor.constraint(
                equalTo: imageView3.rightAnchor,
                constant: Constants.betweenSpacing
            ),
            imageView4.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant:  -Constants.horizontalSpacing
            ),
            imageView4.heightAnchor.constraint(equalToConstant: imageViewWidth),

            bottomSparatorView.topAnchor.constraint(
                equalTo: imageView1.bottomAnchor,
                constant: Constants.verticalSpacing
            ),
            bottomSparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bottomSparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bottomSparatorView.heightAnchor.constraint(equalToConstant: Constants.verticalSpacing),
            bottomSparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension UIImage {

    static func cropToSquare(_ image: UIImage) -> UIImage {
        let cgImage = image.cgImage!
        let imageHeight = cgImage.height
        let imageWidth = cgImage.width
        let isCropWidth = imageHeight < imageWidth
        let minSize = isCropWidth ? imageHeight : imageWidth
        let xCoord = isCropWidth ? (imageWidth - imageHeight) / 2 : 0
        let yCoord = isCropWidth ? 0 : (imageHeight - imageWidth) / 2
        let croppedImage: CGImage! = cgImage.cropping(
            to: CGRect(
                x: xCoord,
                y: yCoord,
                width: minSize,
                height: minSize
            )
        )
        return UIImage(cgImage: croppedImage)
    }
}
