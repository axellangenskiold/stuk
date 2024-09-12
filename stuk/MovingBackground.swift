import SwiftUI

struct MovingBackground: View {
    @State private var imagePositions: [CGPoint] = []
    @State private var destinations: [CGPoint] = []
    private let imageCount = 10
    private let speed: Double = 30.0 // Higher values mean faster speed

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundStyle(.STUK_GRAY)
                
                // Add multiple floating images
                ForEach(0..<imageCount, id: \.self) { index in
                    if index < imagePositions.count {
                        Image("stuk_logo2")
                            .resizable()
                            .frame(width: 130, height: 30)
                            .position(imagePositions[index])
                            .onAppear {
                                moveImage(index: index, in: geometry.size)
                            }
                    }
                }
            }
            .onAppear {
                initializePositions(for: geometry.size)
            }
        }
        .ignoresSafeArea()
    }

    // Initialize random positions and destinations for images
    private func initializePositions(for size: CGSize) {
        imagePositions = (0..<imageCount).map { _ in randomPosition(in: size) }
        destinations = (0..<imageCount).map { _ in randomPosition(in: size) }
    }

    // Move an image from its current position to a random destination
    private func moveImage(index: Int, in size: CGSize) {
        let distance = distanceBetween(imagePositions[index], destinations[index])
        let duration = distance / speed // Speed directly controls the time it takes to move based on distance
        
        withAnimation(Animation.linear(duration: duration)) {
            imagePositions[index] = destinations[index] // Move to the destination
        }

        // After the animation is complete, set a new destination and repeat
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            destinations[index] = randomPosition(in: size) // Set new destination
            moveImage(index: index, in: size) // Continue moving
        }
    }

    // Generate random positions for images within the given size
    private func randomPosition(in size: CGSize) -> CGPoint {
        return CGPoint(
            x: CGFloat.random(in: 0...size.width),
            y: CGFloat.random(in: 0...size.height)
        )
    }

    // Calculate the distance between two points
    private func distanceBetween(_ start: CGPoint, _ end: CGPoint) -> CGFloat {
        let dx = end.x - start.x
        let dy = end.y - start.y
        return sqrt(dx * dx + dy * dy)
    }
}

#Preview {
    MovingBackground()
}
