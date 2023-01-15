import UIKit

class EmailTableViewCell: UITableViewCell {

    private lazy var emailFiled: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        SettingsHelper.tuneTextField(for: textField, placeHolder: "Email or phone")
        textField.autocapitalizationType = .none
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(emailFiled)

        SettingsHelper.setupConstarints(for: emailFiled, viewCell: self)
        
        tuneView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func tuneView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        selectionStyle = .none
    }

    private func setupConstarints() {
        NSLayoutConstraint.activate([
            emailFiled.trailingAnchor.constraint(equalTo: trailingAnchor),
            emailFiled.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailFiled.topAnchor.constraint(equalTo: topAnchor),
            emailFiled.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
