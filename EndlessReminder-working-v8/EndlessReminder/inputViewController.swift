
import Foundation
import UIKit
import RealmSwift

class inputViewController: UIViewController, UITextFieldDelegate {
    //inherits this UIViewController parent class
    
    @IBOutlet var reminderTextField: UITextField!
    @IBOutlet var reminderDatePicker: UIDatePicker!
    
    @IBOutlet var reminderImageView: UIImageView!
    
    private let podRealmSwiftDataBaseVar = try! Realm()
    public var checkRecentReminderTaskInput: (() -> Void)?
    
    //Override this xcode function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderTextField.becomeFirstResponder()
        reminderTextField.delegate = self
        
        reminderDatePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(storeReminderTasksFunction))
        
        pickCoolImage()
    }
    
    func checkUserReminderInputKey(_ reminderTextField: UITextField) -> Bool {
        //Returns checkInput as true if the user has entered a valid input
        let checkInput = true
        reminderTextField.resignFirstResponder()
        return checkInput
    }
    
    func pickCoolImage() {
        //Cool images from URL, includes cyberpunk, Nvivda, modern house, some of our goals
        let coolImageLink1 = URL(string: "https://cdn.mos.cms.futurecdn.net/rLh7Dh7EKo8F6zmDtXYp8W.jpg")
        let coolImageLink2 = URL(string: "https://images-na.ssl-images-amazon.com/images/I/71IlkNRCBQL._AC_SL1500_.jpg")
        let coolImageLink3 = URL(string: "https://i.pinimg.com/originals/29/8d/f1/298df1cac168231b7572f2b4e75a269c.jpg")
        
        var selectedCoolImageLink = URL(string: "https://i.pinimg.com/originals/29/8d/f1/298df1cac168231b7572f2b4e75a269c.jpg")
        
        //Will select random background to keep you entertained, so you don't become bored adding them each day
        
        let tempRand = Int.random(in: 0..<3)
        
        if tempRand == 0 {
            selectedCoolImageLink = coolImageLink1
        }
        else if tempRand == 1 {
            selectedCoolImageLink = coolImageLink2
        }
        else {
            selectedCoolImageLink = coolImageLink3
        }
        
        //print("Random Number is: ", tempRand)
        
        let coolImageObject = try? Data(contentsOf: selectedCoolImageLink!)
        reminderImageView.image = UIImage(data: coolImageObject!)
    }
    
    @objc func storeReminderTasksFunction() {
        //Changes the size to fit
        [reminderTextField .sizeToFit()]
        
        if let reminderMessageInfo = reminderTextField.text, !reminderMessageInfo.isEmpty {
            let reminderDate = reminderDatePicker.date
            
            //Starting to write information to realm database
            podRealmSwiftDataBaseVar.beginWrite()
            
            //Create new variable to point to an object that holds strings, and date value
            let reminderTemplateTaskSet = EndlessRemiderTaskObject()
            //Assigning those new string, values to store in the object
            reminderTemplateTaskSet.reminderTaskDate = reminderDate
            reminderTemplateTaskSet.reminderTaskMessageInfoVar = reminderMessageInfo
            //Now add this object to realm, with string, value in the object
            podRealmSwiftDataBaseVar.add(reminderTemplateTaskSet)
            //Now save the object to realm database
            try! podRealmSwiftDataBaseVar.commitWrite()
            
            //This is optional, if the controller doesn't give a one, if there is no controller to handle it, question mark will check for it to make sure Xcode doesn't crash with an error,
            checkRecentReminderTaskInput?()
            //Once it is saved, go back to the previous reminderTask menu
            navigationController?.popViewController(animated: true)
        }
        else {
            
        }
    }
}

