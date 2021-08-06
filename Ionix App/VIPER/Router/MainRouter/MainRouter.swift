//
//  MainRouter.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 05/08/21.
//

import Foundation
import UIKit

class MainRouter{
    private var baseNavigation: UINavigationController? = nil
    static let shared = MainRouter()
    
    public static func sharedWith(navigation:UINavigationController) -> MainRouter {
        let instance = MainRouter.shared
        instance.baseNavigation = navigation
        return instance
    }
    
    func goCarouselPermission(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "carouselVC") as? CarouselVC
        self.baseNavigation?.present(vc!, animated: true, completion: nil)
    }    
}
