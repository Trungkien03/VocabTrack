//
//  SceneDelegate.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

// Mọi thứ về
class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        print("SceneDelegate is connected!")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("SceneDelegate did disconect!")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("SceneDelegate did become active!")
        AppReviewManager.shared.requestReviewIfAppropriate()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("SceneDelegate will resign active!")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("SceneDelegate will enter foreground!")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("SceneDelegate did enter background!")
    }

    // Hàm này sẽ được gọi khi ứng dụng mở với một URL (deeplink)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // Lấy URL đầu tiên (nếu có)
        guard let url = URLContexts.first?.url else {
            return
        }

        // Gọi hàm xử lý deeplink
        handleDeeplink(url: url)
    }

    // Hàm xử lý deeplink
    private func handleDeeplink(url: URL) {
        print("Handling deeplink: \(url)")

        // Parse URL và thực hiện các hành động tương ứng
        let urlString = url.absoluteString
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    }
}
