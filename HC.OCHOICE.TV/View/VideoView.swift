//import SwiftUI
//import AVKit
//
//struct VideoView: View {
//    @State private var videoURL: URL? = nil
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                // 클릭 이벤트 처리
//                // 여기에 원하는 URL을 설정하세요
//                videoURL = URL(string: "http://media.cablevod.co.kr:1935/vod_nonedrm/_DLIVE_/M5260826.mp4/mp4:M5260826.mp4/playlist.m3u8")
//            }) {
//                Text("Play Video")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            
//            if let videoURL = videoURL {
//                VideoPlayerView(url: videoURL)
//                    .frame(height: 300)
//            }
//        }
//        .padding()
//    }
//}
//
//struct VideoPlayerView: View {
//    let url: URL
//
//    var body: some View {
//        VideoPlayer(player: AVPlayer(url: url))
//            .onDisappear() {
//                // 영상이 사라질 때 플레이어 정지
//                AVPlayer(url: url).pause()
//            }
//    }
//}
//
//
