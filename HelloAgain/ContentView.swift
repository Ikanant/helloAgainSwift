//
//  ContentView.swift
//  HelloAgain
//
//  Created by Jonathan Hernandez on 10/28/21.
//

// https://random.imagecdn.app/500/500

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL(string: "https://random.imagecdn.app/500/500") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                self.image = Image(uiImage: uiImage )
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                if let image = viewModel.image {
                    image
                        .resizable()
                        .foregroundColor(Color.blue)
                        .frame(width: 300, height: 300)
                        .padding()
                        .cornerRadius(8)
                }
                else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.blue)
                        .frame(width: 300, height: 300)
                        .padding()
                }
                
                Spacer ()
                
                Button(action: {
                    viewModel.fetchNewImage()
                }, label: {
                    Text("Pull new image")
                        .bold()
                        .frame(width: 250, height: 40, alignment: Alignment.center)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                })
            }
            .navigationTitle("First App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
