import UIKit

extension UIColor {
    convenience public init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience public init(hexadecimal: Int) {
        self.init(red:(hexadecimal >> 16) & 0xff, green:(hexadecimal >> 8) & 0xff, blue:hexadecimal & 0xff)
    }
}

//Note the '0x' prefix before the hexadecimal number
//In the example below, '0x' indicates that the following integer is in hex format,
//and 'FFFFF' is the actual hex integer
let exampleColor1 = UIColor(hexadecimal: 0xFFFFF)
let exampleColor2 = UIColor(hexadecimal: 0xab543)
