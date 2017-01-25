//
//  AppDelegate.swift
//  Test
//
//  Created by Alex on 1/19/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let naviVC = ScrollingNavigationController()
        let mainView = MainViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        naviVC.viewControllers = [mainView]

        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
        setApperance()
        
        return true
    }

    private func setApperance () {
        let image = generateGradientImage()
        let appearance = UINavigationBar.appearance()
        appearance.setBackgroundImage(image, for: .default)
        appearance.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Chalkduster", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        appearance.tintColor = .white
    }

    private func generateGradientImage() -> UIImage {
        //// blue Gradient
        let startColor = UIColor(red: 0.00, green: 0.78, blue: 1.00, alpha: 1.0)
        let endColor = UIColor(red: 0.00, green: 0.45, blue: 1.00, alpha: 1.0)

        let gradientLayer = CAGradientLayer()
        let sizeLength = UIScreen.main.bounds.size.height * 2
        let navBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: 64)
        gradientLayer.frame = navBarFrame
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]

        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }



}

