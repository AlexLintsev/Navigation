import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String = "Waiting for something..."

    private var safeAreaViewControllerGuide: UILayoutGuide!

    private var avatarImageViewCenter: CGPoint!

    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        let tapAvatar = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapAvatar)
        )
        view.addGestureRecognizer(tapAvatar)
        return view
    }()

    private lazy var viewUnderAvatar: UIView = {
        let view = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 10000,
            height: 10000
        ))
        view.isHidden = true
        return view
    }()

    private lazy var closeButton = CustomButton(
        isUserInteractionEnabled: true,
        titleLabel: nil,
        backgroundColor: nil,
        imageName: "closeButton"
    )

    private lazy var viewForCloseButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.isHidden = true
        return view
    }()

    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = .black
        return label
    }()

    private lazy var setStatusButton = CustomButton(
        isUserInteractionEnabled: true,
        titleLabel: "Set status",
        backgroundColor: .systemBlue,
        imageName: nil
    )

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = statusText
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        return label
    }()

    private lazy var statusTextField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isUserInteractionEnabled = true
        field.placeholder = "Enter new status"
        field.textColor = UIColor.black
        field.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.backgroundColor = .white
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(viewUnderAvatar)
        addSubview(avatarImageView)
        addSubview(closeButton)
        addSubview(viewForCloseButton)
        setupSubviews()
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func statusTextChanged(_ statusTextField: TextFieldWithPadding) {
        statusText = statusTextField.text ?? ""
    }


    @objc func didTapAvatar() {
        launchAnimationAvatar()
    }

    private func launchAnimationAvatar() {
        safeAreaViewControllerGuide = avatarImageView.findViewController()!.view.safeAreaLayoutGuide

        avatarImageViewCenter = avatarImageView.center

        let avatarWidth = avatarImageView.frame.width
        let screenWidth = safeAreaViewControllerGuide.layoutFrame.width
        let screenHeight = safeAreaViewControllerGuide.layoutFrame.height

        viewUnderAvatar.backgroundColor = .white.withAlphaComponent(0)
        viewUnderAvatar.isHidden = false
        viewForCloseButton.isHidden = false
        closeButton.isHidden = false

        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0.5,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.5 / 0.8) {
                        self.avatarImageView.center = CGPoint(
                            x: screenWidth / 2,
                            y: screenHeight / 2
                        )

                        self.avatarImageView.transform = CGAffineTransform(
                            scaleX: screenWidth / avatarWidth,
                            y: screenWidth / avatarWidth
                        )

                        self.avatarImageView.layer.cornerRadius = 0
                        self.avatarImageView.layer.borderWidth = 0
                        self.viewUnderAvatar.backgroundColor = .white.withAlphaComponent(0.7)
                    }

                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 0.3 / 0.8) {
                        self.viewForCloseButton.backgroundColor = .systemGray6.withAlphaComponent(0)
                    }
            },
            completion: { finished in
                self.viewForCloseButton.isHidden = true
            }
        )
    }

    private func launchReverseAnimationAvatar() {
        safeAreaViewControllerGuide = avatarImageView.findViewController()!.view.safeAreaLayoutGuide

        let avatarWidth = avatarImageView.frame.width
        let screenWidth = safeAreaViewControllerGuide.layoutFrame.width

        viewForCloseButton.isHidden = false

        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0.5,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.3 / 0.8) {
                        self.viewForCloseButton.backgroundColor = .systemGray6.withAlphaComponent(1.0)
                    }

                UIView.addKeyframe(
                    withRelativeStartTime: 0.3,
                    relativeDuration: 0.5 / 0.8) {
                        self.avatarImageView.center = CGPoint(
                            x: self.avatarImageViewCenter.x,
                            y: self.avatarImageViewCenter.y
                        )

                        self.avatarImageView.transform = CGAffineTransform(
                            scaleX: screenWidth / avatarWidth,
                            y: screenWidth / avatarWidth
                        )

                        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height / 2
                        self.avatarImageView.layer.borderWidth = 3
                        self.viewUnderAvatar.backgroundColor = .white.withAlphaComponent(0)
                    }
            },
            completion: { finished in
                self.closeButton.isHidden = true
                self.viewForCloseButton.isHidden = true
                self.viewUnderAvatar.isHidden = true
            }
        )
    }

    private func setupSubviews() {
        setStatusButton.tintColor = .white
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7

        closeButton.isHidden = true
    }

    private func setupActions() {
        setStatusButton.tapAction = {
            self.statusLabel.text = self.statusText
            self.statusTextField.text = nil
            print("Status updated: \(self.statusText)")
        }

        closeButton.tapAction = {
            self.launchReverseAnimationAvatar()
        }

        statusTextField.addTarget(
            self,
            action: #selector(statusTextChanged(_:)),
            for: .editingChanged
        )
    }

    private func setupConstraints() {
        let safeAreaGuide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor,
                constant: 16
            ),
            avatarImageView.leftAnchor.constraint(
                equalTo: safeAreaGuide.leftAnchor,
                constant: 16
            ),

            fullNameLabel.heightAnchor.constraint(equalToConstant: 22),
            fullNameLabel.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor,
                constant: 27
            ),
            fullNameLabel.leftAnchor.constraint(
                equalTo: avatarImageView.rightAnchor,
                constant: 14
            ),
            fullNameLabel.rightAnchor.constraint(
                equalTo: safeAreaGuide.rightAnchor,
                constant: -16
            ),

            setStatusButton.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 16
            ),
            setStatusButton.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: -16
            ),
            setStatusButton.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor,
                constant: 46
            ),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -16),

            statusLabel.leftAnchor.constraint(
                equalTo: safeAreaGuide.leftAnchor,
                constant: 130
            ),
            statusLabel.rightAnchor.constraint(
                equalTo: safeAreaGuide.rightAnchor,
                constant: -16
            ),
            statusLabel.bottomAnchor.constraint(
                equalTo: setStatusButton.topAnchor,
                constant: -64
            ),
            statusLabel.heightAnchor.constraint(equalToConstant: 18),

            statusTextField.leftAnchor.constraint(equalTo: statusLabel.leftAnchor),
            statusTextField.rightAnchor.constraint(
                equalTo: safeAreaGuide.rightAnchor,
                constant: -16
            ),
            statusTextField.topAnchor.constraint(
                equalTo: statusLabel.bottomAnchor,
                constant: 10
            ),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),

            closeButton.centerXAnchor.constraint(
                equalTo: safeAreaGuide.rightAnchor,
                constant: -50
            ),
            closeButton.centerYAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor,
                constant: 50
            ),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),

            viewForCloseButton.leftAnchor.constraint(equalTo: closeButton.leftAnchor),
            viewForCloseButton.rightAnchor.constraint(equalTo: closeButton.rightAnchor),
            viewForCloseButton.topAnchor.constraint(equalTo: closeButton.topAnchor),
            viewForCloseButton.bottomAnchor.constraint(equalTo: closeButton.bottomAnchor)
        ])
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
