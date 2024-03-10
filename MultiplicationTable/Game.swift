//
//  Game.swift
//  MultiplicationTable
//
//  Created by enesozmus on 10.03.2024.
//

struct Game {
    
    var _multiplicationTable = 1
    
    var _numberOfQuestions = 3
    var _chooseQuestions = [3, 5, 7, 10]
    
    var _questions: [Int] = [0]
    
    var _answers: [Int] = [0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0]
    
    var _correctAnswer = 0
    var _currentQuestion = 0
    
    var _isRight = false
    
    var _score = 0
    var _round = 0
    
    var _showingScore = false
    
    
    // Main Function
    mutating func start() {
        reset()
        
        _questions = generateUniqueRandomNumbers(
            // 3, 5, 7, 10
            repetitions: _numberOfQuestions,
            maxValue: 19,
            notUnique: _numberOfQuestions > 19 ? true : false
        )
        print(_questions)
        _correctAnswer = _multiplicationTable * _questions[_round]
        print(_correctAnswer)
        _answers = generateOptions(correctAnswer: _correctAnswer)
        print(_answers)
        print(_answers.count)
        _currentQuestion = _questions[_round]
        print(_currentQuestion)
    }
    
    // Function
    func generateUniqueRandomNumbers(repetitions: Int, maxValue: Int, addNum: Int = 0, notUnique: Bool = false) -> [Int] {
        var numbers: [Int] = []
        
        if addNum != 0 {
            numbers.append(addNum)
        }
        
        guard maxValue >= repetitions || notUnique else {
            fatalError("maxValue must be >= repetitions")
        }
        
        for _ in 1...repetitions {
            var n: Int
            if notUnique {
                numbers.append(Int.random(in: 1..<maxValue))
            } else {
                repeat {
                    n = Int.random(in: 1..<maxValue)
                } while numbers.contains(n)
                numbers.append(n)
            }
        }
        
        return numbers
    }
    
    // Function
    func generateOptions(correctAnswer: Int) -> [Int] {
        // The correct answer is added to the options. This needs to be done!
        var numbers: [Int] = []
        numbers.append(_correctAnswer)
        
        // a range suitable for the correct answer
        let minValue = _correctAnswer <= 15 ? 1 : _correctAnswer - 30
        let maxValue = _correctAnswer + 30
        
        // 15 - correct answer = 14
        for _ in 0..<14 {
            var n: Int
            repeat {
                n = Int.random(in: minValue...maxValue)
            } while numbers.contains(n)
            numbers.append(n)
        }
        
        return numbers.shuffled()
    }
    
    // Function
    mutating func checkAnswer(btnNumber: Int) {
        if _answers[btnNumber] == _correctAnswer {
            _score += 1
            _isRight = true
        } else {
            _isRight = false
        }
        
        _round += 1
        
        if _round == _numberOfQuestions {
            showScore()
        } else {
            nextQuestion()
        }
    }
    
    // Function
    mutating func showScore() {
        _showingScore = true
    }
    
    // Function
    mutating func reset() {
        _score = 0
        _round = 0
    }
    
    // Function
    mutating func nextQuestion() {
        _correctAnswer = _multiplicationTable * _questions[_round]
        _answers = generateOptions(correctAnswer: _correctAnswer)
        _currentQuestion = _questions[_round]
    }
}
