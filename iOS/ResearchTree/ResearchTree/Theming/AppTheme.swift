//
//  AppTheme.swift
//  Night Mode
//
//  Created by Michael on 01/04/2018.
//  Copyright © 2018 Late Night Swift. All rights reserved.
//

import UIKit

struct AppTheme {
	var statusBarStyle: UIBarStyle
	var barBackgroundColor: UIColor
	var barForegroundColor: UIColor
	var backgroundColor: UIColor
	var textColor: UIColor
    var cardview: UIColor
    var cardview2: UIColor
    var postsButton: UIColor
    var myJobButton: UIColor
    var logoutButton: UIColor
}

extension AppTheme {
	static let light = AppTheme(
		statusBarStyle: .`default`,
		barBackgroundColor: .white,
		barForegroundColor: .black,
		backgroundColor: UIColor(named: "lightMode")!,
		textColor: .black,
        cardview: .white,
        cardview2:  UIColor(named: "lightCard")!,
        postsButton:.blue,
        myJobButton: UIColor.blue,
        logoutButton: UIColor.white
	)
    
    

	static let dark = AppTheme(
		statusBarStyle: .black  ,
		barBackgroundColor: UIColor(white: 0, alpha: 1),
		barForegroundColor: .white,
		//backgroundColor: UIColor(white: 0.2, alpha: 1),
        backgroundColor: UIColor(named: "darkMode")!,
        textColor: .white,
        cardview: UIColor(named: "darkCard")!,
        cardview2: .black,
        postsButton: UIColor(named: "darkButton")!,
        myJobButton: UIColor(named: "darkButton")!,
        logoutButton: UIColor(named: "darkGrayButton")!
	)
}
