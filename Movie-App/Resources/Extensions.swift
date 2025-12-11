//
//  Extension.swift
//  Movie-App
//
//  Created by Deotwal, Jalaj | Ronnie on 2025/12/10.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
