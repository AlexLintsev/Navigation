import UIKit

class ProfileCell: UICollectionViewCell {

    static let ID = "ProfileCollectionViewCell_ReuseID"

    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func addSubviews() {
        contentView.addSubview(profileImageView)
    }

    private func setupLayouts() {

        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            profileImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func update(with image: UIImage) {
        profileImageView.image = image
    }
}
