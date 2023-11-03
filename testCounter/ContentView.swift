//
//  ContentView.swift
//  testCounter
//
//  Created by Suhail Singh Bains on 2023-11-02.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    @State private var statusCode = 0
    @State private var userData = "No data"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .padding()
            Text("Counter: \(counter)")
                .padding()
            Text("Status Code: \(statusCode)")
                .padding()
            Text("User Data: \(userData)")
                .padding()
            Button("Call API") {
                callAPI()
            }
        }
    }
    
    func callAPI() {
        guard let url = URL(string: "https://reqres.in/api/users/2") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any] {
                    if let data = dictionary["data"] as? [String: Any], let email = data["email"] as? String {
                        DispatchQueue.main.async {
                            userData = email
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            counter += 1
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
