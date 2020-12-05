//
//  ContentView.swift
//  Shared
//
//  Created by silly b on 2020/12/5.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, Pac!")
            .padding()
        
        // if use App Sandbox in macOS.entitlements

        Button(action: {
            let pac = "https://raw.githubusercontent.com/petronny/gfwlist2pac/master/gfwlist.pac"
            guard let url = URL(string: pac) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let str = String(data: data, encoding: .utf8)
                    let path = "\(NSHomeDirectory())/Library/Application Support/V2RayX/pac/gfwlist.pac"
                    print("write to path: \(path)")
                    try str?.write(toFile: path, atomically: true, encoding: .utf8)
                } catch {
                    print("download error: \(error)")
                }
            }.resume()
        }) {
            Text("pac")
        }
        .padding(.all)
        
        Button(action: {
            //                let gh = "https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
            let gfw = "https://gitlab.com/gfwlist/gfwlist/raw/master/gfwlist.txt"
            guard let url = URL(string: gfw) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    guard let data = data, let decoded = Data(base64Encoded: data, options: .ignoreUnknownCharacters) else {
                        print("decode error")
                        return
                    }
                    let str = String(data: decoded, encoding: .utf8)
                    let path = "\(NSHomeDirectory())/Library/Application Support/V2RayX/pac/gfwlist.txt"
                    print("write to path: \(path)")
                    try str?.write(toFile: path, atomically: true, encoding: .utf8)
                } catch {
                    print("download error: \(error)")
                }
            }.resume()
        }) {
            Text("gfwlist")
        }
        .padding(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
