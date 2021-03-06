// UIView+Layout.swift
//
// Copyright (c) 2017 Frédéric Maquin <fred@ephread.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

internal extension UIView {

    var isOutOfSuperview: Bool {
        guard let superview = self.superview else {
            return true
        }

        let intersectedFrame = superview.bounds.intersection(self.frame)

        let isInBounds = fabs(intersectedFrame.origin.x - self.frame.origin.x) < 1 &&
            fabs(intersectedFrame.origin.y - self.frame.origin.y) < 1 &&
            fabs(intersectedFrame.size.width - self.frame.size.width) < 1 &&
            fabs(intersectedFrame.size.height - self.frame.size.height) < 1

        return !isInBounds
    }

    func isOutOfSuperview(consideringInsets insets: UIEdgeInsets) -> Bool {
        guard let superview = self.superview else {
            return true
        }

        let intersectedFrame = superview.bounds.intersection(self.frame)

        let isInBounds = fabs(intersectedFrame.origin.x - (self.frame.origin.x + insets.left)) < 1 &&
            fabs(intersectedFrame.origin.y - (self.frame.origin.y + insets.top)) < 1 &&
            fabs(intersectedFrame.size.width - self.frame.size.width - (insets.left + insets.right)) < 1 &&
            fabs(intersectedFrame.size.height - self.frame.size.height - (insets.top + insets.bottom)) < 1

        return !isInBounds
    }

    func fillSuperview() {
        fillSuperviewVertically()
        fillSuperviewHorizontally()
    }

    func fillSuperviewVertically() {
        for constraint in makeConstraintToFillSuperviewVertically() { constraint.isActive = true }
    }

    func fillSuperviewHorizontally() {
        for constraint in makeConstraintToFillSuperviewHorizontally() { constraint.isActive = true }
    }

    func makeConstraintToFillSuperviewVertically() -> [NSLayoutConstraint] {
        guard let superview = superview else {
            print("Warning: View has no parent, can't make fill constraints.")
            return []
        }

        return [
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
    }

    func makeConstraintToFillSuperviewHorizontally() -> [NSLayoutConstraint] {
        guard let superview = superview else {
            print("Warning: View has no parent, can't make fill constraints.")
            return []
        }

        return [
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ]
    }
}
