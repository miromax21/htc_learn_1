//
//  main.swift
//  newCopy
//
//  Created by UserMac on 27/03/2019.
//  Copyright © 2019 UserMac. All rights reserved.
//

import Foundation

enum OptionType: String,CaseIterable {
    case add = "-a"
    case remove = "-r"
    case list = "-l"
    case exit
    case help
}

enum RemoveType: String,CaseIterable{
    case field = "-f"
    case byIndexs = "-ids"
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
    var userName: String {get set}
    var lastName: String {get set}
    var phoneNumber: Int {get set}
}

class User: UserProtocol{
    var userName: String = ""
    var lastName = ""
    var phoneNumber = 0
    
    init(userName:String, lastName: String, phoneNumber:Int) {
        self.userName = userName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
class UserData{
    static var users:[User] = [User(userName: "max", lastName: "asd", phoneNumber: 1),User(userName: "asd", lastName: "asd", phoneNumber: 1),]
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
    func addUser(user:User){
        UserData.users.append(user)
        print("user has been added!")
    }
    
    func displayUsers() {
        print("All users: \n")
        for user in UserData.users{
            print(" user name \(user.userName) last name : \(user.lastName) phone : \(user.phoneNumber)")
        }
    }
    
    func removeBy(commandParrams: [Substring]) {
        let option = RemoveType(value: String(commandParrams[1]))
        switch option {
        case .field:
            UserData.users.removeAll(where: {$0.userName == commandParrams[2] || $0.lastName == commandParrams[2] || $0.phoneNumber == Int(commandParrams[2]) ?? 0})
            print("user: \(commandParrams[2]) has been deleted!")
        case .byIndexs:
            guard let indexStart = Int(commandParrams[2]), let indexEnd = Int(commandParrams[3]) else { print("invalid index"); return}
            if (indexStart < 0 || indexEnd > UserData.users.count - 1){
                print("input ids are out from range: \n users length is \(UserData.users.count)")
                return
            }
            for index in indexStart...indexEnd {
                UserData.users.remove(at: index)
            }
            displayUsers()
        case .byIndex:
            guard let index = Int(commandParrams[1]) else { print("invalid index"); return}
            UserData.users.remove(at: index)
            print(String(commandParrams[1]))
        }
        
    }
}
var programm = Programm()
var option:OptionType = .help
repeat {
    let inputStreamCommand = ConsoleWork().getInput(getedParam: "Set params;")
    if inputStreamCommand.isEmpty{
        continue
    }
    let commandParrams = inputStreamCommand.split(separator: " ");
    guard let option = OptionType(rawValue: String(commandParrams[0])) else {print("it's unknown function please try again, \n to know about available params write 'help'"); continue}
    if (option == OptionType.exit){
        break
    }
    switch option{
        case .add:
            let user =  User(userName: String(commandParrams[1]), lastName: String(commandParrams[2]), phoneNumber: Int(commandParrams[3]) ?? 0)
            programm.addUser(user: user)
        case .remove:
            programm.removeBy(commandParrams: commandParrams)
        case .list:
            programm.displayUsers()
        case .exit:
             print("goodbye!")
        case .help:
            for typeOption in OptionType.allCases {
                print(" \(typeOption.rawValue) : \(typeOption)")
                if(typeOption == OptionType.remove){
                    for removeOption in RemoveType.allCases {
                        print(" | \(removeOption.rawValue) : \(removeOption)")
                    }
                }
            }
    }
    print("\n")
        

} while option != OptionType.exit
print("goodbye! have a nice day :)")



