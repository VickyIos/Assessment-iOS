//
//  AppConstants.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

enum AppConstants {

    // XMPP CONFIG
    public static let xmppDomain = "stun.joiint.com"
    public static let xmppPort: UInt16 = 5222
    
    // Weather API
    public static let weatherAPIKey = "120ba71fd3231fa535221cd088034211"
    public static let weatherURL = "https://api.openweathermap.org/data/2.5/box/city?bbox=12,32,15,37,10&appid="
    
    // Weather Types
    enum WeatherType: String {
        case clouds
        case drizzle
        case clear
        case rain
        case unknown
    }
}
