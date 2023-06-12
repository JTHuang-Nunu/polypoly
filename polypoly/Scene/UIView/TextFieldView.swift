//
//  TextFieldView.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import UIKit

class TextFieldView: UIView, UITextFieldDelegate {
    var onTouch = Event<Bool>() //true = begin, false = end
    var textField: UITextField!

    override init(frame: CGRect){
        textField = UITextField(frame: frame)
        
        super.init(frame: CGRect(center: ScreenCenter, size: ScreenSize))
        setupTextField()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    private func setupTextField() {
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.backgroundColor = .clear
//        textField.backgroundColor = .gray
//        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        
        textField.center = ScreenCenter
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let userName = textField.text, !userName.isEmpty {
            UserDefaults.standard.set(userName, forKey: userNameKey)
            print("Username saved: \(userName)")
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 處理 UITextField 開始編輯的事件
        // 在這裡你可以執行相應的動作，例如移動場景中的元素
        UIView.animate(withDuration: 0.4, animations: {
            textField.center += CGPoint(0, -55)
        })
        onTouch.Invoke(true)
        print("TextField did begin editing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            textField.center += CGPoint(0, 55)
        })
        onTouch.Invoke(false)
        print("TextField did end editing")
    }
    
}
