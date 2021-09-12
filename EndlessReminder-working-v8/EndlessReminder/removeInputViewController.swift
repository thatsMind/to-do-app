

import Foundation
import UIKit
import RealmSwift

class removeInputViewController: UIViewController {
    
    public var reminderTaskMessageInfoVar: EndlessRemiderTaskObject?
    public var checkRemovableRecentReminderTaskInput: (() -> Void)?
    
    @IBOutlet var reminderTextLabel: UILabel!
    @IBOutlet var reminderDateLabel: UILabel!
    
    @IBOutlet var reminderImageView: UIImageView!
    
    private let podRealmSwiftDataBaseVar = try! Realm()
    
    static let getCalendarDate: DateFormatter = {
        let tempDate = DateFormatter()
        tempDate.dateStyle = .long
        return tempDate
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderTextLabel.text = reminderTaskMessageInfoVar?.reminderTaskMessageInfoVar
        reminderDateLabel.text = Self.getCalendarDate.string(from: reminderTaskMessageInfoVar!.reminderTaskDate)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeReminderTasksFunction))
        
        pickCoolImage()
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
    
    @objc private func removeReminderTasksFunction() {
        guard let tempReminderTaskMessageInfoVar = self.reminderTaskMessageInfoVar else {
            return
        }
        
        podRealmSwiftDataBaseVar.beginWrite()
        
        podRealmSwiftDataBaseVar.delete(tempReminderTaskMessageInfoVar)
        
        try! podRealmSwiftDataBaseVar.commitWrite()
        
        checkRemovableRecentReminderTaskInput?()
        
        //Once removed, go back to the main controller screen
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}


