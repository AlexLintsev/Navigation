import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String = "Waiting for something..."

    private lazy var avatarImageView: UIImageView = { [unowned self] in
        let view = UIImageView(image: UIImage(named: "cat")!)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    private lazy var fullNameLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = "Hipster Cat"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = .black
        return label
    }()

    private lazy var setStatusButton: UIButton = { [unowned self] in
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

    private lazy var statusLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = statusText
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        return label
    }()

    private lazy var statusTextField: TextFieldWithPadding = { [unowned self] in
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
        backgroundColor = .systemGray
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonPressed(_ sender: UIButton) {
        statusLabel.text = statusText
        statusTextField.text = nil
        print("Status updated: \(statusText)")
    }

    @objc func statusTextChanged(_ statusTextField: TextFieldWithPadding) {
        statusText = statusTextField.text ?? ""
    }

    private func setupActions() {
        setStatusButton.addTarget(
            self,
            action: #selector(buttonPressed(_:)),
            for: .touchUpInside
        )

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
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
