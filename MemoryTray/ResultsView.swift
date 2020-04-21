import SwiftUI

struct ResultsView: View {
    
    // changing and passed down from top level info
    @Binding var quiz: Quiz
    
    // all changing information
    @State private var inputText = ""
    @State private var rotateAmount = 0
    @State private var showElements = false
    @State private var showStar = false
    
    // needed to dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    func getInputText() {
        let text = inputText
        let textArray = text.split(separator: " ")
        quiz.computerScore(a: textArray, count: quiz.count)
        print(quiz.points)
    }
    
    // modify state
    func rotateStars() {
        rotateAmount += 180
    }
    
    // modify state
    func showUIElements() {
        showElements = true
    }
    
    var body: some View {
        VStack {
            
            TextField("Enter text here", text: $inputText).font(.system(size: 30))
                .padding()
                .border(Color.blue, width: 1)
            Text("Submit Quiz")
                .font(.system(size: 30))
                .padding()
                .border(Color.blue, width: 1)
                .onTapGesture {
                    self.getInputText()
                    self.showUIElements()
                    self.rotateStars()
            }
            Text("Play Again")
                .font(.system(size: 30))
                .padding()
                .border(Color.blue, width: 1)
                .padding()
                .onTapGesture {
                    // reset the points and dismiss
                    self.quiz.points = 0
                    self.presentationMode.wrappedValue.dismiss()
            }.opacity(showElements ? 1 : 0)
            
            Spacer()
            
            HStack {
                StarView(rotateAmount: $rotateAmount)
                StarView(rotateAmount: $rotateAmount).opacity(quiz.points >= 20 ? 1 : 0)
                StarView(rotateAmount: $rotateAmount).opacity(quiz.points >= 40 ? 1 : 0)
            }.opacity(showElements ? 1 : 0)
            
            VStack {
                Text("\(quiz.points)")
                    .font(.system(size: 130))
                    .italic()
                    .padding()
                    .onTapGesture {
                        self.getInputText()
                }.opacity(showElements ? 1 : 0)
                Text("points!")
                    .font(.system(size: 30))
                    .bold()
                    .italic()
                    .padding()
                    .onTapGesture {
                        self.getInputText()
                }.opacity(showElements ? 1 : 0)
                
                HStack {
                    StarView(rotateAmount: $rotateAmount).opacity(quiz.points >= 60 ? 1 : 0)
                    StarView(rotateAmount: $rotateAmount).opacity(quiz.points >= 80 ? 1 : 0)
                    StarView(rotateAmount: $rotateAmount).opacity(quiz.points >= 95 ? 1 : 0)
                }.opacity(showElements ? 1 : 0)
            }.offset(y: -50)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(quiz: .constant(Quiz(time: 10, count: 4, points: 0)))
    }
}
