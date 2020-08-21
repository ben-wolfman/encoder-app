//
//  MessagesViewController.swift
//  encoder MessagesExtension
//
//  Created by Benjamin Wolfman on 2020-07-26.
//  Copyright © 2020 Benjamin Wolfman. All rights reserved.
//

import UIKit
import Messages
import Foundation

/*
extension StringProtocol {
    //var asciiValues: [UInt8] { compactMap(\.asciiValue) }
}
 */
/*
private static let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }

public func hexEncodedString() -> String {
    return String(self.reduce(into: "".unicodeScalars, { (result, value) in
        result.append(Data.hexAlphabet[Int(value/16)])
        result.append(Data.hexAlphabet[Int(value%16)])
    }))
}
*/
/*
       let layout = MSMessageTemplateLayout();
       layout.caption = textLabel.text;
       
       let message = MSMessage();
       message.layout = layout;
       
       activeConversation?.insert(message, completionHandler: nil);
        */
//print("What'ss going on".data(using: .ascii)?.hexString);
           /*
           let myString = String(bytes: "thisisatest".compactMap { $0.asciiValue }, encoding: .utf8)
           //print("thisisatest".compactMap { $0.asciiValue })
           print("MY STRING IS: " + myString!)

           let str = textLabel?.text
           let data = Data(str!.utf8)
           let hexString = data.map{ String(format:"%02x", $0) }.joined()
           print("HEX STRING IS: " + hexString)
*/
//print("TEXT LABEL IS: " + textLabel!.text)
//let newString = (textLabel?.text.data(using: .ascii)?.hexString)!
//rint("NEW STRING IS: " + newString)
//let encodedString = (textLabel?.text.data(using: .ascii)?.hexString ?? "") + "1";
//let encodedString = (textLabel?.text.data(using: .ascii)?.decimalString ?? "") + "2";
//let encodedString = (textLabel?.text.data(using: .ascii)?.octString ?? "") + "3";
/*
   @IBAction func tapLabel(_ sender: UITapGestureRecognizer) {
       requestPresentationStyle(MSMessagesAppPresentationStyle.expanded);
       textLabel?.text = "";
   }
*/
   /*
   func decode(input: String) -> String {
       if (input.last! == "1") {
           let cleanInput = input.dropLast()
       } else if (input.last! == "2") {
           let cleanInput = input.dropLast()
       } else if (input.last! == "3") {
           let cleanInput = input.dropLast()
       } else {
           print("error")
       }
       return ""
   }
   
   func encodeBase(input: String) -> String {
       let str = input
       print("Original: \(str)")

       let utf8str = str.data(using: .utf8)

       if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
           print("Encoded: \(base64Encoded)")

           if let base64Decoded = Data(base64Encoded: base64Encoded, options: Data.Base64DecodingOptions(rawValue: 0))
           .map({ String(data: $0, encoding: .utf8) }) {
               // Convert back to a string
               print("Decoded: \(base64Decoded ?? "")")
           }
       }
       return " "
   }
*/
   /*
   func hexToStr(text: String) -> String {

       let regex = try! NSRegularExpression(pattern: "(0x)?([0-9A-Fa-f]{2})", options: .caseInsensitive)
       let textNS = text as NSString
       let matchesArray = regex.matches(in: textNS as String, options: [], range: NSMakeRange(0, textNS.length))
       let characters = matchesArray.map {
           Character(UnicodeScalar(UInt32(textNS.substring(with: $0.range(at: 2)), radix: 16)!)!)
       }

       return String(characters)
   }
*/
//let intVal = Int?(char.asciiValue)
//let asciiVal: [UInt8?] = [char.asciiValue]!
//let stringVal: String? = String(bytes: asciiVal, encoding: .utf8)
   /*
   func encodeHex(input: String) -> String {
       var hexString = ""
       for char in input {
           if (char.isASCII) {
               print(char.asciiValue)
               let a: [UInt8?] = [char.asciiValue]
               assert(a.count * MemoryLayout<UInt8>.stride >= MemoryLayout<Int>.size)
               let b = UnsafeRawPointer(a).assumingMemoryBound(to: Int.self).pointee.littleEndian
               print(String(b))
               
               hexString.append(String(b))
           } else {
               hexString.append(char)
           }
       }
       return hexString
   }
*/

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}

extension Data {
    
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }

    var decimalString: String {
        return map { String(format: "%d", $0) }.joined()
    }
    
    var octString: String {
        return map { String(format: "%03hho", $0) }.joined()
    }

}

class MessagesViewController: MSMessagesAppViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var decodeButton: UIButton?
    @IBOutlet weak var encodeButton: UIButton?
    @IBOutlet weak var encodeSendButton: UIButton?
    @IBOutlet weak var textLabel: UITextView!
    
    
    @IBAction func button(_ sender: UIButton) {
        if (sender.tag == 0) {
            var str = textLabel.text
            var counter = 0
            let mySubstring = str?.suffix(2)
            str?.removeLast(2)
            if let number = Int((mySubstring?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!) {
                print(number)
                while (counter < number) {
                    str = str?.fromBase64()
                    print(str)
                    counter += 1
                }
                // Do something with this number
            }
            //let regularStr = str!.fromBase64()
            textLabel.text = str
        }
        
        let number = Int.random(in: 1..<4)
        if textLabel?.text == nil {
            print("error")
        } else {
            
        
        switch(4) {
            case 1:
                let str = textLabel.text
                let data = Data(str!.utf8)
                let hexString = data.map{ String(format:"%02x", $0) }.joined()
                print("NEW HEX STRING IS: " + hexString)
                let encodedString = hexString + "1";
                textLabel?.text = encodedString;

                if (sender.tag == 2) {
                   
                    requestPresentationStyle(MSMessagesAppPresentationStyle.compact);
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {                          self.activeConversation?.sendText(encodedString, completionHandler: nil);
                        }
                }
                break;
            case 2:
                let str = textLabel.text
                let data = Data(str!.utf8)
                let decString = data.map{ String(format:"%d", $0) }.joined()
                let encodedString = decString + "2";
                textLabel?.text = encodedString;
                if (sender.tag == 2) {
                    requestPresentationStyle(MSMessagesAppPresentationStyle.compact);
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {                          self.activeConversation?.sendText(encodedString, completionHandler: nil);
                    }
                }
                break;
            case 3:
                let str = textLabel.text
                let data = Data(str!.utf8)
                let octString = data.map{ String(format:"%03o", $0) }.joined()
                let encodedString = octString + "3";
                textLabel?.text = encodedString;
                if (sender.tag == 2) {
                    requestPresentationStyle(MSMessagesAppPresentationStyle.compact);
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {                          self.activeConversation?.sendText(encodedString, completionHandler: nil);
                    }
                }
                break;
            case 4:
                var str = textLabel.text
                var counter = 0
                let randNum = Int.random(in: 10..<20)
                while (counter < randNum) {
                    str = str!.toBase64()
                    counter += 1
                }
                let encodedString = str! + String(randNum)
                if (sender.tag == 1) {
                    textLabel.text = encodedString;
                }
                if (sender.tag == 2) {
                    requestPresentationStyle(MSMessagesAppPresentationStyle.compact);
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {                          self.activeConversation?.sendText(encodedString, completionHandler: nil);
                    }
                }
                break;
        default:
            print("error")
        }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textLabel?.textColor == UIColor.lightGray {
            self.textLabel?.text = nil
            self.textLabel?.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your text here!"
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.textLabel.text = "Enter your text here!"
        self.textLabel.textColor = UIColor.lightGray
        self.textLabel.delegate = self;
        
        self.textLabel.layer.borderWidth = 2;
        self.textLabel.layer.cornerRadius = 5;
        self.encodeButton?.layer.cornerRadius = 5;
        self.encodeSendButton?.layer.cornerRadius = 5;
        
        self.decodeButton?.layer.cornerRadius = 5;
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {    self.requestPresentationStyle(MSMessagesAppPresentationStyle.expanded);
        }
        if #available(iOSApplicationExtension 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
