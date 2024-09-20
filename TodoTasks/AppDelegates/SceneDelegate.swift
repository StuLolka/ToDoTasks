import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let vc = TasksViewController(nibName: nil, bundle: nil)
        guard let window else {
            Logger.shared.printLog(.foundNil("window"))
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }

}

