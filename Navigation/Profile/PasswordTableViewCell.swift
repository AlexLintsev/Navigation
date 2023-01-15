import UIKit

class PasswordTableViewCell: UITableViewCell {

    private lazy var passwordField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        SettingsHelper.tuneTextField(for: textField, placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(passwordField)

        SettingsHelper.setupConstarints(for: passwordField, viewCell: self)

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
}
