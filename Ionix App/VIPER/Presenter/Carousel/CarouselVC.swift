//
//  CarouselVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 03/08/21.
//

import UIKit

class CarouselVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    lazy var screenPermissions : [StepViewCarouselVC] = {
        let firstView = StepViewCarouselVC()
        firstView.setPermission(permission: PermissionEntity(
                                    imageNamePermission: "cameraPermission",
                                    titlePermission: "Camera Access",
                                    descriptionPermission: "Please allow access to your camera to take photos",
                                    typePermission: .Camera))
        let secondView = StepViewCarouselVC()
        secondView.setPermission(permission: PermissionEntity(
                                    imageNamePermission: "PushNotificationPermission",
                                    titlePermission: "Enable Push Notifications",
                                    descriptionPermission: "Enable push notifications to let send you personal news and updates.",
                                    typePermission: .PushNotifications))
        let thirdView = StepViewCarouselVC()
        secondView.setPermission(permission: PermissionEntity(
                                    imageNamePermission: "locationPermission",
                                    titlePermission: "Enable Location Services",
                                    descriptionPermission: "We wants to access your location only to provide a better experience by helping you find new friends nearby.",
                                    typePermission: .Location))
        
        return [firstView, secondView, thirdView]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func initViewController(){
        dataSource = self
        delegate = self
        
        if let firstViewController = screenPermissions.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return screenPermissions.count
        }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }

}
