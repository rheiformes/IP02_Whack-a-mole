//
//  ViewController.swift
//  IP02_Whack-a-mole
//
//  Created by Rai, Rhea on 8/31/22.
//  2B Mobile Apps

import UIKit

class ViewController: UIViewController {
    
    //sets all the initial variables and constants
    var screenWidth = 0
    var screenHeight = 0
    
    //screen constants
    let xBuffer = 20
    let yBuffer = 100
    
    //score variables
    var scoreLbl = UILabel()
    var score = 0
    var totTaps = 0
    
    //field and mole
    var fieldLbl = UILabel()
    var moleBtn = UIButton()
    
    //timing things: seconds cap is the constant for time allowed per mole, total seconds is time left for that mole (variable). running time is the end to end total time taken
    var timer = Timer()
    var timerLbl = UILabel()
    let secondsCap: Double = 5.0
    var totalSeconds: Double = 5.0
    var runningTime: Double = 0.0
    
    //this is the details pane before game starts and game over
    var screenDetails = UILabel()
    
    //max damage is the least allowed score (so the game can end)
    let maxDamage = -3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //finding the screen size
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        
        //setting up score box
        scoreLbl.frame = CGRect(x: xBuffer, y: yBuffer, width: screenWidth - (8*xBuffer), height: Int(screenHeight/10))
        scoreLbl.backgroundColor = UIColor.blue
        scoreLbl.text = String(score)
        
        view.addSubview(scoreLbl)
        
        //setting up timer box
        timerLbl.frame = CGRect(x: xBuffer + Int(scoreLbl.frame.width), y: yBuffer, width: 6*xBuffer, height: Int(screenHeight/10))
        timerLbl.backgroundColor = UIColor.red
        timerLbl.text = String(totalSeconds) + " sec"
        
        view.addSubview(timerLbl)
        
        //adding screen details
        screenDetails.frame = CGRect(x: xBuffer , y: Int(screenHeight/2), width: screenWidth - (2*xBuffer), height: Int(screenHeight/10))
        screenDetails.backgroundColor = UIColor.red
        screenDetails.text = "Tap the mole to start the timer"
        view.addSubview(screenDetails)
        
        //painting the field
        fieldLbl.frame = CGRect(x: xBuffer, y: yBuffer + Int(screenHeight/10), width: screenWidth - (2 * xBuffer), height: screenHeight - ( 2 * yBuffer) - Int(screenHeight / 10))
        fieldLbl.backgroundColor = UIColor.green
        fieldLbl.text = ""
        
        view.addSubview(fieldLbl)
        
        //adding a mole to the top left of field
        moleBtn.frame = CGRect(x: xBuffer, y: yBuffer + Int(screenHeight/10), width: 40, height: 40)
        moleBtn.layer.cornerRadius = moleBtn.frame.height / 2
        moleBtn.backgroundColor = UIColor.brown
        moleBtn.setTitle("'_'", for: .normal)
        moleBtn.addTarget(self, action: #selector(hitMole(_:)), for: .touchUpInside)
        
        view.addSubview(moleBtn)
        
        //adding screen details (the beginning/ending pane)
        self.view.bringSubviewToFront(screenDetails)
        self.view = view
        
        
    }
    
    func stillHaveTime() -> Bool{
        return totalSeconds > 0
    }
    
    //function to update time
    @objc func timerFunc() {
        //if there is still time left for that mole
        if (stillHaveTime()) {
            //update time label
            timerLbl.text = String(Double(floor(100*totalSeconds)/100)) + " sec"
            totalSeconds-=0.1
        }
        //if there isn't time left, take -1 of score and update mole position
        else {
            runningTime += secondsCap - totalSeconds
            totalSeconds=secondsCap
            timerLbl.text = String(Double(floor(100*totalSeconds)/100)) + " sec"
            score -= 1
            updateScore()
            moleBtn.removeFromSuperview()
            updateMolePostion()
            if (score >= maxDamage) {
                view.addSubview(moleBtn)
            }
        }
    }
    
    //function for when mole button is hit
    @objc func hitMole(_ sender: UIButton!) {
        //if the total taps is 0, the timer hasn't been started yet, so we should start it
        if(totTaps==0) {
            //setting up the timer
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
            //removing the starting pane from the view
            screenDetails.removeFromSuperview()
        }
        
        //incrementing score and taps
        totTaps+=1
        score+=1
        updateScore()
        
        //moving the mole
        moleBtn.removeFromSuperview()
        updateMolePostion()
        
        //keeping track of time (running total and for current mole)
        runningTime += secondsCap - totalSeconds
        totalSeconds = secondsCap
        
        //checking whether to add the mole back if game is not over
        if (score >= maxDamage) {
            view.addSubview(moleBtn)
        }
        
    }
    
    //function to update to random x and y for mole
    func updateMolePostion() {
        //new x and y's using the constants created for the screen (so can be resized if need to change the iphone model
        
        moleBtn.frame.origin.x = CGFloat(Int.random(in: xBuffer...screenWidth - (2*xBuffer) - Int(moleBtn.layer.cornerRadius)))
        
        moleBtn.frame.origin.y =  CGFloat(yBuffer) + CGFloat(scoreLbl.frame.height) + CGFloat.random(in: 0 ... fieldLbl.frame.height - 2 * CGFloat(moleBtn.layer.cornerRadius))
      
    }
    
    func updateScore() {
        scoreLbl.text = String(score)
        
        //handles game over essentially
        if (score < maxDamage) {
            totalSeconds = 0
            timer.invalidate()
            screenDetails.text = "MAX DAMAGE. YOU LASTED: \((Double(floor(100*runningTime)/100)))s. "
            timerLbl.text = "GAME OVER"
            view.addSubview(screenDetails)
            moleBtn.removeFromSuperview()
        }
    }
    
    
    


}

