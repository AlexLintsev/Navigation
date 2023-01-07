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
            action: #selector(buttonPressed(_:))
        )
    }

    @objc func buttonPressed(_ sender: UIButton) {
        let infoNavigationController = UINavigationController(rootViewController: InfoViewController())

        infoNavigationController.modalTransitionStyle = .crossDissolve
        infoNavigationController.modalPresentationStyle = .fullScreen

        present(infoNavigationController, animated: true)
    }
}
