import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowsScene)
        let view = FirstViewController()
        let presenter = FirstViewPresenter(view: view)
        view.presenter = presenter
        let navigationVC = UINavigationController(rootViewController: view)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}
