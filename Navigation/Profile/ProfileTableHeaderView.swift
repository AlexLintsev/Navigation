import UIKit
import SnapKit

class ProfileHeaderView: UIView {

    private var statusText: String = "Waiting for something..."

    private var safeAreaViewControllerGuide: UILayoutGuide!

    private var avatarImageViewCenter: CGPoint!

    private lazy var avatarImageView: UIImageView = {
        let originalImage = UIImage(named: "cat")!
        let view = UIImageView(image: UIImage.cropToSquare(originalImage))
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

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(named: "closeButton"),
            for: .normal
        )
        button.isHidden = true
        button.isUserInteractionEnabled = true
        return button
    }()

    private lazy var viewForCloseButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.isHidden = true
        return view
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = "Hipster Cat"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = .black
        return label
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setTitle("Set status", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()

    private lazy var statusLabel: UILabel = {
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
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func statusButtonPressed(_ sender: UIButton) {
        statusLabel.text = statusText
        statusTextField.text = nil
        print("Status updated: \(statusText)")
    }

    @objc func statusTextChanged(_ statusTextField: TextFieldWithPadding) {
        statusText = statusTextField.text ?? ""
    }

    @objc func closeButtonPressed(_ sender: UIButton) {
        launchReverseAnimationAvatar()
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

    private func setupActions() {
        setStatusButton.addTarget(
            self,
            action: #selector(statusButtonPressed(_:)),
            for: .touchUpInside
        )

        statusTextField.addTarget(
            self,
            action: #selector(statusTextChanged(_:)),
            for: .editingChanged
        )

        closeButton.addTarget(
            self,
            action: #selector(closeButtonPressed(_:)),
            for: .touchUpInside
        )
    }

    private func setupConstraints() {
        let safeAreaGuide = safeAreaLayoutGuide

        avatarImageView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.top.equalTo(safeAreaGuide).offset(16)
            $0.left.equalTo(safeAreaGuide).offset(16)
        }

        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaGuide).offset(27)
            $0.left.equalTo(avatarImageView.snp.right).offset(16)
        }

        setStatusButton.snp.makeConstraints {
            $0.left.equalTo(safeAreaGuide).offset(16)
            $0.right.equalTo(safeAreaGuide).offset(-16)
            $0.top.equalTo(avatarImageView.snp.bottom).offset(46)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeAreaGuide).offset(-16)
        }

        statusLabel.snp.makeConstraints {
            $0.left.equalTo(safeAreaGuide).offset(130)
            $0.right.equalTo(safeAreaGuide).offset(-16)
            $0.bottom.equalTo(setStatusButton.snp.top).offset(-64)
        }

        statusTextField.snp.makeConstraints {
            $0.left.equalTo(statusLabel)
            $0.right.equalTo(safeAreaGuide).offset(-16)
            $0.top.equalTo(statusLabel.snp.bottom).offset(10)
            $0.height.equalTo(40)
        }

        closeButton.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaGuide.snp.right).offset(-50)
            $0.centerY.equalTo(safeAreaGuide.snp.top).offset(50)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }

        viewForCloseButton.snp.makeConstraints {
            $0.edges.equalTo(closeButton)
        }
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
