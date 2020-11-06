/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Photos
import Firebase
import JSQMessagesViewController

import Kingfisher


final class ChatViewController: JSQMessagesViewController {
    @IBOutlet weak var selectableView: UIView?

    @IBOutlet weak var ordr_no: UILabel!
  
    
    @IBOutlet weak var img_land: UIImageView!
    // JSQMessagesAvatarImageFactory().avatarImage(withUserInitials: "DL", backgroundColor: UIColor.jsq_messageBubbleGreen(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12))
//  let  avatar1 = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: "DL", backgroundColor: UIColor.jsq_messageBubbleGreen(), textColor:  UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 30)
    
    @IBOutlet weak var ser_name: UILabel!
    var str_land:String!
var firebase_token_IOS :String!
    var firebase_token_AND :String!

    var ordr_id:String!
    var str_sername:String!
    var sender_id:String!
    var reciver_id:String!
    
  var   landscaper_user_id :String!
    var name1:String!
    // MARK: Properties
    private let imageURLNotSetKey = "NOTSET"
    
    var channelRef: FIRDatabaseReference?
    
    private var messageRef: FIRDatabaseReference! //= self.channelRef!.child("messages")
    fileprivate lazy var storageRef: FIRStorageReference = FIRStorage.storage().reference(forURL: "gs://chatchat-rw-cf107.appspot.com")
    private lazy var userIsTypingRef: FIRDatabaseReference = self.channelRef!.child("typingIndicator").child(self.senderId)
    private lazy var usersTypingQuery: FIRDatabaseQuery = self.channelRef!.child("typingIndicator").queryOrderedByValue().queryEqual(toValue: true)
    
    private var newMessageRefHandle: FIRDatabaseHandle?
    private var updatedMessageRefHandle: FIRDatabaseHandle?
    
    private var messages: [JSQMessage] = []
    private var photoMessageMap = [String: JSQPhotoMediaItem]()
    
    private var localTyping = false
//    var channel: Channel? {
//        didSet {
//            title = channel?.name
//        }
//    }
    
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
   
    
    
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.senderId = FIRAuth.auth()?.currentUser?.uid
       // Orders
     //   UserDefaults.standard.set("", forKey: "orderNo")
        var ary = NSArray()
        var art = NSMutableArray()
        
        if UserDefaults.standard.array(forKey: "ar_value")  != nil
        {
        ary = UserDefaults.standard.array(forKey: "ar_value")  as! NSArray
      
        art = ary.mutableCopy() as! NSMutableArray
        
        art.remove(ordr_id!)
        
        
    
            
             UserDefaults.standard.set(art, forKey: "ar_value")
        }
        
        else
        {
            
        }
            
        let DB_BASE = FIRDatabase.database().reference()
        
        
        let u_id  = UserDefaults.standard.value(forKey: "u_id")
        
        DB_BASE.child("notification_\(u_id!)").updateChildValues(["flag":"0"])

          //  name1
      //  }
     

            
       //     UserDefaults.standard.set(ary, forKey: "ar_value")
            
        
//      let avatarSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height: kJSQMessagesCollectionViewAvatarSizeDefault)
//
//
//
//        collectionView?.collectionViewLayout.incomingAvatarViewSize = avatarSize
//        collectionView?.collectionViewLayout.outgoingAvatarViewSize = avatarSize
      
        self.channelRef  = FIRDatabase.database().reference().child("orders").child(ordr_id!)
        hideKeyboard()
        self.messageRef =  (self.channelRef?.child("messages"))!
        self.inputToolbar.contentView.leftBarButtonItem = nil
        self.senderId = sender_id!
        self.senderDisplayName=""
        self.inputToolbar?.contentView.rightBarButtonItem?.setImage(UIImage(named: "send-button"), for: .normal)
        //self.inputToolbar.contentView.textView.backgroundColor = UIColor.blue
        self.inputToolbar.contentView.textView.layer.borderColor = UIColor.lightGray.cgColor
        
       //self.inputToolbar.maximumHeight = 60
        
//        self.inputToolbar.contentView.textView.layer.borderWidth = 2.0
//        self.inputToolbar.contentView.textView.layer.cornerRadius =     self.inputToolbar.contentView.textView.frame.size.height/2
//
        self.inputToolbar.contentView.backgroundColor = UIColor.white
        // No avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        ser_name.text=str_sername
        ordr_no.text=name1
        
        if str_land == "" ||  str_land == "<null>"
        {

            img_land.image = UIImage.init(named: "user (1)")

        }
        else
        {
            let url = URL(string: str_land)
             img_land.kf.setImage(with: url)
           // img_land.image = UIImage.init(named: "user (1)")



        }
        
      // img_land.setImageFromURl(stringImageUrl: str_land)
        observeMessages()

        addViewOnTop()
        
        
        
    }
    
   

//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
//
// let  avatar1 = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: "DL", backgroundColor: UIColor.jsq_messageBubbleGreen(), textColor:  UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 30)
//        return avatar1
//    }
    func addViewOnTop() {
        
//        selectableView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        selectableView?.autoresizesSubviews = true
        
        selectableView?.frame = CGRect(x: 0, y: 0, width: (selectableView?.frame.size.width)!, height: (selectableView?.frame.size.height)!)
    
        view.addSubview(selectableView!)
        let top = selectableView?.frame.size.height
        let bottom = inputToolbar.frame.size.height
        //  self.collectionView.frame = CGRect (x: 0, y: 125, width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
        self.collectionView?.contentInset = UIEdgeInsets(top: CGFloat(top!), left: 0, bottom: bottom, right: 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: CGFloat(top!), left: 0, bottom: bottom, right: 0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // observeTyping()
        
      
        
    }
    
    deinit {
        if let refHandle = newMessageRefHandle {
            messageRef.removeObserver(withHandle: refHandle)
        }
        if let refHandle = updatedMessageRefHandle {
            messageRef.removeObserver(withHandle: refHandle)
        }
    }
    
    // MARK: Collection view data source (and related) methods
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    
    
    //MARK: NOTIFICATION lIST
    func chat_date(str_date:String)->String
    {
        
        
        //  MM-dd-yyyy HH:mm:ss
        let format1 = DateFormatter()
        format1.dateFormat="yyyy-MM-dd HH:mm:ss Z"
        let date1 = format1.date(from: str_date)
        let format2 = DateFormatter()
        format2.dateFormat="h:mm a"
        let str_result = format2.string(from: date1!)
        return str_result
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId     { // 1
            cell.textView?.textColor = UIColor.white
            cell.textView?.backgroundColor = UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)// 2
            
            
           // print("date-------\(message.date)")
            
            
           // let k  = chat_date(str_date: "2018-08-27 06:30:00 +0000")
          //  print(k)
       //  cell.messageBubbleTopLabel.textColor = UIColor.black
            
            let time = "\(message.date!)"
            
           // print(time)
            
            cell.messageBubbleTopLabel.text =  "\(chat_date(str_date:time))"
            
            

           // cell.messageBubbleTopLabel?.backgroundColor = UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)// 2
            //cell.avatarImageView.image = UIImage.init(named: "star (8)")
            
        } else {
            cell.textView?.textColor = UIColor.black // 3
            cell.textView?.backgroundColor = UIColor (red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
            let time = "\(message.date!)"
            
            // print(time)
            
            cell.messageBubbleTopLabel.text =  "\(chat_date(str_date:time))"

        }
        
        return cell
    }
    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
//        return nil
//    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView?, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString? {
        let message = messages[indexPath.item]
        switch message.senderId {
        case senderId:
            return nil
        default:
            guard let senderDisplayName = message.senderDisplayName else {
                assertionFailure()
                return nil
            }
            return NSAttributedString(string: senderDisplayName)
        }
    }
    
    // MARK: Firebase related methods
    
    private func observeMessages() {
        messageRef = channelRef!.child("messages")
        let messageQuery = messageRef.queryLimited(toLast:25)
        
        // We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderid"] as String!, let name = messageData["senderName"] as String!, let date = messageData["date"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                
                
                
                
               guard   let date12 = messageData["date"]  else
               {return

                }
                
                print(date12)
                
                if date12 == "2/05/2018"
                {
                    
                }
                else
                {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
              //  dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
              let date = dateFormatter.date(from:date12)!
              
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour,.minute], from: date)
                let finalDate = calendar.date(from:components)
                self.addMessage(withId: id, name: name, text: text, date: finalDate!)
                self.finishReceivingMessage()
                }
            } else if let id = messageData["senderId"] as String!, let photoURL = messageData["photoURL"] as String! {
//                if let mediaItem = JSQPhotoMediaItem(maskAsOutgoing: id == self.senderId) {
//                    self.addPhotoMessage(withId: id, key: snapshot.key, mediaItem: mediaItem)
//
//                    if photoURL.hasPrefix("gs://") {
//                        self.fetchImageDataAtURL(photoURL, forMediaItem: mediaItem, clearsPhotoMessageMapOnSuccessForKey: nil)
//                    }
//                }
            } else {
                print("Error! Could not decode message data")
            }
        })
        
        // We can also use the observer method to listen for
        // changes to existing messages.
        // We use this to be notified when a photo has been stored
        // to the Firebase Storage, so we can update the message data
//        updatedMessageRefHandle = messageRef.observe(.childChanged, with: { (snapshot) in
//            let key = snapshot.key
//            let messageData = snapshot.value as! Dictionary<String, String>
//
//            if let photoURL = messageData["photoURL"] as String! {
//                // The photo has been updated.
//                if let mediaItem = self.photoMessageMap[key] {
//                    self.fetchImageDataAtURL(photoURL, forMediaItem: mediaItem, clearsPhotoMessageMapOnSuccessForKey: key)
//                }
//            }
//        })
    }
    
    private func fetchImageDataAtURL(_ photoURL: String, forMediaItem mediaItem: JSQPhotoMediaItem, clearsPhotoMessageMapOnSuccessForKey key: String?) {
//        let storageRef = FIRStorage.storage().reference(forURL: photoURL)
//        storageRef.data(withMaxSize: INT64_MAX){ (data, error) in
//            if let error = error {
//                print("Error downloading image data: \(error)")
//                return
//            }
//
//            storageRef.metadata(completion: { (metadata, metadataErr) in
//                if let error = metadataErr {
//                    print("Error downloading metadata: \(error)")
//                    return
//                }
//
//                if (metadata?.contentType == "image/gif") {
//                    mediaItem.image = UIImage.gifWithData(data!)
//                } else {
//                    mediaItem.image = UIImage.init(data: data!)
//                }
//                self.collectionView.reloadData()
//
//                guard key != nil else {
//                    return
//                }
//                self.photoMessageMap.removeValue(forKey: key!)
//            })
//        }
    }
    
    private func observeTyping() {
        let typingIndicatorRef = channelRef!.child("typingIndicator")
        userIsTypingRef = typingIndicatorRef.child(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqual(toValue: true)
        
        usersTypingQuery.observe(.value) { (data: FIRDataSnapshot) in
            
            // You're the only typing, don't show the indicator
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            
            // Are there others typing?
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottom(animated: true)
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        // 1
        let itemRef = messageRef.childByAutoId()
        
        
      //  let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        let dateString = formatter.string(from: date)
        
        
        print("ttttt\(dateString)")
        
        // 2
        let messageItem = [
            
  
            "senderid": senderId!,
            "senderName": senderDisplayName!,
            "text": text!,
            "date": dateString,
            "receiverid":reciver_id!
        ]
     //   firebase_token
        // 3
        itemRef.setValue(messageItem)
        
        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        // 5
        finishSendingMessage()
        isTyping = false
        
        let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAu83DdAI:APA91bEZvhxX4LPEWjvx_PUbbnsKrIaSjvZwdcyFE7B8wAOHWePL1tW3yOj1pfY40Jkx8BzgeNxN4TwHRk0G-rIyc9MAgtl_vyfVLEtiM8ZwTn_-a6rLHL0-S7rglC3kx0zLYuLzWNCHrR90NS2mUOwNKwUgBji4Sw", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
//        let notData = NSMutableDictionary()
//        let bc = NSMutableDictionary()
//
//        bc.setValue(text!, forKey: "status_name" )
//
//        notData.setValue(self.firebase_token, forKey: "to"  )
//
//      //  notData.setValue("alert", forKey: "aps"  )
//
//        notData.setValue(bc, forKey: "data"  )
        
        
        var notData: [String: Any] = [
           "registration_ids" : [self.firebase_token_IOS!,firebase_token_AND!],
         //   "to" : ["ePuYMquB9jc:APA91bGyaFsb7tSOxe8jssmKe1CAp9QySRribnA9cAeRUztnoVmM2WVlNt7ZikElz1fXiWyZynGyCIQAXfgxI64yI1-xrGbTQ9jSB6L0bnJ5LorKJMfQypUKaAPfu_WJsiqFCzO9aH1t2DY9_UrYHju6IoXWekaK5Q","ePuYMquB9jc:APA91bGyaFsb7tSOxe8jssmKe1CAp9QySRribnA9cAeRUztnoVmM2WVlNt7ZikElz1fXiWyZynGyCIQAXfgxI64yI1-xrGbTQ9jSB6L0bnJ5LorKJMfQypUKaAPfu_WJsiqFCzO9aH1t2DY9_UrYHju6IoXWekaK5Q"],

          
            
         

            "notification": [
                "title" : "Seazoned",
                "body"  : text!,
                "icon"  : ""
            ],
            "data": [
                //More notification data.
                
                
                "status_name": text!,
                
                   "gcm.notification.status" : "100",
                   
                   "orderNo":  self.ordr_id,
                
                 "type": "chat",
                 
                
            ]
        ]
        
        print(notData)
        
        
        //UserDefaults.standard.set(self.ordr_id, forKey: "orderNo")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: notData, options: [])


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
        }
        
        
        let DB_BASE = FIRDatabase.database().reference()
        
        let value1 = ["flag": "1"]
        
        DB_BASE.child("notification_\(landscaper_user_id!)").setValue(value1)
        task.resume()
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func sendPhotoMessage() -> String? {
        let itemRef = messageRef.childByAutoId()
        
        let messageItem = [
            "photoURL": imageURLNotSetKey,
            "senderId": senderId!,
            ]
        
        itemRef.setValue(messageItem)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        finishSendingMessage()
        return itemRef.key
    }
    
    func setImageURL(_ url: String, forPhotoMessageWithKey key: String) {
        let itemRef = messageRef.child(key)
        itemRef.updateChildValues(["photoURL": url])
    }
    
    // MARK: UI and User Interaction
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        present(picker, animated: true, completion:nil)
    }
    
    private func addMessage(withId id: String, name: String, text: String,date: Date) {
//        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
//            messages.append(message)
        
//        }
        
        
        
        if let message = JSQMessage (senderId: id, senderDisplayName: name, date: date, text: text) {
            messages.append(message)
        }
    }
    
    private func addPhotoMessage(withId id: String, key: String, mediaItem: JSQPhotoMediaItem) {
        if let message = JSQMessage(senderId: id, displayName: "", media: mediaItem) {
            messages.append(message)
            
            if (mediaItem.image == nil) {
                photoMessageMap[key] = mediaItem
            }
            
            collectionView.reloadData()
        }
    }
    
    // MARK: UITextViewDelegate methods
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
        isTyping = textView.text != ""
    }
    
}

// MARK: Image Picker Delegate
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion:nil)
        
        // 1
        if let photoReferenceUrl = info[UIImagePickerControllerReferenceURL] as? URL {
            // Handle picking a Photo from the Photo Library
            // 2
            let assets = PHAsset.fetchAssets(withALAssetURLs: [photoReferenceUrl], options: nil)
            let asset = assets.firstObject
            
            // 3
            if let key = sendPhotoMessage() {
                // 4
                asset?.requestContentEditingInput(with: nil, completionHandler: { (contentEditingInput, info) in
                    let imageFileURL = contentEditingInput?.fullSizeImageURL
                    
                    // 5
                    let path = "\(FIRAuth.auth()?.currentUser?.uid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\(photoReferenceUrl.lastPathComponent)"
                    
                    // 6
                    self.storageRef.child(path).putFile(imageFileURL!, metadata: nil) { (metadata, error) in
                        if let error = error {
                            print("Error uploading photo: \(error.localizedDescription)")
                            return
                        }
                        // 7
                        self.setImageURL(self.storageRef.child((metadata?.path)!).description, forPhotoMessageWithKey: key)
                    }
                })
            }
        } else {
            // Handle picking a Photo from the Camera - TODO
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ChatViewController.dismissKeyboard))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        //  addViewOnTop()
        view.endEditing(true)
        
        selectableView?.frame = CGRect(x: 0, y: 0, width: (selectableView?.frame.size.width)!, height: (selectableView?.frame.size.height)!)
        
        view.addSubview(selectableView!)
        let top = (selectableView?.frame.size.height)!
        let bottom = inputToolbar.frame.size.height
        
        self.collectionView?.contentInset = UIEdgeInsets(top: CGFloat(top), left: 0, bottom: bottom, right: 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: CGFloat(top), left: 0, bottom: bottom, right: 0)
    }
}

