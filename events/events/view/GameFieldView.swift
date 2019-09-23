//
// Created by Ivan Andreyshev on 23/09/2019.
// Copyright (c) 2019 iandreyshev. All rights reserved.
//

import UIKit


@IBDesignable
class GameFieldView: UIView {

    @IBInspectable var shapeColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shapePosition: CGPoint = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shapeSize: CGSize = CGSize(width: 100, height: 100) {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var isShapeVisible: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    var shapeHitHandler: (() -> Void)?

    private var _lastPath: UIBezierPath!

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard isShapeVisible else {
            _lastPath = nil
            return
        }

        shapeColor.setFill()
        let shapeRect = CGRect(origin: shapePosition, size: shapeSize)
        _lastPath = getTrianglePath(in: shapeRect)
        _lastPath?.fill()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let curPath = _lastPath else {
            return
        }

        let isHitCompleted = touches.contains(where: { touch -> Bool in
            let touchPoint = touch.location(in: self)
            return curPath.contains(touchPoint)
        })

        if (isHitCompleted) {
            shapeHitHandler?()
        }
    }

    func randomizeShapes() {
        let maxX = bounds.width - shapeSize.width
        let newX = CGFloat(arc4random_uniform(UInt32(maxX)))
        let maxY = bounds.height - shapeSize.height
        let newY = CGFloat(arc4random_uniform(UInt32(maxY)))
        shapePosition = CGPoint(x: newX, y: newY)
    }

    private func getTrianglePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 0
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.close()
        path.stroke()
        path.fill()

        return path
    }

}
