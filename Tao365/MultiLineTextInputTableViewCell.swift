
import UIKit

extension UITableViewCell {
    /// Search up the view hierarchy of the table view cell to find the containing table view
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }
            
            return table as? UITableView
        }
    }
}

extension MultiLineTextInputTableViewCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.max))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            
            if let thisIndexPath = tableView?.indexPathForCell(self) {
                tableView?.scrollToRowAtIndexPath(thisIndexPath, atScrollPosition: .Bottom, animated: false)
            }
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.notificationCenter.postNotificationName("editingText", object: self)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (tableView?.isKindOfClass(DailyThoughtsViewController) == true) {
            if let thisIndexPath = tableView?.indexPathForCell(self) {
                thoughtEntries[thisIndexPath.row].content = textView.text
            }
        }
    }
}

class MultiLineTextInputTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet var textView: UITextView?
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /// Custom setter so we can initialise the height of the text view
    var textString: String {
        get {
            return textView?.text ?? ""
        }
        
        set {
            if let textView = textView {
                textView.text = newValue
                textViewDidChange(textView)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Disable scrolling inside the text view so we enlarge to fitted size
        textView?.scrollEnabled = false
        textView?.delegate = self
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            textView?.becomeFirstResponder()
        } else {
            textView?.resignFirstResponder()
        }
    }
    
}
