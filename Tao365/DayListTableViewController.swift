struct TaoDay {
    var title:String!
    var content:String!
    var taoOfToday:String!
}

import UIKit

class DayListTableViewController: UITableViewController {
    
    var dayNumber:Int = 360
    var days = [Int](1...365)
    var dayList = [TaoDay]()
    var selectedIndex:NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = "TAO 365"
        
        self.tabBarController!.tabBar.barStyle = UIBarStyle.Black
        self.tabBarController!.tabBar.tintColor = UIColor.whiteColor()
        for day in days {
            var dayDetail = TaoDay()
            dayDetail.title = "Day \(day) title"
            dayDetail.content = "Day \(day) content: Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            dayDetail.taoOfToday = "Day \(day) taoOfToday: Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            
            dayList.append(dayDetail)
        }

        print(">>>>>>> dayNumber = \(dayNumber)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dayNumber
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44*6
        }
        
        return 44
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "365 Tao Days"
        }
        
        return ""
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let theDay = dayList[dayNumber-1]
            let cell = tableView.dequeueReusableCellWithIdentifier("todayCell", forIndexPath: indexPath)
            if let title = cell.viewWithTag(1) as? UILabel {
                title.text = "\(theDay.title)"
            }
            
            if let content = cell.viewWithTag(2) as? UITextView {
                content.text = theDay.content
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("dayCell", forIndexPath: indexPath)
        let theDay = dayList[indexPath.row]
        cell.textLabel?.text = "Day \(days[indexPath.row]) - \(theDay.title)"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = indexPath
        if indexPath.section == 1 {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        }
    }
   
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


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "dayDetailNav" {
            let viewController = segue.destinationViewController as! DayDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            viewController.theDay = self.dayList[indexPath!.row]
            viewController.dayNumber = indexPath!.row+1
        }
        
        else if segue.identifier == "startDayNav" {
            let viewController = segue.destinationViewController as! DayDetailViewController
            viewController.theDay = self.dayList[dayNumber-1]
            viewController.dayNumber = dayNumber
        }
        
        else {
            print("...... navigate to introduction")
        }
    }
}
