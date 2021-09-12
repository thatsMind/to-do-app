
import RealmSwift
import UIKit


class EndlessRemiderTaskObject: Object {
    @objc dynamic var reminderTaskMessageInfoVar: String = ""
    @objc dynamic var reminderTaskDate: Date = Date()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var reminderTaskTable: UITableView!
    
    private let podRealmSwiftDataBaseVar = try! Realm()
    private var reminderTaskArray = [EndlessRemiderTaskObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        reminderTaskArray = podRealmSwiftDataBaseVar.objects(EndlessRemiderTaskObject.self).map({ $0 })
        
        reminderTaskTable.register(UITableViewCell.self, forCellReuseIdentifier: "column")
        reminderTaskTable.delegate = self
        reminderTaskTable.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayTotalReminderTaskCount()
        return reminderTaskArray.count
    }
    
    func displayTotalReminderTaskCount() {
        print(reminderTaskArray.count)
        
        for tempReminderTaskCounter in 0..<reminderTaskArray.count {
            print(reminderTaskArray[tempReminderTaskCounter].reminderTaskMessageInfoVar, reminderTaskArray[tempReminderTaskCounter].reminderTaskDate)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt currentPosition: IndexPath) -> UITableViewCell {
        let tableReminderTaskColumn = tableView.dequeueReusableCell(withIdentifier: "column", for: currentPosition)
        tableReminderTaskColumn.contentView.backgroundColor = UIColor.yellow
        //Displays one reminder task per time inside 1 object of the array
        let year2021ReminderTemplateFormat = DateFormatter()
        //Placeholder Year format, hoping 2021 will be a great year! Please :(
        year2021ReminderTemplateFormat.dateFormat = "MM/dd/yyyy"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        let reformatted2021DateTemplate = year2021ReminderTemplateFormat.string(from: reminderTaskArray[currentPosition.row].reminderTaskDate)
        tableReminderTaskColumn.textLabel?.text =  "✅" + reformatted2021DateTemplate + " ⇨" + reminderTaskArray[currentPosition.row].reminderTaskMessageInfoVar
        return tableReminderTaskColumn
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt currentPosition: IndexPath) {
            tableView.deselectRow(at: currentPosition, animated: true)
        
        let tempTaskReminderDataObject = reminderTaskArray[currentPosition.row]
        
        guard let tempReminderViewController = storyboard?.instantiateViewController(identifier: "remove") as? removeInputViewController else {
            return
        }
        
        tempReminderViewController.reminderTaskMessageInfoVar = tempTaskReminderDataObject
        tempReminderViewController.checkRemovableRecentReminderTaskInput = { [weak self] in
            self?.loadAllCurrentReminderTaskData()
        }
        
        tempReminderViewController.navigationItem.largeTitleDisplayMode = .never
        tempReminderViewController.title = tempTaskReminderDataObject.reminderTaskMessageInfoVar
        navigationController?.pushViewController(tempReminderViewController, animated: true)
    }
    
    //After clicking the new task button, switch over to next controller
    @IBAction func confirmNewReminderTaskFunction() {
        guard let reminderViewController = storyboard?.instantiateViewController(identifier: "input") as? inputViewController else {
            return
        }
        
        reminderViewController.checkRecentReminderTaskInput = { [weak self] in
            self?.loadAllCurrentReminderTaskData()
            
        }
        
        reminderViewController.title = "Uploading Reminder"
        reminderViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(reminderViewController, animated: true)
        
        
    }
    
    //After clicking the magic wand, get to here, this funct
    @IBAction func magicWand() {
        
        guard let reminderViewController = storyboard?.instantiateViewController(identifier: "wand") as? magicWandViewController else {
            return
        }
        
        reminderViewController.checkRecentReminderTaskInput = { [weak self] in
            self?.loadAllCurrentReminderTaskData()
            
        }
        
        reminderViewController.title = "Magic Wand"
        reminderViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(reminderViewController, animated: true)
 
    }
    
    func loadAllCurrentReminderTaskData() {
        reminderTaskArray = podRealmSwiftDataBaseVar.objects(EndlessRemiderTaskObject.self).map({ $0 })
        reminderTaskTable.reloadData()
        
        
    }

    
    

}






