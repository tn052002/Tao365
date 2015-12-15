import UIKit

extension DayDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return theDay.title
        } else if section == 1 {
            return "Tao of today"
        }
        return "My Daily Thoughs"
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section != 2) {
            let cell = tableView.dequeueReusableCellWithIdentifier("dayDetailCell", forIndexPath: indexPath)
            var contentString:String!
            
            if indexPath.section == 0 {
                contentString = theDay.content
            } else {
                contentString = theDay.taoOfToday
            }
            
            if let label = cell.viewWithTag(1) as? UILabel {
                label.text = contentString
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("dailyThoughtCell", forIndexPath: indexPath) as! MultiLineTextInputTableViewCell
        cell.titleLabel?.text = "Tap to edit - Tap again when done"
        cell.textString = "Tap to edit"
        
        return cell
    }
}

class DayDetailViewController: UITableViewController {
    
    var theDay:TaoDay!
    var dayNumber:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Day \(dayNumber)"
        
        self.tableView.registerNib(UINib(nibName: "DailyThoughtCell", bundle: nil), forCellReuseIdentifier: "dailyThoughtCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44*4
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer()
//        tap.numberOfTapsRequired = 2
        tap.addTarget(self, action: "endEditing")
        self.view.addGestureRecognizer(tap)
    }
    
    func endEditing() {
        print("tap.....")
        self.tableView.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
