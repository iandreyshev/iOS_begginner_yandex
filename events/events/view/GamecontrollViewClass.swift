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

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actionButton: UIButton!

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

    @IBAction func onStepperChanged(_ sender: UIStepper) {
        updateUI()
    }

    @IBAction func onActionButtonClick(_ sender: UIButton) {
        startStopHandler?()
    }

    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }

    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GameControllView", bundle: bundle)

        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
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
    }

}
