//
//  PolypolyStats.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import SpriteKit

//=======================================
// NetWork
//- IP
//let HostIP = "169.254.89.212"
//let HostIP = "169.254.137.225"
let HostIP = "localhost"
//=======================================
// Name
//- atlas #animation, background
let Explosion1Folder = "explosion.atlas"
let Explosion2Folder = "explosion2.atlas"
let BlackHoleFolder = "blackhole.atlas"
let WinFolder = "win.atlas"
let LoseFolder = "lose.atlas"
let BallSkinFolder = "ballskin.atlas"
let StartBackgroundFolder = "startbackground.atlas"
//- object
let BuildingName = "building"
let DrawObstacleName = "drawObstacle"
let WallName = "wall"
let BallName = "ball"
let TrapName = "trap1"
let BlackHoleName = "blackhole"
let SoccerName = "soccer"

//-key
let userNameKey = "UserName" // 使用者名稱的鍵值
//=======================================
// ScreenSetting
let ScreenSize = UIScreen.main.bounds.size
let ScreenCenter = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
//=======================================
//  Character Setting
let PlayerMaxHP: CGFloat = 100
