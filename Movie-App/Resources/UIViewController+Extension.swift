//
//  UIViewController+Extension.swift
//  Movie-App
//
//  Created by Deotwal, Jalaj | Ronnie
//

import UIKit

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastContainer = UIView()
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 10
        toastContainer.clipsToBounds = true

        let toastLabel = UILabel()
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = .systemFont(ofSize: 14, weight: .regular)
        toastLabel.text = message
        toastLabel.numberOfLines = 0

        toastContainer.addSubview(toastLabel)
        view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 16),
            toastLabel.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -16),
            toastLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 12),
            toastLabel.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -12),

            toastContainer.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            toastContainer.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            toastContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
