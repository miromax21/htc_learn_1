//
//  main.swift
//  htc_learn_1
//
//  Created by Princess Max on 26.03.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import Foundation
enum OptionType:String{
    case add = "-a"
    case remove = "r"
    case showAll = "all"
    case uncnown
    init(value:String){
        switch value {
        case "-a": self = .add
        case "-r": self = .remove
        case "-all": self = .showAll
        default:self = .uncnown
        }
    }
}
enum RemoveType:String{
    case field = "field"
    case byIndexs = "indexs"
    case byIndex
    init(value:String){
        switch value {
        case "-f": self = .field
        case "-ids": self = .byIndexs
        default:self = .byIndex
        }
    }
}
protocol UserProtocol {
    var userName:String {get set}
    var lastName:String {get set}
    var phoneNumber: Int {get set}
}
class User: UserProtocol{
    var userName: String = ""
    var lastName: String = ""
    var phoneNumber: Int = 0
    
    init(userName:String, lastName: String, phoneNumber:Int) {
        self.userName = userName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
class UserData{
   static var users = [User(userName: "max", lastName: "asd", phoneNumber: 1),User(userName: "asd", lastName: "asd", phoneNumber: 1),]
}
private class ConsoleWork{
    func getInput(getedParam: String) -> String {
        print("\(getedParam)")
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)
        return (strData?.trimmingCharacters(in: CharacterSet.newlines)) ?? ""
    }
}
class Programm{
    func getOption(_ option:String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    func getRemoveOption(_ option:String) -> (option:RemoveType, value: String) {
        return (RemoveType(value: option), option)
    }
    func addUser(user:User){
        UserData.users.append(user)
    }
    func displayUsers() {
        for user in UserData.users{
            print("user name \(user.userName) last name : \(user.lastName) phone : \(user.phoneNumber)")
        }
    }
    func removeBy(commandParrams:[Substring]){
        let (option, _) = getRemoveOption(String(commandParrams[1]))
        switch option {
            case .field:
                UserData.users.removeAll(where: {$0.userName == commandParrams[2] || $0.lastName == commandParrams[2] || $0.phoneNumber == Int(commandParrams[2]) ?? 0})
            case .byIndexs:
                print("from : \(commandParrams[2]) to: \(commandParrams[3])")
            case .byIndex:
                print(String(commandParrams[1]))
        }
    }
}
var programm = Programm()
let inputStreamCommand = ConsoleWork().getInput(getedParam: "Set params")
let commandParrams = inputStreamCommand.split(separator: " ");
let (option, _) = programm.getOption(String(commandParrams[0]))
switch option {
    case .add:
        let user =  User(userName: String(commandParrams[1]), lastName: String(commandParrams[2]), phoneNumber: Int(commandParrams[3]) ?? 0)
        programm.addUser(user: user)
    case .remove:
        programm.removeBy(commandParrams: commandParrams)
    case .uncnown:
        print("this is uncnown func")
    case .showAll:
        programm.displayUsers()
}

var a = 1

