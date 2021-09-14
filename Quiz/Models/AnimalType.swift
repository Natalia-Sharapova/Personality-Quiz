//
//  AnimalType.swift
//  Quiz
//
//  Created by Наталья Шарапова on 14.09.2021.
//

enum AnimalType: Character {
    case dog = "🦮",
         cat = "🐈",
         rabbit = "🐇",
         turtle = "🐢"
    
    var definition: String {
        
        switch self {
        case .dog:
            return "Вы активны. Окружаете себя теми, кого любите и наслаждаетесь взаимодействием с друзьями."
        case .cat:
            return "Вы гуляете сами по себе"
        case .rabbit:
            return "Вы активны, радостны. Вы здоровы и полны энергии"
        case .turtle:
            return "Вы умнее ваших лет"
        }
    }
}
