//
//  GamecontrollViewClass.swift
//  events
//
//  Created by Ivan Andreyshev on 23/09/2019.
//  Copyright © 2019 iandreyshev. All rights reserved.
//

import UIKit

@IBDesignable
class GameControllViewclass: UIView {

    let timeLabel = UILabel()
    let stepper = UIStepper()
    let actionButton = UIButton()
    
    override var intrinsicContentSize: CGSize {
        let stepperSize = stepper.intrinsicContentSize
        let timeLabelSize = timeLabel.intrinsicContentSize
        let actionButtonSize = actionButton.intrinsicContentSize
        
        let width = timeLabelSize.width + timeToStepperMargin + stepperSize.width
        let height = stepperSize.height + actionButtonTopMargin + actionButtonSize.height
        
        return CGSize(width: width, height: height)
    }
    
    private let timeToStepperMargin: CGFloat = 8
    private let actionButtonTopMargin: CGFloat = 8

    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        set {
            stepper.value = newValue
            updateUI()
        }
    }

    var startStopHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let stepperSize = stepper.intrinsicContentSize
        stepper.frame = CGRect(
            origin: CGPoint(
                x: bounds.maxX - stepper.bounds.width,
                y: bounds.minY
            ),
            size: stepperSize
        )
        
        let timeLabelSize = timeLabel.intrinsicContentSize
        timeLabel.frame = CGRect(
            origin: CGPoint(
                x: bounds.minX,
                y: bounds.minY + (stepperSize.height - timeLabelSize.height) / 2
            ),
            size: timeLabelSize
        )
        
        let buttonSize = actionButton.intrinsicContentSize
        actionButton.frame = CGRect(
            origin: CGPoint(
                x: bounds.minX + (bounds.width - buttonSize.width) / 2,
                y: stepper.frame.maxY + actionButtonTopMargin
        ),
            size: buttonSize)
    }

    @objc
    private func onStepperChanged() {
        updateUI()
    }

    @objc
    private func onActionButtonClick() {
        startStopHandler?()
    }

    private func setupViews() {
        addSubview(timeLabel)
        addSubview(stepper)
        addSubview(actionButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = true
        stepper.translatesAutoresizingMaskIntoConstraints = true
        actionButton.translatesAutoresizingMaskIntoConstraints = true
        
        stepper.addTarget(self, action: #selector(onStepperChanged), for: .valueChanged)
        actionButton.addTarget(self, action: #selector(onActionButtonClick), for: .touchUpInside)
        
        updateUI()
        
        actionButton.setTitleColor(actionButton.tintColor, for: .normal)
    }

    private func updateUI() {
        if isGameActive {
            timeLabel.text = "Осталось \(Int(gameTimeLeft)) сек"
            actionButton.setTitle("Остановить", for: .normal)
        } else {
            timeLabel.text = "Время \(Int(stepper.value)) сек."
            actionButton.setTitle("Начать", for: .normal)
        }

        stepper.isEnabled = !isGameActive
        
        setNeedsLayout()
    }

}
