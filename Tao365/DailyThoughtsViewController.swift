extension DailyThoughtsViewController {
    dynamic func changeNavButton(notification: NSNotification) {
        self.navigationItem.rightBarButtonItem?.title = "Done"
    }
    
    @IBAction func endEditing(sender: UIBarButtonItem) {
        if (sender.title == "Add") {
            self.tableView.beginUpdates()
            print("........ add new entry")
            var newThoughEntry = Thought()
            newThoughEntry.dateCreated = NSDate()
            newThoughEntry.content = ""
            thoughtEntries.insert(newThoughEntry, atIndex: 0)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
            (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! MultiLineTextInputTableViewCell).textView?.becomeFirstResponder()
        } else {
            print("....... end editing")
            self.tableView.endEditing(true)
            self.navigationItem.rightBarButtonItem?.title = "Add"
        }
    }

}

import UIKit

struct Thought {
    var dateCreated:NSDate!
    var content:String!
}

var thoughtEntries = [Thought]()

class DailyThoughtsViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.title = "JOURNAL"
        
        self.tableView.registerNib(UINib(nibName: "DailyThoughtCell", bundle: nil), forCellReuseIdentifier: "dailyThoughtCell")
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        notificationCenter.addObserver(self, selector: "changeNavButton:", name: "editingText", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.notificationCenter.removeObserver(self, name: "editingText", object: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return thoughtEntries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dailyThoughtCell", forIndexPath: indexPath) as! MultiLineTextInputTableViewCell
        let indexThoughEntry = thoughtEntries[indexPath.row]

        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        formatter.timeStyle = .ShortStyle
        cell.titleLabel!.text = formatter.stringFromDate(indexThoughEntry.dateCreated)
        cell.textString = indexThoughEntry.content

        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
