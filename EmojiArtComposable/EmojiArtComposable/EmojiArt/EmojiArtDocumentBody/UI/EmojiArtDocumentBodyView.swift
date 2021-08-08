//
//  EmojiArtDocumentBodyView.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import ComposableArchitecture
import SwiftUI

struct EmojiArtDocumentBodyView: View {
    let store: Store<EmojiArtDocumentBodyState, EmojiArtDocumentBodyAction>
    let defaultEmojiFontSize: CGFloat

    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1

    private var zoomScale: CGFloat { steadyStateZoomScale * gestureZoomScale }

    @State private var steadyStatePanOffset: CGSize = .zero
    @GestureState private var gesturePanOffset: CGSize = .zero

    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }

    var body: some View {
        GeometryReader { geometry in
            WithViewStore(store.scope(state: ViewState.init, action: EmojiArtDocumentBodyAction.init)) { viewStore in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: viewStore.backgroundImage)
                            .scaleEffect(zoomScale)
                            .position(convertFromEmojiCoordinates((0, 0), in: geometry))
                    )
                    .gesture(doubleTapToZoom(in: geometry.size, viewStore: viewStore))
                    if viewStore.backgroundImageFetchStatus == .fetching {
                        ProgressView().scaleEffect(2)
                    } else {
                        ForEach(viewStore.emojis) { emoji in
                            Text(emoji.text)
                                .font(.system(size: fontSize(for: emoji)))
                                .scaleEffect(zoomScale)
                                .position(position(for: emoji, in: geometry))
                        }
                    }
                }
                .onDrop(of: [.plainText, .url, .image], isTargeted: nil) { providers, location in
                    drop(
                        providers: providers,
                        location: location,
                        in: geometry,
                        viewStore: viewStore
                    )
                }
                .gesture(zoomGesture().simultaneously(with: panGesture()))
            }
        }
    }

    private func drop(
        providers: [NSItemProvider],
        location: CGPoint,
        in geometry: GeometryProxy,
        viewStore: ViewStore<ViewState, ViewAction>
    ) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            viewStore.send(.setBackground(background: .url(url.imageURL)))
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    viewStore.send(.setBackground(background: .imageData(data)))
                }
            }
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emojiChar = string.first, emojiChar.isEmoji {
                    let location = convertToEmojiCoordinates(location, in: geometry)
                    let emojiToAdd = EmojiArtDocumentBodyState.Emoji(
                        text: String(emojiChar),
                        x: location.x,
                        y: location.y,
                        size: Int(defaultEmojiFontSize)
                    )
                    viewStore.send(.addEmoji(emoji: emojiToAdd))
                }
            }
        }
        return found
    }

    private func fontSize(for emoji: EmojiArtDocumentBodyState.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }

    private func convertToEmojiCoordinates(_ location: CGPoint,
                                           in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: (location.x - panOffset.width - center.x) / zoomScale,
            y: (location.y - panOffset.height - center.y) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }

    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int),
                                             in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }

    private func position(for emoji: EmojiArtDocumentBodyState.Emoji,
                          in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }

    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        guard let image = image, image.size.width > 0, image.size.height > 0, size.width > 0,
              size.height > 0 else { return }
        let hZoom = size.width / image.size.width
        let vZoom = size.height / image.size.height
        steadyStatePanOffset = .zero
        steadyStateZoomScale = min(hZoom, vZoom)
    }

    private func doubleTapToZoom(in size: CGSize, viewStore: ViewStore<ViewState, ViewAction>) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(viewStore.backgroundImage, in: size)
                }
            }
    }

    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale, body: { latestGestureScale, state, _ in
                state = latestGestureScale
            })
            .onEnded { scale in
                steadyStateZoomScale *= scale
            }
    }

    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, state, _ in
                state = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
            }
    }
}

struct EmojiArtDocumentBodyView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            initialState: EmojiArtDocumentBodyState(),
            reducer: EmojiArtDocumentBodyReducer.reducer,
            environment: .init(imageClient: .live, mainQueue: .main)
        )
        EmojiArtDocumentBodyView(store: store, defaultEmojiFontSize: 40)
    }
}
