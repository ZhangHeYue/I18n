//
//  ViewController.swift
//  i18n
//
//  Created by 张和悦 on 2017/1/9.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        label.text = Date().localizedDateFrom(formatString: DATE_TITLE.localizedString())
        switchButton.setTitle(BUTTON_TITLE.localizedString(), for: .normal)
        imageView.image = UIImage(named: "animal" + I18nUtility.shareInstance.userLanguageImageSuffix())
    }

    @IBAction func switchLanguage(_ sender: Any) {
        I18nUtility.shareInstance.switchUserlanguage()
        setup()
    }
}

