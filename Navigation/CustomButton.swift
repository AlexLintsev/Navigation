import UIKit

class CustomButton: UIButton {

    var tapAction: (() -> Void)?

    init(
        isUserInteractionEnabled: Bool,
        titleLabel: String?,
        backgroundColor: UIColor?,
        imageName: String?
    ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.setTitle(titleLabel, for: .normal)
        self.backgroundColor = backgroundColor
        self.setImage(UIImage(named: imageName ?? ""), for: .normal)
        self.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        tapAction?()
    }
}
