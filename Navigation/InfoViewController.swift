import UIKit

class InfoViewController: UIViewController {

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-> Решить вопрос <-", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Info"
        view.backgroundColor = .systemYellow
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let infoView = InfoView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.center.x * 2,
            height: 150
        ))
        
        infoView.center = CGPoint(x: view.center.x, y: view.center.y / 2)
        view.addSubview(infoView)
        view.addSubview(actionButton)
        actionButton.center = infoView.center
        actionButton.addTarget(
            self,
            action: #selector(buttonPressed(_:)),
            for: .touchUpInside
        )
    }

    @objc func buttonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Мозг перегружен", message: "Как насчет отдыха?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("Пора на отдых")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
        NSLog("Поработаем еще")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
