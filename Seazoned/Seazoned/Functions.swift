//
//  Functions.swift
//  Prediktion
//
//  Created by Dinesh Sailor on 17/07/17.
//  Copyright © 2017 Dinesh Sailor. All rights reserved.
//

import UIKit

import SVProgressHUD

// MARK: - Storyboard
func getStoryboard(storyboardName: String) -> UIStoryboard {
	return UIStoryboard(name: "\(storyboardName)", bundle: nil)
}

func instantiateViewController(storyboardID: String) -> UIViewController {
	let viewController = getStoryboard(storyboardName: "Main").instantiateViewController(withIdentifier: storyboardID)
	return viewController
}

// MARK: - UIColor
func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
	return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}

func colorWithAlpha(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
	return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

//  MARK: - NSNull
func isNotNull(_ object: AnyObject?) -> Bool {
	guard let object = object else {
		return false
	}
	
	return isNotNSNull(object: object)
}

func isNotNSNull(object:AnyObject) -> Bool {
	return object.classForCoder != NSNull.classForCoder()
}

//  MARK: - Delay
func delay(delay:Double, closure:@escaping ()->()) {
	DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
		closure()
	}
}

//  MARK: - SVProgressHUD
func showError(with text: String) {
	SVProgressHUD.setDefaultStyle(.light)
	SVProgressHUD.setDefaultMaskType(.gradient)
	SVProgressHUD.showError(withStatus: text)
	SVProgressHUD.dismiss(withDelay: 1.5)
}

func showSuccess(with text: String) {
	SVProgressHUD.setDefaultStyle(.light)
	SVProgressHUD.setDefaultMaskType(.gradient)
	SVProgressHUD.showSuccess(withStatus: text)
	SVProgressHUD.dismiss(withDelay: 1.5)
}

func showInfo(with text: String) {
	SVProgressHUD.setDefaultStyle(.light)
	SVProgressHUD.setDefaultMaskType(.gradient)
	SVProgressHUD.showInfo(withStatus: text)
	SVProgressHUD.dismiss(withDelay: 1.5)
}

//  MARK: - Validations
func isEmailValid(_ string: String) -> Bool {
	let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
	
	let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
	return predicate.evaluate(with: string)
}

func isPasswordValid(_ string: String) -> Bool {
	let passwordRegex = "^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%]{8,}$"
	
	let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
	return predicate.evaluate(with: string)
}

class Functions: NSObject {
	
	class func shareString(title : String!, array: [AnyObject]) -> String {
		
		var strValue: String!
		
		strValue = "\(title!)"
		
		if array.count > 0 {
			
			for i in 0...array.count-1 {
				let share:[String: String] = array[i] as! [String : String]
				strValue = "\(strValue!)   \(share["title"]!)  \(share["value"]!)"
			}
			
		}
		
		return strValue!
		
	}
	
}

extension Array where Element: Equatable {
	
	// Remove first collection element that is equal to the given `object`:
	mutating func remove(object: Element) {
		if let index = index(of: object) {
			remove(at: index)
		}
	}
}

extension UIView {
	
	func addBorder(edges: UIRectEdge, color: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: CGFloat = 1.0) -> [UIView] {
		
		var borders = [UIView]()
		
		func border() -> UIView {
			let border = UIView(frame: CGRect.zero)
			border.backgroundColor = color
			border.translatesAutoresizingMaskIntoConstraints = false
			return border
		}
		
		if edges.contains(.top) || edges.contains(.all) {
			let top = border()
			addSubview(top)
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
				                               options: [],
				                               metrics: ["thickness": thickness],
				                               views: ["top": top]))
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
				                               options: [],
				                               metrics: nil,
				                               views: ["top": top]))
			borders.append(top)
		}
		
		if edges.contains(.left) || edges.contains(.all) {
			let left = border()
			addSubview(left)
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
				                               options: [],
				                               metrics: ["thickness": thickness],
				                               views: ["left": left]))
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
				                               options: [],
				                               metrics: nil,
				                               views: ["left": left]))
			borders.append(left)
		}
		
		if edges.contains(.right) || edges.contains(.all) {
			let right = border()
			addSubview(right)
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
				                               options: [],
				                               metrics: ["thickness": thickness],
				                               views: ["right": right]))
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
				                               options: [],
				                               metrics: nil,
				                               views: ["right": right]))
			borders.append(right)
		}
		
		if edges.contains(.bottom) || edges.contains(.all) {
			let bottom = border()
			addSubview(bottom)
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
				                               options: [],
				                               metrics: ["thickness": thickness],
				                               views: ["bottom": bottom]))
			addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
				                               options: [],
				                               metrics: nil,
				                               views: ["bottom": bottom]))
			borders.append(bottom)
		}
		
		return borders
	}
	
}

extension NSLayoutConstraint {
	//We use a simple inspectable to allow us to set a value for iphone 4.
	@IBInspectable var iPhone4Constant: CGFloat {
		
		set {
			if UIScreen.main.nativeBounds.height == 960 {
				self.constant = newValue
			}
		}
		
		get {
			return self.constant
		}
	}
	
	@IBInspectable var iPhone5Constant: CGFloat {
		
		set {
			if UIScreen.main.nativeBounds.height == 1136 {
				self.constant = newValue
			}
		}
		
		get {
			return self.constant
		}
	}
	
	@IBInspectable var iPhone6Constant: CGFloat {
		
		set {
			if UIScreen.main.nativeBounds.height == 1334 {
				self.constant = newValue
			}
		}
		
		get {
			return self.constant
		}
	}
	
	@IBInspectable var iPhone6PConstant: CGFloat {
		
		set {
			if UIScreen.main.nativeBounds.height == 2208 {
				self.constant = newValue
			}
		}
		
		get {
			return self.constant
		}
	}
}

