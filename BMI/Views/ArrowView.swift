//
// Created by Piotr Kupczyk on 04.07.2018.
// Copyright (c) 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class ArrowView: UIView {

    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        super.draw(rect)
        let height = bounds.height

        guard let context = UIGraphicsGetCurrentContext() else {return}

        let x: CGFloat = 50.0

        let endPoint = CGPoint(x: x, y: height)

        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.black.cgColor)

        context.move(to: CGPoint(x: 50, y: 0))
        context.addLine(to: endPoint)

        context.move(to: CGPoint(x: x-20, y: 2*height/3))
        context.addLine(to: endPoint)

        context.move(to: CGPoint(x: x+20, y: 2*height/3))
        context.addLine(to: endPoint)

        context.strokePath()
    }

    func moveAndShow(to: CGPoint) {
        let transform = self.transform
        let moveTransform = transform.translatedBy(x: to.x, y: to.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = moveTransform
        })
    }

}
