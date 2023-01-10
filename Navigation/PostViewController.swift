import UIKit

class PostViewController: UIViewController {

    var postTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = postTitle
        view.backgroundColor = .systemYellow

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(leftButtonPressed(_:))
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(rightButtonPressed(_:))
        )
    }

    @objc func leftButtonPressed(_ sender: UIButton) {
        let infoNavigationController = UINavigationController(rootViewController: InfoViewController())

        infoNavigationController.modalTransitionStyle = .crossDissolve
        infoNavigationController.modalPresentationStyle = .formSheet

        present(infoNavigationController, animated: true)
    }

    @objc func rightButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
