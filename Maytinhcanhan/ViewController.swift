//
//  ViewController.swift
//  Maytinhcanhan
//
//  Created by NguyenHung on 1/4/17.
//  Copyright © 2017 NguyenHung. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
    }
    // Chay het dam nay man hinh defauld se hien ra man hinh
    
    @IBAction func numberPressed(sender: UIButton) {
        // yeu cau an vao cac phim so
        playSound()
        //Keu nhac khi an so bat ky
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        //Vong lap de nhap nhieu so cho mot gia tri VD: 23453 Hoac 12
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    // An vao dau chia (/)
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    // An vao dau nhan (x)
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    //An vao dau tru (-)
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    // An vao dau cong (+)
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    // An vao dau bang (=)
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
            //print("Oi gioi oi")
        }
        
        btnSound.play()
        // Am thanh khi an so
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                // Thuc hien cac phep toan
                
                leftValStr = result
                outputLbl.text = result
                //Ket qua sau khi thuc hien phep tinh
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }


}

