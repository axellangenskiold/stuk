//
//  SetNameView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2025-02-28.
//

import SwiftUI
import FirebaseFirestore

struct SetNameView: View {
    @Environment(\.dismiss) private var dismiss

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
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                headerBar
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        field(placeholder: "Firstname Lastname", text: $name, focus: $isNameFocused)
                        field(placeholder: "personnummer: YYMMDD-XXXX", text: $personnummer, focus: $isPersonnummerFocused)
                        field(placeholder: "mail", text: $mail, focus: $isMailFocused)
                        field(placeholder: "initialer: AL", text: $initialer, focus: $isInitialerFocused)
                        field(placeholder: "padding malmökort (mellan 70 - 80)", text: $paddingMLN, focus: $isPaddingMLNFocused, keyboard: .numberPad)
                        field(placeholder: "padding studentlundkort (mellan 70 - 80)", text: $paddingVanligt, focus: $isPaddingVanligtFocused, keyboard: .numberPad)
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 18)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: isNameFocused) { _ in
            UserDefaults.standard.set(name, forKey: "name")
        }
        .onChange(of: isPersonnummerFocused) { _ in
            UserDefaults.standard.set(personnummer, forKey: "personnummer")

            let db = Firestore.firestore()
            let userRef = db.collection("users").document(personnummer)
            userRef.getDocument { _, error in
                if error != nil {
                    userRef.setData([
                        "timestamp": Timestamp(date: Date()),
                        "disabled": false,
                        "name": UserDefaults.standard.string(forKey: "name") ?? name,
                        "personnummer": personnummer
                    ], merge: true) { err in
                        if let err = err {
                            print("Error saving device name to Firestore: \(err)")
                        } else {
                            print("Successfully saved device name to Firestore")
                        }
                    }
                }
            }
        }
        .onChange(of: isMailFocused) { _ in
            UserDefaults.standard.set(mail, forKey: "mail")
        }
        .onChange(of: isInitialerFocused) { _ in
            UserDefaults.standard.set(initialer, forKey: "initials")
        }
        .onChange(of: isPaddingMLNFocused) { _ in
            UserDefaults.standard.set(Double(paddingMLN), forKey: "firstPadding")
        }
        .onChange(of: isPaddingVanligtFocused) { _ in
            UserDefaults.standard.set(Double(paddingVanligt), forKey: "secondPadding")
        }
    }

    private var headerBar: some View {
        ZStack {
            Text("Inställningar")
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .heavy))
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                        .padding(.leading, 16)
                }
                Spacer()
            }
        }
        .padding(.vertical, 14)
    }

    private func field(placeholder: String,
                       text: Binding<String>,
                       focus: FocusState<Bool>.Binding,
                       keyboard: UIKeyboardType = .default) -> some View {
        TextField("", text: text,
                  prompt: Text(placeholder).foregroundColor(.white.opacity(0.4)))
            .keyboardType(keyboard)
            .foregroundStyle(.white)
            .focused(focus)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.10))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
    }
}

#Preview {
    SetNameView()
}
