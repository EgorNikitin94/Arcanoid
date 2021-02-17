//
//  Game.swift
//  Arcanoid
//
//  Created by Егор Никитин on 09.02.2021.
//

import UIKit

struct Game {
    
    enum HitTarget {
        case x
        case y
    }
    
    var center: CGPoint
    
    var vector: Vector
    
    var viewBall: UIView
    
    var viewParent: UIView
    
    var viewRocket: UIView
    
    var viewBlocks: [UIView] = []
    
    init(in viewParent: UIView, viewRocket: UIView) {
        
        self.viewParent = viewParent
        self.viewRocket = viewRocket
        
        center = viewParent.center
        
        vector = Vector(a: CGPoint(x: 0, y: 0), b: CGPoint(x: 5, y: 5))
        
        viewBall = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        viewBall.backgroundColor = .red
        viewBall.center = center
        viewBall.layer.cornerRadius = 5
        viewParent.addSubview(viewBall)
        
        
        for _ in 0...20 {
            let block = UIView(frame: CGRect(x: CGFloat.random(in: 0...viewParent.frame.size.width - 100), y: CGFloat.random(in: 0...400), width: 100, height: 33))
            block.layer.cornerRadius = 7
            block.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            block.layer.borderWidth = 1
            block.backgroundColor = .green
            viewParent.addSubview(block)
            viewBlocks.append(block)
        }
    }
    
    mutating func tic() {
        
        let newCenter = CGPoint(x: center.x + vector.dx, y: center.y + vector.dy)
        
        if isHit(oldPosition: center, newPosition: newCenter, rect: viewRocket.frame) == .x {
            vector.b.x = -vector.b.x
            vector.b.y = -vector.b.y + CGFloat.random(in: -3...3)
        }
        
        if isHit(oldPosition: center, newPosition: newCenter, rect: viewRocket.frame) == .y {
            vector.b.y = -vector.b.y
            vector.b.x = -vector.b.x + CGFloat.random(in: -3...3)
        }
        
        var indexBlock: Int?
        
        for (index, block) in viewBlocks.enumerated() {
            if isHit(oldPosition: center, newPosition: newCenter, rect: block.frame) == .x {
                vector.b.x = -vector.b.x
                vector.b.y = -vector.b.y + CGFloat.random(in: -3...3)
                indexBlock = index
            }
            
            if isHit(oldPosition: center, newPosition: newCenter, rect: block.frame) == .y {
                vector.b.y = -vector.b.y
                vector.b.x = -vector.b.x + CGFloat.random(in: -3...3)
                indexBlock = index
            }
        }
        
        if let indexBlock = indexBlock {
            let block = viewBlocks[indexBlock]
            UIView.animate(withDuration: 0.2) {
                block.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            } completion: { (bool) in
                block.removeFromSuperview()
            }

            viewBlocks.remove(at: indexBlock)
        }
        
        center = newCenter
        viewBall.center = newCenter
        
        if newCenter.x >= viewParent.frame.size.width || newCenter.x <= 0 {
            vector.b.x = -vector.b.x
        }
        
        if newCenter.y >= viewParent.frame.size.height || newCenter.y <= 0 {
            vector.b.y = -vector.b.y
        }
        
    }
    
    func isHit(oldPosition: CGPoint, newPosition: CGPoint, rect: CGRect) -> HitTarget? {
        
        if oldPosition.x < rect.origin.x &&
            newPosition.x >= rect.origin.x &&
            newPosition.y >= rect.origin.y &&
            newPosition.y <= rect.origin.y + rect.size.height {
            return .x
        }
        
        if oldPosition.x > rect.origin.x + rect.size.width &&
            newPosition.x <= rect.origin.x + rect.size.width &&
            newPosition.y >= rect.origin.y &&
            newPosition.y <= rect.origin.y + rect.size.height {
            return .x
        }
        
        if oldPosition.y < rect.origin.y &&
            newPosition.y >= rect.origin.y &&
            newPosition.x >= rect.origin.x &&
            newPosition.x <= rect.origin.x + rect.size.width {
            return .y
        }
        
        if oldPosition.y > rect.origin.y + rect.size.height &&
            newPosition.y <= rect.origin.y + rect.size.height &&
            newPosition.x >= rect.origin.x &&
            newPosition.x <= rect.origin.x + rect.size.width {
            return .y
        }
        
        return nil
        
    }

}
