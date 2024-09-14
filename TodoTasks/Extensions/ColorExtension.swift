import UIKit

extension UIColor {
    static func create(hex: String, alpha: CGFloat) -> UIColor {
        lazy var defaultColor = UIColor.clear
        
        guard !hex.isEmpty else { return defaultColor }
        
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return defaultColor
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    //MARK: - Main
    static func title(alpha: CGFloat = 1) -> UIColor {
        .black
    }

    static func date(alpha: CGFloat = 1) -> UIColor {
        .lightGray
    }

    static func addNewTaskButtonBackground(alpha: CGFloat = 1) -> UIColor {
        UIColor.create(hex: "#dee8f9", alpha: alpha)
    }

    static func addNewTaskButtonTitle(alpha: CGFloat = 1) -> UIColor {
        UIColor.create(hex: "#2d6de8", alpha: alpha)
    }

    static func separatedViewBackground(alpha: CGFloat = 1) -> UIColor {
        .lightGray
    }

    //MARK: - Filter Buttons
    static func filterButtonUnselectedTitle(alpha: CGFloat = 1) -> UIColor {
        .lightGray
    }

    static func filterButtonUnselectedNumberBackground(alpha: CGFloat = 1) -> UIColor {
        .lightGray
    }

    static func filterButtonUnselectedNumber(alpha: CGFloat = 1) -> UIColor {
        .white
    }

    static func filterButtonSelectedTitle(alpha: CGFloat = 1) -> UIColor {
        UIColor.create(hex: "#0a55f9", alpha: 1)
    }

    static func filterButtonSelectedNumberBackground(alpha: CGFloat = 1) -> UIColor {
        UIColor.create(hex: "#0a55f9", alpha: 1)
    }

    static func filterButtonSelectedNumber(alpha: CGFloat = 1) -> UIColor {
        .white
    }
}
