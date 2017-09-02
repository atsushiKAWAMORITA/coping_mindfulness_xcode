//
//  MindfulnessViewController.swift
//  CopingMindfulness
//
//  Created by 川守田敦史 1 on 2016/06/21.
//  Copyright © 2016年 Atsushi Kawamorita. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class MindfulnessViewController: UIViewController {

    @IBOutlet weak var LabelInterval: UILabel!
    @IBOutlet weak var LabelRate: UILabel!
    @IBOutlet weak var LabelVolume: UILabel!
    
    @IBOutlet weak var SliderInterval: UISlider!
    @IBOutlet weak var SliderRate: UISlider!
    @IBOutlet weak var SliderVolume: UISlider!
    
    @IBOutlet weak var ButtonStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ButtonStartTouchDown(_ sender: AnyObject) {
        let interval: UInt32 = judgeInterval(SliderInterval.value)
        let rate: Float = judgeRate(SliderRate.value)
        let volume: Float = judgeVolume(SliderVolume.value)
        SpeechData(interval, rateValue: rate, volumeValue: volume)
    }
 
    func judgeInterval(_ intervalValue: Float)->UInt32{
        var returnValue : UInt32
        if intervalValue < 55 {
            returnValue = 50
        }else if intervalValue < 70 {
            returnValue = 60
        }else if intervalValue <= 90 {
            returnValue = 90
        }else{
            returnValue = 60
        }
        return returnValue
    }
    
    func judgeRate(_ rateValue: Float)->Float{
        var returnValue: Float
        if rateValue < 0.5 {
            returnValue = AVSpeechUtteranceMinimumSpeechRate
        }else if rateValue == 0.5 {
            returnValue = AVSpeechUtteranceDefaultSpeechRate
        }else{
            returnValue = AVSpeechUtteranceMaximumSpeechRate
        }
        return returnValue
    }
    
    func judgeVolume(_ volumeValue: Float) -> Float {
        var returnValue: Float
        if volumeValue < 3 {
            returnValue = 1
        }else if volumeValue < 5{
            returnValue = 3
        }else if volumeValue < 7{
            returnValue = 5
        }else if volumeValue < 10{
            returnValue = 7
        }else{
            returnValue = 1
        }
        return returnValue
    }
    
    func SpeechData(_ intervalValue: UInt32, rateValue: Float, volumeValue: Float){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "MindfulnessContents")
//        let predicate = NSPredicate(format: "language = %s", "ja-JP")
//        fetchRequest.predicate = predicate
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        do{
            let mindfulnessContents = try appDelegate.managedObjectContext.fetch(fetchRequest) as! [MindfulnessContents]
            
            for mindfulnessContent in mindfulnessContents{
                speechText(mindfulnessContent.data!, language: mindfulnessContent.language!, rate: rateValue, volume: volumeValue)
                sleep(intervalValue)
            }
        }catch let error as NSError {
            print(error)
        }
    }
    
    func speechText(_ text: String, language : String, rate: Float, volume: Float){
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = rate
        utterance.volume = volume
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
