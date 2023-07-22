//
//  ViewController.swift
//  GFIOTDemo
//
//  Created by 司林满 on 2023/7/12.
//

import UIKit
import GFIOT


class ViewController: UIViewController {

    var token = "FJrisgiIy0Hg/V2CIZo7j0efZwZXobKacV+aux1JosM="
    var deviceId = "140220321355"
    var outputMsg: String = "" {
        didSet {
            textView.text = outputMsg
        }
    }

    @IBOutlet weak var tokenBtn: UIButton!
    @IBOutlet weak var tokenTF: UITextField!
    @IBOutlet weak var deviceIdTF: UITextField!
    @IBOutlet weak var deviceIdBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var clearBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        initGFIOTSDK()
        GFIOT.operationLog { [weak self] str in
            guard let self = self else { return }
            let tempStr = self.outputMsg.isEmpty ? "" : "\n"
            self.outputMsg = self.outputMsg + "\(tempStr)\(self.nowDate())指令：\(str)"
        }
    }
    
    func initGFIOTSDK() {
        GFIOT.initSDK(token, isDebug: true ,callback: { [weak self] (code, result) in
            guard let self = self else {
                self?.outputMsg = (self?.outputMsg ?? "") + "\n\(String(describing: self?.nowDate()))初始化致命错误！！！！！！"
                return
            }
            let tempStr = self.outputMsg.isEmpty ? "" : "\n"
            self.outputMsg = self.outputMsg + "\(tempStr)\(self.nowDate())初始化：\(result.message)"
        })
    }
    
    func setupUI() {
        textView.delegate = self
        textView.layer.cornerRadius = 2
        textView.layoutManager.allowsNonContiguousLayout = false
        textView.scrollRangeToVisible(NSRange(location: 0, length: 1))
        tokenTF.delegate = self
        deviceIdTF.delegate = self
        tokenTF.text = token
        deviceIdTF.text = deviceId
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }

    @IBAction func opendoor(_ sender: Any) {
        GFIOT.control(deviceId, .OPEN_DOOR, callback: { [weak self] code, result in
            guard let self = self else {
                self?.outputMsg = (self?.outputMsg ?? "") + "\n\(String(describing: self?.nowDate()))开门致命错误！！！！！！"
                return
            }
            self.outputMsg = self.outputMsg + "\n\(self.nowDate())开门：\(result.message)"
            print("\(result.description)")
        })
    }
    
    @IBAction func closedoor(_ sender: Any) {
        GFIOT.control(deviceId, .CLOSE_DOOR, callback: { [weak self] code, result in
            guard let self = self else {
                self?.outputMsg = (self?.outputMsg ?? "") + "\n\(String(describing: self?.nowDate()))关门致命错误！！！！！！"
                return
            }
            self.outputMsg = self.outputMsg + "\n\(self.nowDate())关门：\(result.message)"
        })
    }
    
    @IBAction func openpower(_ sender: Any) {
        GFIOT.control(deviceId, .OPEN_DOOR_AND_POWER, callback: { [weak self] code, result in
            guard let self = self else {
                self?.outputMsg = (self?.outputMsg ?? "") + "\n\(String(describing: self?.nowDate()))开门供电致命错误！！！！！！"
                return
            }
            self.outputMsg = self.outputMsg + "\n\(self.nowDate())开门供电：\(result.message)"
        })
    }
    
    @IBAction func closepower(_ sender: Any) {
        GFIOT.control(deviceId, .CLOSE_DOOR_AND_POWER, callback: { [weak self] code, result in
            guard let self = self else {
                self?.outputMsg = (self?.outputMsg ?? "") + "\n\(String(describing: self?.nowDate()))关门断电致命错误！！！！！！"
                return
            }
            self.outputMsg = self.outputMsg + "\n\(self.nowDate())关门断电：\(result.message)"
        })
    }
    @IBAction func powerOn(_ sender: Any) {
        GFIOT.control(deviceId, .POWER_ON) { [weak self] code, result in
            guard let self = self else {
                self?.outputMsg = (self?.outputMsg ?? "") + "\n\(String(describing: self?.nowDate()))供电致命错误！！！！！！"
                return
            }
            self.outputMsg = self.outputMsg + "\n\(self.nowDate())供电：\(result.message)"
        }
    }
    
    @IBAction func powerOff(_ sender: Any) {
        GFIOT.control(deviceId, .POWER_OFF) { [weak self] code, result in
            guard let self = self else {
                self?.outputMsg = (self?.outputMsg ?? "") + "\n\(String(describing: self?.nowDate()))断电致命错误！！！！！！"
                return
            }
            self.outputMsg = self.outputMsg + "\n\(self.nowDate())断电：\(result.message)"
        }
    }
    
    //替换token
    @IBAction func replaceTokenAction(_ sender: Any) {
        token = tokenTF.text ?? ""
        self.outputMsg = self.outputMsg + "\n\(self.nowDate())替换token"
        initGFIOTSDK()
    }
    
    //替换deviceId
    @IBAction func replaceDeviceIdAction(_ sender: Any) {
        deviceId = deviceIdTF.text ?? ""
        self.outputMsg = self.outputMsg + "\n\(self.nowDate())替换deviceId"
    }
    
    @IBAction func clearLogAction(_ sender: Any) {
        self.outputMsg = ""
    }
    
    func nowDate() -> String {
        let today = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd HH:mm:ss.SSS"
        dateFormat.locale = Locale.current
        let nowStr = dateFormat.string(from: today) + "  "
        return nowStr
    }
}

extension ViewController: UITextViewDelegate, UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

