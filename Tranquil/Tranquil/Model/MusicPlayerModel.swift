//
//  MusicPlayerModel.swift
//  Tranquil
//
//  Created by Scott on 30/09/2018.
//  Copyright © 2018 Modulus885. All rights reserved.
//

import Foundation

class MusicPlayerModel {
    
    // Sounds array
    var sounds: [String] = []
    var firstViewController = FirstViewController()
    
    // Locate the sound file and store in array.
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
                    mySound = mySound.replacingOccurrences(of: ".mp3", with: " ")
                    
                    // Store sounds in array
                    sounds.append(mySound)
                }
            }
            
           
            
        }catch{
            
        }
    }
    

}
