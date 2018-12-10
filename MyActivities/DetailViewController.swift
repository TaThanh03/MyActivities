//
//  DetailViewController.swift
//  MyActivities
//
//  Created by TA Trung Thanh on 09/12/2018.
//  Copyright © 2018 TA Trung Thanh. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController{
    private let backgroundView = UIImageView()
    private let i = UIImageView()
    private let label_title = UILabel()
    private let label_priority = UILabel()
    private var text_title = UITextField()
    private let seg_priority = UISegmentedControl(items: ["0", "1", "2", "3", "4"])
    
    private var myCell : OneCell?
    
    convenience init (oneCell: OneCell) {
        self.init()
        myCell = oneCell
        text_title.text = myCell!.label
        i.image = myCell!.img
        i.contentMode = .scaleAspectFit
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            i.bounds.size = CGSize(width: 250, height: 250)
        } else {
            i.bounds.size = CGSize(width: 500, height: 500)
        }
        seg_priority.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        seg_priority.tintColor = UIColor.white
        seg_priority.selectedSegmentIndex = myCell!.detail
        seg_priority.addTarget(self, action: #selector(setPriority), for: .valueChanged)
        label_title.text = "Title:"
        label_priority.text = "Priority:"
        
    }
    
    override func viewDidLoad() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        backgroundView.image = UIImage(named: "bg-tableview-cell-sel")
        backgroundView.frame = UIScreen.main.bounds
        
        text_title.delegate = self
        
        self.view.addSubview(backgroundView) //for background
        self.view.addSubview(i)
        self.view.addSubview(label_title)
        self.view.addSubview(label_priority)
        self.view.addSubview(text_title)
        self.view.addSubview(seg_priority)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePhoto))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            NSLog( "Camera OK!")
            self.navigationItem.rightBarButtonItem?.target = self
            self.navigationItem.rightBarButtonItem?.action = #selector(takePhoto)
        }
        self.displayInSize(UIScreen.main.bounds.size)
    }
    
    func displayInSize(_ s : CGSize) {
        var top = 50
        if s.width > s.height && UIDevice.current.userInterfaceIdiom == .phone { //landscape
            /*
            l.frame = CGRect(x: 10, y: s.height/4, width: s.width, height: 40)
            i.frame = CGRect(x: s.width/4*3 - i.frame.size.width/2, y: s.height/2 - i.frame.size.height/2, width: i.frame.size.width, height: i.frame.size.height)
            */
        } else { //portrait
            top = 80
            label_title.frame = CGRect(x: 10, y: top + 20, width: 80, height: 30)
            label_priority.frame = CGRect(x: 10, y: top + 60, width: 80, height: 30)
            text_title.frame = CGRect(x: 70, y: top + 20, width: Int(s.width - 70), height: 30)
            seg_priority.frame = CGRect(x: 10, y: top + 100, width: Int(s.width - 20), height: 30)
            i.frame = CGRect(x: 10, y: top + 150, width: Int(s.width - 20), height: Int(s.height) - top - 200)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.displayInSize(size)
    }
    
    @objc func setPriority() {
        myCell!.detail = seg_priority.selectedSegmentIndex
    }
    
}

extension DetailViewController : UINavigationControllerDelegate {
    //UINavigationControllerDelegate
    @objc func takePhoto() {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        //imgPicker.sourceType = .camera
        let vc = UIApplication.shared.windows[0].rootViewController
        vc?.present(imgPicker, animated: true, completion: nil)
    }
}

extension DetailViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let img =  info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        i.image = img
        i.contentMode = .scaleAspectFit
        myCell!.img = img
    }
}

extension DetailViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        text_title.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        text_title.resignFirstResponder()
        print("DidEndEditing")
        myCell?.label = text_title.text!
    }
}
