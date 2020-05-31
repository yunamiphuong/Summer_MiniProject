//
//  TestViewController.swift
//  Summer_MiniProject
//
//  Created by Apple on 5/29/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var animateView: UIView!
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var timer: Timer!
    var cellTagFromVC1 : Int = 0
    let petCollectionFakeData = fakeData()
    
//    var currentTimeFromVC1 : Int = 0
//    var petChosenFromVC1 : Int = 2
    var dataFromStruct : (passData1to2)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        animateView.frame = CGRect(x: 0, y: view.frame.height - 300, width: 300, height: 100)
        animateView.backgroundColor = .none
        
        petImage.image = UIImage(named: "\(petCollectionFakeData[cellTagFromVC1].imageName)")
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runningWithPet), userInfo: nil, repeats: true)
        
        print(dataFromStruct?.petChoosen ?? 0)
        
        if dataFromStruct?.time ?? 0 > 18 || dataFromStruct?.time ?? 0 < 12 {
            backgroundImage.image = UIImage(named: "beachNight")
backgroundImage.contentMode = .scaleAspectFill
        } else {
            backgroundImage.image = UIImage(named: "beach")
            backgroundImage.contentMode = .scaleAspectFill
        }
        
        petImage.image = UIImage(named: "\(petCollectionFakeData[dataFromStruct?.petChoosen ?? 0].imageName)")
        
    }
    
    
    @objc func runningWithPet(){
        animateView.center.x += 1
        if animateView.center.x >= view.frame.width - 80 {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runningBackWithPet), userInfo: nil, repeats: true)
        }
    }
    @objc func runningBackWithPet(){
        animateView.center.x -= 1
        if animateView.center.x <= 100 {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runningWithPet), userInfo: nil, repeats: true)
        }
    }
    
    
}
