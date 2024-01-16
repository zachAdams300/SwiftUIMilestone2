//
//  ContentView.swift
//  SwiftUIMilestone2
//
//  Created by Zachary Adams on 1/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numToTest = 2
    @State private var numQuestions = 5
    @State private var currentAnswer = ""
    @State private var score = 0
    @State private var currentQuestionNum = 0
    @State private var shouldShowAnswerBox = false
    @State private var canChangeSettings = true
    
    @FocusState private var textfieldIsFocused: Bool
    
    @State private var questionList = [Question]()
    let questionArray = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Settings") {
                    VStack {
                        Stepper("\(numToTest) multiplication table", value: $numToTest, in: 2...12)
                            .disabled(!canChangeSettings)

                        Picker("How many questions?", selection: $numQuestions) {
                            ForEach(questionArray, id:\.self) {
                                Text("\($0)")
                            }
                        }
                        .disabled(!canChangeSettings)
                        Button("Start Game"){
                            startGame()
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding()
                }
                if shouldShowAnswerBox {
                    Section("Type your answer") {
                        Text("What is \(numToTest) X \(currentQuestionNum)")
                        TextField("Type your answer", text: $currentAnswer)
                            .keyboardType(.numberPad)
                            .onSubmit {
                                checkAnswer()
                                textfieldIsFocused = true
                                currentAnswer = ""
                            }
                            .focused($textfieldIsFocused)
                    }
                }
            }
            .navigationTitle("Score: \(score)")
            .toolbar(content: {
                Button("Restart Game") {}
            })
        }
    }
    
    func startGame() {
        shouldShowAnswerBox = true
        questionList.removeAll()
        for num in 0..<numQuestions {
            questionList.append(Question(text: "\(numToTest) X \(num)", answer: numToTest * num))
        }
    }
    
    func restartGame() {
        shouldShowAnswerBox = false
        questionList.removeAll()
        canChangeSettings = true
    }
    
    func checkAnswer () {
        if let currentQuestion = questionList.first {
            if currentQuestion.answer == Int(currentAnswer) {
                score += 1
            }
            currentQuestionNum += 1
            questionList.remove(at: 0)
            
        }
    }
}

#Preview {
    ContentView()
}
