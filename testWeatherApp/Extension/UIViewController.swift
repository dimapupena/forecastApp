//
//  UIViewController.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showLoader() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let loaderView = UIActivityIndicatorView()
            loaderView.style = .large
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            loaderView.startAnimating()
            
            if let parentView = window.rootViewController?.view {
                parentView.addSubview(loaderView)
                loaderView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
                loaderView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
                loaderView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
                loaderView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
            }
        }
    }

    func hideLoader() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            if let loaderView = window.rootViewController?.view.subviews.first(where: { $0 is UIActivityIndicatorView }) {
                loaderView.removeFromSuperview()
            }
        }
    }
}
