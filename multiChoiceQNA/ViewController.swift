//
//  ViewController.swift
//  multiChoiceQNA
//
//  Created by BettyPan on 2021/1/6.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var questionProgressSlider: UISlider!
    
    @IBOutlet weak var numOfQuestionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rightOrWrongLabel: UILabel!

    @IBOutlet var multiChoiceBtns: [UIButton]!

    
    
    //問題array
    var questions = [Question]()
    //題目
    var index = 0
    //題數
    var count = 1
    //音效AVPlayer
    var player: AVPlayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let question1 = Question(description: "Fox", option: ["fox","giraffe","horse","koala"], answer: "fox")
        questions.append(question1)
        let question2 = Question(description: "Giraffe", option: ["giraffe","horse","koala","lion"], answer: "giraffe")
        questions.append(question2)
        let question3 = Question(description: "Horse", option: ["horse","koala","lion","monkey"], answer: "horse")
        questions.append(question3)
        let question4 = Question(description: "Koala", option: ["koala","lion","monkey","mouse"], answer: "koala")
        questions.append(question4)
        let question5 = Question(description: "Lion", option: ["lion","monkey","mouse","pig"], answer: "lion")
        questions.append(question5)
        let question6 = Question(description: "Monkey", option: ["monkey","mouse","pig","rhino"], answer: "monkey")
        questions.append(question6)
        let quesiton7 = Question(description: "Mouse", option: ["mouse","pig","rhino","tiger"], answer: "mouse")
        questions.append(quesiton7)
        let question8 = Question(description: "Pig", option: ["pig","rhino","tiger","zebra"], answer: "pig")
        questions.append(question8)
        let question9 = Question(description: "Rhino", option: ["rhino","tiger","zebra","fox"], answer: "rhino")
        questions.append(question9)
        let question10 = Question(description: "Tiger", option: ["tiger","zebra","fox","giraffe"], answer: "tiger")
        questions.append(question10)
        let question11 = Question(description: "Zebra", option: ["zebra","fox","giraffe","horse"], answer: "zebra")
        questions.append(question11)
        //隨機出題
        questions.shuffle()
        
        startGame()
    }
    
    
    
    func startGame() {
    //option隨機
    questions[index].option.shuffle()
    //更改選擇題四個button圖片
    for i in 0...3{
        multiChoiceBtns[i].setImage(UIImage(named: questions[index].option[i]), for: .normal)
    }

        numOfQuestionLabel.text = "\(count)/10"
        questionLabel.text = questions[index].description
        questionProgressSlider.value = Float(count)
        rightOrWrongLabel.text = "Choose the correct animal"
        rightOrWrongLabel.textColor = UIColor.white

    }
    
    @IBAction func multiChoices(_ sender: UIButton) {
        //如點選圖片之Button與正確答案相同，將...
        if sender.currentImage == UIImage(named: questions[index].answer) {
            rightOrWrongLabel.text = "YES! YOU DID IT!!"
            rightOrWrongLabel.textColor = UIColor.yellow
            //匯入答對音效
            if let url = Bundle.main.url(forResource: "correctAnswer", withExtension: "mp3"){
            player = AVPlayer(url: url)
            player?.play()
            }
        //如點選圖片之Button與正確答案不相同，將...
        }else if sender.currentImage != UIImage(named: questions[index].answer) {
            rightOrWrongLabel.text = "TRY AGAIN!!"
            rightOrWrongLabel.textColor = UIColor.red
            //匯入答錯音效
            if let url = Bundle.main.url(forResource: "wrongAnswer", withExtension: "mp3"){
            player = AVPlayer(url: url)
            player?.play()
                
            }
            
        }
        
    }
    
    @IBAction func speak(_ sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: questionLabel.text!)
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        count = count + 1
        index = index + 1
        //當題數為10時，重新開始
        if count == 11 {
            count = 1
            index = 0
        //隨機出題
        questions.shuffle()
        }

        startGame()
    }
    

}

