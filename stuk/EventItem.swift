//
//  EventItem.swift
//  stuk
//

import SwiftUI

struct EventItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let nation: String
    let nationAddress: String
    let date: String
    let dateLong: String
    let upcomingDates: [(day: String, time: String)]
    let imageURL: String
    let accentColor: Color
    let description: String

    static func == (lhs: EventItem, rhs: EventItem) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

private func pic(_ seed: String, _ w: Int = 600, _ h: Int = 800) -> String {
    "https://picsum.photos/seed/\(seed)/\(w)/\(h)"
}

enum EventStore {
    static let events: [EventItem] = [
        EventItem(
            title: "Fredmans Pub & Bar",
            nation: "Helsingkrona nation",
            nationAddress: "Tornavägen 3C, 22364, Lund",
            date: "FRE 15 MAJ 15:00 - 19:00",
            dateLong: "Fredag 15 maj 2026, 15:00–19:00",
            upcomingDates: [("FRE 15 MAJ", "15:00"), ("FRE 29 MAJ", "15:00"), ("FRE 5 JUN", "15:00")],
            imageURL: pic("fredmans-burger-pub"),
            accentColor: Color(red: 0.35, green: 0.65, blue: 0.70),
            description: "Välkommen till Fredmans Pub & Bar!\n\nFredmans är platsen där du kan koppla av, njuta av en god burgare, något gott att dricka och trevligt sällskap. Vi serverar som vanligt vår Fredmansburgare, samt en specialburgare unik för varje vecka. Ta med dig vännerna för en härlig eftermiddag på Lunds mysigaste pub och kicka igång kvällen på bästa sätt.\n\nKom in och ät en god burgare efter plugget eller påbörja kvällens festligheter! Dörrarna öppnar kl 15:00."
        ),
        EventItem(
            title: "Pub Kaggen",
            nation: "Kalmar Nation",
            nationAddress: "Biskopsgatan 12, 22362, Lund",
            date: "FRE 15 MAJ 18:00 - 16 MAJ 01:00",
            dateLong: "Fredag 15 maj 2026, 18:00–01:00",
            upcomingDates: [("FRE 15 MAJ", "18:00"), ("FRE 22 MAJ", "18:00"), ("FRE 29 MAJ", "18:00")],
            imageURL: pic("pubkaggen-burgers"),
            accentColor: Color(red: 0.50, green: 0.55, blue: 0.75),
            description: "Pub Kaggen är tillbaka! Varje fredag kommer Kalmar Nation att ha en Pub med smakliga burgare. Vi erbjuder en vanlig burgare och en veckovis varierande burgare. Alla burgare kan göras vegetariska eller veganska.\nKom och njut av en avkopplande fredagskväll med burgare och drinkar i vår mysiga pub.\n\nGlöm inte ditt ID/Pass och studentlundsmedlemskap."
        ),
        EventItem(
            title: "Lunch | Blekingska",
            nation: "Blekingska Nationen",
            nationAddress: "Ole Römers väg 14D, Lund",
            date: "TORS 14 MAJ 12:00 - 13:30",
            dateLong: "Torsdag 14 maj 2026, 12:00–13:30",
            upcomingDates: [("TOR 14 MAJ", "12:00"), ("TOR 21 MAJ", "12:00"), ("TOR 28 MAJ", "12:00")],
            imageURL: pic("blekingska-lunch-tomato"),
            accentColor: Color(red: 0.65, green: 0.80, blue: 0.50),
            description: "Studentlunch hos Blekingska Nationen varje torsdag. Tre rätter att välja mellan inklusive vegetariskt alternativ. Pris från 65 kr."
        ),
        EventItem(
            title: "Sopplunch",
            nation: "Västgöta Nation",
            nationAddress: "Tunavägen 39B, Lund",
            date: "TORS 14 MAJ 12:00 - 14:00",
            dateLong: "Torsdag 14 maj 2026, 12:00–14:00",
            upcomingDates: [("TOR 14 MAJ", "12:00"), ("TOR 21 MAJ", "12:00"), ("TOR 28 MAJ", "12:00")],
            imageURL: pic("vastgota-soup-spoons"),
            accentColor: Color(red: 0.92, green: 0.92, blue: 0.88),
            description: "Varje torsdag bjuder Västgöta Nation in till sopplunch i den varma matsalen. Två soppor varje vecka, bröd och pålägg ingår."
        ),
        EventItem(
            title: "Björkdahls Brunch 2026.05.16",
            nation: "Malmö Nation",
            nationAddress: "Östra Tullgatan 19, Malmö",
            date: "LÖR 16 MAJ 12:00 - 15:00",
            dateLong: "Lördag 16 maj 2026, 12:00–15:00",
            upcomingDates: [("LÖR 16 MAJ", "12:00"), ("LÖR 23 MAJ", "12:00")],
            imageURL: pic("brunch-cake-raspberry"),
            accentColor: Color(red: 0.85, green: 0.65, blue: 0.65),
            description: "Brunch i bästa stil hos Malmö Nation. Pannkakor, ägg, sallad, bröd och kaffe. Förboka för att säkra plats."
        ),
        EventItem(
            title: "Kryckans Hörna",
            nation: "Malmö Nation",
            nationAddress: "Östra Tullgatan 19, Malmö",
            date: "TORS 14 MAJ 18:00 - 23:00",
            dateLong: "Torsdag 14 maj 2026, 18:00–23:00",
            upcomingDates: [("TOR 14 MAJ", "18:00"), ("TOR 21 MAJ", "18:00")],
            imageURL: pic("kryckans-bar-night"),
            accentColor: Color(white: 0.18),
            description: "Klassiska Kryckans Hörna - en kvällspub med skön stämning. Kom och umgås!"
        ),
        EventItem(
            title: "Afternoon Tea",
            nation: "Helsingkrona Nation",
            nationAddress: "Tornavägen 3C, Lund",
            date: "FRE 15 MAJ 14:00 - 16:00",
            dateLong: "Fredag 15 maj 2026, 14:00–16:00",
            upcomingDates: [("FRE 15 MAJ", "14:00")],
            imageURL: pic("afternoon-tea-cakes"),
            accentColor: Color(red: 0.85, green: 0.70, blue: 0.80),
            description: "Mysigt afternoon tea med scones, sandwiches och hembakat. Förbokning rekommenderas."
        ),
        EventItem(
            title: "Tapas Torsdag",
            nation: "Västgöta Nation",
            nationAddress: "Tunavägen 39B, Lund",
            date: "TORS 21 MAJ 19:00 - 22:00",
            dateLong: "Torsdag 21 maj 2026, 19:00–22:00",
            upcomingDates: [("TOR 21 MAJ", "19:00"), ("TOR 28 MAJ", "19:00")],
            imageURL: pic("tapas-spanish-plates"),
            accentColor: Color(red: 0.65, green: 0.40, blue: 0.30),
            description: "Smaka på Spanien hos Västgöta. Tapasbuffé med variation varje vecka."
        ),
        EventItem(
            title: "DOWNTOWN",
            nation: "Östgöta Nation",
            nationAddress: "Tornavägen 1, Lund",
            date: "LÖR 17 MAJ 22:00 - 18 MAJ 03:00",
            dateLong: "Lördag 17 maj 2026, 22:00–03:00",
            upcomingDates: [("LÖR 17 MAJ", "22:00")],
            imageURL: pic("downtown-club-lights"),
            accentColor: Color(red: 0.15, green: 0.10, blue: 0.25),
            description: "DOWNTOWN - klubbkväll hos Östgöta Nation. DJ, dans, drinkar."
        ),
        EventItem(
            title: "Novishnollning",
            nation: "Malmö Nation",
            nationAddress: "Östra Tullgatan 19, Malmö",
            date: "FRE 22 MAJ 18:00 - 23:00",
            dateLong: "Fredag 22 maj 2026, 18:00–23:00",
            upcomingDates: [("FRE 22 MAJ", "18:00")],
            imageURL: pic("novish-students-fest"),
            accentColor: Color(red: 0.55, green: 0.40, blue: 0.65),
            description: "Välkomna alla nya studenter! Klassisk novishnollning med lekar och fest."
        ),
        EventItem(
            title: "Torsdagspuben på Sydskånska",
            nation: "Sydskånska Nationen",
            nationAddress: "Tomegapsgatan 31, Lund",
            date: "TORS 21 MAJ 19:00 - 01:00",
            dateLong: "Torsdag 21 maj 2026, 19:00–01:00",
            upcomingDates: [("TOR 21 MAJ", "19:00"), ("TOR 28 MAJ", "19:00")],
            imageURL: pic("sydskanska-pub"),
            accentColor: Color(red: 0.30, green: 0.30, blue: 0.40),
            description: "Sydskånskas torsdagspub - en återkommande favorit."
        ),
    ]
}
