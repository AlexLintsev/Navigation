import UIKit

class SettingsHelper {

    static func tuneTextField(for textField: TextFieldWithPadding, placeHolder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "systemFont", size: 16)
        textField.textColor = .black
        textField.placeholder = placeHolder
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
    }

    static func setupConstarints(for textField: TextFieldWithPadding, viewCell: UITableViewCell) {
        NSLayoutConstraint.activate([
            textField.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor),
            textField.topAnchor.constraint(equalTo: viewCell.topAnchor),
            textField.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor)
        ])
    }

//    static func getPixelColor(from image: UIImage) -> UIColor {
//        let pixelData = image.cgImage!.dataProvider!.data
//        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
//        let r = CGFloat(data[0]) / CGFloat(255.0)
//        let g = CGFloat(data[1]) / CGFloat(255.0)
//        let b = CGFloat(data[2]) / CGFloat(255.0)
//        let a = CGFloat(data[3]) / CGFloat(255.0)
//        return UIColor(red: r, green: g, blue: b, alpha: a)
//    }
}


