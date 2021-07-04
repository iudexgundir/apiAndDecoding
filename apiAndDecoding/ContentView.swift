//
//  ContentView.swift
//  apiAndDecoding
//
//  Created by Govorov Erkhaan on 04.07.2021.
//
import SwiftUI

struct ContentView: View {

@State private var jokeData: JokeData?


var body: some View {
    HStack {
        Spacer()

        VStack(alignment: .trailing) {
            Spacer()

            Text(jokeData?.setup ?? "")
                .font(.title2)

            Text("-\(jokeData?.punchline ?? "")")
                .font(.title2)
                .padding(.top)
                .foregroundColor(.red)

            Spacer()

            Button(action: loadData) {
                Image(systemName: "pencil.and.outline")
                    .foregroundColor(.red)
            }
            .font(.title)
            .padding()
        }
    }
    .multilineTextAlignment(.trailing)
    .padding()
    .onAppear(perform: {
        loadData()
    })
}
    private func loadData() {
        guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let decodeData = try? JSONDecoder().decode(JokeData.self, from: data) {
                DispatchQueue.main.async {
                    self.jokeData = decodeData
                }
            }
        }.resume()
    }
}

struct JokeData: Decodable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
    
}
