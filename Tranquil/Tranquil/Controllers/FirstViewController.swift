//
//  FirstViewController.swift
//  Tranquil
//
//  Created by Scott on 30/09/2018.
//  Copyright © 2018 Modulus885. All rights reserved.
//

import UIKit
import AVFoundation



var sounds: [String] = []
var audioPlayer: AVAudioPlayer!
var thisSound = 0
var audioStuffed = false


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Find sound files
        getSoundName()
        
       
    }

    
    
    // Setting table view cells (number if rows).
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sounds.count
    }
    
    // Setting table view cells (information in each cell).
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = sounds[indexPath.row]
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = .none
        
        return cell
        
        
    }
    
    // Touch interaction with cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        do{
            let audioPath = Bundle.main.path(forResource: sounds[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
            thisSound = indexPath.row
            audioStuffed = true
            
            
            // Create an audio session (for background sound when app closed to home screen)
            do{
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                print("Session is active")
            } catch{
                print(error)
            }
            
            // Segue to sound players
            performSegue(withIdentifier: "goToSoundPlayer", sender: self)
            
            
        }catch{
            print("Error")
        }
        
    }
    
    // Find sound files and store them in array
    func getSoundName(){
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do{
            let soundPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for sound in soundPath{
                 var mySound = sound.absoluteString
                
                // Remove verbose description to just get sound names.
                if mySound.contains(".mp3"){
                    let findString = mySound.split(separator: "/")
                    mySound = String(findString[findString.count-1])
                    mySound = mySound.replacingOccurrences(of: "%20", with: " ")
                    mySound = mySound.replacingOccurrences(of: ".mp3", with: "")
                    
                    // Store sounds in array
                    sounds.append(mySound)
                }
            }
            // Update table view cells
            self.myTableView.reloadData()
        }catch{
            
        }
    }
    
}

