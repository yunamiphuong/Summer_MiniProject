//
//  ViewController.swift
//  Summer_MiniProject
//
//  Created by Apple on 5/28/20.
//  Copyright © 2020 Apple. All rights reserved.
//



import UIKit
import AVFoundation

/*
 
 - NSDate, NSCalendar : nếu mở app sau 12h trưa và trước 18h thì hình nền là ban ngày, nếu mở app vào thời gian còn lại thì hình nền là ban đêm
 - Audio
 - Timer
 - Pass Data Closure
 - Struct
 - điều hướng màn hình
 
 */

class ViewController: UIViewController {
    @IBOutlet weak var TopLabel: UILabel!
    
    @IBOutlet weak var petListTableView: UITableView!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var backgroundScene: UIImageView!
    
    let petDatas = fakeData()
    var timer : Timer!
    var labelIsHiglighted : Bool = false
    var cellTag: Int = 4
    
    var soundPlayerSummer : AVAudioPlayer?
    
    let calendar = NSCalendar.current
    let currentDate = NSDate()
    var dayOrNightSceneHour : Int = 0
    
    var passDatas : (passData1to2)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound()
        TopLabel.text = "Mùa hè tới rồi\nCùng đi dạo với thú cưng nào!"
        TopLabel.textColor = .darkGray
        TopLabel.textAlignment = .center
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(blinkingLabel), userInfo: nil, repeats: true)
        
        petListTableView.delegate = self
        petListTableView.dataSource = self
        petListTableView.rowHeight = 150
        petListTableView.register(UINib(nibName: "PetTableViewCell", bundle: nil), forCellReuseIdentifier: "PetTableViewCell")
        
        // check giờ hiện tại để hiển thị cảnh ngày hoặc đêm
        dayOrNightSceneHour = realTime()
        if dayOrNightSceneHour >= 18 || dayOrNightSceneHour < 12 {
            backgroundScene.image = UIImage(named: "beachNight")
            backgroundScene.contentMode = .scaleAspectFill
        } else {
            backgroundScene.image = UIImage(named: "beach")
            backgroundScene.contentMode = .scaleAspectFill
        }
    }
    
    func realTime() -> (Int) {
        let hour = calendar.component(.hour, from: currentDate as Date)
        return hour
    }
    
    @objc func blinkingLabel() {
        if labelIsHiglighted == false {
            bottomLabel.textColor = .red
            labelIsHiglighted = true
        } else {
            bottomLabel.textColor = .black
            labelIsHiglighted = false
        }
        
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "SummerMusic.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            soundPlayerSummer = try AVAudioPlayer(contentsOf: url)
            soundPlayerSummer?.play()
            // đặt numberOfLoops = -1 để nó chạy lại khi chạy hết
            soundPlayerSummer?.numberOfLoops = -1
        } catch {
            print("lỗi")
            // couldn't load file
        }
    }
    
    @IBAction func onChooseThis(_ sender: Any) {
        
        let testVC = TestViewController()

        passDatas = passData1to2(time: dayOrNightSceneHour, petChoosen: cellTag)
        
        testVC.dataFromStruct = passDatas
        
        self.present(testVC, animated: true, completion: nil)
        testVC.modalPresentationStyle = .fullScreen
        print(cellTag)
        
    }
    
    @IBAction func onRandom(_ sender: Any) {
        cellTag = Int.random(in: 0..<petDatas.count)
        let nextVC = TestViewController()

         passDatas = passData1to2(time: dayOrNightSceneHour, petChoosen: cellTag)
         
         nextVC.dataFromStruct = passDatas
        self.present(nextVC, animated: true, completion: nil)
        nextVC.modalPresentationStyle = .fullScreen
        print(cellTag)
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petListTableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as! PetTableViewCell
        cell.petImage.image = UIImage(named: petDatas[indexPath.row].imageName)
        cell.nameLabel.text = petDatas[indexPath.row].nameLabel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellTag = indexPath.row
        print("cellTagVC1TableDidselectRowAt is \(cellTag)")
    }
    
}
