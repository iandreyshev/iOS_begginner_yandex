//
//  ViewController.swift
//  events
//
//  Created by Ivan Andreyshev on 17/09/2019.
//  Copyright © 2019 iandreyshev. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var gameFieldView: GameFieldView!
    @IBOutlet weak var gameControll: GameControllViewclass!
    @IBOutlet weak var scoreLabel: UILabel!

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
        
        gameControll.startStopHandler = { [weak self] in
            self?.actionButtonTapped()
        }
        gameControll.gameDuration = 20
    }

    func shapeTapped() {
        guard gameControll.isGameActive else {
            return
        }

        startTimerWithReposition()
        _score += 1
    }

    private func actionButtonTapped() {
        if gameControll.isGameActive {
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

        gameControll.gameTimeLeft = gameControll.stepper.value
     
        gameControll.isGameActive = true

        updateUI()
    }

    private func stopGame() {
        gameControll.isGameActive = false

        _gameTimer?.invalidate()
        _shapeTimer?.invalidate()

        updateUI()

        scoreLabel.text = "Последний счет: \(_score)"

        _score = 0
    }

    private func updateUI() {
        gameFieldView.isShapeVisible = gameControll.isGameActive
    }

    @objc private func gameTimerTick() {
        gameControll.gameTimeLeft -= 1

        if gameControll.gameTimeLeft <= 0 {
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
