//
//  InputManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/26.
//

import Foundation

class InputManager: PlayerInputController {
    //for output
    var action: PlayerAction
//    var arrow: Arrow
//    var player:
    func OnDoAction(action: (PlayerAction) -> Void) {
        //touch move
        //input any variable
        //return playAction
    }
    func onTouch(ID: UUID, actionType: ActionType, point: CGPoint?) -> Void{
        switch actionType {
            
        case .ChooseSkill:
                fallthrough
        case .UseSkill:
                fallthrough
        case .Move:
                fallthrough
        case .Draw(_):
            self.action.ActionType = actionType
            
        }
        
    }
    func tBegin(pos: CGPoint){

    }
    func tMove(pos: CGPoint){

    }
    func tEnd(pos:CGPoint){

    }

    var CharacterID: UUID
    init(CharacterID: UUID) {
        self.CharacterID = CharacterID
        self.action = PlayerAction(
            CharacterModelID: UUID(),
            ActionType: .ChooseSkill,
            SkillID: 0,
            ActionTime: Date(),
            point: CGPoint(),
            impulse: CGVector()
        )
    }
//    init(dispatcher: Dispatcher ){
//        self.CharacterID = UUID()
//    }
    private func sendAction(){

    }


}
