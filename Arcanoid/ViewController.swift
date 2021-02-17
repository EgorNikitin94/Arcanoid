//
//  ViewController.swift
//  Arcanoid
//
//  Created by Егор Никитин on 08.02.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private var viewRocket: UIView!
    private var centerRocket: CGPoint!
    
    private var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        startGame()
    }
    
   
    
    private func addRocket() {
        viewRocket = UIView(frame: CGRect(x: 30, y: UIScreen.main.bounds.size.height - 100, width: 150, height: 30))
        viewRocket.layer.cornerRadius = 5
        viewRocket.backgroundColor = .orange
        view.addSubview(viewRocket)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
        viewRocket.addGestureRecognizer(pan)
    }
    
    @objc private func pan(panGestureRecognizer: UIPanGestureRecognizer) {
        if panGestureRecognizer.state == .began {
            centerRocket = viewRocket.center
        }
        
        let x = panGestureRecognizer.translation(in: view).x
        let newCenter = CGPoint(x: centerRocket.x + x, y: centerRocket.y)
        
        viewRocket.center = newCenter
    }
    
    private func startGame() {
        addRocket()
        game = Game(in: self.view, viewRocket: viewRocket)
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.game.tic()
        }
    }
}

