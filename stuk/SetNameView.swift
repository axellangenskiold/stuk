//
//  SwiftUIView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2025-02-28.
//

import SwiftUI
import FirebaseFirestore

struct SetNameView: View {
    @State var name: String
    @State var personnummer: String
    @State var mail: String
    @State var initialer: String
    @State var paddingMLN: String
    @State var paddingVanligt: String
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isPersonnummerFocused: Bool
    @FocusState private var isMailFocused: Bool
    @FocusState private var isInitialerFocused: Bool
    @FocusState private var isPaddingMLNFocused: Bool
    @FocusState private var isPaddingVanligtFocused: Bool
    
    init() {
        self.name = "name"
        self.personnummer = "personnummer"
        self.mail = "mail"
        self.initialer = "initialer"
        self.paddingMLN = "paddingMLN"
        self.paddingVanligt = "paddingVanligt"
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Firstname Lastname", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isNameFocused)
                
                TextField("personnummer: YYMMDD-XXXX", text: $personnummer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isPersonnummerFocused)
                
                TextField("mail", text: $mail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isMailFocused)
                
                TextField("initalier: AL", text: $initialer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isInitialerFocused)
                
                TextField("padding malmökort (mellan 70 - 80)", text: $paddingMLN)
                    .keyboardType(.numberPad) // Sets the keyboard to number pad
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isPaddingMLNFocused)
                
                TextField("padding studentlundkort (mellan 70 - 80)", text: $paddingVanligt)
                    .keyboardType(.numberPad) // Sets the keyboard to number pad
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isPaddingVanligtFocused)
            }
            .frame(width: 350)
        }
        .onChange(of: isNameFocused) { _ in
            let defaults = UserDefaults.standard

            defaults.set(name, forKey: "name")
        }
        .onChange(of: isPersonnummerFocused) { _ in
            let defaults = UserDefaults.standard

            defaults.set(personnummer, forKey: "personnummer")
            
            let db = Firestore.firestore()
            
            let userRef = db.collection("users").document(personnummer)
            
            userRef.getDocument { document, error in
                if let error = error {
                    userRef.setData([
                        "timestamp": Timestamp(date: Date()),
                        "disabled": false,
                        "name": UserDefaults.standard.string(forKey: "name") ?? name,
                        "personnummer": personnummer
                    ], merge: true) { error in
                        if let error = error {
                            print("Error saving device name to Firestore: \(error)")
                        } else {
                            print("Successfully saved device name to Firestore")
                        }
                    }
                }
            }
        }
        .onChange(of: isMailFocused) { _ in
            let defaults = UserDefaults.standard

            defaults.set(mail, forKey: "mail")
        }
        .onChange(of: isInitialerFocused) { _ in
            let defaults = UserDefaults.standard

            defaults.set(initialer, forKey: "initials")
        }
        .onChange(of: isPaddingMLNFocused) { _ in
            let defaults = UserDefaults.standard

            defaults.set(Double(paddingMLN), forKey: "firstPadding")
        }
        .onChange(of: isPaddingVanligtFocused) { _ in
            let defaults = UserDefaults.standard

            defaults.set(Double(paddingVanligt), forKey: "secondPadding")
        }
    }
}

#Preview {
    SetNameView()
}
