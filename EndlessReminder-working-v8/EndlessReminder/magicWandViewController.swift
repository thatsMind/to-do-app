
import Foundation
import RealmSwift
import UIKit

class magicWandViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var reminderLabel: UILabel!
    @IBOutlet var goalTextField: UITextField!
    @IBOutlet var sleepTextField: UITextField!
    @IBOutlet var sleepTextField2: UITextField!
    
    @IBOutlet var sleepLabel: UILabel!
    
    private let podRealmSwiftDataBaseVar = try! Realm()
    public var checkRecentReminderTaskInput: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTextField.becomeFirstResponder()
        goalTextField.delegate = self
        
        sleepTextField.becomeFirstResponder()
        sleepTextField.delegate = self
        
        sleepTextField2.becomeFirstResponder()
        sleepTextField2.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Summon Wand", style: .done, target: self, action: #selector(goBackHome))
    }
    
    @objc func goBackHome(){
        
        //var temp: String = "Get Some Sleep!"
        
        let temp: String = "⭐#1 Get 7-8 Hours of Sleep Minimum! " +
            "⭐#2 Drink More Than 1000 ML of Water A Day! " +
            "⭐#3 Get 30 Minutes Execise Each Day!" +
            "⭐#4 Listen to Relax, Chill or Meditation Music to Calm Yourself! " +
            "⭐#5 Remind yourself of a goal! "
        
        reminderLabel.text = temp
        
        if let reminderMessageInfo = goalTextField.text, !reminderMessageInfo.isEmpty {
            //print(reminderMessageInfo)
            reminderLabel.text = reminderMessageInfo
        }
        
        if let s1 = sleepTextField.text, !s1.isEmpty {
            //print(reminderMessageInfo2)
            
            if let s2 = sleepTextField2.text, !s2.isEmpty {
                //print(reminderMessageInfo2)

                let timeString1 = s1.components(separatedBy: ":")
                let timeBegin1: String = timeString1 [0]
                let timeEnd1: String = timeString1 [1]
                
                let a1:Int? = Int(timeBegin1)
                let b1:Int? = Int(timeEnd1)
                
                //print(a1)
                //print(b1)
                
                let timeString2 = s2.components(separatedBy: ":")
                let timeBegin2: String = timeString2 [0]
                let timeEnd2: String = timeString2 [1]
                
                let a2:Int? = Int(timeBegin2)
                let b2:Int? = Int(timeEnd2)
                
                //print(a2)
                //print(b2)
                
                let eq:Int? = Int((a1! * 60) + b1!)
                let eq2:Int? = Int((a2! * 60) + b2!)
                
                let finalEQ:Int? = Int(eq2! - eq!)
                
                print("You slept for: ", finalEQ)
                
                let sleepTime = String(finalEQ!)
                
                sleepLabel.text = "⚠ You slept 😴 for this many minutes: " + sleepTime + " ⏰. Greater 419 hours is good!"
            }
        }

    }
}

