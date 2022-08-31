//
//  ViewController.swift
//  IP02_Whack-a-mole
//
//  Created by Rai, Rhea on 8/31/22.
//  2B Mobile Apps

import UIKit

class ViewController: UIViewController {
    var screenWidth = 0
    var screenHeight = 0
    
    var scoreLbl = UILabel()
    var score = 0
    
    var fieldLbl = UILabel()
    
    var moleBtn = UIButton()
    let xBuffer = 20
    let yBuffer = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //finding the screen size
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        //setting up score box
        scoreLbl.frame = CGRect(x: xBuffer, y: yBuffer, width: screenWidth - (2*xBuffer), height: Int(screenHeight/10))
        scoreLbl.backgroundColor = UIColor.blue
        scoreLbl.text = String(score)
        
        view.addSubview(scoreLbl)
        
        //painting the field
        
        fieldLbl.frame = CGRect(x: xBuffer, y: yBuffer + Int(screenHeight/10), width: screenWidth - (2 * xBuffer), height: screenHeight - ( 2 * yBuffer) - Int(screenHeight / 10))
        fieldLbl.backgroundColor = UIColor.green
        fieldLbl.text = ""
        
        view.addSubview(fieldLbl)
        
        //adding a mole to the screen
        moleBtn.frame = CGRect(x: xBuffer, y: yBuffer, width: 40, height: 40)
        moleBtn.layer.cornerRadius = moleBtn.frame.height / 2
        moleBtn.backgroundColor = UIColor.brown
        moleBtn.setTitle("'_'", for: .normal)
        moleBtn.addTarget(self, action: #selector(hitMole(_:)), for: .touchUpInside)
        
        view.addSubview(moleBtn)
        
        
        
        
        self.view = view
        
    }
    
    //function for when mole button is hit
    @objc func hitMole(_ sender: UIButton!) {
//        print("Got 'em!!")
        score+=1
        updateScore()
        moleBtn.removeFromSuperview()
        updateMolePostion()
        view.addSubview(moleBtn)
    }
    
    //function to update to random x and y for mole
    func updateMolePostion() {
        //new position
        moleBtn.frame.origin.x = CGFloat(Int.random(in: xBuffer...screenWidth - (2*xBuffer)))
        moleBtn.frame.origin.y = CGFloat(Int.random(in: yBuffer...screenHeight - ( 2 * yBuffer) - Int(screenHeight / 10)))
      
    }
    
    func updateScore() {
        scoreLbl.text = String(score)
    }
    
    
    


}

