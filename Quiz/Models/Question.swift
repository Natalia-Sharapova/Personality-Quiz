//
//  Question.swift
//  Quiz
//
//  Created by Наталья Шарапова on 14.09.2021.
//
struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
    
    static let all: [Question] = [
    
        Question(text: "Какую еду вы предпочитаете?", type: .single, answers: [
            Answer(text: "Мясо", type: .dog),
            Answer(text: "Рыбу", type: .cat),
            Answer(text: "Кукурузу", type: .turtle),
            Answer(text: "Морковку", type: .rabbit),
                 ]),
        
        Question(text: "Как вы относитесь к водным видам спорта?", type: .single, answers: [
            Answer(text: "Не люблю", type: .rabbit),
            Answer(text: "Очень люблю", type: .dog),
            Answer(text: "Ненавижу", type: .cat),
            Answer(text: "Обожаю", type: .turtle),
                 ]),
        
        Question(text: "Что вы любите делать?", type: .multiply, answers: [
                 Answer(text: "Спать", type: .cat),
                 Answer(text: "Веселиться", type: .dog),
                 Answer(text: "Плавать", type: .turtle),
                 Answer(text: "Обниматься", type: .rabbit),
                 ]),
        
        Question(text: "Любите ли вы поездки на машине?", type: .range, answers: [
            Answer(text: "Не люблю", type: .cat),
            Answer(text: "Нервничаю", type: .rabbit),
                 Answer(text: "Не замечаю", type: .turtle),
            Answer(text: "Обожаю", type: .dog),
                 ]),
        
        Question(text: "Выберите понравившуюся картинку", type: .imageSingle, answers: [
            Answer(text: "Трава", type: .rabbit),
            Answer(text: "Парк", type: .dog),
            Answer(text: "Пляж", type: .turtle),
            Answer(text: "Диван", type: .cat),
                 ]),
    ]
    }

