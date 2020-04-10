import UIKit
import Social
import receive_sharing

class ShareViewController: SharingHelper {

    override func shareUrl()->String{
        let value = Bundle.main.object(forInfoDictionaryKey:"MAIN_APP_ID")
        return (value as! String)+".Share"
    }

    override func sharedGroupName() -> String {
         return Bundle.main.object(forInfoDictionaryKey:"ShareGroup") as! String
    }

}
