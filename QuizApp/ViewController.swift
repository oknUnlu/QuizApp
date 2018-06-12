//
//  ViewController.swift
//  QuizApp
//
//  Created by Mobil Trakya on 5/11/18.
//  Copyright © 2018 okanunlu@trakya.edu.tr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let QuizQuestions: [String] = ["Soru1","Soru2","Soru3","Soru4”, “Soru5"]
    
    let QuizAnswers = [["Cevap1A&True","Cevap1B","Cevap1C"],["Cevap2A&True","Cevap2B","Cevap2C"],["Cevap3A","Cevap3B","Cevap3C&True"],["Cevap4A","Cevap4B","Cevap4C&True"]]
    
    var currentQuestions = 0,counter = 1,rightAnswerPlacement:UInt32 = 0

    @IBOutlet weak var TextQuestions: UITextView!
    
    @IBOutlet weak var ButtonAnswersA: UIButton!
    @IBOutlet weak var ButtonAnswersB: UIButton!
    @IBOutlet weak var ButtonAnswersC: UIButton!
    @IBOutlet weak var LabelCounter: UILabel!
    
    @IBAction func OptionA(){
        Option(0)
        next()
    }
    @IBAction func OptionB(){
        Option(1)
        next()
    }
    @IBAction func OptionC(){
        Option(2)
        next()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newQuestions()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //Bu fonksiyon yeni soru gelmesi işlemini gerçekleştiriyor.
    func newQuestions(){
        TextQuestions.text = QuizQuestions[currentQuestions%4]
        
        ButtonSetTitle(ButtonAnswersA, 0)
        ButtonSetTitle(ButtonAnswersB, 1)
        ButtonSetTitle(ButtonAnswersC, 2)
    
        LabelCounter.text = String(counter)
        
    }
    
    func ButtonSetTitle(_ button :UIButton,_ i: Int){
        if(QuizAnswers[currentQuestions%4][i].contains("&True")){
            let tempB = QuizAnswers[currentQuestions%4][i].characters.split(separator: "&")
            button.setTitle(String(tempB.first!), for: .normal)
            
        }
        else{
            button.setTitle(QuizAnswers[currentQuestions%4][i], for: .normal)
        }
    }
    
    func Option(_ i: Int){
        if(QuizAnswers[currentQuestions%4][i].contains("&True")){
            rightAnswerPlacement += 1
        }
        ButtonAnswersA.isEnabled = false
        ButtonAnswersB.isEnabled = false
        ButtonAnswersC.isEnabled = false
    }

    func Finish(){
        if(counter > QuizQuestions.count){
            let alert = UIAlertController(title: "Replay!",
                                          message: "True: \(rightAnswerPlacement) - False: \(UInt32(QuizQuestions.count) - rightAnswerPlacement)",
                                        preferredStyle: .alert)
            let action = UIAlertAction(title: "Click", style: .default,
                                       handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            counter = 1
            rightAnswerPlacement = 0
            LabelCounter.text = String(counter)
        }
        ButtonAnswersA.isEnabled = true
        ButtonAnswersB.isEnabled = true
        ButtonAnswersC.isEnabled = true
    }
    
    func next(){
        currentQuestions += 1
        counter += 1
        newQuestions()
        Finish()
    }
}
