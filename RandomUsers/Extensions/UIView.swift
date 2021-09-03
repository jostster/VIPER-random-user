//
//  UIView.swift
//  RandomUsers
//
//  Created by Brian Jost on 9/2/21.
//

import UIKit

extension UIView {

	func roundCorners(corners:UIRectCorner, radius: CGFloat) {

		DispatchQueue.main.async {
			let path = UIBezierPath(roundedRect: self.bounds,
									byRoundingCorners: corners,
									cornerRadii: CGSize(width: radius, height: radius))
			let maskLayer = CAShapeLayer()
			maskLayer.frame = self.bounds
			maskLayer.path = path.cgPath
			self.layer.mask = maskLayer
		}
	}
}
