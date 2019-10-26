//
//  SecondViewController.swift
//  Tranquil
//
//  Created by Scott on 30/09/2018.
//  Copyright © 2018 Modulus885. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation


class SecondViewController: UIViewController {
    
    // GUI References
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pausePlayBtn: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var countDownBtn: UIButton!
    
    // Timer for countdown
    var count = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Sets background gif image
        backgroundSelector()
        
        
        
    }
    
    // Back button to return to sound list
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Play and pause Button
    @IBAction func play(_ sender: UIButton) {
        if audioStuffed == true && audioPlayer.isPlaying == false{
            audioPlayer.play()
            label.text = sounds[thisSound]
            backgroundSelector()
            pausePlayBtn.setImage(#imageLiteral(resourceName: "icons8-pause-100.png"), for: .normal)
            
        }else {
            audioPlayer.pause()
            pausePlayBtn.setImage(#imageLiteral(resourceName: "icons8-play-filled-100 (1).png"), for: .normal)
        }
    }
    
    
    // Previous Button
    @IBAction func previousBtn(_ sender: UIButton) {
        
        if audioStuffed == true && thisSound != 0{
            playThis(thisOne: sounds[thisSound-1])
            thisSound -= 1
            label.text = sounds[thisSound]
            backgroundSelector()
            print(thisSound)
            pausePlayBtn.setImage(#imageLiteral(resourceName: "icons8-pause-100.png"), for: .normal)
        }else{
            
        }
    }
    
    // Forward Button
    @IBAction func forwardsBtn(_ sender: UIButton) {
        if thisSound < sounds.count - 1 && audioStuffed == true {
            playThis(thisOne: sounds[thisSound+1])
            thisSound += 1
            label.text = sounds[thisSound]
            backgroundSelector()
            pausePlayBtn.setImage(#imageLiteral(resourceName: "icons8-pause-100.png"), for: .normal)
        }else{
            thisSound = 0
            playThis(thisOne: sounds[thisSound])
            label.text = sounds[thisSound]
            backgroundSelector()
        }
        
    }
    
    // Slider Volume
    @IBAction func slider(_ sender: UISlider) {
        
        if audioStuffed == true{
        audioPlayer.volume = sender.value
        }
    }
    
    // Slider to control minute countdown selection
    @IBAction func minSlider(_ sender: UISlider) {
        countDownLabel.text = String(Int(sender.value))
        count = Int(sender.value) * 60
    }
    
    // Audio player
    func playThis(thisOne: String){
        
        do{
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            label.text = sounds[thisSound]
            
            
        }catch{
            print("Error")
        }
        
    }
    
    // Controls the background gif that will appear with sound.
    @objc func backgroundSelector(){
        
        
        label.text = sounds[thisSound]
        if sounds[thisSound] == "Tranquil River"{
            imageView.loadGif(name: "river2")
        }else if sounds[thisSound] == "Tranquil Forest"{
            imageView.loadGif(name: "forestMist")
        }else if sounds[thisSound] == "Tranquil Rain"{
            imageView.loadGif(name: "rain2")
        }else if sounds[thisSound] == "Tranquil Ocean"{
            imageView.loadGif(name: "ocean")
        }else if sounds[thisSound] == "Tranquil City"{
            imageView.loadGif(name: "city")
        }else if sounds[thisSound] == "Tranquil Waterfall"{
            imageView.loadGif(name: "darkRiver")
        }else if sounds[thisSound] == "Tranquil Whitenoise"{
            imageView.loadGif(name: "static")
        }else if sounds[thisSound] == "Tranquil Rain on Tent"{
            imageView.loadGif(name: "rainTent")
        }else if sounds[thisSound] == "Tranquil Thunder"{
            imageView.loadGif(name: "thunder")
        }else if sounds[thisSound] == "Tranquil Fire"{
            imageView.loadGif(name: "fire")
        }
        
    }
    
    //Button to start the timer countdown
    @IBAction func startTimerBtn(_ sender: UIButton) {
        
        if timer.isValid{
            timer.invalidate()
            countDownBtn.setImage(#imageLiteral(resourceName: "countdownBtn2.png"), for: .normal)
        // Controls button image display (on and off)
        }else if !timer.isValid {
        runTimer()
            countDownBtn.setImage(#imageLiteral(resourceName: "stopCountDownBtn.png"), for: .normal)
        }
        
        if count == 0{
            countDownBtn.setImage(#imageLiteral(resourceName: "countdownBtn2.png"), for: .normal)
        }
        
    }
    
    // Initiate timer variable
    @objc func runTimer(){
        
        if count > 0 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)}
    }
    
    // logic to display minutes and seconds on timer
    @objc func update() {
        
        if count > 0{
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            countDownLabel.text = minutes + ":" + seconds
            count = count - 1
        }else if count == 0{
            audioPlayer.stop()
            countDownLabel.text = "Done"
            
        }
    }
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
