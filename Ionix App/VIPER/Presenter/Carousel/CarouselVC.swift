//
//  CarouselVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 03/08/21.
//

import UIKit

class CarouselVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, StepViewCarouselProtocol {
    lazy var screenPermissions : [StepViewCarouselVC] = {
        let firstView = StepViewCarouselVC.setPermission(permission: PermissionEntity(
                                                            imageNamePermission: "cameraPermission",
                                                            titlePermission: "Camera Access",
                                                            descriptionPermission: "Please allow access to your camera to take photos",
                                                            typePermission: .Camera))
        firstView.delegate = self
        
        let secondView = StepViewCarouselVC.setPermission(permission: PermissionEntity(
                                                                imageNamePermission: "pushNotificationPermission",
                                                                titlePermission: "Enable Push Notifications",
                                                                descriptionPermission: "Enable push notifications to let send you personal news and updates.",
                                                                typePermission: .PushNotifications))
        secondView.delegate = self
        
        let thirdView = StepViewCarouselVC.setPermission(permission: PermissionEntity(
                                                            imageNamePermission: "locationPermission",
                                                            titlePermission: "Enable Location Services",
                                                            descriptionPermission: "We wants to access your location only to provide a better experience by helping you find new friends nearby.",
                                                            typePermission: .Location),
                                                            isLastPermission: true)
        thirdView.delegate = self
        
        return [firstView, secondView, thirdView]
    }()
    
    private var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController(){
        dataSource = self
        delegate = self
        
        setCurrentPage()
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return screenPermissions.count
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentPage == 0 {
            return nil
        } else {
            currentPage-=1
            return screenPermissions[currentPage]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentPage == screenPermissions.count - 1 {
            return nil
        } else {
            currentPage+=1
            return screenPermissions[currentPage]
        }
    }
    
    func nextView(finishCarousel: Bool) {
        if finishCarousel {
            self.dismiss(animated: true, completion: nil)            
        }else{
            if currentPage < screenPermissions.count - 1 {
                currentPage+=1
            }else{
                currentPage = 0
            }
            setCurrentPage()
        }
    }
    
    private func setCurrentPage(){
        setViewControllers([screenPermissions[currentPage]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

}
