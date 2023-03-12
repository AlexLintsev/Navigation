import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    private lazy var authorFieldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
            reuseIdentifier: reuseIdentifier
        )

        tuneView()
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(authorFieldLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            authorFieldLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            authorFieldLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            authorFieldLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            authorFieldLabel.heightAnchor.constraint(equalToConstant: 40),

            pictureView.topAnchor.constraint(equalTo: authorFieldLabel.bottomAnchor),
            pictureView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pictureView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            descriptionLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: pictureView.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: pictureView.rightAnchor, constant: -16),

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            likesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            likesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            viewsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            viewsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    private func tuneView() {
        backgroundColor = .none
        contentView.backgroundColor = .none
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        selectionStyle = .none
        accessoryType = .none
    }

    func update(_ post: Post) {
        authorFieldLabel.text = "Автор публикации: \(post.author)"
        let imageProcessor = ImageProcessor()
        imageProcessor.processImage(
            sourceImage: UIImage(named: post.image)!,
            filter: .colorInvert,
            completion: { pictureView.image = $0 }
        )
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
