import SwiftUI

/// All printed card details live in the image assets, including Axel's name.
struct NationCard: View {
    var isFake: Bool = true
    @Binding var circle: Int
    var isLangs: Bool

    var body: some View {
        Image(isFake ? backImage : frontImage)
            .resizable()
            .frame(width: isFake ? 378 : 376, height: (isFake ? 378 : 376) * 1.6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 378, height: 378 * 1.6)
            .shadow(radius: 1)
    }

    private var frontImage: String {
        switch circle {
        case 2: return "nationcard_back"
        case 3: return "studentlundcard_back"
        default: return "malmocard"
        }
    }

    private var backImage: String {
        switch circle {
        case 2: return isLangs ? "nationcard_lange" : "nationcard"
        case 3: return "studentlundcard"
        default: return "malmocard_back"
        }
    }
}

#Preview {
    NationCard(isFake: true, circle: .constant(2), isLangs: true)
}
