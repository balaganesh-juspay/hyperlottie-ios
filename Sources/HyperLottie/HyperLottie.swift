import UIKit
import Lottie

@objc public class HyperLottie: NSObject {

    @objc public override init() {
        super.init()
    }

    @objc public func createLottieAnimationView(_ data: NSDictionary) -> LottieAnimationView? {
        var lottieAnimationView: LottieAnimationView? = nil

        if let urlString = data["lottieUrl"] as? String {
            lottieAnimationView = LottieAnimationView(filePath: urlString)
        } else if let resourcePath = data["lottieResourceId"] as? String {
            lottieAnimationView = LottieAnimationView(filePath: resourcePath)
        } else {
            return nil
        }

        guard let animationView = lottieAnimationView else { return nil }

        var parsedRepeatCount: Int? = nil
        if let rawRepeatCount = data["repeatCount"] {
            if let repeatCountString = rawRepeatCount as? String, let intFromString = Int(repeatCountString) {
                parsedRepeatCount = intFromString
            }
        }

        if let repeatCount = parsedRepeatCount {
            if repeatCount == -1 {
                animationView.loopMode = .loop
            } else if repeatCount > 0 {
                animationView.loopMode = .repeat(Float(repeatCount))
            } else {
                animationView.loopMode = .playOnce
            }
        } else {
            animationView.loopMode = .playOnce
        }

        if let repeatMode = data["repeatMode"] as? String, repeatMode == "reverse" {
            if animationView.loopMode != .playOnce {
                animationView.loopMode = .autoReverse
            }
        }

        if let speedValue = data["speed"] {
            if let speed = speedValue as? CGFloat {
                animationView.animationSpeed = speed
            } else if let speedString = speedValue as? String, let speed = Double(speedString) {
                animationView.animationSpeed = CGFloat(speed)
            }
        }

        if let alphaValue = data["lottieAlpha"] {
            if let alpha = alphaValue as? Float {
                animationView.alpha = CGFloat(alpha)
            } else if let alphaString = alphaValue as? String, let alpha = Double(alphaString) {
                animationView.alpha = CGFloat(alpha)
            }
        }

        return animationView
    }

    @objc public func playAnimation(_ animationView: UIView, animationData: NSDictionary) {
        if let lottieView = animationView as? LottieAnimationView {
            var shouldStartLottie = false
            if let rawValue = animationData["startLottie"] {
                if let startLottieString = rawValue as? String {
                    shouldStartLottie = (startLottieString.lowercased() == "true")
                }
            }
            if shouldStartLottie {
                if let minFrame = animationData["minFrame"] as? Int, let maxFrame = animationData["maxFrame"] as? Int {
                    lottieView.play(fromFrame: AnimationFrameTime(minFrame), toFrame: AnimationFrameTime(maxFrame), completion: nil)
                } else if let maxFrame = animationData["maxFrame"] as? Int {
                    lottieView.play(toFrame: AnimationFrameTime(maxFrame), completion: nil)
                } else if let minProgress = animationData["minProgress"] as? Float, let maxProgress = animationData["maxProgress"] as? Float {
                    lottieView.play(fromProgress: AnimationProgressTime(minProgress), toProgress: AnimationProgressTime(maxProgress), completion: nil)
                } else if let maxProgress = animationData["maxProgress"] as? Float {
                    lottieView.play(toProgress: AnimationProgressTime(maxProgress), completion: nil)
                } else {
                    lottieView.currentProgress = 0
                    lottieView.play() // Play the entire animation
                }
            } else {
                lottieView.stop() // If shouldStartLottie is false, ensure it's stopped
            }
        }
    }

    @objc public func stopAnimation(_ animationView: UIView) {
        if let lottieView = animationView as? LottieAnimationView {
            lottieView.stop()
        }
    }
}
