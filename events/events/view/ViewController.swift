//
//  ViewController.swift
//  events
//
//  Created by Ivan Andreyshev on 17/09/2019.
//  Copyright © 2019 iandreyshev. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameFieldView: GameFieldView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actionButton: UIButton!

    @IBOutlet weak var scoreLabel: UILabel!

    private var _isGameActive = false
    private var _gameTimeLeft: TimeInterval = 0
    private var _gameTimer: Timer!
    private var _shapeTimer: Timer!
    private var _shapeDisplayDuration = 3.0
    private var _score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5

        updateUI()

        gameFieldView.shapeHitHandler = { [weak self] in
            self?.shapeTapped()
        }
    }

    func shapeTapped() {
        guard _isGameActive else {
            return
        }

        startTimerWithReposition()
        _score += 1
    }

    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
    }

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if _isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }

    private func startGame() {
        startTimerWithReposition()

        _gameTimer?.invalidate()
        _gameTimer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(gameTimerTick),
                userInfo: nil,
                repeats: true
        )

        _gameTimeLeft = stepper.value

        _isGameActive = true

        updateUI()
    }

    private func stopGame() {
        _isGameActive = false

        _gameTimer?.invalidate()
        _shapeTimer?.invalidate()

        updateUI()

        scoreLabel.text = "Последний счет: \(_score)"

        _score = 0
    }

    private func updateUI() {
        if _isGameActive {
            timeLabel.text = "Осталось \(Int(_gameTimeLeft)) сек"
            actionButton.setTitle("Остановить", for: .normal)
        } else {
            timeLabel.text = "Время \(Int(stepper.value)) сек."
            actionButton.setTitle("Начать", for: .normal)
        }

        gameFieldView.isShapeVisible = _isGameActive
        stepper.isEnabled = !_isGameActive
    }

    @objc private func gameTimerTick() {
        _gameTimeLeft -= 1

        if _gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateUI()
        }
    }

    @objc private func shapeMove() {
        gameFieldView.randomizeShapes()
    }

    private func startTimerWithReposition() {
        _shapeTimer?.invalidate()
        _shapeTimer = Timer.scheduledTimer(
                timeInterval: _shapeDisplayDuration,
                target: self,
                selector: #selector(shapeMove),
                userInfo: nil,
                repeats: true
        )
        _shapeTimer?.fire()
    }

}
