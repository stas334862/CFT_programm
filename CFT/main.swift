//
//  main.swift
//  CFT
//
//  Created by Stanislav Kuznetsov on 14/10/2019.
//  Copyright © 2019 Stanislav Kuznetsov. All rights reserved.
//

import Foundation
import Cocoa

class Car : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(yearOfTheCar, forKey: "yearOfTheCar")
        aCoder.encode(manufacturer, forKey: "manufacturer")
        aCoder.encode(model, forKey: "model")
        aCoder.encode(bodyType, forKey: "bodyType")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let yearOfTheCar = aDecoder.decodeObject(forKey: "yearOfTheCar") as! String
        let manufacturer = aDecoder.decodeObject(forKey: "manufacturer") as! String
        let model = aDecoder.decodeObject(forKey: "model") as! String
        let bodyType = aDecoder.decodeObject(forKey: "bodyType") as! String
        self.init(yearOfTheCar: yearOfTheCar, manufacturer: manufacturer, model: model, bodyType: bodyType)
    }
    
    var yearOfTheCar : String
    var manufacturer : String
    var model : String
    var bodyType : String
    
    init (yearOfTheCar: String, manufacturer: String, model: String, bodyType: String) {
        self.yearOfTheCar = yearOfTheCar
        self.manufacturer = manufacturer
        self.model = model
        self.bodyType = bodyType
    }
}

var baseOfCars = [Car]()

func printItemOfClass (item: Car) {
    print("Manufacturer: \(item.manufacturer) | Model: \(item.model) | Body type: \(item.bodyType) |  Year of the car: \(item.yearOfTheCar)")
}

func printBase() {
    print("\nYour base of cars:")
    for (index, value) in baseOfCars.enumerated() {
        print("Car \(index):")
        printItemOfClass(item: value)
        print("\n")
    }
}

func ReadString () -> String {
    let value = readLine()
    if value != "" {
        return value!}
    else {
        print("\n!ERROR!Your value is not fit. For this parametr will return is 'VALUE'. You can chenge this one after the completion of the creation. \n")
        return "VALUE"
    }
}

func ReadInt () -> Int {
    let value = readLine()
        if (value != nil){
            for i in 0...1000 {     //Если в базе будет много машин, то этот цикл будет обрабатывать и большие числа тоже
                if (Int(value!) == i){
                    return Int(value!)!}}
                }
        else{ print("\n!ERROR!Your value is not fit\n ") }
    return 8986 // случайное число много больше, чем максимально обрабатываемое (в нашем случает это 1000). Нужно для того, чтобы при вводе не целого или некорректного числа в функцию не вернулось действующее значение, которое в связке со значениеем может произвести деструктивные действия при выборе соответствующего пункта меню.
}

func newCar (){
    print("Enter parametrs and push Enter until the entry process is over...")
    print("Enter manufacturer:")
    let temp1 = ReadString()
    print("Enter model:")
    let temp2 = ReadString()
    print("Enter body type:")
    let temp3 = ReadString()
    print("Enter year of the сar:")
    let temp4 = ReadString()
    let newCarItem = Car(yearOfTheCar: temp4, manufacturer: temp1, model: temp2, bodyType: temp3)
        baseOfCars.append(newCarItem)
}

func saveData (localArray: Array<Any>) {
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: localArray)
    UserDefaults.standard.set(encodedData, forKey: "baseOfCars")
    UserDefaults.standard.synchronize()
}

func firstLoad () {
    let userDefaultsIsEmpty = UserDefaults.standard.object(forKey: "baseOfCars")
    if (userDefaultsIsEmpty == nil) {
        baseOfCars.append(Car (yearOfTheCar: "2018", manufacturer: "Volvo", model: "XC90", bodyType: "Jeep"))
        baseOfCars.append(Car (yearOfTheCar: "2014", manufacturer: "Chevrolet", model: "Tahoe", bodyType: "Jeep"))
        baseOfCars.append(Car (yearOfTheCar: "2012", manufacturer: "Vortex", model: "Tingo", bodyType: "Crossover"))
        saveData(localArray: baseOfCars) }
    }

func loadData () {
    let decoded = UserDefaults.standard.value(forKey: "baseOfCars") as? Data
    let decodedBaseOfCars = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Car]
    baseOfCars = decodedBaseOfCars
}

firstLoad()
loadData()

print("Hello. This is a car database program. Information about cars and their characteristics is stored here. Enjoy your use.\n")

var mode = "Y"
let errorDict = ["WrongMode" : "\nYou entered the wrong mode. You can try again if you want."]

while (mode == "Y" || mode == "y") {
    let countOfBaseOfCars = baseOfCars.count-1
    print("\nEnter what do you want to do with base of cars: \n 1 - Show base \n 2 - Show parametrs of target car \n 3 - To add a car \n 4 - To remove a car \n 5 - Edit information about target car\n 6 - EXIT \n Your answer is: ")
    let choise = ReadInt()
    if (choise <= 6){
    switch choise {
    case 1:
         printBase()
    case 2:
        print("Enter number of car from base:")
        let target = ReadInt()
        if (target <= countOfBaseOfCars){
        print("Parametrs of targeted car:")
            printItemOfClass(item: baseOfCars[target])}
        else {print(errorDict["WrongMode"]!)}
    case 3:
        newCar()
        print("Your car was succesfuly created!")
    case 4:
        print("Enter number of car from base:")
        let target = ReadInt()
        if (target <= countOfBaseOfCars) {
        baseOfCars.remove(at: target)
            print("Your car was succesfuly removed!")}
        else {print(errorDict["WrongMode"]!)}
    case 5:
        print("Enter number of car from base:")
        let target = ReadInt()
        if (target <= countOfBaseOfCars) {
        let targerCar = baseOfCars[target]
        print("Enter the number of the parameter you want to change \n 1 - Manufacturer \n 2 - Model \n 3 - Body type \n 4 - Year of the сar\n Your answer is: ")
        let localChoise = ReadInt()
            if (localChoise <= 4) {
        switch localChoise {
        case 1:
            print("Enter new parametr: ")
            targerCar.manufacturer = ReadString()
            print("Changed!")
        case 2:
            print("Enter new parametr: ")
            targerCar.model = ReadString()
            print("Changed!")
        case 3:
            print("Enter new parametr: ")
            targerCar.bodyType = ReadString()
            print("Changed!")
        case 4:
            print("Enter new parametr: ")
            targerCar.yearOfTheCar = ReadString()
            print("Changed!")
        default:
            print(errorDict["WrongMode"]!)
                }} else { print(errorDict["WrongMode"]!) }
        } else { print(errorDict["WrongMode"]!) }
        case 6:
            break
    default:
        print(errorDict["WrongMode"]!)
        }} else { print(errorDict["WrongMode"]!) }
    print("\nDo you want to continue? Y or N\n Your answer is: ")
    mode = ReadString()
    var endMessage = false
    if (mode == "n" || mode == "N"){
        saveData(localArray: baseOfCars)
    print("\nThank you for using our program. Goodbye!\n")
    }
    if(mode == "n" || mode == "N" || mode == "y" || mode == "Y") {
    endMessage = false
    } else {endMessage = true}
    if (endMessage == true) {
        saveData(localArray: baseOfCars)
        print("\nYou entered an invalid value in the main menu. In accordance with the terms of use of our program, the data will be saved and the program will end. If you want to continue using the program, then start it up. Goodbye.\n")
    }
    saveData(localArray: baseOfCars)
}

