//
//  Localized.swift
//  i18n
//
//  Created by 张和悦 on 2017/1/9.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

import UIKit

private let userLanguageKey = "userLanguage"
private let lprojType = "lproj"

enum Language: String {
    
    case en = "en"
    case zh = "zh-Hans"
    
    func imageSuffix() -> String {
        switch self {
        case .en :
            return "_en"
        case .zh :
            return "_zh"
        }
    }
    
}

class I18nUtility {
    
    fileprivate var bundle: Bundle
    static let shareInstance = I18nUtility()

    private init() {
        let def = UserDefaults.standard
        let string = def.value(forKey: userLanguageKey) as? String
        let path: String?
        if (string == nil || string == "") {
            let def = UserDefaults.standard
            def.setValue(Bundle.main.preferredLocalizations[0], forKey: userLanguageKey)
            def.synchronize()
            path = Bundle.main.path(forResource: Bundle.main.preferredLocalizations[0], ofType: lprojType)
        } else {
            path = Bundle.main.path(forResource: string, ofType: lprojType)
        }
        bundle = Bundle(path: path!)!
    }
    
    func userLanguageImageSuffix() -> String {
        let def = UserDefaults.standard
        let string = def.value(forKey: userLanguageKey) as? String
        guard let strongString = string else {
            fatalError()
        }
        switch strongString {
        case Language.en.rawValue:
            return Language.en.imageSuffix()
        case Language.zh.rawValue:
            return Language.zh.imageSuffix()
        default:
            fatalError()
        }
    }
    
    func userLanguage() -> Language {
        let def = UserDefaults.standard
        guard let strongString = def.value(forKey: userLanguageKey) as? String else {
            fatalError()
        }
        switch strongString {
        case Language.en.rawValue:
            return .en
        case Language.zh.rawValue:
            return .zh
        default:
            fatalError()
        }
    }
    
    func switchUserlanguage() {
        switch userLanguage() {
        case .en:
            setUserlanguage(language: .zh)
        case .zh:
            setUserlanguage(language: .en)
        }
    }
    
    func setUserlanguage(language: Language) {
        let def = UserDefaults.standard
        def.setValue(language.rawValue, forKey: userLanguageKey)
        def.synchronize()
        let path = Bundle.main.path(forResource: language.rawValue , ofType: lprojType)
        bundle = Bundle(path: path!)!
    }
    
}

extension Date {
    
    func localizedDateFrom(formatString: String) -> String {
        let format = DateFormatter()
        switch I18nUtility.shareInstance.userLanguage() {
        case .zh:
            format.locale = Locale(identifier: "zh-Hans")
        case .en:
            format.locale = Locale(identifier: "en")
        }
        format.dateFormat = formatString
        return format.string(from: self)
    }
    
}

extension String {
    
    func localizedString() -> String {
        return self.localizedString(string: "")
    }
    
    func localizedString(string: String) -> String {
        return String(format: NSLocalizedString(self, tableName: nil, bundle: I18nUtility.shareInstance.bundle, value: "", comment: ""), string)
    }
    
}

