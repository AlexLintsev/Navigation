import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String = "Waiting for something..."

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()

    private lazy var labelStatusView: UILabel = {
        let view = UILabel(frame: CGRect(
            x: 130,
            y: Int(actionButton.frame.minY) - 64 - 18, // задавал - 34 вместо - 64 по первому макету, для второго - 64
            width: Int(self.frame.maxX) - 130 - 16,
            height: 18
        ))
        view.text = statusText
        view.textColor = UIColor.darkGray
        view.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        return view
    }()

    private lazy var textField: TextFieldWithPadding = {
        let field = TextFieldWithPadding(frame: CGRect(
            x: Int(labelStatusView.frame.minX),
            y: Int(labelStatusView.frame.maxY + 10),
            width: Int(labelStatusView.frame.width),
            height: 40
        ))
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

        let labelNameView = UILabel(frame: CGRect(
            x: 130,
            y: 27,
            width: self.frame.maxX - 130 - 16,
            height: 22
        ))
        labelNameView.text = "Hipster Cat"
        labelNameView.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        labelNameView.textColor = .black
        addSubview(labelNameView)

        let imageView = UIImageView(image: UIImage(named: "cat")!)
        imageView.frame = CGRect(
            x: 16,
            y: 16,
            width: 100,
            height: 100
        )
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        addSubview(imageView)

        actionButton.frame = CGRect(
            x: 16,
            y: Int(CGRectGetMaxY(imageView.frame) + 46), // задавал + 16 вместо + 46 по первому макету, для второго + 46
            width: Int(self.frame.width) - 32,
            height: 50
        )
        addSubview(actionButton)
        actionButton.addTarget(
            self,
            action: #selector(buttonPressed(_:)),
            for: .touchUpInside
        )

        addSubview(labelStatusView)

        textField.addTarget(
            self,
            action: #selector(statusTextChanged(_:)),
            for: .editingChanged
        )
        addSubview(textField)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonPressed(_ sender: UIButton) {
        labelStatusView.text = statusText
        textField.text = nil
        print("Status updated: \(statusText)")
    }

    @objc func statusTextChanged(_ textField: TextFieldWithPadding) {
        statusText = textField.text ?? ""
    }
}
